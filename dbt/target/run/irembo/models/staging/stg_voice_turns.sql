
  create view "irembo"."analytics"."stg_voice_turns__dbt_tmp"
    
    
  as (
    SELECT
    turn_id,
    session_id,
    turn_number,
    speaker,
    detected_intent,
    intent_confidence,
    asr_confidence,
    error_type,
    turn_duration_sec,
    created_at
FROM voice_turns
  );