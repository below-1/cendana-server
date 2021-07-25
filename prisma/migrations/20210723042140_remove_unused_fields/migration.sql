/*
  Warnings:

  - You are about to drop the column `total` on the `Order` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Order" DROP COLUMN "total",
ALTER COLUMN "subTotal" SET DEFAULT 0,
ALTER COLUMN "grandTotal" SET DEFAULT 0;
