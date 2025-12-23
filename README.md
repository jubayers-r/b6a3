### Query 1: JOIN

Retrieve booking information along with:

- Customer name
- Vehicle name

**Concepts used**: INNER JOIN

```sql
select b.booking_id, u.name customer_name, v.name vehicle_name, b.start_date, b.end_date, b.status
  from bookings b
  inner join users u
  on b.user_id = u.user_id
  inner join vehicles v
  on b.vehicle_id = v.vehicle_id;
```

**Explaination**:
- step 1: select the columns we want after join from the table we want the most infro from (in this case we want most columns from bookings so bookings has been taken as primary table)
- step 2: determine which columns are missing in the primary key that we want but exists in different table but has some foreign key in the primary table (in this case, username and vehicle name was missing, only the ids were there)
- step 3: inner join the tables on the foeign key conditions so that we get the exact matching values (in this case we want customer name and vehicle name, and we matched thowse by matching vehicle id from vehicles and userid from users matching with bookings table)

### Query 2: EXISTS

Find all vehicles that have never been booked.

**Concepts used**: NOT EXISTS

```sql
select * from vehicles v
  where v.status != 'rented'
  and not exists(
  select 1
  from bookings b
  where b.vehicle_id = v.vehicle_id
  )
  order by v;
```
**Explaination**:

- step 1: select all the columns from the table vehicles, but we need to make sure 2 conditions passes (with an and operator)
- step 2: condition 1: vehicle status is rented
- step 3: condition 2: that vehicle doesnt exists on bookings, so used not exists clause to find the never ever rented cars

### Query 3: WHERE

Retrieve all available vehicles of a specific type (e.g. cars).

**Concepts used**: SELECT, WHERE

```sql
select * from vehicles
where type = 'car' and status = 'available';
```

**Explaination**:

- step 1: select every column from vehicles, but we need to make sure 2 conditions passes (with an and operator)
- step 2: condition 1: vehicle type is 'car';
- step 3: condition 2: vehicle status is 'avilable';

### Query 4: GROUP BY and HAVING

Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

**Concepts used**: GROUP BY, HAVING, COUNT


```sql
select name vehicle_name, count(*) as total_bookings
  from bookings b
  inner join vehicles v
  on b.vehicle_id = v.vehicle_id
  group by name
  having count(*) > 2;
```

**Explaination**:

-- step 1: select vehicle name and count of that specific vehicles from bookings table, but to get vehicle names we need to
-- step 2: inner join vehicles table where both tables vehicles id matches and to get count of each car that has more than 2 bookings we need to
- step 3: group by name with having clause that passes 2 count