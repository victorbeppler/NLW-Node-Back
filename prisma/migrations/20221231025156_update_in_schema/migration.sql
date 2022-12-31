/*
  Warnings:

  - You are about to drop the column `firsTeamCountryCode` on the `Game` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[participantId,gameId]` on the table `Guess` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,poolId]` on the table `Participant` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[googleId]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `firstTeamCountryCode` to the `Game` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Participant_poolId_userId_key";

-- AlterTable
ALTER TABLE "User" ADD COLUMN "googleId" TEXT;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Game" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "firstTeamCountryCode" TEXT NOT NULL,
    "secondTeamCountryCode" TEXT NOT NULL
);
INSERT INTO "new_Game" ("date", "id", "secondTeamCountryCode") SELECT "date", "id", "secondTeamCountryCode" FROM "Game";
DROP TABLE "Game";
ALTER TABLE "new_Game" RENAME TO "Game";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Guess_participantId_gameId_key" ON "Guess"("participantId", "gameId");

-- CreateIndex
CREATE UNIQUE INDEX "Participant_userId_poolId_key" ON "Participant"("userId", "poolId");

-- CreateIndex
CREATE UNIQUE INDEX "User_googleId_key" ON "User"("googleId");
