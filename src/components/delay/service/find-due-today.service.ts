import { startOfDay, endOfDay } from 'date-fns'
import { prisma } from '@cend/commons/prisma'
import {
  DelayType
} from '@prisma/client';


type Kind = 'PAYABLE' | 'RECEIVABLE' | 'ALL'

export async function findDueToday(kind: Kind) {
  const today = new Date()
  console.log(today)
  // console.log(startOfDay(today))
  let conditions: any[] = [
    { dueDate: {
      gte: startOfDay(today),
      lte: endOfDay(today)
    } }
    // { complete: false }
  ]

  // switch (kind) {
  //   case 'PAYABLE':
  //     conditions.push({
  //        type: DelayType.PAYABLE
  //     })
  //     break;
  //   case 'RECEIVABLE':
  //     conditions.push({
  //        type: DelayType.RECEIVABLE
  //     })
  //     break;
  //   case 'ALL':
  //     break;
  //   default:
  //     throw new Error(`Unknown kind: ${kind}`)
  // }

  const where = {
    AND: conditions
  }
  const items = await prisma.delay.findMany({
    where,
    include: {
      order: {
        include: {
          targetUser: true
        }
      }
    }
  })
  return items
}