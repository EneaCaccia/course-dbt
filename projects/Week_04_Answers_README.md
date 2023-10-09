# Project week 4 - Answers

## Part 1 - dbt snapshots
### Question 2
The products which changed from week 3 to 4 are:
- Pothos
- Monstera
- Bamboo
- ZZ Plant
- String of pearls
- Philodendron

### Question 3
The items with the most variability are in the table below, where the last column is the number of times the stock changes since we started taking snapshots.

|  NAME             |  NUM_CHANGES | 
| ------------------| :-----------:| 
|  Monstera         |       4      | 
|  Philodendron     |       4      | 
|  Pothos           |       4      | 
|  String of pearls |       4      | 
|  Bamboo           |       3      | 
|  ZZ Plant         |       3      | 

Pothos and String of pearl went out of stock in the last 3 weeks:
```SQL
select * from inventory_snapshot
where inventory = 0;
```

## Part 2 - Modelling challenge
I kept the modelling for this week simple.
I created two models:
- `fact_funnel_by_product` which shows total views and conversion rates by product. of course this model is simplistic but it could answer questions like "which are the worst performing products in terms of conversion rate?"
- `report_funnel` which produces the high level funnel, not broken down in any dimension. here it is:


| PAGE_VIEWS | ADD_TO_CARTS | CHECKOUTS | CONVERSION_TO_CART | CONVERSION_TO_CHECKOUT |
|---|---|---|---|----|
| 1,871 | 986 | 862 | 0.53 |  0.46 |

Here we can see that the biggest drop off point is the conversion to cart. amazingly almost all that concert to cart checkout ;)

I created an exposure for a fictional dashboard in `models/marts/product/_exposures.yml`

```yml
exposures:  
  - name: Product Funnel Dashboard
    description: >
      Totally immaginary dashboard
    type: dashboard
    maturity: high
    url: https://media3.giphy.com/media/V4NSR1NG2p0KeJJyr5/giphy.gif?cid=ecf05e47l8ceuw5e8z3aijhbnjoo1ecgi5qeazrpe9a21wcm&ep=v1_gifs_search&rid=giphy.gif&ct=g
    owner:
      name: Me
      email: me@greenery.com
    depends_on:
      - ref('fact_funnel_by_product')
      - ref('dim_products')
```

## Part 3: Reflections
### 3a
- I would pitch dbt by saying that it would decrease the costs to manage the complexity of our data stack and to spend less resources in knowledge transfer, as newcomers can dive into the codebase and immediately understand the structure of our tables.
- I think dbt is a great tool in the sense that it enables thinking about data modelling in a more sustainable way. I feel quite empowered both by having learned the tool and by the way in which it made me reflect on data modelling.

### 3b
Actually this is what i'm doing at work right now. I setup a dbt deployment with dagster as scheduler. The first thing to do now is connect dbt with our warehouse. then i will take one dataset and try to remodel it using dbt and putting the runs on a dagster schedule. this should give enough experience to set some best practices for the team and transition all our data modelling activity to dbt. as a final step we will rebuild our BI dasboards to take advantage of dbt models, so that the logic beghind reports is easily inspectable.