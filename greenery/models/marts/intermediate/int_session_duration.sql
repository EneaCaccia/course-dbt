select session_id,
    min(created_at) session_start,
    max(created_at) session_end,
    timediff(minute, min(created_at), max(created_at)) session_duration
from {{ ref('stg_events') }}
group by session_id