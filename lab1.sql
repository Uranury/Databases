create database lab1;
create table users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

alter table users
add column isadmin integer;

alter table users
alter column isadmin type boolean using isadmin::boolean;

alter table users
alter column isadmin set default false;

alter table users
add primary key (id);

create table tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id integer,
    primary key(id),
    foreign key(user_id) references users(id)
);

drop table tasks;

drop database lab1


