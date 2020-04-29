/*
 Navicat Premium Data Transfer

 Source Server         : pessoa idade
 Source Server Type    : PostgreSQL
 Source Server Version : 120002
 Source Host           : localhost:5432
 Source Catalog        : postgres
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120002
 File Encoding         : 65001

 Date: 29/04/2020 01:01:45
*/


-- ----------------------------
-- Table structure for age
-- ----------------------------



CREATE SEQUENCE age_id_seq START 1;

DROP TABLE IF EXISTS "public"."age";
CREATE TABLE "public"."age" (
  "id" int2 NOT NULL DEFAULT nextval('age_id_seq'::regclass),
  "age" int4,
  "mysql_id" int4
)
;
ALTER TABLE "public"."age" OWNER TO "postgres";

-- ----------------------------
-- Records of age
-- ----------------------------
BEGIN;
INSERT INTO "public"."age" VALUES (1, 10, 1);
INSERT INTO "public"."age" VALUES (2, 20, 2);
INSERT INTO "public"."age" VALUES (3, 30, 3);
INSERT INTO "public"."age" VALUES (4, 40, 4);
INSERT INTO "public"."age" VALUES (5, 50, 5);
COMMIT;

-- ----------------------------
-- Primary Key structure for table age
-- ----------------------------
ALTER TABLE "public"."age" ADD CONSTRAINT "age_pkey" PRIMARY KEY ("id");
