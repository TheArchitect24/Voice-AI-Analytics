
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select silence_rate
from "irembo"."analytics"."fact_voice_ai_sessions"
where silence_rate is null



  
  
      
    ) dbt_internal_test