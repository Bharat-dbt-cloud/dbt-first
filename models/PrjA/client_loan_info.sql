{{
  config(
    materialized='table'
  )
}}

with client_account_relations as (

    select
        disp_id, client_id, account_id
    from `gebu-data-ml-day0-01-333910.dbt_retail_banking.client_account_relations`

),

client_information as (

    select
        client_id,first,middle,last,sex, age
    from `gebu-data-ml-day0-01-333910.dbt_retail_banking.client_information`

),

card_details as (

    select
       card_id,disp_id
    from `gebu-data-ml-day0-01-333910.dbt_retail_banking.card_details`

),

loan_master as(
     select
       loan_id, account_id, amount
     from `gebu-data-ml-day0-01-333910.dbt_retail_banking.loan_master`

),

final as (

    select
        loan_master.loan_id, loan_master.account_id, loan_master.amount,
        card_details.card_id,
        client_information.first,client_information.middle,client_information.last,client_information.sex, client_information.age,
        client_account_relations.disp_id, client_account_relations.client_id
        
    from loan_master 

    join client_account_relations using (account_id)
    join card_details using (disp_id)
    join client_information using (client_id)

)

select * from final