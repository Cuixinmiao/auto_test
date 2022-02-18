-- create by cuixiangling
-- Date: 2021-09-13

--  system function for timezone test

select * from [show time zone];
select current_timestamp from dual;
select current_timestamp(0) from dual;
select current_timestamp(1) from dual;
select current_timestamp(2) from dual;
select current_timestamp(3) from dual;
select current_timestamp(4) from dual;
select current_timestamp(5) from dual;
select current_timestamp(6) from dual;

select timeofday() from dual;
select current_time from dual;
select current_date from dual;
select clock_timestamp() from dual;
select experimental_follower_read_timestamp() from dual;
select follower_read_timestamp() from dual;
select localtimestamp() from dual;
select localtimestamp(1) from dual;
select localtimestamp(2) from dual;
select localtimestamp(3) from dual;
select localtimestamp(4) from dual;
select localtimestamp(5) from dual;
select localtimestamp(6) from dual;
select localtimestamp(0) from dual;


select transaction_timestamp() from dual;
select statement_timestamp() from dual;
select cluster_logical_timestamp() from dual;
select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select age(current_timestamp::timestamptz) from dual;
select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select (sysdate::timestamptz-now())::int from dual;
select (sysdate::timestamptz-now())::int::date from dual;
select sysdate from dual;

drop table if exists t1;
create table t1 as select current_timestamp from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(0) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(6) from dual;
select * from t1;
drop table if exists t1;


create table t1 as select timeofday() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_time from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select clock_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select experimental_follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(6) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(0) from dual;
select * from t1;
drop table if exists t1;

create table t1 as select transaction_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select statement_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select cluster_logical_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(current_timestamp::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int::date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select sysdate from dual;
select * from t1;
drop table if exists t1;

create table t1(a timestamp,b date,c timestamptz);

insert into t1(a) select current_timestamp from dual;
insert into t1(a) select current_timestamp(0) from dual;
insert into t1(a) select current_timestamp(1) from dual;
insert into t1(a) select current_timestamp(2) from dual;
insert into t1(a) select current_timestamp(3) from dual;
insert into t1(a) select current_timestamp(4) from dual;
insert into t1(a) select current_timestamp(5) from dual;
insert into t1(a) select current_timestamp(6) from dual;
select * from t1;

insert into t1(b) select current_timestamp from dual;
insert into t1(b) select current_timestamp(0) from dual;
insert into t1(b) select current_timestamp(1) from dual;
insert into t1(b) select current_timestamp(2) from dual;
insert into t1(b) select current_timestamp(3) from dual;
insert into t1(b) select current_timestamp(4) from dual;
insert into t1(b) select current_timestamp(5) from dual;
insert into t1(b) select current_timestamp(6) from dual;
select * from t1;

insert into t1(c) select current_timestamp from dual;
insert into t1(c) select current_timestamp(0) from dual;
insert into t1(c) select current_timestamp(1) from dual;
insert into t1(c) select current_timestamp(2) from dual;
insert into t1(c) select current_timestamp(3) from dual;
insert into t1(c) select current_timestamp(4) from dual;
insert into t1(c) select current_timestamp(5) from dual;
insert into t1(c) select current_timestamp(6) from dual;
select * from t1;

insert into t1(a) select clock_timestamp() from dual;
insert into t1(a) select localtimestamp() from dual;
insert into t1(a) select localtimestamp(1) from dual;
insert into t1(a) select localtimestamp(2) from dual;
insert into t1(a) select localtimestamp(3) from dual;
insert into t1(a) select localtimestamp(4) from dual;
insert into t1(a) select localtimestamp(5) from dual;
insert into t1(a) select localtimestamp(6) from dual;
insert into t1(a) select localtimestamp(0) from dual;
select * from t1;

insert into t1(b) select current_date from dual;
insert into t1(b) select localtimestamp() from dual;
insert into t1(b) select localtimestamp(1) from dual;
insert into t1(b) select localtimestamp(2) from dual;
insert into t1(b) select localtimestamp(3) from dual;
insert into t1(b) select localtimestamp(4) from dual;
insert into t1(b) select localtimestamp(5) from dual;
insert into t1(b) select localtimestamp(6) from dual;
insert into t1(b) select localtimestamp(0) from dual;
select * from t1;

insert into t1(c) select clock_timestamp() from dual;
insert into t1(c) select localtimestamp() from dual;
insert into t1(c) select localtimestamp(1) from dual;
insert into t1(c) select localtimestamp(2) from dual;
insert into t1(c) select localtimestamp(3) from dual;
insert into t1(c) select localtimestamp(4) from dual;
insert into t1(c) select localtimestamp(5) from dual;
insert into t1(c) select localtimestamp(6) from dual;
insert into t1(c) select localtimestamp(0) from dual;
select * from t1;

insert into t1(a) select transaction_timestamp() from dual;
insert into t1(a) select statement_timestamp() from dual;
select * from t1;

insert into t1(b) select transaction_timestamp() from dual;
insert into t1(b) select (sysdate::timestamptz-now())::int::date from dual;
insert into t1(b) select sysdate from dual;
select * from t1;

insert into t1(c) select transaction_timestamp() from dual;
insert into t1(c) select statement_timestamp() from dual;
select * from t1;

drop table t1;


set time zone 'utc';

select current_timestamp from dual;
select current_timestamp(0) from dual;
select current_timestamp(1) from dual;
select current_timestamp(2) from dual;
select current_timestamp(3) from dual;
select current_timestamp(4) from dual;
select current_timestamp(5) from dual;
select current_timestamp(6) from dual;

select timeofday() from dual;
select current_time from dual;
select current_date from dual;
select clock_timestamp() from dual;
select experimental_follower_read_timestamp() from dual;
select follower_read_timestamp() from dual;
select localtimestamp() from dual;
select localtimestamp(1) from dual;
select localtimestamp(2) from dual;
select localtimestamp(3) from dual;
select localtimestamp(4) from dual;
select localtimestamp(5) from dual;
select localtimestamp(6) from dual;
select localtimestamp(0) from dual;


select transaction_timestamp() from dual;
select statement_timestamp() from dual;
select cluster_logical_timestamp() from dual;
select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select age(current_timestamp::timestamptz) from dual;
select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select (sysdate::timestamptz-now())::int from dual;
select (sysdate::timestamptz-now())::int::date from dual;
select sysdate from dual;

drop table if exists t1;
create table t1 as select current_timestamp from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(0) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(6) from dual;
select * from t1;
drop table if exists t1;


create table t1 as select timeofday() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_time from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select clock_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select experimental_follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(6) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(0) from dual;
select * from t1;
drop table if exists t1;

create table t1 as select transaction_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select statement_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select cluster_logical_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(current_timestamp::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int::date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select sysdate from dual;
select * from t1;
drop table if exists t1;

create table t1(a timestamp,b date,c timestamptz);

insert into t1(a) select current_timestamp from dual;
insert into t1(a) select current_timestamp(0) from dual;
insert into t1(a) select current_timestamp(1) from dual;
insert into t1(a) select current_timestamp(2) from dual;
insert into t1(a) select current_timestamp(3) from dual;
insert into t1(a) select current_timestamp(4) from dual;
insert into t1(a) select current_timestamp(5) from dual;
insert into t1(a) select current_timestamp(6) from dual;
select * from t1;

insert into t1(b) select current_timestamp from dual;
insert into t1(b) select current_timestamp(0) from dual;
insert into t1(b) select current_timestamp(1) from dual;
insert into t1(b) select current_timestamp(2) from dual;
insert into t1(b) select current_timestamp(3) from dual;
insert into t1(b) select current_timestamp(4) from dual;
insert into t1(b) select current_timestamp(5) from dual;
insert into t1(b) select current_timestamp(6) from dual;
select * from t1;

insert into t1(c) select current_timestamp from dual;
insert into t1(c) select current_timestamp(0) from dual;
insert into t1(c) select current_timestamp(1) from dual;
insert into t1(c) select current_timestamp(2) from dual;
insert into t1(c) select current_timestamp(3) from dual;
insert into t1(c) select current_timestamp(4) from dual;
insert into t1(c) select current_timestamp(5) from dual;
insert into t1(c) select current_timestamp(6) from dual;
select * from t1;

insert into t1(a) select clock_timestamp() from dual;
insert into t1(a) select localtimestamp() from dual;
insert into t1(a) select localtimestamp(1) from dual;
insert into t1(a) select localtimestamp(2) from dual;
insert into t1(a) select localtimestamp(3) from dual;
insert into t1(a) select localtimestamp(4) from dual;
insert into t1(a) select localtimestamp(5) from dual;
insert into t1(a) select localtimestamp(6) from dual;
insert into t1(a) select localtimestamp(0) from dual;
select * from t1;

insert into t1(b) select current_date from dual;
insert into t1(b) select localtimestamp() from dual;
insert into t1(b) select localtimestamp(1) from dual;
insert into t1(b) select localtimestamp(2) from dual;
insert into t1(b) select localtimestamp(3) from dual;
insert into t1(b) select localtimestamp(4) from dual;
insert into t1(b) select localtimestamp(5) from dual;
insert into t1(b) select localtimestamp(6) from dual;
insert into t1(b) select localtimestamp(0) from dual;
select * from t1;

insert into t1(c) select clock_timestamp() from dual;
insert into t1(c) select localtimestamp() from dual;
insert into t1(c) select localtimestamp(1) from dual;
insert into t1(c) select localtimestamp(2) from dual;
insert into t1(c) select localtimestamp(3) from dual;
insert into t1(c) select localtimestamp(4) from dual;
insert into t1(c) select localtimestamp(5) from dual;
insert into t1(c) select localtimestamp(6) from dual;
insert into t1(c) select localtimestamp(0) from dual;
select * from t1;

insert into t1(a) select transaction_timestamp() from dual;
insert into t1(a) select statement_timestamp() from dual;
select * from t1;

insert into t1(b) select transaction_timestamp() from dual;
insert into t1(b) select (sysdate::timestamptz-now())::int::date from dual;
insert into t1(b) select sysdate from dual;
select * from t1;

insert into t1(c) select transaction_timestamp() from dual;
insert into t1(c) select statement_timestamp() from dual;
select * from t1;

drop table t1;


set time zone 'asia/shanghai';

select current_timestamp from dual;
select current_timestamp(0) from dual;
select current_timestamp(1) from dual;
select current_timestamp(2) from dual;
select current_timestamp(3) from dual;
select current_timestamp(4) from dual;
select current_timestamp(5) from dual;
select current_timestamp(6) from dual;

select timeofday() from dual;
select current_time from dual;
select current_date from dual;
select clock_timestamp() from dual;
select experimental_follower_read_timestamp() from dual;
select follower_read_timestamp() from dual;
select localtimestamp() from dual;
select localtimestamp(1) from dual;
select localtimestamp(2) from dual;
select localtimestamp(3) from dual;
select localtimestamp(4) from dual;
select localtimestamp(5) from dual;
select localtimestamp(6) from dual;
select localtimestamp(0) from dual;


select transaction_timestamp() from dual;
select statement_timestamp() from dual;
select cluster_logical_timestamp() from dual;
select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select age(current_timestamp::timestamptz) from dual;
select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select (sysdate::timestamptz-now())::int from dual;
select (sysdate::timestamptz-now())::int::date from dual;
select sysdate from dual;

drop table if exists t1;
create table t1 as select current_timestamp from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(0) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(6) from dual;
select * from t1;
drop table if exists t1;


create table t1 as select timeofday() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_time from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select clock_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select experimental_follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(6) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(0) from dual;
select * from t1;
drop table if exists t1;

create table t1 as select transaction_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select statement_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select cluster_logical_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(current_timestamp::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int::date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select sysdate from dual;
select * from t1;
drop table if exists t1;

create table t1(a timestamp,b date,c timestamptz);

insert into t1(a) select current_timestamp from dual;
insert into t1(a) select current_timestamp(0) from dual;
insert into t1(a) select current_timestamp(1) from dual;
insert into t1(a) select current_timestamp(2) from dual;
insert into t1(a) select current_timestamp(3) from dual;
insert into t1(a) select current_timestamp(4) from dual;
insert into t1(a) select current_timestamp(5) from dual;
insert into t1(a) select current_timestamp(6) from dual;
select * from t1;

insert into t1(b) select current_timestamp from dual;
insert into t1(b) select current_timestamp(0) from dual;
insert into t1(b) select current_timestamp(1) from dual;
insert into t1(b) select current_timestamp(2) from dual;
insert into t1(b) select current_timestamp(3) from dual;
insert into t1(b) select current_timestamp(4) from dual;
insert into t1(b) select current_timestamp(5) from dual;
insert into t1(b) select current_timestamp(6) from dual;
select * from t1;

insert into t1(c) select current_timestamp from dual;
insert into t1(c) select current_timestamp(0) from dual;
insert into t1(c) select current_timestamp(1) from dual;
insert into t1(c) select current_timestamp(2) from dual;
insert into t1(c) select current_timestamp(3) from dual;
insert into t1(c) select current_timestamp(4) from dual;
insert into t1(c) select current_timestamp(5) from dual;
insert into t1(c) select current_timestamp(6) from dual;
select * from t1;

insert into t1(a) select clock_timestamp() from dual;
insert into t1(a) select localtimestamp() from dual;
insert into t1(a) select localtimestamp(1) from dual;
insert into t1(a) select localtimestamp(2) from dual;
insert into t1(a) select localtimestamp(3) from dual;
insert into t1(a) select localtimestamp(4) from dual;
insert into t1(a) select localtimestamp(5) from dual;
insert into t1(a) select localtimestamp(6) from dual;
insert into t1(a) select localtimestamp(0) from dual;
select * from t1;

insert into t1(b) select current_date from dual;
insert into t1(b) select localtimestamp() from dual;
insert into t1(b) select localtimestamp(1) from dual;
insert into t1(b) select localtimestamp(2) from dual;
insert into t1(b) select localtimestamp(3) from dual;
insert into t1(b) select localtimestamp(4) from dual;
insert into t1(b) select localtimestamp(5) from dual;
insert into t1(b) select localtimestamp(6) from dual;
insert into t1(b) select localtimestamp(0) from dual;
select * from t1;

insert into t1(c) select clock_timestamp() from dual;
insert into t1(c) select localtimestamp() from dual;
insert into t1(c) select localtimestamp(1) from dual;
insert into t1(c) select localtimestamp(2) from dual;
insert into t1(c) select localtimestamp(3) from dual;
insert into t1(c) select localtimestamp(4) from dual;
insert into t1(c) select localtimestamp(5) from dual;
insert into t1(c) select localtimestamp(6) from dual;
insert into t1(c) select localtimestamp(0) from dual;
select * from t1;

insert into t1(a) select transaction_timestamp() from dual;
insert into t1(a) select statement_timestamp() from dual;
select * from t1;

insert into t1(b) select transaction_timestamp() from dual;
insert into t1(b) select (sysdate::timestamptz-now())::int::date from dual;
insert into t1(b) select sysdate from dual;
select * from t1;

insert into t1(c) select transaction_timestamp() from dual;
insert into t1(c) select statement_timestamp() from dual;
select * from t1;

drop table t1;


select * from [show time zone];

set time zone '+8';

select current_timestamp from dual;
select current_timestamp(0) from dual;
select current_timestamp(1) from dual;
select current_timestamp(2) from dual;
select current_timestamp(3) from dual;
select current_timestamp(4) from dual;
select current_timestamp(5) from dual;
select current_timestamp(6) from dual;

select timeofday() from dual;
select current_time from dual;
select current_date from dual;
select clock_timestamp() from dual;
select experimental_follower_read_timestamp() from dual;
select follower_read_timestamp() from dual;
select localtimestamp() from dual;
select localtimestamp(1) from dual;
select localtimestamp(2) from dual;
select localtimestamp(3) from dual;
select localtimestamp(4) from dual;
select localtimestamp(5) from dual;
select localtimestamp(6) from dual;
select localtimestamp(0) from dual;


select transaction_timestamp() from dual;
select statement_timestamp() from dual;
select cluster_logical_timestamp() from dual;
select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select age(current_timestamp::timestamptz) from dual;
select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select (sysdate::timestamptz-now())::int from dual;
select (sysdate::timestamptz-now())::int::date from dual;
select sysdate from dual;

drop table if exists t1;
create table t1 as select current_timestamp from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(0) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_timestamp(6) from dual;
select * from t1;
drop table if exists t1;


create table t1 as select timeofday() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_time from dual;
select * from t1;
drop table if exists t1;
create table t1 as select current_date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select clock_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select experimental_follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select follower_read_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(1) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(2) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(3) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(4) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(5) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(6) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select localtimestamp(0) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select transaction_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select statement_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select cluster_logical_timestamp() from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(current_timestamp::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select age(to_char(sysdate,'YYYY-MM-DD HH:MI:SS.FF')::timestamptz) from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int from dual;
select * from t1;
drop table if exists t1;
create table t1 as select (sysdate::timestamptz-now())::int::date from dual;
select * from t1;
drop table if exists t1;
create table t1 as select sysdate from dual;
select * from t1;
drop table if exists t1;

create table t1(a timestamp,b date,c timestamptz);

insert into t1(a) select current_timestamp from dual;
insert into t1(a) select current_timestamp(0) from dual;
insert into t1(a) select current_timestamp(1) from dual;
insert into t1(a) select current_timestamp(2) from dual;
insert into t1(a) select current_timestamp(3) from dual;
insert into t1(a) select current_timestamp(4) from dual;
insert into t1(a) select current_timestamp(5) from dual;
insert into t1(a) select current_timestamp(6) from dual;
select * from t1;

insert into t1(b) select current_timestamp from dual;
insert into t1(b) select current_timestamp(0) from dual;
insert into t1(b) select current_timestamp(1) from dual;
insert into t1(b) select current_timestamp(2) from dual;
insert into t1(b) select current_timestamp(3) from dual;
insert into t1(b) select current_timestamp(4) from dual;
insert into t1(b) select current_timestamp(5) from dual;
insert into t1(b) select current_timestamp(6) from dual;
select * from t1;

insert into t1(c) select current_timestamp from dual;
insert into t1(c) select current_timestamp(0) from dual;
insert into t1(c) select current_timestamp(1) from dual;
insert into t1(c) select current_timestamp(2) from dual;
insert into t1(c) select current_timestamp(3) from dual;
insert into t1(c) select current_timestamp(4) from dual;
insert into t1(c) select current_timestamp(5) from dual;
insert into t1(c) select current_timestamp(6) from dual;
select * from t1;

insert into t1(a) select clock_timestamp() from dual;
insert into t1(a) select localtimestamp() from dual;
insert into t1(a) select localtimestamp(1) from dual;
insert into t1(a) select localtimestamp(2) from dual;
insert into t1(a) select localtimestamp(3) from dual;
insert into t1(a) select localtimestamp(4) from dual;
insert into t1(a) select localtimestamp(5) from dual;
insert into t1(a) select localtimestamp(6) from dual;
insert into t1(a) select localtimestamp(0) from dual;
select * from t1;

insert into t1(b) select current_date from dual;
insert into t1(c) select localtimestamp() from dual;
insert into t1(c) select localtimestamp(1) from dual;
insert into t1(c) select localtimestamp(2) from dual;
insert into t1(c) select localtimestamp(3) from dual;
insert into t1(c) select localtimestamp(4) from dual;
insert into t1(c) select localtimestamp(5) from dual;
insert into t1(c) select localtimestamp(6) from dual;
insert into t1(c) select localtimestamp(0) from dual;
select * from t1;

insert into t1(a) select transaction_timestamp() from dual;
insert into t1(a) select statement_timestamp() from dual;
select * from t1;

insert into t1(b) select transaction_timestamp() from dual;
insert into t1(b) select (sysdate::timestamptz-now())::int::date from dual;
insert into t1(b) select sysdate from dual;
select * from t1;

insert into t1(c) select transaction_timestamp() from dual;
insert into t1(c) select statement_timestamp() from dual;
select * from t1;

drop table t1;