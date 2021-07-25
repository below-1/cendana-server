/*
  Warnings:

  - You are about to drop the column `sell` on the `StockItem` table. All the data in the column will be lost.
  - You are about to drop the column `supplierId` on the `StockItem` table. All the data in the column will be lost.
  - You are about to drop the column `unit` on the `StockItem` table. All the data in the column will be lost.
  - Added the required column `orderStatus` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `targetUserId` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nominal` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('OPEN', 'SEALED');

-- DropForeignKey
ALTER TABLE "StockItem" DROP CONSTRAINT "StockItem_supplierId_fkey";

-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "orderStatus" "OrderStatus" NOT NULL,
ADD COLUMN     "targetUserId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "StockItem" DROP COLUMN "sell",
DROP COLUMN "supplierId",
DROP COLUMN "unit",
ADD COLUMN     "sold" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Transaction" ADD COLUMN     "nominal" DECIMAL(65,30) NOT NULL;

-- AddForeignKey
ALTER TABLE "Order" ADD FOREIGN KEY ("targetUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
