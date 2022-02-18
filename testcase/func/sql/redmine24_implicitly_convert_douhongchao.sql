drop table if exists cs_int;
drop table if exists cs_int2;
drop table if exists cs_varchar;
drop table if exists cs_char;
create table cs_int (id int);
insert into cs_int select generate_series(1,5)::char;
create table cs_int2 (id int);
insert into cs_int2 select generate_series(1,5);
create table cs_varchar(id varchar,name varchar);
insert into cs_varchar select generate_series(1,10)::varchar,random()::varchar;
create index on cs_varchar(id);
create table cs_char (id char(2));
insert into cs_char select generate_series(1,5)::char;
select * from cs_varchar where id=2;
select * from cs_varchar where id=2.0;
select * from cs_char where id=2;    
select * from cs_char where id=2.0;
select * from cs_varchar where id in (select id from cs_int);
select a.id,b.id from cs_varchar a,cs_int b where a.id=b.id;
-- ERROR: unsupported comparison operator: <varchar> = <int>
-- SQLSTATE: 22023
select id+1 from cs_varchar;
-- ERROR: unsupported binary operator: <varchar> + <int>
-- SQLSTATE: 22023
select * from cs_char where id <2;
select * from cs_char where id>2;
select * from cs_varchar where id<2;
select * from cs_varchar where id>2;
select * from cs_varchar where id<2.1;
-- ERROR: unsupported comparison operator: <varchar> > <decimal>
select * from cs_varchar where id between 1 and 3;
select * from cs_varchar where id between 3 and 1;
select * from cs_varchar where id between 1.9 and 3.0;
-- ERROR: unsupported comparison operator: <varchar> < <decimal>
select * from cs_char where id>2.1;
-- ERROR: unsupported comparison operator: <char> > <decimal>
select * from cs_char where id>2.1;
-- ERROR: unsupported comparison operator: <char> > <decimal> 
select * from cs_char where id<2.1;
-- ERROR: unsupported comparison operator: <char> < <decimal>   
select * from cs_varchar where id in (1,5);
select * from cs_varchar where id not in (1,5);
select * from cs_varchar where id like %1;
-- invalid syntax: statement ignored: at or near "%": syntax error
-- SQLSTATE: 42601
-- DETAIL: source SQL:
-- select * from cs_varchar where id like %1
-- HINT: try \h SELECT
select id from cs_varchar order by id desc; --按照asci排序
select id from cs_varchar group by id;
-- 会按照ascii 码值对比
select count(*) from cs_varchar;
select min(id) from cs_varchar;
-- 会按照ascii 码值对比
select max(id) from cs_varchar;
-- 会按照ascii 码值对比
select avg(id) from cs_varchar;
-- ERROR: unknown signature: avg(varchar)
-- SQLSTATE: 42883
select sum(id) from cs_varchar;
-- ERROR: unknown signature: sum(varchar)
-- SQLSTATE: 42883
select nvl(id,1) from cs_varchar;
select length(id) from cs_varchar;
select lpad(id,10,'1') from cs_varchar;
select substr(id,1) from cs_varchar;
select substr(lpad(id,10,'1'),1,9) from cs_varchar;
insert into cs_varchar values (1);
insert into cs_varchar select * from cs_int;
-- ERROR: value type int doesn't match type varchar of column "id"
-- SQLSTATE: 42804
delete from cs_varchar  where id <2;
delete from cs_varchar  where id =2;
delete from cs_varchar  where id in (1,2,3);
delete from cs_varchar  where id not in (1,2,3);
delete from cs_varchar  where id in (select  id from cs_int2);
-- ERROR: unsupported comparison operator: <varchar> = <int>
-- SQLSTATE: 22023
alter table cs_varchar alter column   id set default 1;
insert into cs_varchar select generate_series(1,10)::varchar,random()::varchar;
insert into cs_varchar select generate_series(1,10)::varchar,random()::varchar;
insert into cs_varchar select generate_series(1,10)::varchar,random()::varchar;
explain select id from cs_varchar where id ='1';
drop sequence if exists cs;
create sequence cs;
drop table if exists cs_serial;
create table cs_serial (id varchar default nextval('cs'));
alter index cs_varchar@cs_varchar_id_idx split at values (10);
alter index cs_varchar@cs_varchar_id_idx split at values (1);
alter table cs_varchar split at values (4);
alter table cs_varchar split at values (1);
ALTER TABLE cs_varchar UNSPLIT AT VALUES (1);
ALTER TABLE cs_varchar UNSPLIT all;
ALTER index cs_varchar@cs_varchar_id_idx UNSPLIT  at values(1);
ALTER index cs_varchar@cs_varchar_id_idx UNSPLIT  all;
import into cs_varchar csv data ('nodelocal://1/redmine24_import_data.csv');
select count(*) from cs_varchar;
export into csv 'nodelocal://1/' with nullas='' from table cs_varchar ;
backup table cs_varchar to 'nodelocal://1/';
drop table if exists cs_varcharbak;
create table cs_varcharbak as select * from cs_varchar;
drop table cs_varchar;
restore table cs_varchar from 'nodelocal://1/';
select id,name from cs_varchar where (id,name) not in (select id,name from cs_varcharbak);
drop table cs_int;
drop table cs_int2;
drop table cs_varchar;
drop table cs_char;
drop sequence cs;
drop table cs_serial;
drop table cs_varcharbak;
