--newdb(bankdb),newdb2(bankdb2),tabname(accounts),tabname2(accounts2)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
Drop DATABASE IF EXISTS bankdb cascade;

CREATE DATABASE IF NOT EXISTS bankdb;

USE bankdb;

CREATE TABLE accounts (
  id INT PRIMARY KEY,
  balance DECIMAL(15,2)
);

INSERT INTO accounts VALUES (1, 10000.50);
INSERT INTO accounts (balance, id) VALUES(25000.00, 2);
INSERT INTO accounts VALUES(3, 8100.73),(4, 9400.10);
INSERT INTO accounts(id) VALUES(5);
INSERT INTO accounts(id, balance) VALUES(6, DEFAULT);
CREATE INDEX balance_idx ON accounts (balance DESC);
UPDATE accounts SET balance = balance - 5.50 WHERE balance < 10000;



Drop DATABASE if EXISTS bankdb2 cascade;
CREATE DATABASE IF NOT EXISTS bankdb2;
USE bankdb2;
CREATE TABLE accounts2 (
  id INT PRIMARY KEY,
  balance DECIMAL(15,2)
);

INSERT INTO accounts2 VALUES (1, 10000.50);
INSERT INTO accounts2 (balance, id) VALUES(25000.00, 2);
INSERT INTO accounts2 VALUES(3, 8100.73),(4, 900.10);
INSERT INTO accounts2(id) VALUES(5);
INSERT INTO accounts2(id, balance) VALUES(6, DEFAULT);
CREATE INDEX balance_idx ON accounts2 (balance DESC);
UPDATE accounts2 SET balance = balance - 5.50 WHERE balance < 10000;
