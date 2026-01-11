
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select misunderstanding_rate
from "irembo"."analytics"."fact_voice_ai_sessions"
where misunderstanding_rate is null



  
  
      
    ) dbt_internal_test