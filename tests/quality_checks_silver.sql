/* 
======================================================================================
QUALITY CHECKS
======================================================================================
Script purpose:
This script performs various quality checks for data consitency, accuracym and standardisation. 
It includes:
- Check for duplicates
-Unwanted spaces in strings field
-Invalid dates ranges
- Data consistency between related fields.

Usage Notes:
- Run these checks after loading silver Layer
-Investigate and resolve any discrepancies found during the checks

============================================================================================
*/


--Data Standardization & Consitency
SELECT DISTINCT
gen
FROM silver.erp_cust_az12

---Check for Unwanted Spaces
-- Expectation No results
SELECT *
FROM silver.erp_px_cat_giv2
WHERE cat != TRIM(cat)
    OR subcat != TRIM(subcat) 
    OR maintance != TRIM(maintance)

--Check for duplicates 
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) <1

--Check for invalid Dates
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt


