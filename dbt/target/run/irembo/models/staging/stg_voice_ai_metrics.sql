
  create view "irembo"."analytics"."stg_voice_ai_metrics__dbt_tmp"
    
    
  as (
    SELECT
    session_id,
    avg_asr_confidence,
    avg_intent_confidence,
    misunderstanding_rate,
    silence_rate,
    recovery_success,
    escalation_flag
FROM voice_ai_metrics
  );