--newdb(bankdb),tabname(accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
--带有#的数据表：table_#
Drop DATABASE IF EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
use bankdb;
CREATE TABLE bankdb.accounts (
  balance char(15),
  id INT PRIMARY KEY  
);

INSERT INTO bankdb.accounts VALUES ('1',1 );
INSERT INTO bankdb.accounts (balance, id) VALUES('2', 2);
INSERT INTO bankdb.accounts VALUES ('#3', 3);

