# SQL Query Examples & Documentation

A comprehensive guide demonstrating fundamental SQL concepts through a vehicle booking system database.

## Table of Contents
- [Query 1: INNER JOIN](#query-1-inner-join)
- [Query 2: Subquery with EXISTS](#query-2-subquery-with-exists)
- [Query 3: Filtering with WHERE](#query-3-filtering-with-where)
- [Query 4: Aggregation with GROUP BY](#query-4-aggregation-with-group-by)
- [Best Practices](#best-practices-demonstrated)

---

## Query 1: INNER JOIN

### Objective
Retrieve comprehensive booking information including customer names and vehicle names by joining multiple tables.

### SQL Query
```sql
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

### Concepts Used
- `INNER JOIN` - Combines rows from multiple tables based on related columns
- Table aliases (`b`, `u`, `v`) for improved readability

### Explanation
1. **Primary table selection**: Begin with the `bookings` table as it contains the core information needed
2. **Identify missing data**: Customer and vehicle names exist in separate tables (`users` and `vehicles`)
3. **Join operations**:
   - Join `users` table on matching `user_id` to retrieve customer names
   - Join `vehicles` table on matching `vehicle_id` to retrieve vehicle names
4. **Result**: A comprehensive view combining booking details with human-readable names

---

## Query 2: Subquery with EXISTS

### Objective
Identify all vehicles that have never been booked in the system.

### SQL Query
```sql
SELECT *
FROM vehicles v
WHERE v.status != 'rented'
  AND NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
  )
ORDER BY v.vehicle_id;
```

### Concepts Used
- `NOT EXISTS` - Tests for the absence of rows in a subquery
- Subquery - Nested query used for conditional filtering
- `WHERE` clause with multiple conditions

### Explanation
1. **Main query**: Select all columns from the `vehicles` table
2. **Condition 1**: Filter vehicles where status is not 'rented'
3. **Condition 2**: Use `NOT EXISTS` with a correlated subquery to exclude vehicles that appear in the `bookings` table
4. **Sorting**: Order results by vehicle_id for consistent presentation
5. **Result**: Returns only vehicles with no booking history

---

## Query 3: Filtering with WHERE

### Objective
Retrieve all available vehicles of a specific type (cars only).

### SQL Query
```sql
SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available';
```

### Concepts Used
- `SELECT` - Retrieves data from database
- `WHERE` clause - Filters records based on specified conditions
- Logical `AND` operator - Combines multiple conditions

### Explanation
1. **Column selection**: Retrieve all columns using `*`
2. **Condition 1**: Filter by vehicle type equals 'car'
3. **Condition 2**: Filter by status equals 'available'
4. **Logic**: Both conditions must be true (AND operator)
5. **Result**: Returns only available cars ready for booking

---

## Query 4: Aggregation with GROUP BY

### Objective
Calculate total bookings per vehicle and display only vehicles with more than 2 bookings.

### SQL Query
```sql
SELECT
    v.name AS vehicle_name,
    COUNT(*) AS total_bookings
FROM bookings b
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(*) > 2;
```

### Concepts Used
- `COUNT()` - Aggregate function to count rows
- `GROUP BY` - Groups rows sharing a common attribute
- `HAVING` - Filters grouped results (post-aggregation filter)
- `INNER JOIN` - Combines tables to access vehicle names

### Explanation
1. **Join operation**: Link `bookings` with `vehicles` to access vehicle names
2. **Aggregation**: Use `COUNT(*)` to calculate total bookings per vehicle
3. **Grouping**: Group results by vehicle name to aggregate bookings per vehicle
4. **Post-aggregation filter**: Apply `HAVING` clause to include only vehicles with more than 2 bookings
5. **Result**: Returns popular vehicles that have been booked multiple times

---


## Best Practices Demonstrated

1. **Use table aliases** for cleaner, more readable queries
2. **Apply meaningful column aliases** (e.g., `AS customer_name`) for clarity
3. **Leverage appropriate joins** to combine related data efficiently
4. **Use EXISTS/NOT EXISTS** for performant existence checks
5. **Apply HAVING for aggregate filters** rather than WHERE
6. **Order results** for consistent, predictable output
7. **Use proper indentation** for complex queries to improve readability
