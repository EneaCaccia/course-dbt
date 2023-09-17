# Week 1 project answers
NOTE: all SQL snippets are run as having `dev_db.dbt_enea` as query context

## 1. How many users do we have?
130 users
```SQL
select count(user_id) from stg_users
```

## 2. On average, how many orders do we receive per hour?
7.52 orders per hour.

```SQL
with all_orders as (
        select
            date_trunc('hour', created_at_utc) as order_hour
        from stg_orders
    )
select
    order_hour,
    count(order_hour) order_count,
    avg(count(order_hour)) over () as avg_orders_per_hour
from all_orders
group by order_hour
order by 1 asc
```

## 3. On average, how long does an order take from being placed to being delivered?
It takes on average 93.4 hours, or just below 4 days (3.89 days)

```SQL
select
    avg(
        datediff(
            hour,
            created_at_utc,
            delivered_at_utc
        )
    ) as avg_delivery_time_hours,
    avg(
        datediff(
            day,
            created_at_utc,
            delivered_at_utc
        )
    ) as avg_delivery_time_days
from stg_orders
where delivered_at_utc is not null
```

## 4. How many users have only made one purchase? Two purchases? Three+ purchases?
One Purchase: 25 users
Two Purchases: 28 users
Three or more Purchases: 71 users

```SQL
select
    case
        when purchase_count = 1 then 'one purchase'
        when purchase_count = 2 then 'two purchases'
        when purchase_count >= 3 then 'three or more purchases'
        else 'error'
    end as purchase_group,
    count(*) as user_count
from (
        select
            user_id,
            count(*) as purchase_count
        from stg_orders
        group by
            user_id
    ) as user_purchase_counts
group by purchase_group
```

## 5. On average, how many unique sessions do we have per hour?
On average we have 16.3 sessions per hour.

```SQL
select
    date_trunc('hour', created_at) as hour_of_day,
    count(distinct session_id) as unique_sessions_per_hour,
    avg(count(distinct session_id)) over () as avg_unique_sessions_per_hour
from stg_events
group by hour_of_day
order by hour_of_day;
```