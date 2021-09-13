import { prisma } from '@cend/commons/prisma';
import { format } from 'date-fns';
import { toDateUpperLower } from '@cend/commons/to-date-upper-lower'

interface Report1Param {
  year: number;
  month: number;
}

export async function report1({ year, month }: Report1Param) {
  const { lower: lowerDate, upper: upperDate } = toDateUpperLower(year, month);
  const pgDateFormat = 'yyyy-MM-dd'
  const slower = format(lowerDate, pgDateFormat)
  const supper = format(upperDate, pgDateFormat)
  console.log(slower)
  console.log(supper)

  const items = await prisma.$queryRaw`
    select 
      d::date as "day",
      sum(case   when t."type" = 'DEBIT' then t.nominal else 0 end) as total_debit,
      sum(case   when t."type" = 'CREDIT' then t.nominal else 0 end) as total_credit
      from generate_series(${lowerDate}, ${upperDate}, '1 day'::interval) d
      left join "Transaction" as t on t."createdAt"::date  = d
      group by d
      order by d asc
  `;
  return items;
}
