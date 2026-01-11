
  create view "irembo"."analytics"."stg_voice_sessions__dbt_tmp"
    
    
  as (
    SELECT
    session_id,
    user_id,
    channel,
    language,
    total_duration_sec,
    total_turns,
    final_outcome,
    transfer_reason,
    created_at
FROM voice_sessions
  );