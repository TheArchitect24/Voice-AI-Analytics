{{ config(
    materialized='table'
) }}

WITH sessions AS (
    SELECT
        session_id,
        user_id,
        channel,
        language,
        total_duration_sec,
        total_turns,
        final_outcome,
        transfer_reason,
        created_at AS session_created_at
    FROM {{ ref('stg_voice_sessions') }}
),


agg_voice_turns AS (
    SELECT 
        session_id,
        count(turn_id) turn_id_count,
        sum(turn_duration_sec) total_turn_duration_sec,
        avg(intent_confidence) avg_turn_intent_confidence,
        avg(asr_confidence) avg_turn_asr_confidence,
        (count(*) filter (WHERE error_type = 'misunderstanding')::float)/count(*) AS ratio_misunderstanding_turns,
        (count(*) filter (WHERE error_type = 'noise')::float)/count(*) AS ratio_noise_turns,
        (count(*) filter (WHERE error_type = 'silence')::float)/count(*) AS ratio_silence_turns,
        (count(*) filter (WHERE coalesce(error_type, '') NOT IN ('silence', 'misunderstanding', 'noise'))::float) / count(*) AS ratio_no_error_type_turns
    FROM {{ ref('stg_voice_turns') }}
    GROUP BY session_id
),


users_enriched AS (
    SELECT
        user_id,
        region,
        disability_flag,
        first_time_digital_user
    FROM {{ ref('stg_users') }}
),

ai_metrics AS (
    SELECT
        session_id,
        avg_asr_confidence,
        avg_intent_confidence,
        misunderstanding_rate,
        silence_rate,
        recovery_success,
        escalation_flag
    FROM {{ ref('stg_voice_ai_metrics') }}
)

SELECT
    s.session_id,
    s.user_id,

    u.region,
    u.disability_flag,
    u.first_time_digital_user,

    s.channel,
    s.language,

    s.session_created_at,
    s.total_duration_sec,
    s.total_turns,
    s.final_outcome,
    COALESCE(s.transfer_reason, 'No Transfer') transfer_reason,

    m.avg_asr_confidence,
    m.avg_intent_confidence,
    m.misunderstanding_rate,
    m.silence_rate,
    m.recovery_success,
    m.escalation_flag,

    a.avg_turn_intent_confidence,
    a.avg_turn_asr_confidence,
    a.ratio_misunderstanding_turns,
    a.ratio_noise_turns,
    a.ratio_silence_turns,
    a.ratio_no_error_type_turns,


    CASE WHEN s.final_outcome = 'completed' THEN 1 ELSE 0 END
        AS is_completed_session,

    CASE WHEN s.final_outcome = 'abandoned' THEN 1 ELSE 0 END
        AS is_abandoned_session,

    CASE WHEN s.final_outcome = 'transferred' THEN 1 ELSE 0 END
        AS is_transferred_session
        
FROM sessions s
LEFT JOIN users_enriched u
    ON s.user_id = u.user_id
INNER JOIN ai_metrics m
    ON s.session_id = m.session_id
INNER JOIN agg_voice_turns a
    ON s.session_id = a.session_id
