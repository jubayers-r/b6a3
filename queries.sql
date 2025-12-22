-- create enum types

DO
  $$
  BEGIN

  -- user_role
  if not exists (select 1 from pg_type where typname = 'user_role') then
    create type user_role as enum ('Admin', 'Customer');
  end if;

  --vehicle_type
  if not exists (select 1 from pg_type where typname = 'vehicle_type') then
  create type vehicle_type as enum ('car', 'bike', 'truck');
  end if;

  --avilibility_status
  if not exists (select 1 from pg_type where typname = 'avilibility_status') then
  create type avilibility_status as enum ('available', 'maintenance', 'rented');
  end if;

  -- booking_status
  if not exists (select 1 from pg_type where typname = 'booking_status') then
  create type booking_status as enum ('completed', 'confirmed', 'pending');
  end if;

  END
  $$


  drop table bookings;
  drop table vehicles;
  drop table users;

-- create tables

create table if not exists users(
  user_id int primary key,
  name varchar(100) not null,
  email text not null unique,
  phone varchar(10),
  role user_role not null
);

create table if not exists vehicles(
  vehicle_id int primary key,
  name varchar(100) not null,
  type vehicle_type not null,
  model varchar(4) not null,
  registration_number varchar(100) not null,
  rental_price int not null,
  status avilibility_status not null
);

create table if not exists bookings(
  booking_id int primary key,
  user_id int not null references users(user_id) on delete cascade,
  vehicle_id int not null references vehicles(vehicle_id) on delete cascade,
  start_date date not null,
  end_date date not null,
  status booking_status not null,
  total_cost int not null
);



-- insert

-- Users Table
INSERT INTO Users (user_id, name, email, phone, role) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');

-- Vehicles Table
INSERT INTO Vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');

-- Bookings Table
INSERT INTO Bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);



-- query 1

select b.booking_id, u.name as customer_name, v.name as vehicle_name, b.start_date, b.end_date, b.status
  from bookings as b
  inner join users as u
  on b.user_id = u.user_id
  inner join vehicles as v
  on b.vehicle_id = v.vehicle_id;


-- query 2
-- SELECT * FROM bookings;

-- select *
--   from vehicles as v
--   inner join bookings as b
--   on v.vehicle_id != b.vehicle_id
--   where v.status != 'rented'
--   AND v.status

-- select * from vehicles
-- where not exists () ; -- subquery required


-- query 3

select * from vehicles
where type = 'car' and status = 'available';

-- query 4

select name as vehicle_name, count(*) as total_bookings
  from bookings as b
  inner join vehicles as v
  on b.vehicle_id = v.vehicle_id
  group by name
  having count(*) > 2;