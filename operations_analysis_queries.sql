-- Karma Dog Training Operations Efficiency Analysis
-- Portfolio SQL queries

-- 1. Trainer workload, revenue, cancellation rate, and satisfaction
SELECT
    t.trainer_id,
    t.trainer_name,
    l.city,
    t.certification_level,
    COUNT(s.session_id) AS total_sessions,
    SUM(CASE WHEN s.cancelled = 'No' THEN 1 ELSE 0 END) AS completed_sessions,
    ROUND(100.0 * SUM(CASE WHEN s.cancelled = 'Yes' THEN 1 ELSE 0 END) / COUNT(s.session_id), 1) AS cancellation_rate_pct,
    ROUND(AVG(CASE WHEN s.cancelled = 'No' THEN s.outcome_score END), 2) AS avg_outcome_score,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM trainers t
JOIN locations l ON t.location_id = l.location_id
LEFT JOIN sessions s ON t.trainer_id = s.trainer_id
LEFT JOIN payments p ON s.session_id = p.session_id
GROUP BY t.trainer_id, t.trainer_name, l.city, t.certification_level
ORDER BY total_sessions DESC;

-- 2. Location utilization and revenue efficiency
SELECT
    l.city,
    l.region,
    COUNT(s.session_id) AS total_sessions,
    ROUND(COUNT(s.session_id) / 130.0, 1) AS avg_sessions_per_week,
    l.max_weekly_session_capacity,
    ROUND(100.0 * (COUNT(s.session_id) / 130.0) / l.max_weekly_session_capacity, 1) AS capacity_utilization_pct,
    ROUND(SUM(p.amount), 2) AS total_revenue,
    ROUND(SUM(p.amount) - (l.monthly_rent * 30), 2) AS revenue_less_estimated_rent
FROM locations l
LEFT JOIN trainers t ON l.location_id = t.location_id
LEFT JOIN sessions s ON t.trainer_id = s.trainer_id
LEFT JOIN payments p ON s.session_id = p.session_id
GROUP BY l.location_id, l.city, l.region, l.max_weekly_session_capacity, l.monthly_rent
ORDER BY total_revenue DESC;

-- 3. Peak booking days
SELECT
    CASE strftime('%w', session_date)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS sessions,
    ROUND(AVG(outcome_score), 2) AS avg_outcome_score,
    ROUND(100.0 * SUM(CASE WHEN cancelled = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS cancellation_rate_pct
FROM sessions
GROUP BY strftime('%w', session_date)
ORDER BY sessions DESC;

-- 4. Service type performance
SELECT
    s.service_type,
    COUNT(*) AS total_sessions,
    ROUND(SUM(p.amount), 2) AS total_revenue,
    ROUND(AVG(CASE WHEN s.cancelled = 'No' THEN s.outcome_score END), 2) AS avg_outcome_score,
    ROUND(100.0 * SUM(CASE WHEN s.cancelled = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS cancellation_rate_pct
FROM sessions s
JOIN payments p ON s.session_id = p.session_id
GROUP BY s.service_type
ORDER BY total_revenue DESC;

-- 5. Client retention proxy: repeat clients by referral source
WITH client_session_counts AS (
    SELECT
        c.client_id,
        c.referral_source,
        COUNT(s.session_id) AS total_sessions,
        SUM(p.amount) AS client_revenue
    FROM clients c
    LEFT JOIN sessions s ON c.client_id = s.client_id AND s.cancelled = 'No'
    LEFT JOIN payments p ON s.session_id = p.session_id
    GROUP BY c.client_id, c.referral_source
)
SELECT
    referral_source,
    COUNT(*) AS total_clients,
    SUM(CASE WHEN total_sessions >= 3 THEN 1 ELSE 0 END) AS repeat_clients,
    ROUND(100.0 * SUM(CASE WHEN total_sessions >= 3 THEN 1 ELSE 0 END) / COUNT(*), 1) AS repeat_client_rate_pct,
    ROUND(AVG(client_revenue), 2) AS avg_client_lifetime_value
FROM client_session_counts
GROUP BY referral_source
ORDER BY repeat_client_rate_pct DESC;

-- 6. Hypothesis test: does trainer overload correlate with lower outcome score?
WITH trainer_metrics AS (
    SELECT
        t.trainer_id,
        t.trainer_name,
        COUNT(s.session_id) AS total_sessions,
        ROUND(AVG(CASE WHEN s.cancelled = 'No' THEN s.outcome_score END), 2) AS avg_outcome_score,
        ROUND(100.0 * SUM(CASE WHEN s.cancelled = 'Yes' THEN 1 ELSE 0 END) / COUNT(s.session_id), 1) AS cancellation_rate_pct
    FROM trainers t
    JOIN sessions s ON t.trainer_id = s.trainer_id
    GROUP BY t.trainer_id, t.trainer_name
)
SELECT
    *,
    CASE
        WHEN total_sessions >= 250 THEN 'High workload'
        WHEN total_sessions >= 125 THEN 'Moderate workload'
        ELSE 'Low workload'
    END AS workload_bucket
FROM trainer_metrics
ORDER BY total_sessions DESC;
