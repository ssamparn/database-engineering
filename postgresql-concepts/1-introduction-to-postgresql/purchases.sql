-- ---------------------
--  Drop purchases table
-- ---------------------

DROP TABLE IF EXISTS "public"."purchases";

-- -----------------------
--  Create purchases table
-- -----------------------

CREATE TABLE "public"."purchases" (
	"purchase_id" int4 NOT NULL,
	"product_id" int4,
	"customer_id" int4
)
WITH (OIDS=FALSE);

-- ------------------------------------
--  Insert records into purchases table
-- ------------------------------------

BEGIN;
INSERT INTO "public"."purchases" VALUES ('1', '1', '1');
INSERT INTO "public"."purchases" VALUES ('2', '3', '1');
INSERT INTO "public"."purchases" VALUES ('3', '6', '2');
INSERT INTO "public"."purchases" VALUES ('4', '6', '2');
INSERT INTO "public"."purchases" VALUES ('5', '3', '3');
INSERT INTO "public"."purchases" VALUES ('6', '2', '3');
INSERT INTO "public"."purchases" VALUES ('7', '4', '4');
INSERT INTO "public"."purchases" VALUES ('8', '2', '4');
INSERT INTO "public"."purchases" VALUES ('9', '3', '5');
INSERT INTO "public"."purchases" VALUES ('10', '6', '5');
COMMIT;

-- --------------------------------------
-- Add primary key to the purchases table
-- --------------------------------------

ALTER TABLE "public"."purchases" ADD PRIMARY KEY ("purchase_id") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- ----------------------------------------
--  Add Foreign keys to the purchases table
-- ----------------------------------------

ALTER TABLE "public"."purchases" ADD CONSTRAINT "fk_customer_purchase" FOREIGN KEY ("customer_id") REFERENCES "public"."customers" ("customer_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE "public"."purchases" ADD CONSTRAINT "fk_purchase_product" FOREIGN KEY ("product_id") REFERENCES "public"."products" ("product_id") ON UPDATE NO ACTION ON DELETE NO ACTION NOT DEFERRABLE INITIALLY IMMEDIATE;
