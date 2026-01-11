
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT
    session_id
FROM "irembo"."analytics"."fact_voice_ai_sessions"
WHERE total_turns = 0
  
  
      
    ) dbt_internal_test