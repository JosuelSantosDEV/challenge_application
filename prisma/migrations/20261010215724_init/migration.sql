-- CreateEnum
CREATE TYPE "StatusMatch" AS ENUM ('RED', 'BLUE', 'DRAW');

-- CreateTable
CREATE TABLE "levels" (
    "id" UUID NOT NULL,
    "level_number" INTEGER NOT NULL,
    "required_score" INTEGER NOT NULL,

    CONSTRAINT "levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "players" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "level_id" UUID NOT NULL,

    CONSTRAINT "players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "matches" (
    "id" UUID NOT NULL,
    "winner" "StatusMatch" NOT NULL,
    "red_roll" INTEGER NOT NULL,
    "blue_roll" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "player_blue_id" UUID NOT NULL,
    "player_red_id" UUID NOT NULL,

    CONSTRAINT "matches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scores" (
    "id" UUID NOT NULL,
    "score_value" INTEGER NOT NULL DEFAULT 0,
    "points_value" INTEGER NOT NULL DEFAULT 0,
    "victories" INTEGER NOT NULL DEFAULT 0,
    "draws" INTEGER NOT NULL DEFAULT 0,
    "losses" INTEGER NOT NULL DEFAULT 0,
    "player_id" UUID NOT NULL,

    CONSTRAINT "scores_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "levels_level_number_key" ON "levels"("level_number");

-- CreateIndex
CREATE UNIQUE INDEX "players_name_key" ON "players"("name");

-- CreateIndex
CREATE INDEX "matches_player_blue_id_idx" ON "matches"("player_blue_id");

-- CreateIndex
CREATE INDEX "matches_player_red_id_idx" ON "matches"("player_red_id");

-- CreateIndex
CREATE UNIQUE INDEX "scores_player_id_key" ON "scores"("player_id");

-- AddForeignKey
ALTER TABLE "players" ADD CONSTRAINT "players_level_id_fkey" FOREIGN KEY ("level_id") REFERENCES "levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_player_blue_id_fkey" FOREIGN KEY ("player_blue_id") REFERENCES "players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_player_red_id_fkey" FOREIGN KEY ("player_red_id") REFERENCES "players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scores" ADD CONSTRAINT "scores_player_id_fkey" FOREIGN KEY ("player_id") REFERENCES "players"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
