drop table if exists testPreparedStatementTalbe4;
create table if not exists testPreparedStatementTalbe4 (id largeint,c2 int);
create table if not exists testPreparedStatementTalbe4 (id int GENERATED ALWAYS AS IDENTITY,c2 int);
create table if not exists testPreparedStatementTalbe4 (id largeint GENERATED ALWAYS AS IDENTITY,c2 int);
create table if not exists testPreparedStatementTalbe4 (a string[] GENERATED ALWAYS AS IDENTITY,c2 int);
create table if not exists testPreparedStatementTalbe4 (a numeric GENERATED ALWAYS AS IDENTITY,c2 int);
create table if not exists testPreparedStatementTalbe4 (a double GENERATED ALWAYS AS IDENTITY,c2 int);
create table if not exists testPreparedStatementTalbe4 (a float GENERATED ALWAYS AS IDENTITY,c2 int);
drop table testPreparedStatementTalbe4;
