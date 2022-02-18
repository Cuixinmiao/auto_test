--newdb(bankdb),tabname(accounts),column_balance(balance),column_id(id)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
--带有#的数据表：table_#
Drop DATABASE IF EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
use bankdb;
CREATE TABLE bankdb.accounts (
  balance char(15),
  id INT PRIMARY KEY  
);

