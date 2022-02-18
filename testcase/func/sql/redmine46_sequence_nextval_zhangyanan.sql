--创建一个序列，插入数据
create sequence  if not exists seq_t1_id;
create table t1(id int,str string);
insert into t1 values (1,'A');
insert into t1(id) values (seq_t1_id.nextval);
select * from t1;
drop table t1;
drop sequence seq_t1_id;

--创建一个序列，查询中加减乘除
create sequence  seq_t1_id;
select seq_t1_id.nextval +1;
select seq_t1_id.nextval -1;
select seq_t1_id.nextval ;
select seq_t1_id.nextval *2;
select seq_t1_id.nextval /2;
drop sequence seq_t1_id;

--同一个库下，不同模式下查询。创建相同名字。
create sequence  seq_t1_id;
create schema test1;
set search_path=test1;
select seq_t1_id.nextval ;
select public.seq_t1_id.nextval;
create sequence seq_t1_id;
select seq_t1_id.nextval;
select defaultdb.public.seq_t1_id.nextval;
drop schema test1 CASCADE;
set search_path=public;
drop sequence  seq_t1_id;


--不同库下，不同模式下查询并创建相同名字。
create sequence seq_t1_id;
create schema test1;
create database test1;
set search_path=test1;
create sequence seq_t1_id;
select seq_t1_id.nextval;
select defaultdb.public.seq_t1_id.nextval;
use test1;
select defaultdb.seq_t1_id.nextval;
select defaultdb.test1.seq_t1_id.nextval;
set search_path=public;
create sequence if not exists seq_t1_id start with 1 increment by 1 no cycle no maxvalue;
select seq_t1_id.nextval;
use defaultdb;
drop database test1 CASCADE;
drop schema test1 CASCADE;
drop sequence  seq_t1_id;

--序列的混合使用场景
create sequence seq_t1_id start with 1 increment by 1 no cycle no maxvalue;
create table t1(id int default seq_t1_id.nextval,str string);
insert into t1(str) values ('A'),('B'),('C'),('D'),('a'),('b'),('c'),('d');
select * from t1;
select nextval('seq_t1_id');
select seq_t1_id.nextval;
insert into t1(str) values ('E');
select * from t1 order by id desc;
select * from information_schema.sequences t where t.sequence_name='seq_t1_id';
delete from t1 where id > 8;
alter sequence seq_t1_id increment by -2;
select seq_t1_id.nextval;
alter sequence seq_t1_id increment by 1;
insert into t1(str) values ('E');
select * from t1 order by id desc;
alter table t1  alter column id drop default;
drop sequence seq_t1_id;
drop table t1;

--序列强转text类型。
CREATE SEQUENCE sequence_test; 
SELECT sequence_test.nextval::text;
DROP SEQUENCE sequence_test ;

--修改序列名字
CREATE SEQUENCE foo_seq;
ALTER SEQUENCE foo_seq RENAME TO foo_seq_new;
SELECT * FROM foo_seq_new  ;
SELECT foo_seq_new.nextval;
SELECT foo_seq_new.nextval ;
DROP SEQUENCE foo_seq_new  ;

--跨库修改序列名
create database test1;
use test1;
CREATE SEQUENCE foo_seq ;
create database test;
use test;
ALTER SEQUENCE test1.foo_seq RENAME TO test1.foo_seq_new ;
SELECT * FROM test1.foo_seq_new  ;
SELECT test1.foo_seq_new.nextval;
SELECT test1.foo_seq_new.nextval;
DROP SEQUENCE test1.foo_seq_new  ;
use defaultdb;
drop database test cascade;
drop database test1 cascade;

--创建序列参数。
CREATE SEQUENCE sequence_testx   INCREMENT BY 0 ;
CREATE SEQUENCE sequence_testx   INCREMENT BY -1 MINVALUE 20 ;
CREATE SEQUENCE sequence_testx   INCREMENT BY 1  MAXVALUE -20 ;
CREATE SEQUENCE sequence_testx   INCREMENT BY -1 START 10 ;
CREATE SEQUENCE sequence_testx   INCREMENT BY 1 START -10 ;
CREATE SEQUENCE sequence_testx   CACHE 0 ;
CREATE SEQUENCE sequence_testx   INCREMENT  BY -1  START 10 ;
CREATE SEQUENCE sequence_testx1 INCREMENT  BY 1   MINVALUE 20 ;
CREATE SEQUENCE sequence_testx2 INCREMENT  BY -1  MAXVALUE -20 ;
CREATE SEQUENCE sequence_testx3 INCREMENT  BY -1  START -10 ;
SELECT nextval('sequence_testx3') ;
CREATE SEQUENCE sequence_testx4 INCREMENT  BY 1   START  10 ;
SELECT nextval('sequence_testx4') ;
SHOW SEQUENCES;
DROP SEQUENCE sequence_testx1,sequence_testx2,sequence_testx3,sequence_testx4;

--不支持的pg语法。
CREATE SEQUENCE sequence_testx5   INCREMENT  BY 5 MINVALUE 1 MAXVALUE 99 START WITH 10 CACHE 20 CYCLE;
CREATE SEQUENCE sequence_testx6   INCREMENT  BY 5  MINVALUE 1  MAXVALUE 99 START WITH 10 CACHE 1 CYCLE;

--检查删除序列时的依赖
CREATE  SEQUENCE myseq2;
CREATE  SEQUENCE myseq3;
CREATE  TABLE del_seq_test (f1 serial,f2 int DEFAULT nextval('myseq2'),f3 int DEFAULT nextval('myseq3'::text)) ;
DROP SEQUENCE myseq2 ;
DROP SEQUENCE myseq3 ;
DROP TABLE del_seq_test;
DROP SEQUENCE myseq2 ;
DROP SEQUENCE myseq3 ;

--修改序列参数
CREATE SEQUENCE seq_table1 INCREMENT  BY 1   MINVALUE 5 MAXVALUE 10;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
ALTER SEQUENCE seq_table1 INCREMENT  BY -1   MINVALUE -15 MAXVALUE -10;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
ALTER SEQUENCE seq_table1 INCREMENT  BY 1    MINVALUE 10 MAXVALUE 15;
SELECT seq_table1.nextval;
SELECT seq_table1.nextval;
ALTER SEQUENCE seq_table1 INCREMENT  BY 1    MAXVALUE 5; 
SELECT seq_table1.nextval;
DROP SEQUENCE seq_table1;
CREATE SEQUENCE seq_table2 INCREMENT  BY -1   MINVALUE -10 MAXVALUE -5;
SELECT seq_table2.nextval;
SELECT seq_table2.nextval;
ALTER SEQUENCE seq_table2 INCREMENT  BY -1   MINVALUE -20 MAXVALUE -10;
SELECT seq_table2.nextval;
SELECT seq_table2.nextval;
ALTER SEQUENCE seq_table2 INCREMENT  BY 1    MINVALUE 1 MAXVALUE 5;
SELECT seq_table2.nextval;
SELECT seq_table2.nextval;
ALTER SEQUENCE seq_table2 INCREMENT  BY 1    MINVALUE -5; 
SELECT seq_table2.nextval;
DROP SEQUENCE seq_table2;
CREATE SEQUENCE seq_table3 INCREMENT  BY 1   MINVALUE 1 MAXVALUE 100;
SELECT seq_table3.nextval;
SELECT seq_table3.nextval;
SELECT seq_table3.nextval;
ALTER SEQUENCE seq_table3 INCREMENT  BY 1    MINVALUE 1 MAXVALUE 5; 
DROP SEQUENCE seq_table3;

-- 修改序列参数
CREATE SEQUENCE sequence_test; 
SELECT sequence_test.nextval::text;
SELECT sequence_test.nextval::text ;
SELECT setval('sequence_test'::text, 32) ;
SELECT sequence_test.nextval::text;
SELECT setval('sequence_test'::text, 99, false) ;
SELECT sequence_test.nextval::text;
SELECT setval('sequence_test'::text, 32) ;
SELECT sequence_test.nextval::text;
SELECT setval('sequence_test'::text, 99, false) ;
SELECT sequence_test.nextval::text ;
DROP SEQUENCE sequence_test ;
drop sequence seq_t1_id;
drop sequence test1.seq_t1_id;
drop schema test1;
