--newdb(bankdb),tabname(accounts),column_id(id),column_balance(balance)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
--带有NULL的数据表：table_null
Drop DATABASE if EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
USE bankdb;
CREATE TABLE accounts (
  id INT PRIMARY KEY,
  balance DECIMAL(15,2)
);
CREATE INDEX balance_idx ON accounts (balance DESC);
