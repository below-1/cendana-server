import { prisma } from '@cend/commons/prisma';
import { FindOptions } from '@cend/commons/find';

export async function find(keyword: string, options: FindOptions.Marker) {
  const totalData = await prisma.tool.count({
    where: {
      title: {
        contains: keyword
      }
    }
  });
  const perPage = options.perPage == -1 ? totalData : options.perPage;
  const totalPage = perPage == 0 ? 0 : Math.ceil(totalData / perPage);
  const offset = perPage * options.page;
  const items = await prisma.tool.findMany({
    where: {
      title: {
        contains: keyword
      }
    },
    skip: offset,
    take: perPage
  })
  return {
    items,
    totalPage,
    totalData
  }
}
