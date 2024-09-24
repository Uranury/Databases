-- 1 --
create database lab2;

-- 2 --
create table countries (
    country_id SERIAL primary key,
    country_name VARCHAR(50),
    region_id integer,
    population integer
);

-- 3 --
insert into countries (country_name, region_id, population)
values ('France', 3, 67000000);

-- 4 --
insert into countries (country_id, country_name)
values (DEFAULT, 'Russia');

-- 5 --
insert into countries (country_name, region_id, population)
values ('Australia', NULL, 25000000);

-- 6 --
insert into countries (country_name, region_id, population)
values
        ('Brazil', 4, 21300000),
        ('Germany', 5, 19000000),
        ('Spain', 10, 40000000);

-- 7 --
alter table countries
alter column country_name set default 'Kazakhstan';

-- 8 --
insert into countries (country_name)
values (DEFAULT);

-- 9 --
insert into countries
default values;

-- 10 --
create table countries_new
(LIKE countries);

-- 11 --
insert into countries_new
select * from countries;

-- 12 --
update countries
set region_id = 1
where region_id is null;

-- 13 --
select country_name,
       countries.population * 1.10 as "New population"
from countries;

-- 14 --
delete from countries
where population < 100000;

-- 15 --
delete from countries_new
using countries
where countries_new.country_id = countries.country_id
returning *;

-- 16 --
delete from countries
returning *;








