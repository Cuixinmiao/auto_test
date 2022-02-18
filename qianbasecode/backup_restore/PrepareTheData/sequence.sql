--newdb(bankdb),tabname(accounts),--seqname(seq_test)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容

Drop DATABASE IF EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
USE bankdb;

create sequence seq_test
minvalue 250
maxvalue 99999
start with 258
increment by 10
cache 20;

CREATE TABLE accounts (
    id int PRIMARY KEY,
    age INT DEFAULT nextval('seq_test'),
    name STRING
);

insert into accounts (id,name) values (1,'a');
insert into accounts (id,name) values (2,'b');
insert into accounts (id,name) values (3,'c');
select nextval('seq_test');
insert into accounts (id,name) values (4,'d');
