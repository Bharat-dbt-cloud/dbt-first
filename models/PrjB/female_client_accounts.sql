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
    from `gebu-data-ml-day0-01-333910.dbt_retail_banking.client_information` where sex like 'Female'

),

card_details as (

    select
       card_id,disp_id
    from `gebu-data-ml-day0-01-333910.dbt_retail_banking.card_details`

),

final as (

    select
        card_details.card_id,
        client_information.first,client_information.middle,client_information.last,client_information.sex, client_information.age,
        client_account_relations.disp_id, client_account_relations.client_id
        
    from  client_information

    join client_account_relations using (client_id)
    join card_details using (disp_id)
    

)

select * from final