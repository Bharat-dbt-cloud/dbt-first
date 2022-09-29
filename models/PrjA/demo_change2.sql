{{
  config(
    materialized='table'
  )
}}


select * from  `gebu-data-ml-day0-01-333910.dbt_retail_banking.loan_master`
where amount>'10000'