
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select user_id
from "irembo"."analytics"."fact_voice_ai_sessions"
where user_id is null



  
  
      
    ) dbt_internal_test