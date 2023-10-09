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

| NAME             | NUM_CHANGES |
|------------------|:-----------:|
| Monstera         |      4      |
| Philodendron     |      4      |
| Pothos           |      4      |
| String of pearls |      4      |
| Bamboo           |      3      |
| ZZ Plant         |      3      |

Pothos and String of pearl went out of stock in the last 3 weeks:
```SQL
select * from inventory_snapshot
where inventory = 0;
```

## Part 2 - Modelling challenge
