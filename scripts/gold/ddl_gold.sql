/* 
==================================================
DDL Script: Create Gold Views
==================================================

Script purposeL
This script creates views in the 'Gold layer in the data warehouse,
The Gold layer represents the final dimension and fact tables (Start schema)

Each view performs transformations and combines data from Silver layer to produce
a clean, enriched and businss ready dataset.

Usage:
These views can be queried directly for analytics and reporting.
*/
-- ========================================================
IF OBJECT_ID ('gold.dim_customer' , 'V') IS NOT NULL
	DROP TABLE gold.dim_customer;

GO
CREATE VIEW gold.dim_customers AS 
SELECT  
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number ,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
ci.cst_marital_status AS marital_status ,
CASE WHEN ci.cst_gndr !='n/a' THEN ci.cst_gndr --- CRM is the Master for the gender Info 
ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate AS birthdate,
ci.cst_creat_date AS create_date,

la.cntry AS country
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid

  
  IF OBJECT_ID ('gold.dim_product' , 'V') IS NOT NULL
	DROP TABLE gold.dim_product;

GO

CREATE VIEW gold.dim_products AS 

SELECT
ROW_NUMBER() OVER (ORDER BY pn.prd_start, pn.prd_key) AS product_key,
pn.prd_id AS product_id,
pn.prd_key AS product_number,
pn.prd_nm AS product_name,
pn.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pn.prd_cost AS cost,
pn.prd_line AS product_line,
pn.prd_start AS start_date,
pn.prd_end_dt AS end_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_giv2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- FILTER ALL HISTORICAL DATA

 IF OBJECT_ID (' gold.facts_sales' , 'V') IS NOT NULL
	DROP TABLE  gold.facts_sales;

GO

CREATE VIEW gold.facts_sales AS 

SELECT
sd.sls_ord_num AS order_number,
pr.product_key,
cu.customer_id,
sd.sls_order_dt AS order_name,
sd.sls_ship_dt AS shipping_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales_amount,
sd.sls_quant AS quantity,
sd.sls_price AS price 
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key =pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id




