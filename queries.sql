-- query 1
select b.booking_id, u.name customer_name, v.name vehicle_name, b.start_date, b.end_date, b.status
  from bookings b
  inner join users u
  on b.user_id = u.user_id
  inner join vehicles v
  on b.vehicle_id = v.vehicle_id;


-- query 2
select * from vehicles v
  where v.status != 'rented'
  and not exists(
  select 1
  from bookings b
  where b.vehicle_id = v.vehicle_id
  )
  order by v;


-- query 3
select * from vehicles
where type = 'car' and status = 'available';

-- query 4
select name as vehicle_name, count(*) as total_bookings
  from bookings b
  inner join vehicles v
  on b.vehicle_id = v.vehicle_id
  group by name
  having count(*) > 2;