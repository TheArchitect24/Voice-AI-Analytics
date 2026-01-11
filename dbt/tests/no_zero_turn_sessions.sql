SELECT
    session_id
FROM {{ ref('fact_voice_ai_sessions') }}
WHERE total_turns = 0
