
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ratio_noise_turns
from "irembo"."analytics"."fact_voice_ai_sessions"
where ratio_noise_turns is null



  
  
      
    ) dbt_internal_test