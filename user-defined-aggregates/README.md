# User Defined Aggregates

## Felix Geisendörfer

### 2017-12-19 - Berlin PostgreSQL Meetup

---

# Example: Manufacturing Yields

```sql
CREATE TABLE yields AS
SELECT *
FROM (VALUES
  ('day-1', 'step-1', 0.8),
  ('day-1', 'step-2', 0.9),
  ('day-1', 'step-3', 0.1),
  ('day-2', 'step-1', 0.6),
  ('day-2', 'step-2', 0.4),
  ('day-2', 'step-3', 0.5)
)v (day, step, yield);
```
---

# Which day was better?

---

# Which day was better?

```sql
SELECT day, avg(yield)
FROM yields
GROUP BY 1
ORDER BY 2 DESC;
```
```
  day  | avg
-------+-----
 day-1 | 0.6
 day-2 | 0.5
```

---

# avg = 🤦🏻‍♂️

---

# Rolled Throughput Yield

$$
\mathit{rpy} = \mathit{\text{yield at step 1}} * \mathit{\text{yield at step 2}} * \mathit{...} * \mathit{\text{yield at step n}}
$$

---

# Which day was better?

```sql
SELECT day, product(yield)
FROM yields
GROUP BY 1
ORDER BY 2 DESC;
```
```
ERROR:  function product(numeric) does not exist
LINE 1: SELECT day, product(yield)
```

# 🙈

---

# And with some other body copy

> The best way to predict the future is to invent it
-- Alan Kay
