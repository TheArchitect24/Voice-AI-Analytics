
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select channel
from "irembo"."analytics"."fact_voice_ai_sessions"
where channel is null



  
  
      
    ) dbt_internal_test