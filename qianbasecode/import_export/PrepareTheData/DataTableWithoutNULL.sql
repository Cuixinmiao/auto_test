--newdb(bankdb),tabname(accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
Drop DATABASE if EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
USE bankdb;
CREATE TABLE accounts (
  id INT PRIMARY KEY,
  balance DECIMAL(15,2)
);
CREATE INDEX balance_idx ON accounts (balance DESC);
INSERT INTO accounts VALUES (1, 10000.50);
INSERT INTO accounts (balance, id) VALUES(25000.00, 2);
