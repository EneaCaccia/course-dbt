select distinct event_type events from 
{{ ref("stg_events") }}