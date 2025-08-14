import { fakerPT_BR as faker } from "@faker-js/faker";
import { db } from "./client.ts";
import { courses, enrollments, users } from "./schema.ts";

async function seed() {
  const usersInsert = await db.insert(users).values([
    { name: faker.person.fullName(), email: faker.internet.email() },
    { name: faker.person.fullName(), email: faker.internet.email() },
    { name: faker.person.fullName(), email: faker.internet.email() },
  ]);

  const coursesInsert = await db
    .insert(courses)
    .values([{ title: faker.lorem.words(4) }, { title: faker.lorem.words(4) }]);

  await db.insert(enrollments).values([
    { courseId: coursesInsert[0].id, userId: usersInsert[0].id },
    { courseId: coursesInsert[0].id, userId: usersInsert[1].id },
    { courseId: coursesInsert[1].id, userId: usersInsert[2].id },
  ]);
}

seed();
