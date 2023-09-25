# Project week 2 - Answers

## 1. What is our user repeat rate?
Our user repeat rate is around 80% (~0.798)

```SQL
with user_order_count as (
    select
        user_id,
        count(user_id) orders
    from
        stg_orders
    group by
        all
)
select
    avg(
        case
            when orders > 1 then 1
            else 0
        end
    )
from
    user_order_count;
```

## 2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

NOTE: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.

Good indicators of repeat customer:
- Number of past purchases. A loyal user will likely purchase again
- Users that are engaged with the platform, e.g. who browse for new products or review purchased ones.
- Users who have items in their cart but did not arrive at the checkout stage
- Users who placed high value orders or orders with many items
- Users who have recently purchased might be more likely to repurchase compared to a user who purchased a long time ago
- Users who have used promotions. This might indicate price sensitivity
- Users who buy according to specific patterns, such as a particular period in the year or at particular events (christmas, autumn, ...)

Indicators of one-time buyers:
- Bad experience with the the platform, such as failed or delayed delivery
- Short session length or low page visits per session could indicate low engagement with the product
- Negative product reviews
- Purchases with only one product or low value order could indicate a one-time purchase
- High return rate of orders

I would probably want to obtain additional data on product reviews or the response of customers to engagement campaigns or special promos.

## 3. Explain the product mart models you added. Why did you organize the models in the way you did?

Under products i created two models:
1. `fact_session_info` contains some information at the user-session granularity. This model is intended to identify patterns in the browsing of users. For example we could answer the question "how many page views happened before checkout" or "how many products were added to the cart". Additionally it can help with identifying users with products in the cart who could be converted into purchases. This model is intended for the Marketing team.
2. `fact_page_views` is a table intended to answer the questions outlined in the project questions. Which products receive more views? Daily orders per product? ... It contains information on the products and the traffic and orders they receive.
The current model is very simple, showing total page views, additions to carts and two conversion rations.
An extension to the model could add the time dimension to allow for more meaningful analysis.




