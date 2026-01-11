SELECT
    session_id,
  round(ratio_misunderstanding_turns
  + ratio_silence_turns
  + ratio_noise_turns
  + ratio_no_error_type_turns) AS total_ratio
FROM analytics.fact_voice_ai_sessions
WHERE
   round(ratio_misunderstanding_turns
  + ratio_silence_turns
  + ratio_no_error_type_turns
  + ratio_noise_turns)
  > 1.01
