
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select final_outcome
from "irembo"."analytics"."fact_voice_ai_sessions"
where final_outcome is null



  
  
      
    ) dbt_internal_test