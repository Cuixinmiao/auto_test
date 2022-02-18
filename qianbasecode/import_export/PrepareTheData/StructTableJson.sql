--newdb(bankdb),tabname(accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
Drop DATABASE if EXISTS bankdb cascade;
CREATE DATABASE IF NOT EXISTS bankdb;
USE bankdb;
CREATE TABLE accounts (i INT8 NULL,s STRING NULL,c INT8 NULL);
