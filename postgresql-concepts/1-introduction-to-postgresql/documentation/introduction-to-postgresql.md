#### create an user
```sql
DROP ROLE IF EXISTS sashank;
CREATE ROLE sashank WITH
    LOGIN
    SUPERUSER
    INHERIT
    CREATEDB
    CREATEROLE
    REPLICATION
    ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:fYOSq+ETNva/5fZA0IZdWg==$S+pTvjt2RlsvKL9Oyu4/JtmeCr9kMYna/vJlF3qKo/s=:sJ1XIwU559BGDg/xVsUiRMNAYpbEB4sIDADzi/NSOE0=';
```

#### create a database
```sql
CREATE DATABASE "learning-postgres"
WITH
OWNER = sashank
ENCODING = 'UTF8'
CONNECTION LIMIT = -1
IS_TEMPLATE = False;
```

#### install sample data files on server `customers.sql`
```sql
select * from "public"."customers"
```

#### install sample data files on server `products.sql`
```sql
select * from "public"."products"
```

#### install sample data files on server `purchases.sql`
```sql
select * from "public"."purchases"
```

#### install Human Resources (hr) database `hr.sql`
```sql
select * from "public"."countries"
select * from "public"."departments"
select * from "public"."employees"
select * from "public"."job_history"
select * from "public"."jobs"
select * from "public"."locations"
select * from "public"."regions"
```

#### install sample stocks market data `stocks_prices.sql`, `stocks_symbols.sql` and `stocks_types.sql`
```sql
select * from "public"."stocks_symbols"
select * from "public"."stocks_types"
select * from "public"."stocks_prices"
```

#### install Northwind database `northwind.sql`
```sql
select * from "public"."categories"
select * from "public"."customer_customer_demo"
select * from "public"."customer_demographics"
select * from "public"."customers"
select * from "public"."employee_territories"
select * from "public"."employees"
select * from "public"."order_details"
select * from "public"."orders"
select * from "public"."products"
select * from "public"."region"
select * from "public"."shippers"
select * from "public"."suppliers"
select * from "public"."territories"
select * from "public"."us_states"
```

#### drop a database `drop_database.sql`
```sql

```