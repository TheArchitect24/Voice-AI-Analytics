
  create view "irembo"."analytics"."stg_users__dbt_tmp"
    
    
  as (
    SELECT
    user_id,
    region,
    disability_flag,
    first_time_digital_user
FROM users
  );