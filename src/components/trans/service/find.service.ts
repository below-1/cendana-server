import { prisma } from '@cend/commons/prisma';
import {
  TransactionStatus,
  TransactionType,
  PaymentMethod,
  DelayType
} from '@prisma/client';
import { FindOptions as BaseOptions } from '@cend/commons/find';
import { TransType } from '../trans-type.enum'

interface FindOptions extends BaseOptions.Marker {
  keyword?: string;
  year: number;
  month: number;
}

export async function findTransactions(t: TransType, options: FindOptions) {
  let conditions: any[] = []
  switch (t) {

    case TransType.PURCHASE:
      conditions = [
        ...conditions,
        { orderId: { gte: 1 } },
          { type: TransactionType.CREDIT }
      ]
      break;

    case TransType.SALE:
      conditions = [
        ...conditions,
        { orderId: { gte: 1 } },
        { type: TransactionType.DEBIT }
      ]
      break;

    case TransType.OPEX:
      conditions = [
        ...conditions,
        { opex: { title: { contains: options.keyword } } },
        { type: TransactionType.CREDIT }
      ]
      break;

    case TransType.TOOL:
      conditions = [
        ...conditions,
        { tool: { title: { contains: options.keyword } } },
        { type: TransactionType.CREDIT }
      ]
      break;

    case TransType.AP_PAYMENT:
      conditions = [
        ...conditions,
        {delay: { type: DelayType.PAYABLE }}
      ]
      break;

    case TransType.AR_PAYMENT:
      conditions = [
        ...conditions,
        {delay: {type: DelayType.RECEIVABLE}}
      ]
      break;

    case TransType.ALL:
      break;

    default:
      throw new Error('unknown t')
  }
  // Date filter

  // combine conditions
  let where = {
    AND: conditions
  }

  const totalData = await prisma.transaction.count({
    where
  })

  const perPage = options.perPage == -1 ? totalData : options.perPage
  const totalPage = Math.ceil(totalData / perPage)
  const offset = perPage * options.page

  const items = await prisma.transaction.findMany({
    where,
    include: {
      opex: true,
      tool: true,
      order: true,
      author: true
    },
    orderBy: {
      createdAt: 'desc'
    },
    take: perPage,
    skip: offset
  })

  return {
    totalPage,
    totalData,
    items
  }
}