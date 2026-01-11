

WITH apps as (SELECT
    application_id,
    session_id,
    user_id,
    service_code,
    channel,
    status,
    time_to_submit_sec,
    submitted_at
FROM "irembo"."analytics"."stg_applications"
),

users as (SELECT
    user_id,
    region,
    disability_flag,
    first_time_digital_user
FROM "irembo"."analytics"."stg_users"
)


SELECT 
    a.application_id,
    a.session_id,
    a.user_id,
    a.service_code,
    a.channel,
    a.status,
    a.time_to_submit_sec,
    a.submitted_at,

    u.region,
    u.disability_flag,
    u.first_time_digital_user

FROM apps a
LEFT JOIN users u 
ON a.user_id = u.user_id