import 'dotenv/config';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../src/generated/prisma/client.js';

const adapter = new PrismaPg({ connectionString: process.env['DATABASE_URL'] });
const prisma = new PrismaClient({ adapter });

const levels = [
  { level_number: 1, required_score: 0 },
  { level_number: 2, required_score: 30 },
  { level_number: 3, required_score: 100 },
  { level_number: 4, required_score: 250 },
  { level_number: 5, required_score: 500 },
];

async function main() {
  for (const level of levels) {
    await prisma.level.upsert({
      where: { level_number: level.level_number },
      update: { required_score: level.required_score },
      create: level,
    });
  }
  console.log(`Seed completed: ${levels.length} levels.`);
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
