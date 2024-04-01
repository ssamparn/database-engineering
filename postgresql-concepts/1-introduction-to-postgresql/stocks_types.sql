-- ------------------------
--  Drop stocks_types table
-- ------------------------
DROP TABLE IF EXISTS "public"."stocks_types";

-- --------------------------
--  Create stocks_types table
-- --------------------------

CREATE TABLE "public"."stocks_types" (
	"type_id" int4 NOT NULL,
	"type_code" varchar(10) NOT NULL COLLATE "default",
	"type_name" varchar(255) NOT NULL COLLATE "default"
)
WITH (OIDS=FALSE);

-- ---------------------------------------
--  Insert records into stocks_types table
-- ---------------------------------------
BEGIN;
INSERT INTO "public"."stocks_types" VALUES ('1','EQS','Stock');
INSERT INTO "public"."stocks_types" VALUES ('2','ETF','Exchange Traded Fund');
COMMIT;

-- --------------------------------------
--  Add primary key to stocks_types table
-- --------------------------------------

ALTER TABLE "public"."stocks_types" ADD PRIMARY KEY ("type_id") NOT DEFERRABLE INITIALLY IMMEDIATE;