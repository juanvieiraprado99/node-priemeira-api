CREATE TYPE "public"."user_roles" AS ENUM('studant', 'manager');--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "password" text NOT NULL;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "role" "user_roles" DEFAULT 'studant' NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX "enrollments_userId_courseId_index" ON "enrollments" USING btree ("userId","courseId");