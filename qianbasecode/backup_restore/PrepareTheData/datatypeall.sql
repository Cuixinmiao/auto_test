--newdb(bankdb),tabname(accounts)



drop database if EXISTS bankdb cascade;
create database bankdb;
use bankdb;

CREATE TYPE status AS ENUM ('123', '456', '789');
create table accounts(
customer int,
id int,
col_decimal decimal, 
col_decimal_length10_0 decimal(10,0), 
col_decimal_length10_2 decimal(10,2), 
col_decimal_length10_3 decimal(10,3), 
col_decimal_length10_10 decimal(10,10), 
col_decimal_length38_0 decimal(38,0), 
col_decimal_length38_38 decimal(38,38), 
col_decimal_length39_0 decimal(39,0), 
col_numeric numeric, 
col_numeric_length10_0 numeric(10,0), 
col_numeric_length10_2 numeric(10,2), 
col_numeric_length10_3 numeric(10,3), 
col_numeric_length10_10 numeric(10,10), 
col_numeric_length38_0 numeric(38,0), 
col_numeric_length38_38 numeric(38,38), 
col_numeric_length39_0 numeric(39,0), 
col_float float, 
col_float_length10_0 float(10),  
col_float_length38_0 float(38),
col_float_length38_38 float(39),
col_float_length10_2 REAL, 
col_float_length10_3 DOUBLE PRECISION,
col_int int,
col_integer integer,
col_int8 int8,
col_int64 int64,
col_bigint bigint,
col_int2 int2,
col_smallint smallint,
col_int4 int4,
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10) ,
col_CHAR CHAR, 
col_CHAR_length CHAR(10),
strlst STRING[],
bit_x BIT,
bit_y BIT(3),
bit_z VARBIT,
bit_w VARBIT(3),
bool_b BOOL,
bool_c BOOLEAN,
bytes_b BYTES,
collen_a STRING COLLATE en,
data_d DATE,
status status,
ip INET,
int_e INTERVAL,
json_b JSONB,
s_SERIAL SERIAL,
t_time time,
t_TIMESTAMPTZ TIMESTAMPTZ,
token uuid,
primary key (customer, id)
);

insert into accounts values(10,11,1,1,1,1,0.1,1,0.1,1,1,1,1,1,0.1,1,0.1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,'0.11111111', '0.11111111', '0.11111111','0.11111111', '0.11111111','1', '0.11111111',ARRAY['123', '123', '123'],B'1', B'101', B'1', B'1', true, CAST(0 AS BOOL),b'\141\142\143','123' COLLATE en,DATE '2018-11-02','789','2001:4f8:3:ba:2e0:81ff:fe22:d1f1/120',INTERVAL '1 year 2 months 3 days 4 hours 5 minutes 6 seconds','{"222": "111", "333": "111", "444": "111", "666" : 547}',123,TIME '05:40:00',TIMESTAMPTZ '2016-03-26 10:10:10-05:00','63616665663030646465616462656562');
insert into accounts values(12,13,1,1,1,1,0.1,1,0.1,1,1,1,1,1,0.1,1,0.1,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,'0.11111115', '0.11114111', '0.11113111','0.11111511', '0.11121111','2', '0.11111111',ARRAY['130', '123', '123'],B'1', B'101', B'1', B'1', false, CAST(0 AS BOOL),b'\141\142\143','123' COLLATE en,DATE '2018-11-02','456','192.168.0.1',INTERVAL '1-2 3 4:5:6','{"222": "111", "333": "111", "444": "1", "666" : 547}','123',TIME '05:40:00',TIMESTAMPTZ '2016-03-26 10:10:10-05:00','63616665663030646465616462656562');
insert into accounts values(14,15,1,1,1,1,0.1,1,0.1,1,1,1,1,1,0.1,1,0.1,1,1,1,1,1,1,5,1,1,1,1,1,1,1,1,'0.11131111', '0.11111211', '0.11114111','0.11116111', '0.11131111','3', '0.11111111',ARRAY['121', '123', '123'],B'1', B'101', B'1', B'1', true, CAST(0 AS BOOL),b'\141\142\143','123' COLLATE en,DATE '2018-11-02','123','192.168.0.2/10','1-2 3 4:5:6','{"222": "111", "3": "111", "444": "111", "666" : 547}',123,TIME '05:40:00',TIMESTAMPTZ '2016-03-26 10:10:10-05:00','63616665-6630-3064-6465-616462656562');
