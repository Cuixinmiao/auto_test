---语法验证

----oracle 官网case:

SELECT TO_CHAR('01110' + 1) FROM DUAL;   ----R-340
SELECT TO_CHAR(-10000,'L99G999D99MI') "Amount" FROM DUAL;

---返回语法报错
SELECT TO_CHAR(-10000,'L99G999D99MI',  'NLS_NUMERIC_CHARACTERS = '',.''  NLS_CURRENCY = ''AusDollars'' ') "Amount"  FROM DUAL;
SELECT TO_CHAR(-10000,'99G999D99C', 'NLS_NUMERIC_CHARACTERS = '',.'' NLS_ISO_CURRENCY=POLAND') "Amount" FROM DUAL;

drop table if exists empl_temp;
CREATE TABLE empl_temp 
  ( 
     employee_id NUMBER(6), 
     first_name  VARCHAR(20), 
     last_name   VARCHAR(25), 
     email       VARCHAR(25), 
     hire_date   DATE , 
     job_id      VARCHAR(10)
     ---clob_column CLOB 
  );

INSERT INTO empl_temp
VALUES(111,'John','Doe','example.com','10-JAN-2015','1001');

INSERT INTO empl_temp
VALUES(112,'John','Smith','example.com','12-JAN-2015','1002');

INSERT INTO empl_temp
VALUES(113,'Johnnie','Smith','example.com','12-JAN-2014','1002');

INSERT INTO empl_temp
VALUES(115,'Jane','Doe','example.com','15-JAN-2015','1005');

SELECT To_char(employee_id) "NUM_TO_CHAR" FROM   empl_temp WHERE  employee_id IN ( 111, 112, 113, 115 );


SELECT TO_CHAR('01110') FROM DUAL;  ----R-341
SELECT TO_CHAR('1') FROM DUAL;

-------数值类型
drop table if exists numerical;
create table numerical(
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
col_float_length10 float(10),  
col_float_length38 float(38),
col_float_length39 float(39),
col_real real, 
col_double_precision double precision,
col_int int,
col_integer integer,
col_int8 int8,
col_int64 int64,
col_bigint bigint,
col_int2 int2,
col_smallint smallint,
col_int4 int4,
col_number number
);

insert into numerical values(
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
1234567890);


insert into numerical values(
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-1234567890);


insert into numerical values(
  1.03E+08,
  1.03E+08,
null,
null,
null,
  1.03E+08,
null,
  1.03E+08,
  1.03E+08,
  1.03E+08,
null,
null,
null,
  1.03E+08,
null,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08, 
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1.03E+08,
  1E+1,
  1E+1,
  1.03E+08,
  1.03E+08);
  

insert into numerical values(
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);

insert into numerical values(
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0);


select col_decimal,to_char(col_decimal) from numerical;
select col_decimal_length10_0,to_char(col_decimal_length10_0) from numerical;
select col_decimal_length10_2,to_char(col_decimal_length10_2) from numerical;
select col_decimal_length10_3,to_char(col_decimal_length10_3) from numerical;
select col_decimal_length10_10,to_char(col_decimal_length10_10) from numerical;
select col_decimal_length38_0,to_char(col_decimal_length38_0) from numerical;
select col_decimal_length38_38,to_char(col_decimal_length38_38) from numerical;
select col_decimal_length39_0,to_char(col_decimal_length39_0) from numerical;
select col_numeric,to_char(col_numeric) from numerical;
select col_numeric_length10_0,to_char(col_numeric_length10_0) from numerical;
select col_numeric_length10_2,to_char(col_numeric_length10_2) from numerical;
select col_numeric_length10_3,to_char(col_numeric_length10_3) from numerical;
select col_numeric_length10_10,to_char(col_numeric_length10_10) from numerical;
select col_numeric_length38_0,to_char(col_numeric_length38_0) from numerical;
select col_numeric_length38_38,to_char(col_numeric_length38_38) from numerical;
select col_numeric_length39_0,to_char(col_numeric_length39_0) from numerical;
select col_float,to_char(col_float) from numerical;
select col_float_length10,to_char(col_float_length10) from numerical;
select col_float_length38,to_char(col_float_length38) from numerical;
select col_float_length39,to_char(col_float_length39) from numerical;
select col_real,to_char(col_real) from numerical;
select col_double_precision,to_char(col_double_precision) from numerical;
select col_int,to_char(col_int) from numerical;
select col_integer,to_char(col_integer) from numerical;
select col_int8,to_char(col_int8) from numerical;
select col_int64,to_char(col_int64) from numerical;
select col_bigint,to_char(col_bigint) from numerical;
select col_int2,to_char(col_int2) from numerical;
select col_smallint,to_char(col_smallint) from numerical;
select col_int4,to_char(col_int4) from numerical;
select col_number,to_char(col_number) from numerical;


select col_decimal_length10_0,to_char(col_decimal_length10_0,'999999999999999') from numerical;
select col_decimal_length10_2,to_char(col_decimal_length10_2,'9999999999999.99') from numerical;
select col_decimal_length10_3,to_char(col_decimal_length10_3,'999999999999.999') from numerical;
select col_decimal_length10_10,to_char(col_decimal_length10_10,'9.99999999999999') from numerical;
select col_decimal_length38_0,to_char(col_decimal_length38_0,'999999999999999') from numerical;
select col_decimal_length38_38,to_char(col_decimal_length38_38,'9.99999999999999') from numerical;
select col_decimal_length39_0,to_char(col_decimal_length39_0,'999999999999999') from numerical;
select col_numeric,to_char(col_numeric,'999999999999999') from numerical;
select col_numeric_length10_0,to_char(col_numeric_length10_0,'999999999999999') from numerical;
select col_numeric_length10_2,to_char(col_numeric_length10_2,'9999999999999.99') from numerical;
select col_numeric_length10_3,to_char(col_numeric_length10_3,'999999999999.999') from numerical;
select col_numeric_length10_10,to_char(col_numeric_length10_10,'9.99999999999999') from numerical;
select col_numeric_length38_0,to_char(col_numeric_length38_0,'999999999999999') from numerical;
select col_numeric_length38_38,to_char(col_numeric_length38_38,'9.99999999999999') from numerical;
select col_numeric_length39_0,to_char(col_numeric_length39_0,'999999999999999') from numerical;
select col_float,to_char(col_float,'999999999999999') from numerical;
select col_float_length10,to_char(col_float_length10,'999999999999999') from numerical;
select col_float_length38,to_char(col_float_length38,'999999999999999') from numerical;
select col_float_length39,to_char(col_float_length39,'999999999999999') from numerical;
select col_real,to_char(col_real,'999999999999999') from numerical;
select col_double_precision,to_char(col_double_precision,'999999999999999') from numerical;
select col_int,to_char(col_int,'999999999999999') from numerical;
select col_integer,to_char(col_integer,'999999999999999') from numerical;
select col_int8,to_char(col_int8,'999999999999999') from numerical;
select col_int64,to_char(col_int64,'999999999999999') from numerical;
select col_bigint,to_char(col_bigint,'999999999999999') from numerical;
select col_int2,to_char(col_int2,'999999999999999') from numerical;
select col_smallint,to_char(col_smallint,'999999999999999') from numerical;
select col_int4,to_char(col_int4,'999999999999999') from numerical;
select col_number,to_char(col_number,'999999999999999') from numerical;

select to_char(12345678.12) from dual;
select to_char(1234567.123) from dual;
select to_char(0.012345679) from dual;
select to_char(1234567890) from dual;
select to_char(12345678901234567890123456789012345678) from dual;
select to_char(123456789012345678901234567890123456789) from dual;
select to_char(12345) from dual;
select to_char(-12345678.12) from dual;
select to_char(-1234567.123) from dual;
select to_char(-0.012345679) from dual;
select to_char(-1234567) from dual;
select to_char(-1234567890) from dual;
select to_char(-12345678901234567890123456789012345678) from dual;
select to_char(-123456789012345678901234567890123456789) from dual;
select to_char(1.03E+08) from dual;
select to_char(1E+1) from dual;
select to_char(-1.03E+08) from dual;
select to_char(-1E+1) from dual;
select to_char(null) from dual;
select to_char(0) from dual;
select to_char(-0.1) from dual;
select to_char(1234567890numerical2) from dual;
select to_char(-1234567890numerical2) from dual;


select to_char( 12345678.12) from dual;
select to_char( 1234567.123) from dual;
select to_char( 0.012345679) from dual;
select to_char( 1234567890) from dual;
select to_char( 12345678901234567890123456789012345678) from dual;
select to_char( 123456789012345678901234567890123456789) from dual;
select to_char( 12345) from dual;
select to_char( -12345678.12) from dual;
select to_char( -1234567.123) from dual;
select to_char( -0.012345679) from dual;
select to_char( -1234567) from dual;
select to_char( -1234567890) from dual;
select to_char( -12345678901234567890123456789012345678) from dual;
select to_char( -123456789012345678901234567890123456789) from dual;
select to_char( 1.03E+08) from dual;
select to_char( 1E+1) from dual;
select to_char( -1.03E+08) from dual;
select to_char( -1E+1) from dual;
select to_char( null) from dual;
select to_char( 0) from dual;
select to_char( -0.1) from dual;
select to_char( 1234567890numerical2) from dual;
select to_char( -1234567890numerical2) from dual;

select to_char( 12345678.12 ) from dual;
select to_char( 1234567.123 ) from dual;
select to_char( 0.012345679 ) from dual;
select to_char( 1234567890 ) from dual;
select to_char( 12345678901234567890123456789012345678 ) from dual;
select to_char( 123456789012345678901234567890123456789 ) from dual;
select to_char( 12345 ) from dual;
select to_char( -12345678.12 ) from dual;
select to_char( -1234567.123 ) from dual;
select to_char( -0.012345679 ) from dual;
select to_char( -1234567 ) from dual;
select to_char( -1234567890 ) from dual;
select to_char( -12345678901234567890123456789012345678 ) from dual;
select to_char( -123456789012345678901234567890123456789 ) from dual;
select to_char( 1.03E+08 ) from dual;
select to_char( 1E+1 ) from dual;
select to_char( -1.03E+08 ) from dual;
select to_char( -1E+1 ) from dual;
select to_char( null ) from dual;
select to_char( 0 ) from dual;
select to_char( -0.1 ) from dual;
select to_char( 1234567890numerical2 ) from dual;
select to_char( -1234567890numerical2 ) from dual;

select to_char( - 12345678.12) from dual;
select to_char( - 1234567.123) from dual;
select to_char( - 0.012345679) from dual;
select to_char( - 1234567) from dual;
select to_char( - 1234567890) from dual;
select to_char( - 12345678901234567890123456789012345678) from dual;
select to_char( - 123456789012345678901234567890123456789) from dual;
select to_char( - 1.03E+08) from dual;
select to_char( - 1E+1) from dual;
select to_char( - 0 ) from dual;
select to_char( - 0.1) from dual;
select to_char( - 1234567890numerical2) from dual;


select to_char( -  12345678.12) from dual;
select to_char( -  1234567.123) from dual;
select to_char( -  0.012345679) from dual;
select to_char( -  1234567) from dual;
select to_char( -  1234567890) from dual;
select to_char( -  12345678901234567890123456789012345678) from dual;
select to_char( -  123456789012345678901234567890123456789) from dual;
select to_char( -  1.03E+08) from dual;
select to_char( -  1E+1) from dual;
select to_char( -  0 ) from dual;
select to_char( -  0.1) from dual;
select to_char( -  1234567890numerical2) from dual;

select to_char( 12345678 . 12 ) from dual;
select to_char( 1234 567.123 ) from dual;
select to_char( 0.012 345679 ) from dual;
select to_char( 12 3456 7890 ) from dual;
select to_char( 12345 6789012345 67890123456789 012345678 ) from dual;
select to_char( 1 234567890123 456789012345678 90123456789 ) from dual;
select to_char( 12 345 ) from dual;
select to_char( -123 45678 . 12 ) from dual;
select to_char( - 12 3456 7.123 ) from dual;
select to_char( - 0.012345679 ) from dual;
select to_char( - 1234567 ) from dual;
select to_char( - 1234567890 ) from dual;
select to_char( - 123456789012 34567890123456789012345678 ) from dual;
select to_char( - 123456789 012345678901234567890123456789 ) from dual;
select to_char( 1 . 03E+08 ) from dual;
select to_char(  1 E+1 ) from dual;
select to_char( -1.03 E+08 ) from dual;
select to_char( -1E + 1 ) from dual;
select to_char( n ull ) from dual;
select to_char( -0 .1 ) from dual;
select to_char( 123 45678 90nume rical2 ) from dual;
select to_char( -1234567890 numerical2 ) from dual;


SELECT TO_CHAR(TO_DATE('01-01-2009', 'MM-DD-YYYY'),'J')    FROM DUAL;


-------v1 测试case
drop table if exists test_mytab;
create table test_mytab
(
a int ,
b numeric(18,8),
c decimal(18,6),
d float,
e real
);

---insert into test_mytab values
---(1,2812345678.10824588,658347113123.890712,12000,3688.88),
---(2,3812345678.88754088,791187213123.930285,15000,2367.77),
---(3,5212345670.13141588,992131413123.882911,18777,4356.99),
---(-1,-1234567678.28908872,-0.013745,-1000000,-88.66),
---(0,0,0,0,0),
---(null,null,null,null,null);

insert into test_mytab values
(1,288.108245,6583471.890037,12000,3688.88),
(2,388.887540,7911872.930485,15000,2367.77),
(3,520.131415,9921314.882911,18777,4356.99),
(-1,-678.289072,-0.013745,-1000000,-88.66),
(0,0,0,0,0),
(null,null,null,null,null);

select * from test_mytab;

--int'999,99'
select a,to_char(a,'999,99') from test_mytab;

--numeric'999,99'
select b,to_char(b,'999,99') from test_mytab;

--decimal'999,99'
select c,to_char(c,'999,99') from test_mytab;

--float'999,99'
select d,to_char(d,'999,99') from test_mytab;

--real'999,99'
select e,to_char(e,'999,99') from test_mytab;

--int'999,999'
select a,to_char(a,'999,999') from test_mytab;

--numeric'999,999'
select b,to_char(b,'999,999') from test_mytab;

--decimal'999,999'
select c,to_char(c,'999,999') from test_mytab;

--float'999,999'
select d,to_char(d,'999,999') from test_mytab;

--real'999,999'
select e,to_char(e,'999,999') from test_mytab;

--int',999'
select a,to_char(a,',999') from test_mytab;

--numeric',999'
select b,to_char(b,',999') from test_mytab;

--decimal',999'
select c,to_char(c,',999') from test_mytab;

--float',999'
select d,to_char(d,',999') from test_mytab;

--real',999'
select e,to_char(e,',999') from test_mytab;

--int'9,'
select a,to_char(a,'9,') from test_mytab;

--numeric'9,'
select b,to_char(b,'9,') from test_mytab;

--decimal'9,'
select c,to_char(c,'9,') from test_mytab;

--float'9,'
select d,to_char(d,'9,') from test_mytab;

--real'9,'
select e,to_char(e,'9,') from test_mytab;

--int'999.99'
select a,to_char(a,'999.99') from test_mytab;

--numeric'999.99'
select b,to_char(b,'999.99') from test_mytab;

--decimal'999.99'
select c,to_char(c,'999.99') from test_mytab;

--float'999.99'
select d,to_char(d,'999.99') from test_mytab;

--real'999.99'
select e,to_char(e,'999.99') from test_mytab;

--int'999.999'
select a,to_char(a,'999.999') from test_mytab;

--numeric'999.999'
select b,to_char(b,'999.999') from test_mytab;

--decimal'999.999'
select c,to_char(c,'999.999') from test_mytab;

--float'999.999'
select d,to_char(d,'999.999') from test_mytab;

--real'999.999'
select e,to_char(e,'999.999') from test_mytab;

--int'.999'
select a,to_char(a,'.999') from test_mytab;

--numeric'.999'
select b,to_char(b,'.999') from test_mytab;

--decimal'.999'
select c,to_char(c,'.999') from test_mytab;

--float'.999'
select d,to_char(d,'.999') from test_mytab;

--real'.999'
select e,to_char(e,'.999') from test_mytab;

--int'9.'
select a,to_char(a,'9.') from test_mytab;

--numeric'9.'
select b,to_char(b,'9.') from test_mytab;

--decimal'9.'
select c,to_char(c,'9.') from test_mytab;

--float'9.'
select d,to_char(d,'9.') from test_mytab;

--real'9.'
select e,to_char(e,'9.') from test_mytab;

--int'$999.9900'
select a,to_char(a,'$999.9900') from test_mytab;

--numeric'$999.9900'
select b,to_char(b,'$999.9900') from test_mytab;

--decimal'$999.9900'
select c,to_char(c,'$999.9900') from test_mytab;

--float'$999.9900'
select d,to_char(d,'$999.9900') from test_mytab;

--real'$999.9900'
select e,to_char(e,'$999.9900') from test_mytab;

--int'$000,999,999'
select a,to_char(a,'$000,999,999') from test_mytab;

--numeric'$000,999,999'
select b,to_char(b,'$000,999,999') from test_mytab;

--decimal'$000,999,999'
select c,to_char(c,'$000,999,999') from test_mytab;

--float'$000,999,999'
select d,to_char(d,'$000,999,999') from test_mytab;

--real'$000,999,999'
select e,to_char(e,'$000,999,999') from test_mytab;

--int'$999999'
select a,to_char(a,'$999999') from test_mytab;

--numeric'$999999'
select b,to_char(b,'$999999') from test_mytab;

--decimal'$999999'
select c,to_char(c,'$999999') from test_mytab;

--float'$999999'
select d,to_char(d,'$999999') from test_mytab;

--real'$999999'
select e,to_char(e,'$999999') from test_mytab;

--int'00999.9900'
select a,to_char(a,'00999.9900') from test_mytab;

--numeric'00999.9900'
select b,to_char(b,'00999.9900') from test_mytab;

--decimal'00999.9900'
select c,to_char(c,'00999.9900') from test_mytab;

--float'00999.9900'
select d,to_char(d,'00999.9900') from test_mytab;

--real'00999.9900'
select e,to_char(e,'00999.9900') from test_mytab;

--int'0999,999000'
select a,to_char(a,'0999,999000') from test_mytab;

--numeric'0999,999000'
select b,to_char(b,'0999,999000') from test_mytab;

--decimal'0999,999000'
select c,to_char(c,'0999,999000') from test_mytab;

--float'0999,999000'
select d,to_char(d,'0999,999000') from test_mytab;

--real'0999,999000'
select e,to_char(e,'0999,999000') from test_mytab;

--int'99999900'
select a,to_char(a,'99999900') from test_mytab;

--numeric'99999900'
select b,to_char(b,'99999900') from test_mytab;

--decimal'99999900'
select c,to_char(c,'99999900') from test_mytab;

--float'99999900'
select d,to_char(d,'99999900') from test_mytab;

--real'99999900'
select e,to_char(e,'99999900') from test_mytab;

--int'00999999'
select a,to_char(a,'00999999') from test_mytab;

--numeric'00999999'
select b,to_char(b,'00999999') from test_mytab;

--decimal'00999999'
select c,to_char(c,'00999999') from test_mytab;

--float'00999999'
select d,to_char(d,'00999999') from test_mytab;

--real'00999999'
select e,to_char(e,'00999999') from test_mytab;

--int'999999999'
select a,to_char(a,'999999999') from test_mytab;

--numeric'999999999'
select b,to_char(b,'999999999') from test_mytab;

--decimal'999999999'
select c,to_char(c,'999999999') from test_mytab;

--float'999999999'
select d,to_char(d,'999999999') from test_mytab;

--real'999999999'
select e,to_char(e,'999999999') from test_mytab;

--int'b999999999'
select a,to_char(a,'b999999999') from test_mytab;

--numeric'b999999999'
select b,to_char(b,'b999999999') from test_mytab;

--decimal'b999999999'
select c,to_char(c,'b999999999') from test_mytab;

--float'b999999999'
select d,to_char(d,'b999999999') from test_mytab;

--real'b999999999'
select e,to_char(e,'b999999999') from test_mytab;

--int'c999999999'
select a,to_char(a,'c999999999') from test_mytab;

--numeric'c999999999'
select b,to_char(b,'c999999999') from test_mytab;

--decimal'c999999999'
select c,to_char(c,'c999999999') from test_mytab;

--float'c999999999'
select d,to_char(d,'c999999999') from test_mytab;

--real'c999999999'
select e,to_char(e,'c999999999') from test_mytab;

--int'd999999999'
select a,to_char(a,'d999999999') from test_mytab;

--numeric'd999999999'
select b,to_char(b,'d999999999') from test_mytab;

--decimal'd999999999'
select c,to_char(c,'d999999999') from test_mytab;

--float'd999999999'
select d,to_char(d,'d999999999') from test_mytab;

--real'd999999999'
select e,to_char(e,'d999999999') from test_mytab;

--int'999999.99eeee'
select a,to_char(a,'999999.99eeee') from test_mytab;

--numeric'999999.99eeee'
select b,to_char(b,'999999.99eeee') from test_mytab;

--decimal'999999.99eeee'
select c,to_char(c,'999999.99eeee') from test_mytab;

--float'999999.99eeee'
select d,to_char(d,'999999.99eeee') from test_mytab;

--real'999999.99eeee'
select e,to_char(e,'999999.99eeee') from test_mytab;

--int'9g999g9g9999'
select a,to_char(a,'9g999g9g9999') from test_mytab;

--numeric'9g999g9g9999'
select b,to_char(b,'9g999g9g9999') from test_mytab;

--decimal'9g999g9g9999'
select c,to_char(c,'9g999g9g9999') from test_mytab;

--float'9g999g9g9999'
select d,to_char(d,'9g999g9g9999') from test_mytab;

--real'9g999g9g9999'
select e,to_char(e,'9g999g9g9999') from test_mytab;

--int'g9g999g9g9999'
select a,to_char(a,'g9g999g9g9999') from test_mytab;

--numeric'g9g999g9g9999'
select b,to_char(b,'g9g999g9g9999') from test_mytab;

--decimal'g9g999g9g9999'
select c,to_char(c,'g9g999g9g9999') from test_mytab;

--float'g9g999g9g9999'
select d,to_char(d,'g9g999g9g9999') from test_mytab;

--real'g9g999g9g9999'
select e,to_char(e,'g9g999g9g9999') from test_mytab;

--int'9g999g9g9999g'
select a,to_char(a,'9g999g9g9999g') from test_mytab;

--numeric'9g999g9g9999g'
select b,to_char(b,'9g999g9g9999g') from test_mytab;

--decimal'9g999g9g9999g'
select c,to_char(c,'9g999g9g9999g') from test_mytab;

--float'9g999g9g9999g'
select d,to_char(d,'9g999g9g9999g') from test_mytab;

--real'9g999g9g9999g'
select e,to_char(e,'9g999g9g9999g') from test_mytab;

--int'g9g999g9g9999g'
select a,to_char(a,'g9g999g9g9999g') from test_mytab;

--numeric'g9g999g9g9999g'
select b,to_char(b,'g9g999g9g9999g') from test_mytab;

--decimal'g9g999g9g9999g'
select c,to_char(c,'g9g999g9g9999g') from test_mytab;

--float'g9g999g9g9999g'
select d,to_char(d,'g9g999g9g9999g') from test_mytab;

--real'g9g999g9g9999g'
select e,to_char(e,'g9g999g9g9999g') from test_mytab;

--int'999999999mi'
select a,to_char(a,'999999999mi') from test_mytab;

--numeric'999999999mi'
select b,to_char(b,'999999999mi') from test_mytab;

--decimal'999999999mi'
select c,to_char(c,'999999999mi') from test_mytab;

--float'999999999mi'
select d,to_char(d,'999999999mi') from test_mytab;

--real'999999999mi'
select e,to_char(e,'999999999mi') from test_mytab;

--int'999999999pr'
select a,to_char(a,'999999999pr') from test_mytab;

--numeric'999999999pr'
select b,to_char(b,'999999999pr') from test_mytab;

--decimal'999999999pr'
select c,to_char(c,'999999999pr') from test_mytab;

--float'999999999pr'
select d,to_char(d,'999999999pr') from test_mytab;

--real'999999999pr'
select e,to_char(e,'999999999pr') from test_mytab;

--int'rn'
select a,to_char(a,'rn') from test_mytab;

--numeric'rn'
select b,to_char(b,'rn') from test_mytab;

--decimal'rn'
select c,to_char(c,'rn') from test_mytab;

--float'rn'
select d,to_char(d,'rn') from test_mytab;

--real'rn'
select e,to_char(e,'rn') from test_mytab;

--int's999999999'
select a,to_char(a,'s999999999') from test_mytab;

--numeric's999999999'
select b,to_char(b,'s999999999') from test_mytab;

--decimal's999999999'
select c,to_char(c,'s999999999') from test_mytab;

--float's999999999'
select d,to_char(d,'s999999999') from test_mytab;

--real's999999999'
select e,to_char(e,'s999999999') from test_mytab;

--int'99999v9999'
select a,to_char(a,'99999v9999') from test_mytab;

--numeric'99999v9999'
select b,to_char(b,'99999v9999') from test_mytab;

--decimal'99999v9999'
select c,to_char(c,'99999v9999') from test_mytab;

--float'99999v9999'
select d,to_char(d,'99999v9999') from test_mytab;

--real'99999v9999'
select e,to_char(e,'99999v9999') from test_mytab;


----不支持 TM

----不支持
--int'fm999999999.9900'
select a,to_char(a,'fm999999999.9900') from test_mytab;

--numeric'fm999999999.9900'
select b,to_char(b,'fm999999999.9900') from test_mytab;

--decimal'fm999999999.9900'
select c,to_char(c,'fm999999999.9900') from test_mytab;

--float'fm999999999.9900'
select d,to_char(d,'fm999999999.9900') from test_mytab;

--real'fm999999999.9900'
select e,to_char(e,'fm999999999.9900') from test_mytab;


----fmt
---，(9,999) 返回指定位置的逗号

select to_char('123456','999,999') from dual;
select to_char('123456','999,999,') from dual;

--------------------------------------补充
drop table if exists numerical;
create table numerical
(
col_int int ,
col_numeric numeric(18,8),
col_decimal decimal(18,6),
col_float float,
col_real real,
col_double_precision double precision,
col_number number
);

insert into numerical values ('10000', '10000', '10000','10000', '10000','10000','10000');

---指定1个逗号
select 
to_char(col_int,'999999,9999')"col_int",
to_char(col_numeric,'999999,9999')"col_numeric",
to_char(col_decimal,'999999,9999')"col_decimal",
to_char(col_float,'999999,9999')"col_float",
to_char(col_real,'999999,9999')"col_real",
to_char(col_double_precision,'999999,9999')"col_double_precision",
to_char(col_number,'999999,9999')"col_number"
from numerical;

---指定多个逗号
select 
to_char(col_int,'9,999,999,999')"col_int",
to_char(col_numeric,'9,999,999,999')"col_numeric",
to_char(col_decimal,'9,999,999,999')"col_decimal",
to_char(col_float,'9,999,999,999')"col_float",
to_char(col_real,'9,999,999,999')"col_real",
to_char(col_double_precision,'9,999,999,999')"col_double_precision",
to_char(col_number,'9,999,999,999')"col_number"
from numerical;

---逗号元素作为数字格式模型的开头
select 
to_char(col_int,',999999,9999')"col_int",
to_char(col_numeric,',999999,9999')"col_numeric",
to_char(col_decimal,',999999,9999')"col_decimal",
to_char(col_float,',999999,9999')"col_float",
to_char(col_real,',999999,9999')"col_real",
to_char(col_double_precision,',999999,9999')"col_double_precision",
to_char(col_number,',999999,9999')"col_number"
from numerical;



---在句点的右侧
select 
to_char(col_int,'9999999999.,')"col_int",
to_char(col_numeric,'9999999999.,')"col_numeric",
to_char(col_decimal,'9999999999.,')"col_decimal",
to_char(col_float,'9999999999.,')"col_float",
to_char(col_real,'9999999999.,')"col_real",
to_char(col_double_precision,'9999999999.,')"col_double_precision",
to_char(col_number,'9999999999.,')"col_number"
from numerical;

---不在句点的右侧
select 
to_char(col_int,'9999999999,.')"col_int",
to_char(col_numeric,'9999999999,.')"col_numeric",
to_char(col_decimal,'9999999999,.')"col_decimal",
to_char(col_float,'9999999999,.')"col_float",
to_char(col_real,'9999999999,.')"col_real",
to_char(col_double_precision,'9999999999,.')"col_double_precision",
to_char(col_number,'9999999999,.')"col_number"
from numerical;

 
---在十进制字符的右侧

select 
to_char(col_int,'9999999999,')"col_int",
to_char(col_numeric,'9999999999,')"col_numeric",
to_char(col_decimal,'9999999999,')"col_decimal",
to_char(col_float,'9999999999,')"col_float",
to_char(col_real,'9999999999,')"col_real",
to_char(col_double_precision,'9999999999,')"col_double_precision",
to_char(col_number,'9999999999,')"col_number"
from numerical;

 

----(99.99) 返回小数点，即指定位置的句号(.)
---数字格式模型中指定一个句点
select 
to_char(col_int,'9999999999.')"col_int",
to_char(col_numeric,'9999999999.')"col_numeric",
to_char(col_decimal,'9999999999.')"col_decimal",
to_char(col_float,'9999999999.')"col_float",
to_char(col_real,'9999999999.')"col_real",
to_char(col_double_precision,'9999999999.')"col_double_precision",
to_char(col_number,'9999999999.')"col_number"
from numerical;

truncate numerical;

insert into numerical values (100.0, 100.0, 100.0,100.0, 100.0,100.0,100.0);

select 
to_char(col_int,'99999999.9')"col_int",
to_char(col_numeric,'99999999.9')"col_numeric",
to_char(col_decimal,'99999999.9')"col_decimal",
to_char(col_float,'99999999.9')"col_float",
to_char(col_real,'99999999.9')"col_real",
--to_char(col_double_precision,'99999999.9')"col_double_precision",
to_char(col_number,'99999999.9')"col_number"
from numerical;



----数字格式模型中指定多个句点

truncate numerical;

insert into numerical values (10000000, 10000000, 10000000,10000000, 10000000,10000000,10000000);

select 
to_char(col_int,'9999.999.9')"col_int",
to_char(col_numeric,'9999.999.9')"col_numeric",
to_char(col_decimal,'9999.999.9')"col_decimal",
to_char(col_float,'9999.999.9')"col_float",
to_char(col_real,'9999.999.9')"col_real",
--to_char(col_double_precision,'9999.999.9')"col_double_precision",
to_char(col_number,'9999.999.9')"col_number"
from numerical;

---($9999) 返回带有前导美元符号的值。

truncate numerical;

insert into numerical values (10000000, 10000000, 10000000,10000000, 10000000,10000000,10000000);

select 
to_char(col_int,'$9999999999')"col_int",
to_char(col_numeric,'$9999999999')"col_numeric",
to_char(col_decimal,'$9999999999')"col_decimal",
to_char(col_float,'$9999999999')"col_float",
to_char(col_real,'$9999999999')"col_real",
--to_char(col_double_precision,'$9999999999')"col_double_precision",
to_char(col_number,'$9999999999')"col_number"
from numerical;

 
---(l9999) 返回带有前导人民币符号的值。

 
select 
to_char(col_int,'l9999999999')"col_int",
to_char(col_numeric,'l9999999999')"col_numeric",
to_char(col_decimal,'l9999999999')"col_decimal",
to_char(col_float,'l9999999999')"col_float",
to_char(col_real,'l9999999999')"col_real",
--to_char(col_double_precision,'l9999999999')"col_double_precision",
to_char(col_number,'l9999999999')"col_number"
from numerical;


 
---(€9999) 返回带有前导欧元符号的值。

 
 select 
to_char(col_int,'u9999999999')"col_int",
to_char(col_numeric,'u9999999999')"col_numeric",
to_char(col_decimal,'u9999999999')"col_decimal",
to_char(col_float,'u9999999999')"col_float",
to_char(col_real,'u9999999999')"col_real",
--to_char(col_double_precision,'u9999999999')"col_double_precision",
to_char(col_number,'u9999999999')"col_number"
from numerical;

truncate numerical;

----(09999990) 返回前导零。返回尾随零

 
insert into numerical values ('010010', '010010', '010010','010010', '010010','0','010010');
--R-369
select 
to_char(col_int,'09999990')"col_int",
to_char(col_numeric,'09999990')"col_numeric",
to_char(col_decimal,'09999990')"col_decimal",
to_char(col_float,'09999990')"col_float",
to_char(col_real,'09999990')"col_real",
to_char(col_double_precision,'09999990')"col_double_precision",
to_char(col_number,'09999990')"col_number"
from numerical;

truncate numerical;

----(9999) 返回具有指定位数的值

--正数则带有前导空格

insert into numerical values (' 010010', ' 010010', ' 010010',' 010010', ' 010010','0',' 010010'); ----插入失败，XTP还不支持带空格

--select 
--to_char(col_int,'999999')"col_int",
--to_char(col_numeric,'999999')"col_numeric",
--to_char(col_decimal,'999999')"col_decimal",
--to_char(col_float,'999999')"col_float",
--to_char(col_real,'999999')"col_real",
--to_char(col_double_precision,'999999')"col_double_precision",
--to_char(col_number,'999999')"col_number"
--from numerical;
--
--truncate numerical;

--正数则带有前导空格+'+'

insert into numerical values (' +010010', ' +010010', ' +010010',' +010010', ' +010010','+010010',' +010010');----插入失败，XTP还不支持带空格
insert into numerical values ('+010010', '+010010', '+010010','+010010', '+010010','+010010','+010010');


select 
to_char(col_int,'999999')"col_int",
to_char(col_numeric,'999999')"col_numeric",
to_char(col_decimal,'999999')"col_decimal",
to_char(col_float,'999999')"col_float",
to_char(col_real,'999999')"col_real",
to_char(col_double_precision,'999999')"col_double_precision",
to_char(col_number,'999999')"col_number"
from numerical;

truncate numerical;

--正数则带有前导'+'+空格

insert into numerical values (' + 010010', ' + 010010', ' + 010010',' + 010010', ' + 010010','0',' + 010010');  --xtp插入失败

---select 
---to_char(col_int,'999999')"col_int",
---to_char(col_numeric,'999999')"col_numeric",
---to_char(col_decimal,'999999')"col_decimal",
---to_char(col_float,'999999')"col_float",
---to_char(col_real,'999999')"col_real",
---to_char(col_double_precision,'999999')"col_double_precision",
---to_char(col_number,'999999')"col_number"
---from numerical;
---
truncate numerical;

--负数则带有前导空格+减号

insert into numerical values (' -010010', ' -010010', ' -010010',' -010010', ' -010010','-010010',' -010010');  --xtp插入失败
insert into numerical values ('-010010', '-010010', '-010010','-010010', '-010010','-010010','-010010'); 

select 
to_char(col_int,'999999')"col_int",
to_char(col_numeric,'999999')"col_numeric",
to_char(col_decimal,'999999')"col_decimal",
to_char(col_float,'999999')"col_float",
to_char(col_real,'999999')"col_real",
to_char(col_double_precision,'999999')"col_double_precision",
to_char(col_number,'999999')"col_number"
from numerical;

truncate numerical;

--负数则带有前导减号+空格

insert into numerical values (' - 010010', ' - 010010', ' - 010010',' - 010010', ' - 010010','0',' - 010010');--xtp插入失败

---select 
---to_char(col_int,'999999')"col_int",
---to_char(col_numeric,'999999')"col_numeric",
---to_char(col_decimal,'999999')"col_decimal",
---to_char(col_float,'999999')"col_float",
---to_char(col_real,'999999')"col_real",
---to_char(col_double_precision,'999999')"col_double_precision",
---to_char(col_number,'999999')"col_number"
---from numerical;

truncate numerical;

--前导零是空白

insert into numerical values (' 0 ', ' 0 ', ' 0 ',' 0 ', ' 0 ','0',' 0 ');--xtp插入失败

--select 
--to_char(col_int,'999999')"col_int",
--to_char(col_numeric,'999999')"col_numeric",
--to_char(col_decimal,'999999')"col_decimal",
--to_char(col_float,'999999')"col_float",
--to_char(col_real,'999999')"col_real",
--to_char(col_double_precision,'999999')"col_double_precision",
--to_char(col_number,'999999')"col_number"
--from numerical;

truncate numerical;

--前导零是空白+0+空白+0+空白

insert into numerical values (' 0 0 ', ' 0 0 ', ' 0 0 ',' 0 0 ', ' 0 0 ','0',' 0 0 ');  ----oracle 和 xtp 都插入失败

select 
to_char(col_int,'999999')"col_int",
to_char(col_numeric,'999999')"col_numeric",
to_char(col_decimal,'999999')"col_decimal",
to_char(col_float,'999999')"col_float",
to_char(col_real,'999999')"col_real",
to_char(col_double_precision,'999999')"col_double_precision",
to_char(col_number,'999999')"col_number"
from numerical;

truncate numerical;

---b9999
---当整数部分为零时，定点数的整数部分返回空白
--整数

insert into numerical values ('10010', '10010', '10010','10010', '10010','10010','10010');

select 
to_char(col_int,'b99999')"col_int",
to_char(col_numeric,'b99999')"col_numeric",
to_char(col_decimal,'b99999')"col_decimal",
to_char(col_float,'b99999')"col_float",
to_char(col_real,'b99999')"col_real",
to_char(col_double_precision,'b99999')"col_double_precision",
to_char(col_number,'b99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('010010', '010010', '010010','010010', '010010','010010','010010');

select 
to_char(col_int,'b99999')"col_int",
to_char(col_numeric,'b99999')"col_numeric",
to_char(col_decimal,'b99999')"col_decimal",
to_char(col_float,'b99999')"col_float",
to_char(col_real,'b99999')"col_real",
to_char(col_double_precision,'b99999')"col_double_precision",
to_char(col_number,'b99999')"col_number"
from numerical;

truncate numerical;


--小数
insert into numerical values ('0.10010', '0.10010', '0.10010','0.10010', '0.10010','0.10010','0.10010');  -----xtp插入失败
insert into numerical values ('0', '0.10010', '0.10010','0.10010', '0.10010','0.10010','0.10010');  

select 
to_char(col_int,'b9.99999')"col_int",
to_char(col_numeric,'b9.99999')"col_numeric",
to_char(col_decimal,'b9.99999')"col_decimal",
to_char(col_float,'b9.99999')"col_float",
to_char(col_real,'b9.99999')"col_real",
to_char(col_double_precision,'b9.99999')"col_double_precision",
to_char(col_number,'b9.99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('1.10010', '1.10010', '1.10010','1.10010', '1.10010','1.10010','1.10010');--xtp插入失败
insert into numerical values ('1', '1.10010', '1.10010','1.10010', '1.10010','1.10010','1.10010');
select 
to_char(col_int,'b9.99999')"col_int",
to_char(col_numeric,'b9.99999')"col_numeric",
to_char(col_decimal,'b9.99999')"col_decimal",
to_char(col_float,'b9.99999')"col_float",
to_char(col_real,'b9.99999')"col_real",
to_char(col_double_precision,'b9.99999')"col_double_precision",
to_char(col_number,'b9.99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('1.0000', '1.0000', '1.0000','1.0000', '1.0000','1.0000','1.0000');--xtp插入失败
insert into numerical values ('1', '1.0000', '1.0000','1.0000', '1.0000','1.0000','1.0000');

select 
to_char(col_int,'b9.99999')"col_int",
to_char(col_numeric,'b9.99999')"col_numeric",
to_char(col_decimal,'b9.99999')"col_decimal",
to_char(col_float,'b9.99999')"col_float",
to_char(col_real,'b9.99999')"col_real",
to_char(col_double_precision,'b9.99999')"col_double_precision",
to_char(col_number,'b9.99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('11.0000', '11.0000', '11.0000','11.0000', '11.0000','11.0000','11.0000');--xtp插入失败
insert into numerical values ('11', '11.0000', '11.0000','11.0000', '11.0000','11.0000','11.0000'); 

select 
to_char(col_int,'b99.99999')"col_int",
to_char(col_numeric,'b99.99999')"col_numeric",
to_char(col_decimal,'b99.99999')"col_decimal",
to_char(col_float,'b99.99999')"col_float",
to_char(col_real,'b99.99999')"col_real",
to_char(col_double_precision,'b99.99999')"col_double_precision",
to_char(col_number,'b99.99999')"col_number"
from numerical;

truncate numerical;

---eeee  
---(9.9eeee) 返回使用科学记数法的值

insert into numerical values ('1.234e-3', '1.234e-3', '1.234e-3','1.234e-3', '1.234e-3','1.234e-3','1.234e-3');--xtp插入失败
insert into numerical values ('1', '1.234e-3', '1.234e-3','1.234e-3', '1.234e-3','1.234e-3','1.234e-3');
select 
to_char(col_int,'9.999eeee')"col_int",
to_char(col_numeric,'9.999eeee')"col_numeric",
to_char(col_decimal,'9.999eeee')"col_decimal",
to_char(col_float,'9.999eeee')"col_float",
to_char(col_real,'9.999eeee')"col_real",
to_char(col_double_precision,'9.999eeee')"col_double_precision",
to_char(col_number,'9.999eeee')"col_number"
from numerical;

truncate numerical;


insert into numerical values ('-1.234e-3', '-1.234e-3', '-1.234e-3','-1.234e-3', '-1.234e-3','1','-1.234e-3');--xtp插入失败
insert into numerical values ('-1', '-1.234e-3', '-1.234e-3','-1.234e-3', '-1.234e-3','1','-1.234e-3');

select 
to_char(col_int,'9.999eeee')"col_int",
to_char(col_numeric,'9.999eeee')"col_numeric",
to_char(col_decimal,'9.999eeee')"col_decimal",
to_char(col_float,'9.999eeee')"col_float",
to_char(col_real,'9.999eeee')"col_real",
to_char(col_double_precision,'9.999eeee')"col_double_precision",
to_char(col_number,'9.999eeee')"col_number"
from numerical;

truncate numerical;


insert into numerical values ('3e3', '3e3', '3e3','3e3', '3e3','1','3e3');  -----xtp插入失败
insert into numerical values (1, '3e3', '3e3','3e3', '3e3','3e3','3e3');  

select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-3e3', '-3e3', '-3e3','-3e3', '-3e3','1','-3e3');  -----xtp插入失败
insert into numerical values ('-1', '-3e3', '-3e3','-3e3', '-3e3','1','-3e3'); 

select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;

---边界

---insert into numerical(col_int) values (1e18);
---insert into numerical(col_numeric)values(123456789012345678e-8);
---insert into numerical(col_decimal)values(123456789012345678e-6);
---
-----float 类型oracle最大125
---insert into numerical(col_float)values(1e125);
---insert into numerical(col_float)values(1e126);
---
-----real 类型oracle最大125
---insert into numerical(col_real)values(1e125);
---insert into numerical(col_real)values(1e126);
---
-----double precision 类型oracle最大125
---insert into numerical(col_double_precision)values(1e125);
---insert into numerical(col_double_precision)values(1e126);
---
-----number 类型oracle最大125
---insert into numerical(col_number)values (1e125);
---insert into numerical(col_number)values (1e126);
---


---XTP整数最多1e999 位,超过1e999返回报错。oracle 1e125位,

---XTP小数最多1e-999位,超过1e-999返回报错。oracle 小于1e-131位正常显示值（科学计数法显示），超过1e-130位显示0


insert into numerical values (1e18, 123456789012345678e-8, 123456789012345678e-6,1e125,1e125,1e125,1e125);

select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;

select 
--to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
--to_char(col_float,'9999eeee')"col_float",
--to_char(col_real,'9999eeee')"col_real",
--to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;


insert into numerical values ('1e-999', '1e-999', '1e-999','1e-999', '1e-999','1e-999','1e-999');  -----xtp插入失败
insert into numerical values ('1', '1e-999', '1e-999','1e-999', '1e-999','1e-999','1e-999');


select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;


 

insert into numerical values ('1e1000', '1e1000', '1e1000','1e1000', '1e1000','1','1e1000');   ----oracle和xtp都插入失败
 
select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;


insert into numerical values ('1e-1000', '1e-1000', '1e-1000','1e-1000', '1e-1000','1e-1000','1e-1000');  ----xtp插入失败
insert into numerical values ('1', '1e-1000', '1e-1000','1e-1000', '1e-1000','1e-1000','1e-1000'); 


select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;


select 
--to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
--to_char(col_float,'9999eeee')"col_float",
--to_char(col_real,'9999eeee')"col_real",
--to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('1', '1e-130', '1e-130','1e-130', '1e-130','1e-130','1e-130'); 

select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;


select 
--to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
--to_char(col_float,'9999eeee')"col_float",
--to_char(col_real,'9999eeee')"col_real",
--to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('1', '1e-131', '1e-131','1e-131', '1e-131','1e-131','1e-131'); 

select 
to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
to_char(col_float,'9999eeee')"col_float",
to_char(col_real,'9999eeee')"col_real",
to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;


select 
--to_char(col_int,'9999eeee')"col_int",
to_char(col_numeric,'9999eeee')"col_numeric",
to_char(col_decimal,'9999eeee')"col_decimal",
--to_char(col_float,'9999eeee')"col_float",
--to_char(col_real,'9999eeee')"col_real",
--to_char(col_double_precision,'9999eeee')"col_double_precision",
to_char(col_number,'9999eeee')"col_number"
from numerical;

truncate numerical;



----(9999mi) 
----返回带有尾随减号 (-) 的负值
insert into numerical values ('10010-', '10010-', '10010-','10010-', '10010-','10010-','10010-');  ---oracle和xtp都插入失败
 


----返回带有尾随空白的正值
----mi 格式元素在数字格式模型的最后一个位置

insert into numerical values ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','10010','10010 '); ----xtp插入失败

insert into numerical values ('10010', '10010', '10010','10010', '10010','10010','10010'); 

select  
to_char(col_int,'99999mi')"col_int",
to_char(col_numeric,'99999mi')"col_numeric",
to_char(col_decimal,'99999mi')"col_decimal",
to_char(col_float,'99999mi')"col_float",
to_char(col_real,'99999mi')"col_real",
to_char(col_double_precision,'99999mi')"col_double_precision",
to_char(col_number,'99999mi')"col_number"
from numerical;

truncate numerical;

----mi 格式元素在数字格式模型的中间位置
insert into numerical values ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','10010 ','10010 ');----xtp插入失败
select 
to_char(col_int,'999mi99')"col_int",
to_char(col_numeric,'999mi99')"col_numeric",
to_char(col_decimal,'999mi99')"col_decimal",
to_char(col_float,'999mi99')"col_float",
to_char(col_real,'999mi99')"col_real",
to_char(col_double_precision,'999mi99')"col_double_precision",
to_char(col_number,'999mi99')"col_number"
from numerical;

truncate numerical;
----mi 格式元素在数字格式模型的开始位置
insert into numerical values ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','10010 ','10010 ');----xtp插入失败
select 
to_char(col_int,'mi99999')"col_int",
to_char(col_numeric,'mi99999')"col_numeric",
to_char(col_decimal,'mi99999')"col_decimal",
to_char(col_float,'mi99999')"col_float",
to_char(col_real,'mi99999')"col_real",
to_char(col_double_precision,'mi99999')"col_double_precision",
to_char(col_number,'mi99999')"col_number"
from numerical;

truncate numerical;


---9999pr
---在 <尖括号> 中返回负值
---pr格式元素在数字格式模型的最后一个位置
insert into numerical values ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','<10010>','<10010>'); ---oracle和xtp都插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('<1.0010>', '<1.0010>', '<1.0010>','<1.0010>', '<1.0010>','<1.0010>','<1.0010>'); ---oracle和xtp都插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('<-1.0010>', '<-1.0010>', '<-1.0010>','<-1.0010>', '<-1.0010>','<-1.0010>','<-1.0010>'); ---oracle和xtp都插入失败
select 
to_char(col_int,'9.9999pr')"col_int",
to_char(col_numeric,'9.9999pr')"col_numeric",
to_char(col_decimal,'9.9999pr')"col_decimal",
to_char(col_float,'9.9999pr')"col_float",
to_char(col_real,'9.9999pr')"col_real",
to_char(col_double_precision,'9.9999pr')"col_double_precision",
to_char(col_number,'9.9999pr')"col_number"
from numerical;

truncate numerical;


---返回带有前导和尾随空白的正值
insert into numerical values ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','10010 ','10010 ');----xtp插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('10010- ', '10010- ', '10010 ','10010 ', '10010 ','10010 ','10010 ');----xtp插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('<10010 >', '<10010 >', '<10010 >','<10010 >', '<10010 >','<10010 >','<10010 >');----oracle和xtp都插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('<1.0010 >', '<1.0010 >', '<1.0010 >','<1.0010 >', '<1.0010 >','<1.0010 >','<1.0010 >');----oracle和xtp都插入失败
select 
to_char(col_int,'99999pr')"col_int",
to_char(col_numeric,'99999pr')"col_numeric",
to_char(col_decimal,'99999pr')"col_decimal",
to_char(col_float,'99999pr')"col_float",
to_char(col_real,'99999pr')"col_real",
to_char(col_double_precision,'99999pr')"col_double_precision",
to_char(col_number,'99999pr')"col_number"
from numerical;

truncate numerical;

---pr格式元素在数字格式模型的中间位置
insert into numerical values ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','<10010>','<10010>');----oracle和xtp都插入失败
select 
to_char(col_int,'999pr99')"col_int",
to_char(col_numeric,'999pr99')"col_numeric",
to_char(col_decimal,'999pr99')"col_decimal",
to_char(col_float,'999pr99')"col_float",
to_char(col_real,'999pr99')"col_real",
to_char(col_double_precision,'999pr99')"col_double_precision",
to_char(col_number,'999pr99')"col_number"
from numerical;

truncate numerical;
---pr格式元素在数字格式模型的开始位置
insert into numerical values ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','<10010>','<10010>');----oracle和xtp都插入失败
select 
to_char(col_int,'pr99999')"col_int",
to_char(col_numeric,'pr99999')"col_numeric",
to_char(col_decimal,'pr99999')"col_decimal",
to_char(col_float,'pr99999')"col_float",
to_char(col_real,'pr99999')"col_real",
to_char(col_double_precision,'pr99999')"col_double_precision",
to_char(col_number,'pr99999')"col_number"
from numerical;

truncate numerical;


---s99999999s
--返回带前导减号 (-) 的负值
insert into numerical values ('-10010', '-10010', '-10010','-10010', '-10010','-10010','-10010');
select 
to_char(col_int,'s99999')"col_int",
to_char(col_numeric,'s99999')"col_numeric",
to_char(col_decimal,'s99999')"col_decimal",
to_char(col_float,'s99999')"col_float",
to_char(col_real,'s99999')"col_real",
to_char(col_double_precision,'s99999')"col_double_precision",
to_char(col_number,'s99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-10.010', '-10.010', '-10.010','-10.010', '-10.010','-10.010','-10.010');---xtp 插入失败
 


select 
to_char(col_int,'s99.999')"col_int",
to_char(col_numeric,'s99.999')"col_numeric",
to_char(col_decimal,'s99.999')"col_decimal",
to_char(col_float,'s99.999')"col_float",
to_char(col_real,'s99.999')"col_real",
to_char(col_double_precision,'s99.999')"col_double_precision",
to_char(col_number,'s99.999')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('-0.010', '-0.010', '-0.010','-0.010', '-0.010','-0.010','-0.010');---xtp 插入失败
select 
to_char(col_int,'s99.999')"col_int",
to_char(col_numeric,'s99.999')"col_numeric",
to_char(col_decimal,'s99.999')"col_decimal",
to_char(col_float,'s99.999')"col_float",
to_char(col_real,'s99.999')"col_real",
to_char(col_double_precision,'s99.999')"col_double_precision",
to_char(col_number,'s99.999')"col_number"
from numerical;

truncate numerical;


--返回带前导加号 (+) 的正值

insert into numerical values ('+10010', '+10010', '+10010','+10010', '+10010','+10010','+10010');
select 
to_char(col_int,'s99999')"col_int",
to_char(col_numeric,'s99999')"col_numeric",
to_char(col_decimal,'s99999')"col_decimal",
to_char(col_float,'s99999')"col_float",
to_char(col_real,'s99999')"col_real",
to_char(col_double_precision,'s99999')"col_double_precision",
to_char(col_number,'s99999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('+10.010', '+10.010', '+10.010','+10.010', '+10.010','+10.010','+10.010');  ---xtp插入失败
insert into numerical values ('+10', '+10.010', '+10.010','+10.010', '+10.010','+10.010','+10.010');

select 
to_char(col_int,'s99.999')"col_int",
to_char(col_numeric,'s99.999')"col_numeric",
to_char(col_decimal,'s99.999')"col_decimal",
to_char(col_float,'s99.999')"col_float",
to_char(col_real,'s99.999')"col_real",
to_char(col_double_precision,'s99.999')"col_double_precision",
to_char(col_number,'s99.999')"col_number"
from numerical;

select 
to_char(col_int,'s99.999')"col_int",
to_char(col_numeric,'s99.999')"col_numeric",
to_char(col_decimal,'s99.999')"col_decimal",
to_char(col_float,'s99.999')"col_float",
to_char(col_real,'s99.999')"col_real",
to_char(col_double_precision,'s99.999')"col_double_precision",
to_char(col_number,'s99.999')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('+0.010', '+0.010', '+0.010','+0.010', '+0.010','0','+0.010');  ---xtp插入失败
insert into numerical values ('1', '+0.010', '+0.010','+0.010', '+0.010','0','+0.010');

select 
to_char(col_int,'s99.999')"col_int",
to_char(col_numeric,'s99.999')"col_numeric",
to_char(col_decimal,'s99.999')"col_decimal",
to_char(col_float,'s99.999')"col_float",
to_char(col_real,'s99.999')"col_real",
to_char(col_double_precision,'s99.999')"col_double_precision",
to_char(col_number,'s99.999')"col_number"
from numerical;

truncate numerical;

--返回带尾随减号 (-) 的负值

insert into numerical values ('10010-', '10010-', '10010-','10010-', '10010-','10010-','10010-');  ---oracle和xtp都插入失败
 
select 
to_char(col_int,'99999s')"col_int",
to_char(col_numeric,'99999s')"col_numeric",
to_char(col_decimal,'99999s')"col_decimal",
to_char(col_float,'99999s')"col_float",
to_char(col_real,'99999s')"col_real",
to_char(col_double_precision,'99999s')"col_double_precision",
to_char(col_number,'99999s')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('10.010-', '10.010-', '10.010-','10.010-', '10.010-','0','10.010-'); ---oracle和xtp都插入失败
select 
to_char(col_int,'99.999s')"col_int",
to_char(col_numeric,'99.999s')"col_numeric",
to_char(col_decimal,'99.999s')"col_decimal",
to_char(col_float,'99.999s')"col_float",
to_char(col_real,'99.999s')"col_real",
to_char(col_double_precision,'99.999s')"col_double_precision",
to_char(col_number,'99.999s')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('0.010-', '0.010-', '0.010-','0.010-', '0.010-','0','0.010-'); ---oracle和xtp都插入失败
select 
to_char(col_int,'99.999s')"col_int",
to_char(col_numeric,'99.999s')"col_numeric",
to_char(col_decimal,'99.999s')"col_decimal",
to_char(col_float,'99.999s')"col_float",
to_char(col_real,'99.999s')"col_real",
to_char(col_double_precision,'99.999s')"col_double_precision",
to_char(col_number,'99.999s')"col_number"
from numerical;

truncate numerical;

--返回带尾随加号 (+) 的正值
insert into numerical values ('10010+', '10010+', '10010+','10010+', '10010+','0','10010+');---oracle和xtp都插入失败
select 
to_char(col_int,'99999s')"col_int",
to_char(col_numeric,'99999s')"col_numeric",
to_char(col_decimal,'99999s')"col_decimal",
to_char(col_float,'99999s')"col_float",
to_char(col_real,'99999s')"col_real",
to_char(col_double_precision,'99999s')"col_double_precision",
to_char(col_number,'99999s')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('10.010+', '10.010+', '10.010+','10.010+', '10.010+','0','10.010+');---oracle和xtp都插入失败
select 
to_char(col_int,'99.999s')"col_int",
to_char(col_numeric,'99.999s')"col_numeric",
to_char(col_decimal,'99.999s')"col_decimal",
to_char(col_float,'99.999s')"col_float",
to_char(col_real,'99.999s')"col_real",
to_char(col_double_precision,'99.999s')"col_double_precision",
to_char(col_number,'99.999s')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('0.010+', '0.010+', '0.010+','0.010+', '0.010+','0','0.010+');---oracle和xtp都插入失败
select 
to_char(col_int,'99.999s')"col_int",
to_char(col_numeric,'99.999s')"col_numeric",
to_char(col_decimal,'99.999s')"col_decimal",
to_char(col_float,'99.999s')"col_float",
to_char(col_real,'99.999s')"col_real",
to_char(col_double_precision,'99.999s')"col_double_precision",
to_char(col_number,'99.999s')"col_number"
from numerical;

truncate numerical;

--s格式元素在数字格式模型的中间位置
insert into numerical values ('10010+', '10010+', '10010+','10010+', '10010+','0','10010+'); ---oracle和xtp都插入失败
select 
to_char(col_int,'999s99')"col_int",
to_char(col_numeric,'999s99')"col_numeric",
to_char(col_decimal,'999s99')"col_decimal",
to_char(col_float,'999s99')"col_float",
to_char(col_real,'999s99')"col_real",
to_char(col_double_precision,'999s99')"col_double_precision",
to_char(col_number,'999s99')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('10.010+', '10.010+', '10.010+','10.010+', '10.010+','0','10.010+'); ---oracle和xtp都插入失败
select 
to_char(col_int,'99.9s9')"col_int",
to_char(col_numeric,'99.9s9')"col_numeric",
to_char(col_decimal,'99.9s9')"col_decimal",
to_char(col_float,'99.9s9')"col_float",
to_char(col_real,'99.9s9')"col_real",
to_char(col_double_precision,'99.9s9')"col_double_precision",
to_char(col_number,'99.9s9')"col_number"
from numerical;

truncate numerical;


--需与oracle对比,当s和$都存在时，确认s和货币$的先后顺序？
---($9999) 返回带有前导美元符号的值。

truncate numerical;

insert into numerical values ('-$1000', '-$1000', '-$1000','-$1000', '-$1000','1','-$1000'); ---oracle和xtp都插入失败

select 
to_char(col_int,'s$9999')"col_int",
to_char(col_numeric,'s$9999')"col_numeric",
to_char(col_decimal,'s$9999')"col_decimal",
to_char(col_float,'s$9999')"col_float",
to_char(col_real,'s$9999')"col_real",
--to_char(col_double_precision,'s$9999')"col_double_precision",
to_char(col_number,'s$9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('$1000-', '$1000-', '$1000-','$1000-', '$1000-','1','$1000-');  ---oracle和xtp都插入失败

select 
to_char(col_int,'$9999s')"col_int",
to_char(col_numeric,'$9999s')"col_numeric",
to_char(col_decimal,'$9999s')"col_decimal",
to_char(col_float,'$9999s')"col_float",
to_char(col_real,'$9999s')"col_real",
--to_char(col_double_precision,'$9999s')"col_double_precision",
to_char(col_number,'$9999s')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('+$1000', '+$1000', '+$1000','+$1000', '+$1000','1','+$1000');  ---oracle和xtp都插入失败

select 
to_char(col_int,'s$9999')"col_int",
to_char(col_numeric,'s$9999')"col_numeric",
to_char(col_decimal,'s$9999')"col_decimal",
to_char(col_float,'s$9999')"col_float",
to_char(col_real,'s$9999')"col_real",
--to_char(col_double_precision,'s$9999')"col_double_precision",
to_char(col_number,'s$9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('$1000+', '$1000+', '$1000+','$1000+', '$1000+','1','$1000+');  ---oracle和xtp都插入失败

select 
to_char(col_int,'$9999s')"col_int",
to_char(col_numeric,'$9999s')"col_numeric",
to_char(col_decimal,'$9999s')"col_decimal",
to_char(col_float,'$9999s')"col_float",
to_char(col_real,'$9999s')"col_real",
--to_char(col_double_precision,'$9999s')"col_double_precision",
to_char(col_number,'$9999s')"col_number"
from numerical;


---(l9999) 返回带有前导人民币符号的值。

truncate numerical;

insert into numerical values ('-¥1000', '-¥1000', '-¥1000','-¥1000', '-¥1000','1','-¥1000'); ---oracle和xtp都插入失败

select 
to_char(col_int,'sl9999')"col_int",
to_char(col_numeric,'sl9999')"col_numeric",
to_char(col_decimal,'sl9999')"col_decimal",
to_char(col_float,'sl9999')"col_float",
to_char(col_real,'sl9999')"col_real",
--to_char(col_double_precision,'sl9999')"col_double_precision",
to_char(col_number,'sl9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('¥1000-', '¥1000-', '¥1000-','¥1000-', '¥1000-','1','¥1000-'); ---oracle和xtp都插入失败

select 
to_char(col_int,'l9999s')"col_int",
to_char(col_numeric,'l9999s')"col_numeric",
to_char(col_decimal,'l9999s')"col_decimal",
to_char(col_float,'l9999s')"col_float",
to_char(col_real,'l9999s')"col_real",
--to_char(col_double_precision,'l9999s')"col_double_precision",
to_char(col_number,'l9999s')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('+¥1000', '+¥1000', '+¥1000','+¥1000', '+¥1000','1','+¥1000'); ---oracle和xtp都插入失败

select 
to_char(col_int,'sl9999')"col_int",
to_char(col_numeric,'sl9999')"col_numeric",
to_char(col_decimal,'sl9999')"col_decimal",
to_char(col_float,'sl9999')"col_float",
to_char(col_real,'sl9999')"col_real",
--to_char(col_double_precision,'sl9999')"col_double_precision",
to_char(col_number,'sl9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('¥1000+', '¥1000+', '¥1000+','¥1000+', '¥1000+','1','¥1000+'); ---oracle和xtp都插入失败

select 
to_char(col_int,'l9999s')"col_int",
to_char(col_numeric,'l9999s')"col_numeric",
to_char(col_decimal,'l9999s')"col_decimal",
to_char(col_float,'l9999s')"col_float",
to_char(col_real,'l9999s')"col_real",
--to_char(col_double_precision,'l9999s')"col_double_precision",
to_char(col_number,'l9999s')"col_number"
from numerical;



---(€9999) 返回带有前导欧元符号的值。

truncate numerical;

insert into numerical values ('-€1000', '-€1000', '-€1000','-€1000', '-€1000','1','-€1000'); ---oracle和xtp都插入失败

select 
to_char(col_int,'su9999')"col_int",
to_char(col_numeric,'su9999')"col_numeric",
to_char(col_decimal,'su9999')"col_decimal",
to_char(col_float,'su9999')"col_float",
to_char(col_real,'su9999')"col_real",
--to_char(col_double_precision,'su9999')"col_double_precision",
to_char(col_number,'su9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('€1000-', '€1000-', '€1000-','€1000-', '€1000-','1','€1000-'); ---oracle和xtp都插入失败

select 
to_char(col_int,'u9999s')"col_int",
to_char(col_numeric,'u9999s')"col_numeric",
to_char(col_decimal,'u9999s')"col_decimal",
to_char(col_float,'u9999s')"col_float",
to_char(col_real,'u9999s')"col_real",
--to_char(col_double_precision,'u9999s')"col_double_precision",
to_char(col_number,'u9999s')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('+€1000', '+€1000', '+€1000','+€1000', '+€1000','1','+€1000'); ---oracle和xtp都插入失败

select 
to_char(col_int,'su9999')"col_int",
to_char(col_numeric,'su9999')"col_numeric",
to_char(col_decimal,'su9999')"col_decimal",
to_char(col_float,'su9999')"col_float",
to_char(col_real,'su9999')"col_real",
--to_char(col_double_precision,'su9999')"col_double_precision",
to_char(col_number,'su9999')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('€1000+', '€1000+', '€1000+','€1000+', '€1000+','1','€1000+'); ---oracle和xtp都插入失败

select 
to_char(col_int,'u9999s')"col_int",
to_char(col_numeric,'u9999s')"col_numeric",
to_char(col_decimal,'u9999s')"col_decimal",
to_char(col_float,'u9999s')"col_float",
to_char(col_real,'u9999s')"col_real",
--to_char(col_double_precision,'u9999s')"col_double_precision",
to_char(col_number,'u9999s')"col_number"
from numerical;

--（999v99)
---返回一个乘以 10n 的值（其中 n 是 v 后面的 9 的个数）

truncate numerical;

insert into numerical values ('1000', '1000', '1000','1000', '1000','1000','1000');

select 
to_char(col_int,'9999v99')"col_int",
to_char(col_numeric,'9999v99')"col_numeric",
to_char(col_decimal,'9999v99')"col_decimal",
to_char(col_float,'9999v99')"col_float",
to_char(col_real,'9999v99')"col_real",
--to_char(col_double_precision,'9999v99')"col_double_precision",
to_char(col_number,'9999v99')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-1000', '-1000', '-1000','-1000', '-1000','-1000','-1000');

select 
to_char(col_int,'9999v99')"col_int",
to_char(col_numeric,'9999v99')"col_numeric",
to_char(col_decimal,'9999v99')"col_decimal",
to_char(col_float,'9999v99')"col_float",
to_char(col_real,'9999v99')"col_real",
--to_char(col_double_precision,'9999v99')"col_double_precision",
to_char(col_number,'9999v99')"col_number"
from numerical;

insert into numerical values ('0.111', '0.111', '0.111','0.111', '0.111','1','0.111');  ----xtp插入失败
 
----oracal 和 xtp 都失败
select 
to_char(col_int,'9.999v99')"col_int",
to_char(col_numeric,'9.999v99')"col_numeric",
to_char(col_decimal,'9.999v99')"col_decimal",
to_char(col_float,'9.999v99')"col_float",
to_char(col_real,'9.999v99')"col_real",
--to_char(col_double_precision,'9.999v99')"col_double_precision",
to_char(col_number,'9.999v99')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-0.111', '-0.111', '-0.111','-0.111', '-0.111','1','-0.111');
----oracal 和 xtp 都失败
select 
to_char(col_int,'9.999v99')"col_int",
to_char(col_numeric,'9.999v99')"col_numeric",
to_char(col_decimal,'9.999v99')"col_decimal",
to_char(col_float,'9.999v99')"col_float",
to_char(col_real,'9.999v99')"col_real",
--to_char(col_double_precision,'9.999v99')"col_double_precision",
to_char(col_number,'9.999v99')"col_number"
from numerical;

truncate numerical;

---(xxxxxxxx)
---16进制

insert into numerical values ('0a0a', '0a0a', '0a0a', '0a0a', '0a0a', '0a0a', '0a0a'); ---oracle和xtp都插入失败

select 
to_char(col_int,'xxxx')"col_int",
to_char(col_numeric,'xxxx')"col_numeric",
to_char(col_decimal,'xxxx')"col_decimal",
to_char(col_float,'xxxx')"col_float",
to_char(col_real,'xxxx')"col_real",
to_char(col_double_precision,'xxxx')"col_double_precision",
to_char(col_number,'xxxx')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa'); ---oracle和xtp都插入失败

select 
to_char(col_int,'xx')"col_int",
to_char(col_numeric,'xx')"col_numeric",
to_char(col_decimal,'xx')"col_decimal",
to_char(col_float,'xx')"col_float",
to_char(col_real,'xx')"col_real",
to_char(col_double_precision,'xx')"col_double_precision",
to_char(col_number,'xx')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('78', '78', '78', '78', '78', '78', '78');

select 
to_char(col_int,'xx')"col_int",
to_char(col_numeric,'xx')"col_numeric",
to_char(col_decimal,'xx')"col_decimal",
to_char(col_float,'xx')"col_float",
to_char(col_real,'xx')"col_real",
to_char(col_double_precision,'xx')"col_double_precision",
to_char(col_number,'xx')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-78', '-78', '-78', '-78', '-78', '-78', '-78');

select 
to_char(col_int,'xx')"col_int",
to_char(col_numeric,'xx')"col_numeric",
to_char(col_decimal,'xx')"col_decimal",
to_char(col_float,'xx')"col_float",
to_char(col_real,'xx')"col_real",
to_char(col_double_precision,'xx')"col_double_precision",
to_char(col_number,'xx')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('7.8', '7.8', '7.8', '7.8', '7.8', '7.8', '7.8'); ----xtp插入失败
insert into numerical values ('8', '7.8', '7.8', '7.8', '7.8', '7.8', '7.8');

select 
to_char(col_int,'xx')"col_int",
to_char(col_numeric,'xx')"col_numeric",
to_char(col_decimal,'xx')"col_decimal",
to_char(col_float,'xx')"col_float",
to_char(col_real,'xx')"col_real",
to_char(col_double_precision,'xx')"col_double_precision",
to_char(col_number,'xx')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '-7.8');----xtp插入失败
insert into numerical values ('-8', '-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '-7.8');



select 
to_char(col_int,'xx')"col_int",
to_char(col_numeric,'xx')"col_numeric",
to_char(col_decimal,'xx')"col_decimal",
to_char(col_float,'xx')"col_float",
to_char(col_real,'xx')"col_real",
to_char(col_double_precision,'xx')"col_double_precision",
to_char(col_number,'xx')"col_number"
from numerical;


truncate numerical;

insert into numerical values ('7.8', '7.8', '7.8', '7.8', '7.8', '7.8', '7.8');----xtp插入失败
insert into numerical values ('8', '7.8', '7.8', '7.8', '7.8', '7.8', '7.8');

---oracle和xtp都报错
select 
to_char(col_int,'x.x')"col_int",
to_char(col_numeric,'x.x')"col_numeric",
to_char(col_decimal,'x.x')"col_decimal",
to_char(col_float,'x.x')"col_float",
to_char(col_real,'x.x')"col_real",
to_char(col_double_precision,'x.x')"col_double_precision",
to_char(col_number,'x.x')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '7', '-7.8');----xtp插入失败
insert into numerical values ('-8', '-7.8', '-7.8', '-7.8', '-7.8', '7', '-7.8');

---oracle和xtp都报错
select 
to_char(col_int,'x.x')"col_int",
to_char(col_numeric,'x.x')"col_numeric",
to_char(col_decimal,'x.x')"col_decimal",
to_char(col_float,'x.x')"col_float",
to_char(col_real,'x.x')"col_real",
to_char(col_double_precision,'x.x')"col_double_precision",
to_char(col_number,'x.x')"col_number"
from numerical;



truncate numerical;

insert into numerical values ('0', '0', '0', '0', '0', '0', '0');

select 
to_char(col_int,'x')"col_int",
to_char(col_numeric,'x')"col_numeric",
to_char(col_decimal,'x')"col_decimal",
to_char(col_float,'x')"col_float",
to_char(col_real,'x')"col_real",
to_char(col_double_precision,'x')"col_double_precision",
to_char(col_number,'x')"col_number"
from numerical;

truncate numerical;

---oracle和xtp都报错
insert into numerical values ('-0', '-0', '-0', '-0', '-0', '-0', '-0');

select 
to_char(col_int,'-x')"col_int",
to_char(col_numeric,'-x')"col_numeric",
to_char(col_decimal,'-x')"col_decimal",
to_char(col_float,'-x')"col_float",
to_char(col_real,'-x')"col_real",
to_char(col_double_precision,'-x')"col_double_precision",
to_char(col_number,'-x')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('-0', '-0', '-0', '-0', '-0', '-0', '-0');

select 
to_char(col_int,'x')"col_int",
to_char(col_numeric,'x')"col_numeric",
to_char(col_decimal,'x')"col_decimal",
to_char(col_float,'x')"col_float",
to_char(col_real,'x')"col_real",
to_char(col_double_precision,'x')"col_double_precision",
to_char(col_number,'x')"col_number"
from numerical;

truncate numerical;



---，(9g999) 返回指定位置的逗号

select to_char('123456','999g999') from dual;  ----xtp报错
select to_char('123456','999g999g') from dual; ----xtp报错


select to_char(123456,'999g999') from dual;  
select to_char(123456,'999g999g') from dual; 

drop table if exists numerical;

create table numerical
(
col_int int ,
col_numeric numeric(18,8),
col_decimal decimal(18,6),
col_float float,
col_real real,
col_double_precision double precision,
col_number number
);

insert into numerical values ('10000', '10000', '10000','10000', '10000','10000','10000');

---指定1个逗号
select 
to_char(col_int,'999999g9999')"col_int",
to_char(col_numeric,'999999g9999')"col_numeric",
to_char(col_decimal,'999999g9999')"col_decimal",
to_char(col_float,'999999g9999')"col_float",
to_char(col_real,'999999g9999')"col_real",
to_char(col_double_precision,'999999g9999')"col_double_precision",
to_char(col_number,'999999g9999')"col_number"
from numerical;

---指定多个逗号
select 
to_char(col_int,'9g999g999g999')"col_int",
to_char(col_numeric,'9g999g999g999')"col_numeric",
to_char(col_decimal,'9g999g999g999')"col_decimal",
to_char(col_float,'9g999g999g999')"col_float",
to_char(col_real,'9g999g999g999')"col_real",
to_char(col_double_precision,'9g999g999g999')"col_double_precision",
to_char(col_number,'9g999g999g999')"col_number"
from numerical;

---逗号元素作为数字格式模型的开头 
----oracle和xtp都报错
select 
to_char(col_int,',999999g9999')"col_int",
to_char(col_numeric,',999999g9999')"col_numeric",
to_char(col_decimal,',999999g9999')"col_decimal",
to_char(col_float,',999999g9999')"col_float",
to_char(col_real,',999999g9999')"col_real",
to_char(col_double_precision,',999999g9999')"col_double_precision",
to_char(col_number,',999999g9999')"col_number"
from numerical;


---在句点的右侧
----oracle和xtp都报错
select 
to_char(col_int,'9999999999dg')"col_int",
to_char(col_numeric,'9999999999dg')"col_numeric",
to_char(col_decimal,'9999999999dg')"col_decimal",
to_char(col_float,'9999999999dg')"col_float",
to_char(col_real,'9999999999dg')"col_real",
to_char(col_double_precision,'9999999999dg')"col_double_precision",
to_char(col_number,'9999999999dg')"col_number"
from numerical;

---不在句点的右侧
select 
to_char(col_int,'9999999999gd')"col_int",
to_char(col_numeric,'9999999999gd')"col_numeric",
to_char(col_decimal,'9999999999gd')"col_decimal",
to_char(col_float,'9999999999gd')"col_float",
to_char(col_real,'9999999999gd')"col_real",
to_char(col_double_precision,'9999999999gd')"col_double_precision",
to_char(col_number,'9999999999gd')"col_number"
from numerical;

 
---在十进制字符的右侧

select 
to_char(col_int,'9999999999g')"col_int",
to_char(col_numeric,'9999999999g')"col_numeric",
to_char(col_decimal,'9999999999g')"col_decimal",
to_char(col_float,'9999999999g')"col_float",
to_char(col_real,'9999999999g')"col_real",
to_char(col_double_precision,'9999999999g')"col_double_precision",
to_char(col_number,'9999999999g')"col_number"
from numerical;

 

----(99d99) 返回小数点，即指定位置的句号(.)
---数字格式模型中指定一个句点
select 
to_char(col_int,'9999999999d')"col_int",
to_char(col_numeric,'9999999999d')"col_numeric",
to_char(col_decimal,'9999999999d')"col_decimal",
to_char(col_float,'9999999999d')"col_float",
to_char(col_real,'9999999999d')"col_real",
to_char(col_double_precision,'9999999999d')"col_double_precision",
to_char(col_number,'9999999999d')"col_number"
from numerical;

truncate numerical;

insert into numerical values ('100.0', '100.0', '100.0','100.0', '100.0','100.0','100.0');   ---xtp插入失败
insert into numerical values ('100', '100.0', '100.0','100.0', '100.0','100.0','100.0');   
select 
to_char(col_int,'99999999d9')"col_int",
to_char(col_numeric,'99999999d9')"col_numeric",
to_char(col_decimal,'99999999d9')"col_decimal",
to_char(col_float,'99999999d9')"col_float",
to_char(col_real,'99999999d9')"col_real",
--to_char(col_double_precision,'99999999d9')"col_double_precision",
to_char(col_number,'99999999d9')"col_number"
from numerical;



----数字格式模型中指定多个句点

truncate numerical;

insert into numerical values ('1000.000.0', '1000.000.0', '1000.000.0','1000.000.0', '1000.000.0','1000.000.0','1000.000.0');  ---oracle和xtp都插入失败
 
select 
to_char(col_int,'9999d999d9')"col_int",
to_char(col_numeric,'9999d999d9')"col_numeric",
to_char(col_decimal,'9999d999d9')"col_decimal",
to_char(col_float,'9999d999d9')"col_float",
to_char(col_real,'9999d999d9')"col_real",
--to_char(col_double_precision,'9999d999d9')"col_double_precision",
to_char(col_number,'9999d999d9')"col_number"
from numerical;






--datetimehh24:mi:ss.ff
drop table if exists test_1;
create table test_1
(
t1 time(6),
ts1 timestamp(6),
t2 time(0),
ts2 timestamp(0)
);

insert into test_1 values
(time'00:00:30.123456',timestamp'2018-01-01 00:00:30.123456',time'00:00:30',timestamp'2018-01-01 00:00:30'),
(time'00:00:31.123456',timestamp'2018-01-02 00:00:31.123456',time'00:00:31',timestamp'2018-01-02 00:00:31'),
(time'00:00:32.123456',timestamp'2018-01-03 00:00:32.123456',time'00:00:32',timestamp'2018-01-03 00:00:32'),
(time'00:00:33.123456',timestamp'2018-01-04 00:00:33.123456',time'00:00:33',timestamp'2018-01-04 00:00:33'),
(time'00:00:34.123456',timestamp'2018-01-05 00:00:34.123456',time'00:00:34',timestamp'2018-01-05 00:00:34');

select to_char(time'13:05:10.123456009','hh24:mi:ss.ff')from dual;
select to_char(t1,'hh24:mi:ss.ff')from test_1;
select to_char(t2,'hh24:mi:ss.ff')from test_1;

--datetimeyyyymmddhh24missff
select to_char(timestamp'2018-03-01 12:00:59.123456','yyyymmddhh24missff')from dual;
select to_char(ts1,'yyyymmddhh24missff')from test_1;
select to_char(ts2,'yyyymmddhh24missff')from test_1;

--datetimedd-mm-yyyyhh24:mi:ss
select to_char(timestamp'2018-03-01 12:00:59','dd-mm-yyyyhh24:mi:ss')from dual;
select to_char(ts1,'dd-mm-yyyyhh24:mi:ss')from test_1;
select to_char(ts2,'dd-mm-yyyyhh24:mi:ss')from test_1;

--datetimedd-mm-yyyyhh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','dd-mm-yyyyhh24:mi:ss.ff')from dual;
select to_char(ts1,'dd-mm-yyyyhh24:mi:ss.ff')from test_1;
select to_char(ts2,'dd-mm-yyyyhh24:mi:ss.ff')from test_1;

--datetimedd.mm.yyyy:hh24.mi.ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','dd.mm.yyyy:hh24.mi.ss.ff')from dual;
select to_char(ts1,'dd.mm.yyyy:hh24.mi.ss.ff')from test_1;
select to_char(ts2,'dd.mm.yyyy:hh24.mi.ss.ff')from test_1;

--datetimeyyyy-mm-ddhh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','yyyy-mm-ddhh24:mi:ss.ff')from dual;
select to_char(ts1,'yyyy-mm-ddhh24:mi:ss.ff')from test_1;
select to_char(ts2,'yyyy-mm-ddhh24:mi:ss.ff')from test_1;

--datetimeyyyymmdd:hh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','yyyymmdd:hh24:mi:ss.ff')from dual;
select to_char(ts1,'yyyymmdd:hh24:mi:ss.ff')from test_1;
select to_char(ts2,'yyyymmdd:hh24:mi:ss.ff')from test_1;

--datetimemmddyyyyhh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','mmddyyyyhh24:mi:ss.ff')from dual;
select to_char(ts1,'mmddyyyyhh24:mi:ss.ff')from test_1;
select to_char(ts2,'mmddyyyyhh24:mi:ss.ff')from test_1;

--datetimemm/dd/yyyyhh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','mm/dd/yyyyhh24:mi:ss.ff')from dual;
select to_char(ts1,'mm/dd/yyyyhh24:mi:ss.ff')from test_1;
select to_char(ts2,'mm/dd/yyyyhh24:mi:ss.ff')from test_1;

--datetimedd-mon-yyyyhh:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','dd-mon-yyyyhh:mi:ss.ff')from dual;
select to_char(ts1,'dd-mon-yyyyhh:mi:ss.ff')from test_1;
select to_char(ts2,'dd-mon-yyyyhh:mi:ss.ff')from test_1;

--datetimedd.mm.yyyyhh24.mi.ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','dd.mm.yyyyhh24.mi.ss.ff')from dual;
select to_char(ts1,'dd.mm.yyyyhh24.mi.ss.ff')from test_1;
select to_char(ts2,'dd.mm.yyyyhh24.mi.ss.ff')from test_1;

--datetimeyyyy/mm/ddhh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','yyyy/mm/ddhh24:mi:ss.ff')from dual;
select to_char(ts1,'yyyy/mm/ddhh24:mi:ss.ff')from test_1;
select to_char(ts2,'yyyy/mm/ddhh24:mi:ss.ff')from test_1;

--datetimeyyyy-mm-dd:hh24:mi:ss.ff
select to_char(timestamp'2018-03-01 12:00:59.123456','yyyy-mm-dd:hh24:mi:ss.ff')from dual;
select to_char(ts1,'yyyy-mm-dd:hh24:mi:ss.ff')from test_1;
select to_char(ts2,'yyyy-mm-dd:hh24:mi:ss.ff')from test_1;


-----XTP没有隐式转换，都是失败

----字符类型

drop table if exists STRINGS;

CREATE TABLE STRINGS (
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10) ,
col_CHAR CHAR, 
col_CHAR_length CHAR(10)
);

---小数
INSERT INTO strings VALUES ('0.11111111', '0.11111111', '0.11111111','0.11111111', '0.11111111','1', '0.11111111');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

---别名
select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_string)=0.11111111 and
to_char(col_string_length)=0.11111111 and
to_char(col_text)=0.11111111 and
to_char(col_varchar)=0.11111111 and
to_char(col_varchar_length)=0.11111111 and
col_char = '1' and 
to_char(col_char_length)=0.11111111;

select * from strings;

--整数
INSERT INTO strings VALUES ('11111111', '11111111', '11111111','11111111', '11111111','1','11111111');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

---别名
select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_STRING)=11111111 and
to_char(col_string)=11111111 and
to_char(col_string_length)=11111111 and
to_char(col_text)=11111111 and
to_char(col_varchar)=11111111 and
to_char(col_varchar_length)=11111111 and
col_char = '1' and 
to_char(col_char_length)=11111111;

select * from strings;

--科学计数法：
INSERT INTO strings VALUES ('1.03E+08', '1.03E+08','1.03E+08','1.03E+08','1.03E+08','1','1.03E+08');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_STRING)=1.03E+8 and
to_char(col_string)=1.03E+8 and
to_char(col_string_length)=1.03E+8 and
to_char(col_text)=1.03E+8 and
to_char(col_varchar)=1.03E+8 and
to_char(col_varchar_length)=1.03E+8 and
col_char = '1' and 
to_char(col_char_length)=1.03E+8;

select * from strings;

---16进制

INSERT INTO strings VALUES ('0A', '0A', '0A', '0A', '0A', 'A', '0A');

select 
to_char(col_string,'XX'),
to_char(col_string_length,'XX'),
to_char(col_text,'XX'),
to_char(col_varchar,'XX'),
to_char(col_varchar_length,'XX'),
to_char(col_char,'XX'),
to_char(col_char_length,'XX')
from strings;

select 
to_char(col_string,'XX')col_string,
to_char(col_string_length,'XX')col_string_length,
to_char(col_text,'XX')col_text,
to_char(col_varchar,'XX')col_varchar,
to_char(col_varchar_length,'XX')col_varchar_length,
to_char(col_char,'XX')col_char,
to_char(col_char_length,'XX')col_char_length
from strings;

SELECT 
to_char(COL_STRING,'XX')"COL_STRING",
to_char(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
to_char(COL_TEXT,'XX')"COL_TEXT",
to_char(COL_VARCHAR,'XX')"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
to_char(COL_CHAR,'XX')"COL_CHAR",
to_char(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string,'XX')=10 and
to_char(col_string_length,'XX')=10 and
to_char(col_text,'XX')=10 and
to_char(col_varchar,'XX')=10 and
to_char(col_varchar_length,'XX')=10 and
to_char(col_char,'XX')=10 and
to_char(col_char_length,'XX')=10;

select * from strings;

INSERT INTO strings VALUES ('aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'a', 'aaaaaaaa');

select 
to_char(col_string,'XX'),
to_char(col_string_length,'XX'),
to_char(col_text,'XX'),
to_char(col_varchar,'XX'),
to_char(col_varchar_length,'XX'),
to_char(col_char,'XX'),
to_char(col_char_length,'XX')
from strings;

select 
to_char(col_string,'XX')col_string,
to_char(col_string_length,'XX')col_string_length,
to_char(col_text,'XX')col_text,
to_char(col_varchar,'XX')col_varchar,
to_char(col_varchar_length,'XX')col_varchar_length,
to_char(col_char,'XX')col_char,
to_char(col_char_length,'XX')col_char_length
from strings;

SELECT 
to_char(COL_STRING,'XX')"COL_STRING",
to_char(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
to_char(COL_TEXT,'XX')"COL_TEXT",
to_char(COL_VARCHAR,'XX')"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
to_char(COL_CHAR,'XX')"COL_CHAR",
to_char(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string,'XX')=2863311530 and
to_char(col_string_length,'XX')=2863311530 and
to_char(col_text,'XX')=2863311530 and
to_char(col_varchar,'XX')=2863311530 and
to_char(col_varchar_length,'XX')=2863311530 and
to_char(col_char,'XX')=10 and
to_char(col_char_length,'XX')=2863311530;

select * from strings;

----有-号
----字符类型

CREATE TABLE STRINGS (
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10),
col_CHAR CHAR, 
col_CHAR_length CHAR(10)
);

---小数
INSERT INTO strings VALUES ('-0.1111111', '-0.1111111', '-0.1111111','-0.1111111', '-0.1111111','1', '-0.1111111');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

---别名
select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_string)=0.1111111 and
to_char(col_string_length)=0.1111111 and
to_char(col_text)=0.1111111 and
to_char(col_varchar)=0.1111111 and
to_char(col_varchar_length)=0.1111111 and
col_char = '1' and 
to_char(col_char_length)=0.1111111;

select * from strings;

--整数
INSERT INTO strings VALUES ('-1111111', '-1111111', '-1111111','-1111111', '-1111111','1','-1111111');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

---别名
select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_string)=1111111 and
to_char(col_string_length)=1111111 and
to_char(col_text)=1111111 and
to_char(col_varchar)=1111111 and
to_char(col_varchar_length)=1111111 and
col_char = '1' and 
to_char(col_char_length)=1111111;

select * from strings;

--科学计数法：
INSERT INTO strings VALUES ('-1.03E+08', '-1.03E+08','-1.03E+08','-1.03E+08','-1.03E+08','1','-1.03E+08');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string)=1.03E+8 and
to_char(col_string_length)=1.03E+8 and
to_char(col_text)=1.03E+8 and
to_char(col_varchar)=1.03E+8 and
to_char(col_varchar_length)=1.03E+8 and
col_char = '1' and 
to_char(col_char_length)=1.03E+8;

select * from strings;

---16进制

INSERT INTO strings VALUES ('-0A', '-0A', '-0A', '-0A', '-0A', 'A', '-0A');

select 
to_char(col_string,'XX'),
to_char(col_string_length,'XX'),
to_char(col_text,'XX'),
to_char(col_varchar,'XX'),
to_char(col_varchar_length,'XX'),
to_char(col_char,'XX'),
to_char(col_char_length,'XX')
from strings;

select 
to_char(col_string,'XX')col_string,
to_char(col_string_length,'XX')col_string_length,
to_char(col_text,'XX')col_text,
to_char(col_varchar,'XX')col_varchar,
to_char(col_varchar_length,'XX')col_varchar_length,
to_char(col_char,'XX')col_char,
to_char(col_char_length,'XX')col_char_length
from strings;

SELECT 
to_char(COL_STRING,'XX')"COL_STRING",
to_char(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
to_char(COL_TEXT,'XX')"COL_TEXT",
to_char(COL_VARCHAR,'XX')"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
to_char(COL_CHAR,'XX')"COL_CHAR",
to_char(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string,'XX')=10 and
to_char(col_string_length,'XX')=10 and
to_char(col_text,'XX')=10 and
to_char(col_varchar,'XX')=10 and
to_char(col_varchar_length,'XX')=10 and
to_char(col_char,'XX')=10 and
to_char(col_char_length,'XX')=10;

select * from strings;

INSERT INTO strings VALUES ('-aaaaaaa', '-aaaaaaa', '-aaaaaaa', '-aaaaaaa', '-aaaaaaa', 'a', '-aaaaaaa');

select 
to_char(col_string,'XX'),
to_char(col_string_length,'XX'),
to_char(col_text,'XX'),
to_char(col_varchar,'XX'),
to_char(col_varchar_length,'XX'),
to_char(col_char,'XX'),
to_char(col_char_length,'XX')
from strings;

select 
to_char(col_string,'XX')col_string,
to_char(col_string_length,'XX')col_string_length,
to_char(col_text,'XX')col_text,
to_char(col_varchar,'XX')col_varchar,
to_char(col_varchar_length,'XX')col_varchar_length,
to_char(col_char,'XX')col_char,
to_char(col_char_length,'XX')col_char_length
from strings;

SELECT 
to_char(COL_STRING,'XX')"COL_STRING",
to_char(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
to_char(COL_TEXT,'XX')"COL_TEXT",
to_char(COL_VARCHAR,'XX')"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
to_char(COL_CHAR,'XX')"COL_CHAR",
to_char(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string,'XX')=2863311530 and
to_char(col_string_length,'XX')=2863311530 and
to_char(col_text,'XX')=2863311530 and
to_char(col_varchar,'XX')=2863311530 and
to_char(col_varchar_length,'XX')=2863311530 and
to_char(col_char,'XX')=10 and
to_char(col_char_length,'XX')=2863311530;

select * from strings;



---字母

INSERT INTO strings VALUES ('abcdefg','abcdefg','abcdefg', 'abcdefg', 'abcdefg', 'g', 'abcdefg');


select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

select * from strings;

truncate strings;

---中文字符:
INSERT INTO strings VALUES ('测','测','测', '测', '测', '测', '测');


select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

select * from strings;

truncate strings;

-----特殊字符
INSERT INTO strings VALUES ('~!@#$%^&*?', '~!@#$%^&*?', '~!@#$%^&*?','~!@#$%^&*?','~!@#$%^&*?', '~', '~!@#$%^&*?');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;
select * from strings;

truncate strings;

----字母\中文\特殊字符
INSERT INTO strings VALUES ('a测#', 'a测#','a测#','a测#', 'a测#', '测', 'a测#');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;
select * from strings;

truncate strings;


------null值
INSERT INTO strings VALUES (null, null,null,null, null, null, null);

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_char(col_string)is NULL and
to_char(col_string_length)is NULL and
to_char(col_text)is NULL and
to_char(col_varchar)is NULL and
to_char(col_varchar_length)is NULL and
to_char(col_char)is NULL and
to_char(col_char_length)is NULL;



select * from strings;
truncate strings;

----空串''
INSERT INTO strings VALUES ('', '','','', '', '', '');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_string)='' and
to_char(col_string_length)='' and
to_char(col_text)='' and
to_char(col_varchar)='' and
to_char(col_varchar_length)='' and
to_char(col_char)='' and
to_char(col_char_length)='';

truncate strings;

----空串' '
INSERT INTO strings VALUES (' ', ' ',' ',' ', ' ', ' ', ' ');

select 
to_char(col_string),
to_char(col_string_length),
to_char(col_text),
to_char(col_varchar),
to_char(col_varchar_length),
--to_char(col_char),
to_char(col_char_length)
from strings;

select 
to_char(col_string)col_string,
to_char(col_string_length)col_string_length,
to_char(col_text)col_text,
to_char(col_varchar)col_varchar,
to_char(col_varchar_length)col_varchar_length,
--to_char(col_char)col_char,
to_char(col_char_length)col_char_length
from strings;

SELECT 
to_char(COL_STRING)"COL_STRING",
to_char(COL_STRING_LENGTH)"COL_STRING_LENGTH",
to_char(COL_TEXT)"COL_TEXT",
to_char(COL_VARCHAR)"COL_VARCHAR",
to_char(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--to_char(COL_CHAR)"COL_CHAR",
to_char(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_char(col_string)=' ' and
to_char(col_string_length)=' ' and
to_char(col_text)=' ' and
to_char(col_varchar)=' ' and
to_char(col_varchar_length)=' ' and
to_char(col_char)=' ' and
to_char(col_char_length)=' ';


---非数值和字符类型
--array
drop table if exists a;
CREATE TABLE a (b STRING[]);
INSERT INTO a VALUES (ARRAY['123', '123', '123']);
select to_char(b)  from  a;


--bit
drop table if exists b;
CREATE TABLE b (x BIT, y BIT(3), z VARBIT, w VARBIT(3));
INSERT INTO b(x, y, z, w) VALUES (B'1', B'101', B'1', B'1');
select to_char(x)  from  b;
select to_char(y)  from  b;
select to_char(z)  from  b;
select to_char(w)  from  b;

--bool
drop table if exists bool;
CREATE TABLE bool (a INT PRIMARY KEY, b BOOL, c BOOLEAN);
INSERT INTO bool VALUES (12345, true, CAST(0 AS BOOL));
--select to_char(a)  from bool;
select to_char(b)  from bool;
select to_char(c)  from bool;

--bytes
drop table if exists bytes;
CREATE TABLE bytes (a INT PRIMARY KEY, b BYTES);
INSERT INTO bytes VALUES (1, b'\141\142\143'), (2, b'\x61\x62\x63'), (3, b'\141\x62\c');
---select to_char(a)  from bytes;
select to_char(b)  from bytes;
truncate bytes;
INSERT INTO bytes VALUES (4, '123');
---select to_char(a)  from bytes;
select to_char(b)  from bytes;

--string collate en
drop table if exists foo;
CREATE TABLE foo (a STRING COLLATE en PRIMARY KEY);
INSERT INTO foo VALUES ('123' COLLATE en);
select to_char(a)  from foo;

--date
drop table if exists dates;
CREATE TABLE dates (a DATE PRIMARY KEY);
INSERT INTO dates VALUES (DATE '2018-11-02');
select to_char(a)  from dates;

select * from dates;

select to_char(to_char(to_date(a,'YYYY-MM-DD'),'MM'),'99') from dates;
 
select to_char(to_char(to_date('2018-11-02','YYYY-MM-DD'),'MM'),'99') from dual;

--enum
drop table if exists accounts;
drop TYPE if exists status;

CREATE TYPE status AS ENUM ('123', '456', '789');
SHOW ENUMS;
CREATE TABLE accounts (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        balance DECIMAL,
        status status
);
INSERT INTO accounts(balance,status) VALUES (500.50,'123');
SELECT count(*) FROM accounts;
select to_char(id)  from accounts;
---select to_char(balance)  from accounts;
select to_char(status)  from accounts;

--inet
drop table if exists computers;
CREATE TABLE computers (
    ip INET PRIMARY KEY
  );
INSERT INTO computers VALUES ('192.168.0.1');
select to_char(ip)  from accounts;
truncate accounts;
INSERT INTO computers VALUES ('192.168.0.2/10');
select to_char(ip)  from accounts;
truncate accounts;
INSERT INTO computers  VALUES ('2001:4f8:3:ba:2e0:81ff:fe22:d1f1/120');
select to_char(ip)  from accounts;
truncate accounts;
 
--interval
drop table if exists intervals1;
CREATE TABLE intervals1 (b INTERVAL);
INSERT INTO  intervals1  VALUES (INTERVAL '1 year 2 months 3 days 4 hours 5 minutes 6 seconds');
select to_char(b)  from intervals1;
truncate intervals1;
INSERT INTO  intervals1  VALUES (INTERVAL '1-2 3 4:5:6');
select to_char(b)  from intervals1;
truncate intervals1;
INSERT INTO  intervals1  VALUES ('1-2 3 4:5:6');
select to_char(b)  from intervals1;
truncate intervals1;

--jsonb
drop table if exists users;
CREATE TABLE users (
    user_profile JSONB
  );
INSERT INTO users (user_profile) VALUES ('{"222": "111", "333": "111", "444": "111", "666" : 547}');
select to_char(user_profile)  from users;

--serial
drop table if exists serial1;
CREATE TABLE serial1 (a SERIAL );
INSERT INTO serial1 (a) VALUES (123);
select to_char(a)  from serial1;
truncate serial1;
INSERT INTO serial1 (a) VALUES ('123');
select to_char(a)  from serial1;
truncate serial1;

--time
drop table if exists time1;
CREATE TABLE time1(time_val TIME);
INSERT INTO time1 VALUES (TIME '05:40:00');
select * from time1;
select to_char(time_val)  from time1;


--timestamp
drop table if exists timestamps_test;
CREATE TABLE timestamps_test (b TIMESTAMPTZ);
INSERT INTO timestamps_test VALUES (TIMESTAMPTZ '2016-03-26 10:10:10-05:00');
select * from timestamps_test;
select to_char(b)  from timestamps_test;

--uuid
drop table if exists v;
CREATE TABLE v (token uuid);
INSERT INTO v VALUES ('63616665-6630-3064-6465-616462656562');
SELECT * FROM v;
select to_char(token)  from v;
truncate v;
INSERT INTO v VALUES ('63616665663030646465616462656562');
SELECT * FROM v;
select to_char(token)  from v;


--查询
----where
-------数值类型
drop table if exists numerical;
create table numerical(
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
col_float_length10 float(10),  
col_float_length38 float(38),
col_float_length39 float(39),
col_real real, 
col_double_precision double precision,
col_int int,
col_integer integer,
col_int8 int8,
col_int64 int64,
col_bigint bigint,
col_int2 int2,
col_smallint smallint,
col_int4 int4
);

insert into numerical values(
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345);


insert into numerical values(
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345);


insert into numerical values(
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08, 
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1e+1,
  1e+1,
  1.03e+08);
  

insert into numerical values(
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0);


insert into numerical values(
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);

select * from numerical where
to_char(col_decimal)='0' and 
to_char(col_decimal_length10_0)='0' and 
--to_char(col_decimal_length10_2)='0' and 
--to_char(col_decimal_length10_3)='0' and 
--to_char(col_decimal_length10_10)='0' and 
to_char(col_decimal_length38_0)='0' and 
--to_char(col_decimal_length38_38)='0' and 
to_char(col_decimal_length39_0)='0' and 
to_char(col_numeric)='0' and 
to_char(col_numeric_length10_0)='0' and 
--to_char(col_numeric_length10_2)='0' and 
--to_char(col_numeric_length10_3)='0' and 
--to_char(col_numeric_length10_10)='0' and 
to_char(col_numeric_length38_0)='0' and 
--to_char(col_numeric_length38_38)='0' and 
to_char(col_numeric_length39_0)='0' and 
to_char(col_float)='0' and 
to_char(col_float_length10)='0' and 
to_char(col_float_length38)='0' and 
to_char(col_float_length39)='0' and 
to_char(col_real)='0' and 
to_char(col_double_precision)='0' and 
to_char(col_int)='0' and 
to_char(col_integer)='0' and 
to_char(col_int8)='0' and 
to_char(col_int64)='0' and 
to_char(col_bigint)='0' and 
to_char(col_int2)='0' and 
to_char(col_smallint)='0' and 
to_char(col_int4)='0';

select * from numerical where
to_char(col_decimal_length10_2)='0' and 
to_char(col_decimal_length10_3)='0' and 
to_char(col_decimal_length10_10)='0' and 
to_char(col_decimal_length38_38)='0' and 
to_char(col_numeric_length10_2)='0' and 
to_char(col_numeric_length10_3)='0' and 
to_char(col_numeric_length10_10)='0' and 
to_char(col_numeric_length38_38)='0';

select * from numerical where
to_char(col_decimal) is null and 
to_char(col_decimal_length10_0) is null and 
to_char(col_decimal_length10_2) is null and 
to_char(col_decimal_length10_3) is null and 
to_char(col_decimal_length10_10) is null and 
to_char(col_decimal_length38_0) is null and 
to_char(col_decimal_length38_38) is null and 
to_char(col_decimal_length39_0) is null and 
to_char(col_numeric) is null and 
to_char(col_numeric_length10_0) is null and 
to_char(col_numeric_length10_2) is null and 
to_char(col_numeric_length10_3) is null and 
to_char(col_numeric_length10_10) is null and 
to_char(col_numeric_length38_0) is null and 
to_char(col_numeric_length38_38) is null and 
to_char(col_numeric_length39_0) is null and 
to_char(col_float) is null and 
to_char(col_float_length10) is null and 
to_char(col_float_length38) is null and 
to_char(col_float_length39) is null and 
to_char(col_real) is null and 
to_char(col_double_precision) is null and 
to_char(col_int) is null and 
to_char(col_integer) is null and 
to_char(col_int8) is null and 
to_char(col_int64) is null and 
to_char(col_bigint) is null and 
to_char(col_int2) is null and 
to_char(col_smallint) is null and 
to_char(col_int4) is null;

----BUG导致报错
select * from numerical where
to_char(col_decimal)                           = '1234567' and 
to_char(col_decimal_length10_0)                = '1234567890' and 
to_char(col_decimal_length10_2)                = '12345678.12' and 
to_char(col_decimal_length10_3)                = '1234567.123' and 
to_char(col_decimal_length10_10)               = '0.012345679' and 
to_char(col_decimal_length38_0)                = '12345678901234567890123456789012345678' and 
-to_char(col_decimal_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_decimal_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_numeric)                           = '1234567' and 
to_char(col_numeric_length10_0)                = '1234567890' and 
to_char(col_numeric_length10_2)                = '12345678.12' and 
to_char(col_numeric_length10_3)                = '1234567.123' and 
to_char(col_numeric_length10_10)               = '0.012345679' and 
to_char(col_numeric_length38_0)                = '12345678901234567890123456789012345678' and 
to_char(col_numeric_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_numeric_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_float)                             = '1234567' and 
to_char(col_float_length10)                    = '1234567890' and 
to_char(col_float_length38)                    = '12345678901234567890123456789012345678' and 
to_char(col_float_length39)                    = '123456789012345678901234567890123456789' and 
to_char(col_real)                              = '12345' and 
to_char(col_double_precision)                  = '12345' and 
to_char(col_int)                               = '12345' and 
to_char(col_integer)                           = '12345' and 
to_char(col_int8)                              = '12345' and 
to_char(col_int64)                             = '12345' and 
to_char(col_bigint)                            = '12345' and 
to_char(col_int2)                              = '12345' and 
to_char(col_smallint)                          = '12345' and 
to_char(col_int4)                              = '12345';


select * from numerical where
to_char(col_decimal)                           = '1234567' and 
to_char(col_decimal_length10_0)                = '1234567890' and 
--to_char(col_decimal_length10_2)                = '12345678.12' and 
--to_char(col_decimal_length10_3)                = '1234567.123' and 
--to_char(col_decimal_length10_10)               = '0.012345679' and 
to_char(col_decimal_length38_0)                = '12345678901234567890123456789012345678' and 
--to_char(col_decimal_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_decimal_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_numeric)                           = '1234567' and 
to_char(col_numeric_length10_0)                = '1234567890' and 
--to_char(col_numeric_length10_2)                = '12345678.12' and 
--to_char(col_numeric_length10_3)                = '1234567.123' and 
--to_char(col_numeric_length10_10)               = '0.012345679' and 
to_char(col_numeric_length38_0)                = '12345678901234567890123456789012345678' and 
--to_char(col_numeric_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_numeric_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_float)                             = '1234567' and 
to_char(col_float_length10)                    = '1234567890' and 
to_char(col_float_length38)                    = '12345678901234567890123456789012345678' and 
to_char(col_float_length39)                    = '123456789012345678901234567890123456789' and 
to_char(col_real)                              = '12345' and 
to_char(col_double_precision)                  = '12345' and 
to_char(col_int)                               = '12345' and 
to_char(col_integer)                           = '12345' and 
to_char(col_int8)                              = '12345' and 
to_char(col_int64)                             = '12345' and 
to_char(col_bigint)                            = '12345' and 
to_char(col_int2)                              = '12345' and 
to_char(col_smallint)                          = '12345' and 
to_char(col_int4)                              = '12345';


select * from numerical where
to_char(col_decimal)                           = '1234567' and 
to_char(col_decimal_length10_0)                = '1234567890' and 
--to_char(col_decimal_length10_2)                = '12345678.12' and 
--to_char(col_decimal_length10_3)                = '1234567.123' and 
--to_char(col_decimal_length10_10)               = '0.012345679' and 
to_char(col_decimal_length38_0)                = '12345678901234567890123456789012345678' and 
--to_char(col_decimal_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_decimal_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_numeric)                           = '1234567' and 
to_char(col_numeric_length10_0)                = '1234567890' and 
--to_char(col_numeric_length10_2)                = '12345678.12' and 
--to_char(col_numeric_length10_3)                = '1234567.123' and 
--to_char(col_numeric_length10_10)               = '0.012345679' and 
to_char(col_numeric_length38_0)                = '12345678901234567890123456789012345678' and 
--to_char(col_numeric_length38_38)               = '0.12345678901234567890123456789012345678' and 
to_char(col_numeric_length39_0)                = '123456789012345678901234567890123456789' and 
to_char(col_float)                             = '1234567' and 
to_char(col_float_length10)                    = '1234567890' and 
--to_char(col_float_length38)                    = '12345678901234567890123456789012345678' and 
---to_char(col_float_length39)                    = '123456789012345678901234567890123456789' and 
to_char(col_real)                              = '12345' and 
to_char(col_double_precision)                  = '12345' and 
to_char(col_int)                               = '12345' and 
to_char(col_integer)                           = '12345' and 
to_char(col_int8)                              = '12345' and 
to_char(col_int64)                             = '12345' and 
to_char(col_bigint)                            = '12345' and 
to_char(col_int2)                              = '12345' and 
to_char(col_smallint)                          = '12345' and 
to_char(col_int4)                              = '12345';



select * from numerical where
to_char(col_decimal)                           = '-1234567' and 
to_char(col_decimal_length10_0)                = '-1234567890' and 
to_char(col_decimal_length10_2)                = '-12345678.12' and 
to_char(col_decimal_length10_3)                = '-1234567.123' and 
to_char(col_decimal_length10_10)               = '-0.012345679' and 
to_char(col_decimal_length38_0)                = '-12345678901234567890123456789012345678' and 
to_char(col_decimal_length38_38)               = '-0.12345678901234567890123456789012345678' and 
to_char(col_decimal_length39_0)                = '-123456789012345678901234567890123456789' and 
to_char(col_numeric)                           = '-1234567' and 
to_char(col_numeric_length10_0)                = '-1234567890' and 
to_char(col_numeric_length10_2)                = '-12345678.12' and 
to_char(col_numeric_length10_3)                = '-1234567.123' and 
to_char(col_numeric_length10_10)               = '-0.012345679' and 
to_char(col_numeric_length38_0)                = '-12345678901234567890123456789012345678' and 
to_char(col_numeric_length38_38)               = '-0.12345678901234567890123456789012345678' and 
to_char(col_numeric_length39_0)                = '-123456789012345678901234567890123456789' and 
to_char(col_float)                             = '-1234567' and 
to_char(col_float_length10)                    = '-1234567890' and 
to_char(col_float_length38)                    = '-12345678901234567890123456789012345678' and 
to_char(col_float_length39)                    = '-123456789012345678901234567890123456789' and 
to_char(col_real)                              = '-12345' and 
to_char(col_double_precision)                  = '-12345' and 
to_char(col_int)                               = '-12345' and 
to_char(col_integer)                           = '-12345' and 
to_char(col_int8)                              = '-12345' and 
to_char(col_int64)                             = '-12345' and 
to_char(col_bigint)                            = '-12345' and 
to_char(col_int2)                              = '-12345' and 
to_char(col_smallint)                          = '-12345' and 
to_char(col_int4)                              = '-12345';


select * from numerical where
to_char(col_decimal)                           = '-1234567' and 
to_char(col_decimal_length10_0)                = '-1234567890' and 
--to_char(col_decimal_length10_2)                = '-12345678.12' and 
--to_char(col_decimal_length10_3)                = '-1234567.123' and 
--to_char(col_decimal_length10_10)               = '-0.012345679' and 
to_char(col_decimal_length38_0)                = '-12345678901234567890123456789012345678' and 
--to_char(col_decimal_length38_38)               = '-0.12345678901234567890123456789012345678' and 
to_char(col_decimal_length39_0)                = '-123456789012345678901234567890123456789' and 
to_char(col_numeric)                           = '-1234567' and 
to_char(col_numeric_length10_0)                = '-1234567890' and 
--to_char(col_numeric_length10_2)                = '-12345678.12' and 
--to_char(col_numeric_length10_3)                = '-1234567.123' and 
--to_char(col_numeric_length10_10)               = '-0.012345679' and 
to_char(col_numeric_length38_0)                = '-12345678901234567890123456789012345678' and 
--to_char(col_numeric_length38_38)               = '-0.12345678901234567890123456789012345678' and 
to_char(col_numeric_length39_0)                = '-123456789012345678901234567890123456789' and 
to_char(col_float)                             = '-1234567' and 
to_char(col_float_length10)                    = '-1234567890' and 
--to_char(col_float_length38)                    = '-12345678901234567890123456789012345678' and 
--to_char(col_float_length39)                    = '-123456789012345678901234567890123456789' and 
to_char(col_real)                              = '-12345' and 
to_char(col_double_precision)                  = '-12345' and 
to_char(col_int)                               = '-12345' and 
to_char(col_integer)                           = '-12345' and 
to_char(col_int8)                              = '-12345' and 
to_char(col_int64)                             = '-12345' and 
to_char(col_bigint)                            = '-12345' and 
to_char(col_int2)                              = '-12345' and 
to_char(col_smallint)                          = '-12345' and 
to_char(col_int4)                              = '-12345';

 
----order by

select to_char(col_decimal) from numerical order by to_char(col_decimal);
select to_char(col_decimal_length10_0) from numerical order by to_char(col_decimal_length10_0);
select to_char(col_decimal_length38_0) from numerical order by to_char(col_decimal_length38_0);
select to_char(col_decimal_length39_0) from numerical order by to_char(col_decimal_length39_0);
select to_char(col_numeric) from numerical order by to_char(col_numeric);
select to_char(col_numeric_length10_0) from numerical order by to_char(col_numeric_length10_0);
select to_char(col_numeric_length38_0) from numerical order by to_char(col_numeric_length38_0);
select to_char(col_numeric_length39_0) from numerical order by to_char(col_numeric_length39_0);
select to_char(col_float) from numerical order by to_char(col_float);
select to_char(col_float_length10) from numerical order by to_char(col_float_length10);
select to_char(col_float_length38) from numerical order by to_char(col_float_length38);
select to_char(col_float_length39) from numerical order by to_char(col_float_length39);
select to_char(col_real) from numerical order by to_char(col_real);
select to_char(col_double_precision) from numerical order by to_char(col_double_precision);
select to_char(col_int) from numerical order by to_char(col_int);
select to_char(col_integer) from numerical order by to_char(col_integer);
select to_char(col_int8) from numerical order by to_char(col_int8);
select to_char(col_int64) from numerical order by to_char(col_int64);
select to_char(col_bigint) from numerical order by to_char(col_bigint);
select to_char(col_int2) from numerical order by to_char(col_int2);
select to_char(col_smallint) from numerical order by to_char(col_smallint);
select to_char(col_int4) from numerical order by to_char(col_int4);

select to_char(col_decimal_length10_2) from numerical order by to_char(col_decimal_length10_2);
select to_char(col_decimal_length10_3) from numerical order by to_char(col_decimal_length10_3);
select to_char(col_decimal_length10_10) from numerical order by to_char(col_decimal_length10_10);
select to_char(col_decimal_length38_38) from numerical order by to_char(col_decimal_length38_38);
select to_char(col_numeric_length10_2) from numerical order by to_char(col_numeric_length10_2);
select to_char(col_numeric_length10_3) from numerical order by to_char(col_numeric_length10_3);
select to_char(col_numeric_length10_10) from numerical order by to_char(col_numeric_length10_10);
select to_char(col_numeric_length38_38) from numerical order by to_char(col_numeric_length38_38);

select to_char(col_decimal) from numerical order by  col_decimal;
select to_char(col_decimal_length10_0) from numerical order by  col_decimal_length10_0;
select to_char(col_decimal_length38_0) from numerical order by  col_decimal_length38_0;
select to_char(col_decimal_length39_0) from numerical order by  col_decimal_length39_0;
select to_char(col_numeric) from numerical order by  col_numeric;
select to_char(col_numeric_length10_0) from numerical order by  col_numeric_length10_0;
select to_char(col_numeric_length38_0) from numerical order by  col_numeric_length38_0;
select to_char(col_numeric_length39_0) from numerical order by  col_numeric_length39_0;
select to_char(col_float) from numerical order by  col_float;
select to_char(col_float_length10) from numerical order by  col_float_length10;
select to_char(col_float_length38) from numerical order by  col_float_length38;
select to_char(col_float_length39) from numerical order by  col_float_length39;
select to_char(col_real) from numerical order by  col_real;
select to_char(col_double_precision) from numerical order by  col_double_precision;
select to_char(col_int) from numerical order by  col_int;
select to_char(col_integer) from numerical order by  col_integer;
select to_char(col_int8) from numerical order by  col_int8;
select to_char(col_int64) from numerical order by  col_int64;
select to_char(col_bigint) from numerical order by  col_bigint;
select to_char(col_int2) from numerical order by  col_int2;
select to_char(col_smallint) from numerical order by  col_smallint;
select to_char(col_int4) from numerical order by  col_int4;

select to_char(col_decimal_length10_2) from numerical order by  col_decimal_length10_2;
select to_char(col_decimal_length10_3) from numerical order by  col_decimal_length10_3;
select to_char(col_decimal_length10_10) from numerical order by  col_decimal_length10_10;
select to_char(col_decimal_length38_38) from numerical order by  col_decimal_length38_38;
select to_char(col_numeric_length10_2) from numerical order by  col_numeric_length10_2;
select to_char(col_numeric_length10_3) from numerical order by  col_numeric_length10_3;
select to_char(col_numeric_length10_10) from numerical order by  col_numeric_length10_10;
select to_char(col_numeric_length38_38) from numerical order by  col_numeric_length38_38;
 

 
----join
 

drop table if exists numerical2;
create table numerical2(
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
col_float_length10 float(10),  
col_float_length38 float(38),
col_float_length39 float(39),
col_real real, 
col_double_precision double precision,
col_int int,
col_integer integer,
col_int8 int8,
col_int64 int64,
col_bigint bigint,
col_int2 int2,
col_smallint smallint,
col_int4 int4
);

insert into numerical2 values(
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345);


insert into numerical2 values(
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345);


insert into numerical2 values(
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08, 
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1e+1,
  1e+1,
  1.03e+08);
  

insert into numerical2 values(
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0);


insert into numerical2 values(
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);


--inner join


select to_char(numerical.col_decimal) "col_decimal" ,to_char(numerical2.col_decimal) "col_decimal" from numerical inner join numerical2 on numerical.col_decimal= numerical2.col_decimal;
select to_char(numerical.col_decimal_length10_0) "col_decimal_length10_0"  ,to_char(numerical2.col_decimal_length10_0) "col_decimal_length10_0"from numerical inner join numerical2 on numerical.col_decimal_length10_0= numerical2.col_decimal_length10_0;
select to_char(numerical.col_decimal_length38_0) "col_decimal_length38_0" ,to_char(numerical2.col_decimal_length38_0) "col_decimal_length38_0" from numerical inner join numerical2 on numerical.col_decimal_length10_2= numerical2.col_decimal_length10_2;
select to_char(numerical.col_decimal_length39_0) "col_decimal_length39_0" ,to_char(numerical2.col_decimal_length39_0) "col_decimal_length39_0" from numerical inner join numerical2 on numerical.col_decimal_length10_3= numerical2.col_decimal_length10_3;
select to_char(numerical.col_numeric)  "col_numeric"  ,to_char(numerical2.col_numeric)  "col_numeric"  from numerical inner join numerical2 on numerical.col_decimal_length10_10= numerical2.col_decimal_length10_10;
select to_char(numerical.col_numeric_length10_0) "col_numeric_length10_0" ,to_char(numerical2.col_numeric_length10_0) "col_numeric_length10_0" from numerical inner join numerical2 on numerical.col_decimal_length38_0= numerical2.col_decimal_length38_0;
select to_char(numerical.col_numeric_length38_0) "col_numeric_length38_0" ,to_char(numerical2.col_numeric_length38_0) "col_numeric_length38_0" from numerical inner join numerical2 on numerical.col_decimal_length38_38= numerical2.col_decimal_length38_38;
select to_char(numerical.col_numeric_length39_0) "col_numeric_length39_0" ,to_char(numerical2.col_numeric_length39_0) "col_numeric_length39_0" from numerical inner join numerical2 on numerical.col_decimal_length39_0= numerical2.col_decimal_length39_0;
select to_char(numerical.col_float) "col_float" ,to_char(numerical2.col_float) "col_float" from numerical inner join numerical2 on numerical.col_numeric= numerical2.col_numeric;
select to_char(numerical.col_float_length10)  "col_float_length10"  ,to_char(numerical2.col_float_length10)  "col_float_length10"  from numerical inner join numerical2 on numerical.col_numeric_length10_0= numerical2.col_numeric_length10_0;
select to_char(numerical.col_float_length38) "col_float_length38" ,to_char(numerical2.col_float_length38) "col_float_length38" from numerical inner join numerical2 on numerical.col_numeric_length10_2= numerical2.col_numeric_length10_2;
select to_char(numerical.col_float_length39) "col_float_length39" ,to_char(numerical2.col_float_length39) "col_float_length39" from numerical inner join numerical2 on numerical.col_numeric_length10_3= numerical2.col_numeric_length10_3;
select to_char(numerical.col_real) "col_real" ,to_char(numerical2.col_real) "col_real" from numerical inner join numerical2 on numerical.col_numeric_length10_10= numerical2.col_numeric_length10_10;
select to_char(numerical.col_double_precision)  "col_double_precision"  ,to_char(numerical2.col_double_precision)  "col_double_precision"  from numerical inner join numerical2 on numerical.col_numeric_length38_0= numerical2.col_numeric_length38_0;
select to_char(numerical.col_int) "col_int" ,to_char(numerical2.col_int) "col_int" from numerical inner join numerical2 on numerical.col_numeric_length38_38= numerical2.col_numeric_length38_38;
select to_char(numerical.col_integer) "col_integer" ,to_char(numerical2.col_integer) "col_integer" from numerical inner join numerical2 on numerical.col_numeric_length39_0= numerical2.col_numeric_length39_0;
select to_char(numerical.col_int8) "col_int8" ,to_char(numerical2.col_int8) "col_int8" from numerical inner join numerical2 on numerical.col_float= numerical2.col_float;
select to_char(numerical.col_int64) "col_int64" ,to_char(numerical2.col_int64) "col_int64" from numerical inner join numerical2 on numerical.col_float_length10= numerical2.col_float_length10;
select to_char(numerical.col_bigint) "col_bigint" ,to_char(numerical2.col_bigint) "col_bigint" from numerical inner join numerical2 on numerical.col_float_length38= numerical2.col_float_length38;
select to_char(numerical.col_int2) "col_int2" ,to_char(numerical2.col_int2) "col_int2" from numerical inner join numerical2 on numerical.col_float_length39= numerical2.col_float_length39;
select to_char(numerical.col_smallint) "col_smallint" ,to_char(numerical2.col_smallint) "col_smallint" from numerical inner join numerical2 on numerical.col_real= numerical2.col_real;
select to_char(numerical.col_int4) "col_int4" ,to_char(numerical2.col_int4) "col_int4" from numerical inner join numerical2 on numerical.col_double_precision= numerical2.col_double_precision;

----BUG
select to_char(numerical.col_decimal_length10_2)"col_decimal_length10_2",to_char(numerical2.col_decimal_length10_2)"col_decimal_length10_2"from numerical inner join numerical2 on numerical.col_int= numerical2.col_int;
select to_char(numerical.col_decimal_length10_3)"col_decimal_length10_3",to_char(numerical2.col_decimal_length10_3)"col_decimal_length10_3"from numerical inner join numerical2 on numerical.col_integer= numerical2.col_integer;
select to_char(numerical.col_decimal_length10_10)"col_decimal_length10_10",to_char(numerical2.col_decimal_length10_10)"col_decimal_length10_10"from numerical inner join numerical2 on numerical.col_int8= numerical2.col_int8;
select to_char(numerical.col_decimal_length38_38)"col_decimal_length38_38",to_char(numerical2.col_decimal_length38_38)"col_decimal_length38_38"from numerical inner join numerical2 on numerical.col_int64= numerical2.col_int64;
select to_char(numerical.col_numeric_length10_2)"col_numeric_length10_2",to_char(numerical2.col_numeric_length10_2)"col_numeric_length10_2"from numerical inner join numerical2 on numerical.col_bigint= numerical2.col_bigint;
select to_char(numerical.col_numeric_length10_3)"col_numeric_length10_3",to_char(numerical2.col_numeric_length10_3)"col_numeric_length10_3"from numerical inner join numerical2 on numerical.col_int2= numerical2.col_int2;
select to_char(numerical.col_numeric_length10_10)"col_numeric_length10_10",to_char(numerical2.col_numeric_length10_10)"col_numeric_length10_10"from numerical inner join numerical2 on numerical.col_smallint= numerical2.col_smallint;
select to_char(numerical.col_numeric_length38_38)"col_numeric_length38_38",to_char(numerical2.col_numeric_length38_38)"col_numeric_length38_38"from numerical inner join numerical2 on numerical.col_int4= numerical2.col_int4;

--join

select to_char(numerical.col_decimal) "col_decimal" ,to_char(numerical2.col_decimal) "col_decimal" from numerical  join numerical2 on numerical.col_decimal= numerical2.col_decimal;
select to_char(numerical.col_decimal_length10_0) "col_decimal_length10_0"  ,to_char(numerical2.col_decimal_length10_0) "col_decimal_length10_0"from numerical  join numerical2 on numerical.col_decimal_length10_0= numerical2.col_decimal_length10_0;
select to_char(numerical.col_decimal_length38_0) "col_decimal_length38_0" ,to_char(numerical2.col_decimal_length38_0) "col_decimal_length38_0" from numerical  join numerical2 on numerical.col_decimal_length10_2= numerical2.col_decimal_length10_2;
select to_char(numerical.col_decimal_length39_0) "col_decimal_length39_0" ,to_char(numerical2.col_decimal_length39_0) "col_decimal_length39_0" from numerical  join numerical2 on numerical.col_decimal_length10_3= numerical2.col_decimal_length10_3;
select to_char(numerical.col_numeric)  "col_numeric"  ,to_char(numerical2.col_numeric)  "col_numeric"  from numerical  join numerical2 on numerical.col_decimal_length10_10= numerical2.col_decimal_length10_10;
select to_char(numerical.col_numeric_length10_0) "col_numeric_length10_0" ,to_char(numerical2.col_numeric_length10_0) "col_numeric_length10_0" from numerical  join numerical2 on numerical.col_decimal_length38_0= numerical2.col_decimal_length38_0;
select to_char(numerical.col_numeric_length38_0) "col_numeric_length38_0" ,to_char(numerical2.col_numeric_length38_0) "col_numeric_length38_0" from numerical  join numerical2 on numerical.col_decimal_length38_38= numerical2.col_decimal_length38_38;
select to_char(numerical.col_numeric_length39_0) "col_numeric_length39_0" ,to_char(numerical2.col_numeric_length39_0) "col_numeric_length39_0" from numerical  join numerical2 on numerical.col_decimal_length39_0= numerical2.col_decimal_length39_0;
select to_char(numerical.col_float) "col_float" ,to_char(numerical2.col_float) "col_float" from numerical  join numerical2 on numerical.col_numeric= numerical2.col_numeric;
select to_char(numerical.col_float_length10)  "col_float_length10"  ,to_char(numerical2.col_float_length10)  "col_float_length10"  from numerical  join numerical2 on numerical.col_numeric_length10_0= numerical2.col_numeric_length10_0;
select to_char(numerical.col_float_length38) "col_float_length38" ,to_char(numerical2.col_float_length38) "col_float_length38" from numerical  join numerical2 on numerical.col_numeric_length10_2= numerical2.col_numeric_length10_2;
select to_char(numerical.col_float_length39) "col_float_length39" ,to_char(numerical2.col_float_length39) "col_float_length39" from numerical  join numerical2 on numerical.col_numeric_length10_3= numerical2.col_numeric_length10_3;
select to_char(numerical.col_real) "col_real" ,to_char(numerical2.col_real) "col_real" from numerical  join numerical2 on numerical.col_numeric_length10_10= numerical2.col_numeric_length10_10;
select to_char(numerical.col_double_precision)  "col_double_precision"  ,to_char(numerical2.col_double_precision)  "col_double_precision"  from numerical  join numerical2 on numerical.col_numeric_length38_0= numerical2.col_numeric_length38_0;
select to_char(numerical.col_int) "col_int" ,to_char(numerical2.col_int) "col_int" from numerical  join numerical2 on numerical.col_numeric_length38_38= numerical2.col_numeric_length38_38;
select to_char(numerical.col_integer) "col_integer" ,to_char(numerical2.col_integer) "col_integer" from numerical  join numerical2 on numerical.col_numeric_length39_0= numerical2.col_numeric_length39_0;
select to_char(numerical.col_int8) "col_int8" ,to_char(numerical2.col_int8) "col_int8" from numerical  join numerical2 on numerical.col_float= numerical2.col_float;
select to_char(numerical.col_int64) "col_int64" ,to_char(numerical2.col_int64) "col_int64" from numerical  join numerical2 on numerical.col_float_length10= numerical2.col_float_length10;
select to_char(numerical.col_bigint) "col_bigint" ,to_char(numerical2.col_bigint) "col_bigint" from numerical  join numerical2 on numerical.col_float_length38= numerical2.col_float_length38;
select to_char(numerical.col_int2) "col_int2" ,to_char(numerical2.col_int2) "col_int2" from numerical  join numerical2 on numerical.col_float_length39= numerical2.col_float_length39;
select to_char(numerical.col_smallint) "col_smallint" ,to_char(numerical2.col_smallint) "col_smallint" from numerical  join numerical2 on numerical.col_real= numerical2.col_real;
select to_char(numerical.col_int4) "col_int4" ,to_char(numerical2.col_int4) "col_int4" from numerical  join numerical2 on numerical.col_double_precision= numerical2.col_double_precision;

----BUG
select to_char(numerical.col_decimal_length10_2)"col_decimal_length10_2",to_char(numerical2.col_decimal_length10_2)"col_decimal_length10_2"from numerical  join numerical2 on numerical.col_int= numerical2.col_int;
select to_char(numerical.col_decimal_length10_3)"col_decimal_length10_3",to_char(numerical2.col_decimal_length10_3)"col_decimal_length10_3"from numerical  join numerical2 on numerical.col_integer= numerical2.col_integer;
select to_char(numerical.col_decimal_length10_10)"col_decimal_length10_10",to_char(numerical2.col_decimal_length10_10)"col_decimal_length10_10"from numerical  join numerical2 on numerical.col_int8= numerical2.col_int8;
select to_char(numerical.col_decimal_length38_38)"col_decimal_length38_38",to_char(numerical2.col_decimal_length38_38)"col_decimal_length38_38"from numerical  join numerical2 on numerical.col_int64= numerical2.col_int64;
select to_char(numerical.col_numeric_length10_2)"col_numeric_length10_2",to_char(numerical2.col_numeric_length10_2)"col_numeric_length10_2"from numerical  join numerical2 on numerical.col_bigint= numerical2.col_bigint;
select to_char(numerical.col_numeric_length10_3)"col_numeric_length10_3",to_char(numerical2.col_numeric_length10_3)"col_numeric_length10_3"from numerical  join numerical2 on numerical.col_int2= numerical2.col_int2;
select to_char(numerical.col_numeric_length10_10)"col_numeric_length10_10",to_char(numerical2.col_numeric_length10_10)"col_numeric_length10_10"from numerical  join numerical2 on numerical.col_smallint= numerical2.col_smallint;
select to_char(numerical.col_numeric_length38_38)"col_numeric_length38_38",to_char(numerical2.col_numeric_length38_38)"col_numeric_length38_38"from numerical  join numerical2 on numerical.col_int4= numerical2.col_int4;



--left join


select to_char(numerical.col_decimal) "col_decimal" ,to_char(numerical2.col_decimal) "col_decimal" from numerical left join numerical2 on numerical.col_decimal= numerical2.col_decimal;
select to_char(numerical.col_decimal_length10_0) "col_decimal_length10_0"  ,to_char(numerical2.col_decimal_length10_0) "col_decimal_length10_0"from numerical left join numerical2 on numerical.col_decimal_length10_0= numerical2.col_decimal_length10_0;
select to_char(numerical.col_decimal_length38_0) "col_decimal_length38_0" ,to_char(numerical2.col_decimal_length38_0) "col_decimal_length38_0" from numerical left join numerical2 on numerical.col_decimal_length10_2= numerical2.col_decimal_length10_2;
select to_char(numerical.col_decimal_length39_0) "col_decimal_length39_0" ,to_char(numerical2.col_decimal_length39_0) "col_decimal_length39_0" from numerical left join numerical2 on numerical.col_decimal_length10_3= numerical2.col_decimal_length10_3;
select to_char(numerical.col_numeric)  "col_numeric"  ,to_char(numerical2.col_numeric)  "col_numeric"  from numerical left join numerical2 on numerical.col_decimal_length10_10= numerical2.col_decimal_length10_10;
select to_char(numerical.col_numeric_length10_0) "col_numeric_length10_0" ,to_char(numerical2.col_numeric_length10_0) "col_numeric_length10_0" from numerical left join numerical2 on numerical.col_decimal_length38_0= numerical2.col_decimal_length38_0;
select to_char(numerical.col_numeric_length38_0) "col_numeric_length38_0" ,to_char(numerical2.col_numeric_length38_0) "col_numeric_length38_0" from numerical left join numerical2 on numerical.col_decimal_length38_38= numerical2.col_decimal_length38_38;
select to_char(numerical.col_numeric_length39_0) "col_numeric_length39_0" ,to_char(numerical2.col_numeric_length39_0) "col_numeric_length39_0" from numerical left join numerical2 on numerical.col_decimal_length39_0= numerical2.col_decimal_length39_0;
select to_char(numerical.col_float) "col_float" ,to_char(numerical2.col_float) "col_float" from numerical left join numerical2 on numerical.col_numeric= numerical2.col_numeric;
select to_char(numerical.col_float_length10)  "col_float_length10"  ,to_char(numerical2.col_float_length10)  "col_float_length10"  from numerical left join numerical2 on numerical.col_numeric_length10_0= numerical2.col_numeric_length10_0;
select to_char(numerical.col_float_length38) "col_float_length38" ,to_char(numerical2.col_float_length38) "col_float_length38" from numerical left join numerical2 on numerical.col_numeric_length10_2= numerical2.col_numeric_length10_2;
select to_char(numerical.col_float_length39) "col_float_length39" ,to_char(numerical2.col_float_length39) "col_float_length39" from numerical left join numerical2 on numerical.col_numeric_length10_3= numerical2.col_numeric_length10_3;
select to_char(numerical.col_real) "col_real" ,to_char(numerical2.col_real) "col_real" from numerical left join numerical2 on numerical.col_numeric_length10_10= numerical2.col_numeric_length10_10;
select to_char(numerical.col_double_precision)  "col_double_precision"  ,to_char(numerical2.col_double_precision)  "col_double_precision"  from numerical left join numerical2 on numerical.col_numeric_length38_0= numerical2.col_numeric_length38_0;
select to_char(numerical.col_int) "col_int" ,to_char(numerical2.col_int) "col_int" from numerical left join numerical2 on numerical.col_numeric_length38_38= numerical2.col_numeric_length38_38;
select to_char(numerical.col_integer) "col_integer" ,to_char(numerical2.col_integer) "col_integer" from numerical left join numerical2 on numerical.col_numeric_length39_0= numerical2.col_numeric_length39_0;
select to_char(numerical.col_int8) "col_int8" ,to_char(numerical2.col_int8) "col_int8" from numerical left join numerical2 on numerical.col_float= numerical2.col_float;
select to_char(numerical.col_int64) "col_int64" ,to_char(numerical2.col_int64) "col_int64" from numerical left join numerical2 on numerical.col_float_length10= numerical2.col_float_length10;
select to_char(numerical.col_bigint) "col_bigint" ,to_char(numerical2.col_bigint) "col_bigint" from numerical left join numerical2 on numerical.col_float_length38= numerical2.col_float_length38;
select to_char(numerical.col_int2) "col_int2" ,to_char(numerical2.col_int2) "col_int2" from numerical left join numerical2 on numerical.col_float_length39= numerical2.col_float_length39;
select to_char(numerical.col_smallint) "col_smallint" ,to_char(numerical2.col_smallint) "col_smallint" from numerical left join numerical2 on numerical.col_real= numerical2.col_real;
select to_char(numerical.col_int4) "col_int4" ,to_char(numerical2.col_int4) "col_int4" from numerical left join numerical2 on numerical.col_double_precision= numerical2.col_double_precision;

----BUG
select to_char(numerical.col_decimal_length10_2)"col_decimal_length10_2",to_char(numerical2.col_decimal_length10_2)"col_decimal_length10_2"from numerical left join numerical2 on numerical.col_int= numerical2.col_int;
select to_char(numerical.col_decimal_length10_3)"col_decimal_length10_3",to_char(numerical2.col_decimal_length10_3)"col_decimal_length10_3"from numerical left join numerical2 on numerical.col_integer= numerical2.col_integer;
select to_char(numerical.col_decimal_length10_10)"col_decimal_length10_10",to_char(numerical2.col_decimal_length10_10)"col_decimal_length10_10"from numerical left join numerical2 on numerical.col_int8= numerical2.col_int8;
select to_char(numerical.col_decimal_length38_38)"col_decimal_length38_38",to_char(numerical2.col_decimal_length38_38)"col_decimal_length38_38"from numerical left join numerical2 on numerical.col_int64= numerical2.col_int64;
select to_char(numerical.col_numeric_length10_2)"col_numeric_length10_2",to_char(numerical2.col_numeric_length10_2)"col_numeric_length10_2"from numerical left join numerical2 on numerical.col_bigint= numerical2.col_bigint;
select to_char(numerical.col_numeric_length10_3)"col_numeric_length10_3",to_char(numerical2.col_numeric_length10_3)"col_numeric_length10_3"from numerical left join numerical2 on numerical.col_int2= numerical2.col_int2;
select to_char(numerical.col_numeric_length10_10)"col_numeric_length10_10",to_char(numerical2.col_numeric_length10_10)"col_numeric_length10_10"from numerical left join numerical2 on numerical.col_smallint= numerical2.col_smallint;
select to_char(numerical.col_numeric_length38_38)"col_numeric_length38_38",to_char(numerical2.col_numeric_length38_38)"col_numeric_length38_38"from numerical left join numerical2 on numerical.col_int4= numerical2.col_int4;



 
--right join


select to_char(numerical.col_decimal) "col_decimal" ,to_char(numerical2.col_decimal) "col_decimal" from numerical right join numerical2 on numerical.col_decimal= numerical2.col_decimal;
select to_char(numerical.col_decimal_length10_0) "col_decimal_length10_0"  ,to_char(numerical2.col_decimal_length10_0) "col_decimal_length10_0"from numerical right join numerical2 on numerical.col_decimal_length10_0= numerical2.col_decimal_length10_0;
select to_char(numerical.col_decimal_length38_0) "col_decimal_length38_0" ,to_char(numerical2.col_decimal_length38_0) "col_decimal_length38_0" from numerical right join numerical2 on numerical.col_decimal_length10_2= numerical2.col_decimal_length10_2;
select to_char(numerical.col_decimal_length39_0) "col_decimal_length39_0" ,to_char(numerical2.col_decimal_length39_0) "col_decimal_length39_0" from numerical right join numerical2 on numerical.col_decimal_length10_3= numerical2.col_decimal_length10_3;
select to_char(numerical.col_numeric)  "col_numeric"  ,to_char(numerical2.col_numeric)  "col_numeric"  from numerical right join numerical2 on numerical.col_decimal_length10_10= numerical2.col_decimal_length10_10;
select to_char(numerical.col_numeric_length10_0) "col_numeric_length10_0" ,to_char(numerical2.col_numeric_length10_0) "col_numeric_length10_0" from numerical right join numerical2 on numerical.col_decimal_length38_0= numerical2.col_decimal_length38_0;
select to_char(numerical.col_numeric_length38_0) "col_numeric_length38_0" ,to_char(numerical2.col_numeric_length38_0) "col_numeric_length38_0" from numerical right join numerical2 on numerical.col_decimal_length38_38= numerical2.col_decimal_length38_38;
select to_char(numerical.col_numeric_length39_0) "col_numeric_length39_0" ,to_char(numerical2.col_numeric_length39_0) "col_numeric_length39_0" from numerical right join numerical2 on numerical.col_decimal_length39_0= numerical2.col_decimal_length39_0;
select to_char(numerical.col_float) "col_float" ,to_char(numerical2.col_float) "col_float" from numerical right join numerical2 on numerical.col_numeric= numerical2.col_numeric;
select to_char(numerical.col_float_length10)  "col_float_length10"  ,to_char(numerical2.col_float_length10)  "col_float_length10"  from numerical right join numerical2 on numerical.col_numeric_length10_0= numerical2.col_numeric_length10_0;
select to_char(numerical.col_float_length38) "col_float_length38" ,to_char(numerical2.col_float_length38) "col_float_length38" from numerical right join numerical2 on numerical.col_numeric_length10_2= numerical2.col_numeric_length10_2;
select to_char(numerical.col_float_length39) "col_float_length39" ,to_char(numerical2.col_float_length39) "col_float_length39" from numerical right join numerical2 on numerical.col_numeric_length10_3= numerical2.col_numeric_length10_3;
select to_char(numerical.col_real) "col_real" ,to_char(numerical2.col_real) "col_real" from numerical right join numerical2 on numerical.col_numeric_length10_10= numerical2.col_numeric_length10_10;
select to_char(numerical.col_double_precision)  "col_double_precision"  ,to_char(numerical2.col_double_precision)  "col_double_precision"  from numerical right join numerical2 on numerical.col_numeric_length38_0= numerical2.col_numeric_length38_0;
select to_char(numerical.col_int) "col_int" ,to_char(numerical2.col_int) "col_int" from numerical right join numerical2 on numerical.col_numeric_length38_38= numerical2.col_numeric_length38_38;
select to_char(numerical.col_integer) "col_integer" ,to_char(numerical2.col_integer) "col_integer" from numerical right join numerical2 on numerical.col_numeric_length39_0= numerical2.col_numeric_length39_0;
select to_char(numerical.col_int8) "col_int8" ,to_char(numerical2.col_int8) "col_int8" from numerical right join numerical2 on numerical.col_float= numerical2.col_float;
select to_char(numerical.col_int64) "col_int64" ,to_char(numerical2.col_int64) "col_int64" from numerical right join numerical2 on numerical.col_float_length10= numerical2.col_float_length10;
select to_char(numerical.col_bigint) "col_bigint" ,to_char(numerical2.col_bigint) "col_bigint" from numerical right join numerical2 on numerical.col_float_length38= numerical2.col_float_length38;
select to_char(numerical.col_int2) "col_int2" ,to_char(numerical2.col_int2) "col_int2" from numerical right join numerical2 on numerical.col_float_length39= numerical2.col_float_length39;
select to_char(numerical.col_smallint) "col_smallint" ,to_char(numerical2.col_smallint) "col_smallint" from numerical right join numerical2 on numerical.col_real= numerical2.col_real;
select to_char(numerical.col_int4) "col_int4" ,to_char(numerical2.col_int4) "col_int4" from numerical right join numerical2 on numerical.col_double_precision= numerical2.col_double_precision;

----BUG
select to_char(numerical.col_decimal_length10_2)"col_decimal_length10_2",to_char(numerical2.col_decimal_length10_2)"col_decimal_length10_2"from numerical right join numerical2 on numerical.col_int= numerical2.col_int;
select to_char(numerical.col_decimal_length10_3)"col_decimal_length10_3",to_char(numerical2.col_decimal_length10_3)"col_decimal_length10_3"from numerical right join numerical2 on numerical.col_integer= numerical2.col_integer;
select to_char(numerical.col_decimal_length10_10)"col_decimal_length10_10",to_char(numerical2.col_decimal_length10_10)"col_decimal_length10_10"from numerical right join numerical2 on numerical.col_int8= numerical2.col_int8;
select to_char(numerical.col_decimal_length38_38)"col_decimal_length38_38",to_char(numerical2.col_decimal_length38_38)"col_decimal_length38_38"from numerical right join numerical2 on numerical.col_int64= numerical2.col_int64;
select to_char(numerical.col_numeric_length10_2)"col_numeric_length10_2",to_char(numerical2.col_numeric_length10_2)"col_numeric_length10_2"from numerical right join numerical2 on numerical.col_bigint= numerical2.col_bigint;
select to_char(numerical.col_numeric_length10_3)"col_numeric_length10_3",to_char(numerical2.col_numeric_length10_3)"col_numeric_length10_3"from numerical right join numerical2 on numerical.col_int2= numerical2.col_int2;
select to_char(numerical.col_numeric_length10_10)"col_numeric_length10_10",to_char(numerical2.col_numeric_length10_10)"col_numeric_length10_10"from numerical right join numerical2 on numerical.col_smallint= numerical2.col_smallint;
select to_char(numerical.col_numeric_length38_38)"col_numeric_length38_38",to_char(numerical2.col_numeric_length38_38)"col_numeric_length38_38"from numerical right join numerical2 on numerical.col_int4= numerical2.col_int4;


 

 
--full outer join

select to_char(numerical.col_decimal) "col_decimal" ,to_char(numerical2.col_decimal) "col_decimal" from numerical full outer  join numerical2 on numerical.col_decimal= numerical2.col_decimal;
select to_char(numerical.col_decimal_length10_0) "col_decimal_length10_0"  ,to_char(numerical2.col_decimal_length10_0) "col_decimal_length10_0"from numerical full outer  join numerical2 on numerical.col_decimal_length10_0= numerical2.col_decimal_length10_0;
select to_char(numerical.col_decimal_length38_0) "col_decimal_length38_0" ,to_char(numerical2.col_decimal_length38_0) "col_decimal_length38_0" from numerical full outer  join numerical2 on numerical.col_decimal_length10_2= numerical2.col_decimal_length10_2;
select to_char(numerical.col_decimal_length39_0) "col_decimal_length39_0" ,to_char(numerical2.col_decimal_length39_0) "col_decimal_length39_0" from numerical full outer  join numerical2 on numerical.col_decimal_length10_3= numerical2.col_decimal_length10_3;
select to_char(numerical.col_numeric)  "col_numeric"  ,to_char(numerical2.col_numeric)  "col_numeric"  from numerical full outer  join numerical2 on numerical.col_decimal_length10_10= numerical2.col_decimal_length10_10;
select to_char(numerical.col_numeric_length10_0) "col_numeric_length10_0" ,to_char(numerical2.col_numeric_length10_0) "col_numeric_length10_0" from numerical full outer  join numerical2 on numerical.col_decimal_length38_0= numerical2.col_decimal_length38_0;
select to_char(numerical.col_numeric_length38_0) "col_numeric_length38_0" ,to_char(numerical2.col_numeric_length38_0) "col_numeric_length38_0" from numerical full outer  join numerical2 on numerical.col_decimal_length38_38= numerical2.col_decimal_length38_38;
select to_char(numerical.col_numeric_length39_0) "col_numeric_length39_0" ,to_char(numerical2.col_numeric_length39_0) "col_numeric_length39_0" from numerical full outer  join numerical2 on numerical.col_decimal_length39_0= numerical2.col_decimal_length39_0;
select to_char(numerical.col_float) "col_float" ,to_char(numerical2.col_float) "col_float" from numerical full outer  join numerical2 on numerical.col_numeric= numerical2.col_numeric;
select to_char(numerical.col_float_length10)  "col_float_length10"  ,to_char(numerical2.col_float_length10)  "col_float_length10"  from numerical full outer  join numerical2 on numerical.col_numeric_length10_0= numerical2.col_numeric_length10_0;
select to_char(numerical.col_float_length38) "col_float_length38" ,to_char(numerical2.col_float_length38) "col_float_length38" from numerical full outer  join numerical2 on numerical.col_numeric_length10_2= numerical2.col_numeric_length10_2;
select to_char(numerical.col_float_length39) "col_float_length39" ,to_char(numerical2.col_float_length39) "col_float_length39" from numerical full outer  join numerical2 on numerical.col_numeric_length10_3= numerical2.col_numeric_length10_3;
select to_char(numerical.col_real) "col_real" ,to_char(numerical2.col_real) "col_real" from numerical full outer  join numerical2 on numerical.col_numeric_length10_10= numerical2.col_numeric_length10_10;
select to_char(numerical.col_double_precision)  "col_double_precision"  ,to_char(numerical2.col_double_precision)  "col_double_precision"  from numerical full outer  join numerical2 on numerical.col_numeric_length38_0= numerical2.col_numeric_length38_0;
select to_char(numerical.col_int) "col_int" ,to_char(numerical2.col_int) "col_int" from numerical full outer  join numerical2 on numerical.col_numeric_length38_38= numerical2.col_numeric_length38_38;
select to_char(numerical.col_integer) "col_integer" ,to_char(numerical2.col_integer) "col_integer" from numerical full outer  join numerical2 on numerical.col_numeric_length39_0= numerical2.col_numeric_length39_0;
select to_char(numerical.col_int8) "col_int8" ,to_char(numerical2.col_int8) "col_int8" from numerical full outer  join numerical2 on numerical.col_float= numerical2.col_float;
select to_char(numerical.col_int64) "col_int64" ,to_char(numerical2.col_int64) "col_int64" from numerical full outer  join numerical2 on numerical.col_float_length10= numerical2.col_float_length10;
select to_char(numerical.col_bigint) "col_bigint" ,to_char(numerical2.col_bigint) "col_bigint" from numerical full outer  join numerical2 on numerical.col_float_length38= numerical2.col_float_length38;
select to_char(numerical.col_int2) "col_int2" ,to_char(numerical2.col_int2) "col_int2" from numerical full outer  join numerical2 on numerical.col_float_length39= numerical2.col_float_length39;
select to_char(numerical.col_smallint) "col_smallint" ,to_char(numerical2.col_smallint) "col_smallint" from numerical full outer  join numerical2 on numerical.col_real= numerical2.col_real;
select to_char(numerical.col_int4) "col_int4" ,to_char(numerical2.col_int4) "col_int4" from numerical full outer  join numerical2 on numerical.col_double_precision= numerical2.col_double_precision;

----BUG
select to_char(numerical.col_decimal_length10_2)"col_decimal_length10_2",to_char(numerical2.col_decimal_length10_2)"col_decimal_length10_2"from numerical full outer  join numerical2 on numerical.col_int= numerical2.col_int;
select to_char(numerical.col_decimal_length10_3)"col_decimal_length10_3",to_char(numerical2.col_decimal_length10_3)"col_decimal_length10_3"from numerical full outer  join numerical2 on numerical.col_integer= numerical2.col_integer;
select to_char(numerical.col_decimal_length10_10)"col_decimal_length10_10",to_char(numerical2.col_decimal_length10_10)"col_decimal_length10_10"from numerical full outer  join numerical2 on numerical.col_int8= numerical2.col_int8;
select to_char(numerical.col_decimal_length38_38)"col_decimal_length38_38",to_char(numerical2.col_decimal_length38_38)"col_decimal_length38_38"from numerical full outer  join numerical2 on numerical.col_int64= numerical2.col_int64;
select to_char(numerical.col_numeric_length10_2)"col_numeric_length10_2",to_char(numerical2.col_numeric_length10_2)"col_numeric_length10_2"from numerical full outer  join numerical2 on numerical.col_bigint= numerical2.col_bigint;
select to_char(numerical.col_numeric_length10_3)"col_numeric_length10_3",to_char(numerical2.col_numeric_length10_3)"col_numeric_length10_3"from numerical full outer  join numerical2 on numerical.col_int2= numerical2.col_int2;
select to_char(numerical.col_numeric_length10_10)"col_numeric_length10_10",to_char(numerical2.col_numeric_length10_10)"col_numeric_length10_10"from numerical full outer  join numerical2 on numerical.col_smallint= numerical2.col_smallint;
select to_char(numerical.col_numeric_length38_38)"col_numeric_length38_38",to_char(numerical2.col_numeric_length38_38)"col_numeric_length38_38"from numerical full outer  join numerical2 on numerical.col_int4= numerical2.col_int4;



----union all\union


select to_char(col_decimal) "col_decimal"  from numerical union all select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal) "col_decimal"  from numerical union all select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal_length10_0) "col_decimal_length10_0"   from numerical union all select to_char(col_decimal_length10_0) "col_decimal_length10_0" from numerical2 ;
select to_char(col_decimal_length38_0) "col_decimal_length38_0"  from numerical union all select to_char(col_decimal_length38_0) "col_decimal_length38_0" from numerical2 ;
select to_char(col_decimal_length39_0) "col_decimal_length39_0"  from numerical union all select to_char(col_decimal_length39_0) "col_decimal_length39_0" from numerical2 ;
select to_char(col_numeric)  "col_numeric"   from numerical union all select to_char(col_numeric)  "col_numeric"  from numerical2 ;
select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical union all select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical2 ;
select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical union all select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical2 ;
select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical union all select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical2 ;
select to_char(col_float) "col_float"  from numerical union all select to_char(col_float) "col_float"  from numerical2 ;
select to_char(col_float_length10)  "col_float_length10"   from numerical union all select to_char(col_float_length10)  "col_float_length10"   from numerical2 ;
select to_char(col_float_length38) "col_float_length38"  from numerical union all select to_char(col_float_length38) "col_float_length38"  from numerical2 ;
select to_char(col_float_length39) "col_float_length39"  from numerical union all select to_char(col_float_length39) "col_float_length39"  from numerical2 ;
select to_char(col_real) "col_real"  from numerical union all select to_char(col_real) "col_real"  from numerical2 ;
select to_char(col_double_precision)  "col_double_precision"   from numerical union all select to_char(col_double_precision)  "col_double_precision"   from numerical2 ;
select to_char(col_int) "col_int"  from numerical union all select to_char(col_int) "col_int"  from numerical2 ;
select to_char(col_integer) "col_integer"  from numerical union all select to_char(col_integer) "col_integer"  from numerical2 ;
select to_char(col_int8) "col_int8"  from numerical union all select to_char(col_int8) "col_int8"  from numerical2 ;
select to_char(col_int64) "col_int64"  from numerical union all select to_char(col_int64) "col_int64"  from numerical2 ;
select to_char(col_bigint) "col_bigint"  from numerical union all select to_char(col_bigint) "col_bigint"  from numerical2 ;
select to_char(col_int2) "col_int2"  from numerical union all select to_char(col_int2) "col_int2"  from numerical2 ;
select to_char(col_smallint) "col_smallint"  from numerical union all select to_char(col_smallint) "col_smallint" from numerical2 ;
select to_char(col_int4) "col_int4"  from numerical union all select to_char(col_int4) "col_int4"  from numerical2 ;
select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical union all select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical2 ;
select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical union all select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical2 ;
select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical union all select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical2 ;
select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical union all select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical2 ;
select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical union all select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical2 ;
select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical union all select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical2 ;
select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical union all select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical2 ;
select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical union all select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical2 ;



select to_char(col_decimal) "col_decimal"  from numerical union  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal) "col_decimal"  from numerical union  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal_length10_0) "col_decimal_length10_0"   from numerical union  select to_char(col_decimal_length10_0) "col_decimal_length10_0" from numerical2 ;
select to_char(col_decimal_length38_0) "col_decimal_length38_0"  from numerical union  select to_char(col_decimal_length38_0) "col_decimal_length38_0" from numerical2 ;
select to_char(col_decimal_length39_0) "col_decimal_length39_0"  from numerical union  select to_char(col_decimal_length39_0) "col_decimal_length39_0" from numerical2 ;
select to_char(col_numeric)  "col_numeric"   from numerical union  select to_char(col_numeric)  "col_numeric"  from numerical2 ;
select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical union  select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical2 ;
select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical union  select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical2 ;
select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical union  select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical2 ;
select to_char(col_float) "col_float"  from numerical union  select to_char(col_float) "col_float"  from numerical2 ;
select to_char(col_float_length10)  "col_float_length10"   from numerical union  select to_char(col_float_length10)  "col_float_length10"   from numerical2 ;
select to_char(col_float_length38) "col_float_length38"  from numerical union  select to_char(col_float_length38) "col_float_length38"  from numerical2 ;
select to_char(col_float_length39) "col_float_length39"  from numerical union  select to_char(col_float_length39) "col_float_length39"  from numerical2 ;
select to_char(col_real) "col_real"  from numerical union  select to_char(col_real) "col_real"  from numerical2 ;
select to_char(col_double_precision)  "col_double_precision"   from numerical union  select to_char(col_double_precision)  "col_double_precision"   from numerical2 ;
select to_char(col_int) "col_int"  from numerical union  select to_char(col_int) "col_int"  from numerical2 ;
select to_char(col_integer) "col_integer"  from numerical union  select to_char(col_integer) "col_integer"  from numerical2 ;
select to_char(col_int8) "col_int8"  from numerical union  select to_char(col_int8) "col_int8"  from numerical2 ;
select to_char(col_int64) "col_int64"  from numerical union  select to_char(col_int64) "col_int64"  from numerical2 ;
select to_char(col_bigint) "col_bigint"  from numerical union  select to_char(col_bigint) "col_bigint"  from numerical2 ;
select to_char(col_int2) "col_int2"  from numerical union  select to_char(col_int2) "col_int2"  from numerical2 ;
select to_char(col_smallint) "col_smallint"  from numerical union  select to_char(col_smallint) "col_smallint" from numerical2 ;
select to_char(col_int4) "col_int4"  from numerical union  select to_char(col_int4) "col_int4"  from numerical2 ;
select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical union  select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical2 ;
select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical union  select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical2 ;
select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical union  select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical2 ;
select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical union  select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical2 ;
select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical union  select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical2 ;
select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical union  select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical2 ;
select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical union  select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical2 ;
select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical union  select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical2 ;

----except


select to_char(col_decimal) "col_decimal"  from numerical except  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal) "col_decimal"  from numerical except  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal_length10_0) "col_decimal_length10_0"   from numerical except  select to_char(col_decimal_length10_0) "col_decimal_length10_0" from numerical2 ;
select to_char(col_decimal_length38_0) "col_decimal_length38_0"  from numerical except  select to_char(col_decimal_length38_0) "col_decimal_length38_0" from numerical2 ;
select to_char(col_decimal_length39_0) "col_decimal_length39_0"  from numerical except  select to_char(col_decimal_length39_0) "col_decimal_length39_0" from numerical2 ;
select to_char(col_numeric)  "col_numeric"   from numerical except  select to_char(col_numeric)  "col_numeric"  from numerical2 ;
select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical except  select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical2 ;
select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical except  select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical2 ;
select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical except  select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical2 ;
select to_char(col_float) "col_float"  from numerical except  select to_char(col_float) "col_float"  from numerical2 ;
select to_char(col_float_length10)  "col_float_length10"   from numerical except  select to_char(col_float_length10)  "col_float_length10"   from numerical2 ;
select to_char(col_float_length38) "col_float_length38"  from numerical except  select to_char(col_float_length38) "col_float_length38"  from numerical2 ;
select to_char(col_float_length39) "col_float_length39"  from numerical except  select to_char(col_float_length39) "col_float_length39"  from numerical2 ;
select to_char(col_real) "col_real"  from numerical except  select to_char(col_real) "col_real"  from numerical2 ;
select to_char(col_double_precision)  "col_double_precision"   from numerical except  select to_char(col_double_precision)  "col_double_precision"   from numerical2 ;
select to_char(col_int) "col_int"  from numerical except  select to_char(col_int) "col_int"  from numerical2 ;
select to_char(col_integer) "col_integer"  from numerical except  select to_char(col_integer) "col_integer"  from numerical2 ;
select to_char(col_int8) "col_int8"  from numerical except  select to_char(col_int8) "col_int8"  from numerical2 ;
select to_char(col_int64) "col_int64"  from numerical except  select to_char(col_int64) "col_int64"  from numerical2 ;
select to_char(col_bigint) "col_bigint"  from numerical except  select to_char(col_bigint) "col_bigint"  from numerical2 ;
select to_char(col_int2) "col_int2"  from numerical except  select to_char(col_int2) "col_int2"  from numerical2 ;
select to_char(col_smallint) "col_smallint"  from numerical except  select to_char(col_smallint) "col_smallint" from numerical2 ;
select to_char(col_int4) "col_int4"  from numerical except  select to_char(col_int4) "col_int4"  from numerical2 ;
select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical except  select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical2 ;
select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical except  select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical2 ;
select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical except  select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical2 ;
select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical except  select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical2 ;
select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical except  select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical2 ;
select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical except  select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical2 ;
select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical except  select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical2 ;
select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical except  select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical2 ;




----intersect

select to_char(col_decimal) "col_decimal"  from numerical intersect  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal) "col_decimal"  from numerical intersect  select to_char(col_decimal) "col_decimal" from numerical2 ;
select to_char(col_decimal_length10_0) "col_decimal_length10_0"   from numerical intersect  select to_char(col_decimal_length10_0) "col_decimal_length10_0" from numerical2 ;
select to_char(col_decimal_length38_0) "col_decimal_length38_0"  from numerical intersect  select to_char(col_decimal_length38_0) "col_decimal_length38_0" from numerical2 ;
select to_char(col_decimal_length39_0) "col_decimal_length39_0"  from numerical intersect  select to_char(col_decimal_length39_0) "col_decimal_length39_0" from numerical2 ;
select to_char(col_numeric)  "col_numeric"   from numerical intersect  select to_char(col_numeric)  "col_numeric"  from numerical2 ;
select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical intersect  select to_char(col_numeric_length10_0) "col_numeric_length10_0"  from numerical2 ;
select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical intersect  select to_char(col_numeric_length38_0) "col_numeric_length38_0"  from numerical2 ;
select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical intersect  select to_char(col_numeric_length39_0) "col_numeric_length39_0"  from numerical2 ;
select to_char(col_float) "col_float"  from numerical intersect  select to_char(col_float) "col_float"  from numerical2 ;
select to_char(col_float_length10)  "col_float_length10"   from numerical intersect  select to_char(col_float_length10)  "col_float_length10"   from numerical2 ;
select to_char(col_float_length38) "col_float_length38"  from numerical intersect  select to_char(col_float_length38) "col_float_length38"  from numerical2 ;
select to_char(col_float_length39) "col_float_length39"  from numerical intersect  select to_char(col_float_length39) "col_float_length39"  from numerical2 ;
select to_char(col_real) "col_real"  from numerical intersect  select to_char(col_real) "col_real"  from numerical2 ;
select to_char(col_double_precision)  "col_double_precision"   from numerical intersect  select to_char(col_double_precision)  "col_double_precision"   from numerical2 ;
select to_char(col_int) "col_int"  from numerical intersect  select to_char(col_int) "col_int"  from numerical2 ;
select to_char(col_integer) "col_integer"  from numerical intersect  select to_char(col_integer) "col_integer"  from numerical2 ;
select to_char(col_int8) "col_int8"  from numerical intersect  select to_char(col_int8) "col_int8"  from numerical2 ;
select to_char(col_int64) "col_int64"  from numerical intersect  select to_char(col_int64) "col_int64"  from numerical2 ;
select to_char(col_bigint) "col_bigint"  from numerical intersect  select to_char(col_bigint) "col_bigint"  from numerical2 ;
select to_char(col_int2) "col_int2"  from numerical intersect  select to_char(col_int2) "col_int2"  from numerical2 ;
select to_char(col_smallint) "col_smallint"  from numerical intersect  select to_char(col_smallint) "col_smallint" from numerical2 ;
select to_char(col_int4) "col_int4"  from numerical intersect  select to_char(col_int4) "col_int4"  from numerical2 ;
select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical intersect  select to_char(col_decimal_length10_2)"col_decimal_length10_2" from numerical2 ;
select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical intersect  select to_char(col_decimal_length10_3)"col_decimal_length10_3" from numerical2 ;
select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical intersect  select to_char(col_decimal_length10_10)"col_decimal_length10_10" from numerical2 ;
select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical intersect  select to_char(col_decimal_length38_38)"col_decimal_length38_38" from numerical2 ;
select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical intersect  select to_char(col_numeric_length10_2)"col_numeric_length10_2" from numerical2 ;
select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical intersect  select to_char(col_numeric_length10_3)"col_numeric_length10_3" from numerical2 ;
select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical intersect  select to_char(col_numeric_length10_10)"col_numeric_length10_10" from numerical2 ;
select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical intersect  select to_char(col_numeric_length38_38)"col_numeric_length38_38" from numerical2 ;




----distinct
insert into numerical values(
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678.12,
1234567.123,
0.012345679,
12345678901234567890123456789012345678,
0.12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
1234567,
1234567890,
12345678901234567890123456789012345678,
123456789012345678901234567890123456789,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345,
12345);


insert into numerical values(
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678.12,
-1234567.123,
-0.012345679,
-12345678901234567890123456789012345678,
-0.12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-1234567,
-1234567890,
-12345678901234567890123456789012345678,
-123456789012345678901234567890123456789,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345,
-12345);


insert into numerical values(
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
null,
null,
null,
  1.03e+08,
null,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08, 
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1.03e+08,
  1e+1,
  1e+1,
  1.03e+08);
  

insert into numerical values(
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0);


insert into numerical values(
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null);

select distinct to_char(col_decimal) from numerical ;
select distinct to_char(col_decimal_length10_0) from numerical ;
select distinct to_char(col_decimal_length38_0) from numerical ;
select distinct to_char(col_decimal_length39_0) from numerical ;
select distinct to_char(col_numeric) from numerical ;
select distinct to_char(col_numeric_length10_0) from numerical ;
select distinct to_char(col_numeric_length38_0) from numerical ;
select distinct to_char(col_numeric_length39_0) from numerical ;
select distinct to_char(col_float) from numerical ;
select distinct to_char(col_float_length10) from numerical ;
select distinct to_char(col_float_length38) from numerical ;
select distinct to_char(col_float_length39) from numerical ;
select distinct to_char(col_real) from numerical ;
select distinct to_char(col_double_precision) from numerical ;
select distinct to_char(col_int) from numerical ;
select distinct to_char(col_integer) from numerical ;
select distinct to_char(col_int8) from numerical ;
select distinct to_char(col_int64) from numerical ;
select distinct to_char(col_bigint) from numerical ;
select distinct to_char(col_int2) from numerical ;
select distinct to_char(col_smallint) from numerical ;
select distinct to_char(col_int4) from numerical ;

select distinct to_char(col_decimal_length10_2) from numerical ;
select distinct to_char(col_decimal_length10_3) from numerical ;
select distinct to_char(col_decimal_length10_10) from numerical ;
select distinct to_char(col_decimal_length38_38) from numerical ;
select distinct to_char(col_numeric_length10_2) from numerical ;
select distinct to_char(col_numeric_length10_3) from numerical ;
select distinct to_char(col_numeric_length10_10) from numerical ;
select distinct to_char(col_numeric_length38_38) from numerical ;


--function

--to_char(avg())
select to_char(avg(col_decimal)) from numerical ;
select to_char(avg(col_decimal_length10_0)) from numerical ;
select to_char(avg(col_decimal_length38_0)) from numerical ;
select to_char(avg(col_decimal_length39_0)) from numerical ;
select to_char(avg(col_numeric)) from numerical ;
select to_char(avg(col_numeric_length10_0)) from numerical ;
select to_char(avg(col_numeric_length38_0)) from numerical ;
select to_char(avg(col_numeric_length39_0)) from numerical ;
select to_char(avg(col_float)) from numerical ;
select to_char(avg(col_float_length10)) from numerical ;
select to_char(avg(col_float_length38)) from numerical ;
select to_char(avg(col_float_length39)) from numerical ;
select to_char(avg(col_real)) from numerical ;
select to_char(avg(col_double_precision)) from numerical ;
select to_char(avg(col_int)) from numerical ;
select to_char(avg(col_integer)) from numerical ;
select to_char(avg(col_int8)) from numerical ;
select to_char(avg(col_int64)) from numerical ;
select to_char(avg(col_bigint)) from numerical ;
select to_char(avg(col_int2)) from numerical ;
select to_char(avg(col_smallint)) from numerical ;
select to_char(avg(col_int4)) from numerical ;

-----BUG导致报错
select to_char(avg(col_decimal_length10_2)) from numerical ;
select to_char(avg(col_decimal_length10_3)) from numerical ;
select to_char(avg(col_decimal_length10_10)) from numerical ;
select to_char(avg(col_decimal_length38_38)) from numerical ;
select to_char(avg(col_numeric_length10_2)) from numerical ;
select to_char(avg(col_numeric_length10_3)) from numerical ;
select to_char(avg(col_numeric_length10_10)) from numerical ;
select to_char(avg(col_numeric_length38_38)) from numerical ;

--to_char(count())

select to_char(count(col_decimal)) from numerical ;
select to_char(count(col_decimal_length10_0)) from numerical ;
select to_char(count(col_decimal_length38_0)) from numerical ;
select to_char(count(col_decimal_length39_0)) from numerical ;
select to_char(count(col_numeric)) from numerical ;
select to_char(count(col_numeric_length10_0)) from numerical ;
select to_char(count(col_numeric_length38_0)) from numerical ;
select to_char(count(col_numeric_length39_0)) from numerical ;
select to_char(count(col_float)) from numerical ;
select to_char(count(col_float_length10)) from numerical ;
select to_char(count(col_float_length38)) from numerical ;
select to_char(count(col_float_length39)) from numerical ;
select to_char(count(col_real)) from numerical ;
select to_char(count(col_double_precision)) from numerical ;
select to_char(count(col_int)) from numerical ;
select to_char(count(col_integer)) from numerical ;
select to_char(count(col_int8)) from numerical ;
select to_char(count(col_int64)) from numerical ;
select to_char(count(col_bigint)) from numerical ;
select to_char(count(col_int2)) from numerical ;
select to_char(count(col_smallint)) from numerical ;
select to_char(count(col_int4)) from numerical ;

select to_char(count(col_decimal_length10_2)) from numerical ;
select to_char(count(col_decimal_length10_3)) from numerical ;
select to_char(count(col_decimal_length10_10)) from numerical ;
select to_char(count(col_decimal_length38_38)) from numerical ;
select to_char(count(col_numeric_length10_2)) from numerical ;
select to_char(count(col_numeric_length10_3)) from numerical ;
select to_char(count(col_numeric_length10_10)) from numerical ;
select to_char(count(col_numeric_length38_38)) from numerical ;
--to_char(min())

select to_char(min(col_decimal)) from numerical ;
select to_char(min(col_decimal_length10_0)) from numerical ;
select to_char(min(col_decimal_length38_0)) from numerical ;
select to_char(min(col_decimal_length39_0)) from numerical ;
select to_char(min(col_numeric)) from numerical ;
select to_char(min(col_numeric_length10_0)) from numerical ;
select to_char(min(col_numeric_length38_0)) from numerical ;
select to_char(min(col_numeric_length39_0)) from numerical ;
select to_char(min(col_float)) from numerical ;
select to_char(min(col_float_length10)) from numerical ;
select to_char(min(col_float_length38)) from numerical ;
select to_char(min(col_float_length39)) from numerical ;
select to_char(min(col_real)) from numerical ;
select to_char(min(col_double_precision)) from numerical ;
select to_char(min(col_int)) from numerical ;
select to_char(min(col_integer)) from numerical ;
select to_char(min(col_int8)) from numerical ;
select to_char(min(col_int64)) from numerical ;
select to_char(min(col_bigint)) from numerical ;
select to_char(min(col_int2)) from numerical ;
select to_char(min(col_smallint)) from numerical ;
select to_char(min(col_int4)) from numerical ;

select to_char(min(col_decimal_length10_2)) from numerical ;
select to_char(min(col_decimal_length10_3)) from numerical ;
select to_char(min(col_decimal_length10_10)) from numerical ;
select to_char(min(col_decimal_length38_38)) from numerical ;
select to_char(min(col_numeric_length10_2)) from numerical ;
select to_char(min(col_numeric_length10_3)) from numerical ;
select to_char(min(col_numeric_length10_10)) from numerical ;
select to_char(min(col_numeric_length38_38)) from numerical ;
--to_char(max())

select to_char(max(col_decimal)) from numerical ;
select to_char(max(col_decimal_length10_0)) from numerical ;
select to_char(max(col_decimal_length38_0)) from numerical ;
select to_char(max(col_decimal_length39_0)) from numerical ;
select to_char(max(col_numeric)) from numerical ;
select to_char(max(col_numeric_length10_0)) from numerical ;
select to_char(max(col_numeric_length38_0)) from numerical ;
select to_char(max(col_numeric_length39_0)) from numerical ;
select to_char(max(col_float)) from numerical ;
select to_char(max(col_float_length10)) from numerical ;
select to_char(max(col_float_length38)) from numerical ;
select to_char(max(col_float_length39)) from numerical ;
select to_char(max(col_real)) from numerical ;
select to_char(max(col_double_precision)) from numerical ;
select to_char(max(col_int)) from numerical ;
select to_char(max(col_integer)) from numerical ;
select to_char(max(col_int8)) from numerical ;
select to_char(max(col_int64)) from numerical ;
select to_char(max(col_bigint)) from numerical ;
select to_char(max(col_int2)) from numerical ;
select to_char(max(col_smallint)) from numerical ;
select to_char(max(col_int4)) from numerical ;

select to_char(max(col_decimal_length10_2)) from numerical ;
select to_char(max(col_decimal_length10_3)) from numerical ;
select to_char(max(col_decimal_length10_10)) from numerical ;
select to_char(max(col_decimal_length38_38)) from numerical ;
select to_char(max(col_numeric_length10_2)) from numerical ;
select to_char(max(col_numeric_length10_3)) from numerical ;
select to_char(max(col_numeric_length10_10)) from numerical ;
select to_char(max(col_numeric_length38_38)) from numerical ;


--to_char(abs())

select to_char(abs(col_decimal)) from numerical ;
select to_char(abs(col_decimal_length10_0)) from numerical ;
select to_char(abs(col_decimal_length38_0)) from numerical ;
select to_char(abs(col_decimal_length39_0)) from numerical ;
select to_char(abs(col_numeric)) from numerical ;
select to_char(abs(col_numeric_length10_0)) from numerical ;
select to_char(abs(col_numeric_length38_0)) from numerical ;
select to_char(abs(col_numeric_length39_0)) from numerical ;
select to_char(abs(col_float)) from numerical ;
select to_char(abs(col_float_length10)) from numerical ;
select to_char(abs(col_float_length38)) from numerical ;
select to_char(abs(col_float_length39)) from numerical ;
select to_char(abs(col_real)) from numerical ;
select to_char(abs(col_double_precision)) from numerical ;
select to_char(abs(col_int)) from numerical ;
select to_char(abs(col_integer)) from numerical ;
select to_char(abs(col_int8)) from numerical ;
select to_char(abs(col_int64)) from numerical ;
select to_char(abs(col_bigint)) from numerical ;
select to_char(abs(col_int2)) from numerical ;
select to_char(abs(col_smallint)) from numerical ;
select to_char(abs(col_int4)) from numerical ;

select to_char(abs(col_decimal_length10_2)) from numerical ;
select to_char(abs(col_decimal_length10_3)) from numerical ;
select to_char(abs(col_decimal_length10_10)) from numerical ;
select to_char(abs(col_decimal_length38_38)) from numerical ;
select to_char(abs(col_numeric_length10_2)) from numerical ;
select to_char(abs(col_numeric_length10_3)) from numerical ;
select to_char(abs(col_numeric_length10_10)) from numerical ;
select to_char(abs(col_numeric_length38_38)) from numerical ;

--to_char(to_date())
--to_char(ceil())
select to_char(ceil(col_decimal)) from numerical ;
select to_char(ceil(col_decimal_length10_0)) from numerical ;
select to_char(ceil(col_decimal_length38_0)) from numerical ;
select to_char(ceil(col_decimal_length39_0)) from numerical ;
select to_char(ceil(col_numeric)) from numerical ;
select to_char(ceil(col_numeric_length10_0)) from numerical ;
select to_char(ceil(col_numeric_length38_0)) from numerical ;
select to_char(ceil(col_numeric_length39_0)) from numerical ;
select to_char(ceil(col_float)) from numerical ;
select to_char(ceil(col_float_length10)) from numerical ;
select to_char(ceil(col_float_length38)) from numerical ;
select to_char(ceil(col_float_length39)) from numerical ;
select to_char(ceil(col_real)) from numerical ;
select to_char(ceil(col_double_precision)) from numerical ;
select to_char(ceil(col_int)) from numerical ;
select to_char(ceil(col_integer)) from numerical ;
select to_char(ceil(col_int8)) from numerical ;
select to_char(ceil(col_int64)) from numerical ;
select to_char(ceil(col_bigint)) from numerical ;
select to_char(ceil(col_int2)) from numerical ;
select to_char(ceil(col_smallint)) from numerical ;
select to_char(ceil(col_int4)) from numerical ;
select to_char(ceil(col_decimal_length10_2)) from numerical ;
select to_char(ceil(col_decimal_length10_3)) from numerical ;
select to_char(ceil(col_decimal_length10_10)) from numerical ;
select to_char(ceil(col_decimal_length38_38)) from numerical ;
select to_char(ceil(col_numeric_length10_2)) from numerical ;
select to_char(ceil(col_numeric_length10_3)) from numerical ;
select to_char(ceil(col_numeric_length10_10)) from numerical ;
select to_char(ceil(col_numeric_length38_38)) from numerical ;

--to_char(sum())
select to_char(sum(col_decimal)) from numerical ;
select to_char(sum(col_decimal_length10_0)) from numerical ;
select to_char(sum(col_decimal_length38_0)) from numerical ;
select to_char(sum(col_decimal_length39_0)) from numerical ;
select to_char(sum(col_numeric)) from numerical ;
select to_char(sum(col_numeric_length10_0)) from numerical ;
select to_char(sum(col_numeric_length38_0)) from numerical ;
select to_char(sum(col_numeric_length39_0)) from numerical ;
select to_char(sum(col_float)) from numerical ;
select to_char(sum(col_float_length10)) from numerical ;
select to_char(sum(col_float_length38)) from numerical ;
select to_char(sum(col_float_length39)) from numerical ;
select to_char(sum(col_real)) from numerical ;
select to_char(sum(col_double_precision)) from numerical ;
select to_char(sum(col_int)) from numerical ;
select to_char(sum(col_integer)) from numerical ;
select to_char(sum(col_int8)) from numerical ;
select to_char(sum(col_int64)) from numerical ;
select to_char(sum(col_bigint)) from numerical ;
select to_char(sum(col_int2)) from numerical ;
select to_char(sum(col_smallint)) from numerical ;
select to_char(sum(col_int4)) from numerical ;

select to_char(sum(col_decimal_length10_2)) from numerical ;
select to_char(sum(col_decimal_length10_3)) from numerical ;
select to_char(sum(col_decimal_length10_10)) from numerical ;
select to_char(sum(col_decimal_length38_38)) from numerical ;
select to_char(sum(col_numeric_length10_2)) from numerical ;
select to_char(sum(col_numeric_length10_3)) from numerical ;
select to_char(sum(col_numeric_length10_10)) from numerical ;
select to_char(sum(col_numeric_length38_38)) from numerical ;

--to_char(nvl())

 
select NVL(to_char(col_decimal),to_char(col_decimal)) from numerical ;
select NVL(to_char(col_decimal_length10_0),to_char(col_decimal_length10_0)) from numerical ;
select NVL(to_char(col_decimal_length38_0),to_char(col_decimal_length38_0)) from numerical ;
select NVL(to_char(col_decimal_length39_0),to_char(col_decimal_length39_0)) from numerical ;
select NVL(to_char(col_numeric),to_char(col_numeric)) from numerical ;
select NVL(to_char(col_numeric_length10_0),to_char(col_numeric_length10_0)) from numerical ;
select NVL(to_char(col_numeric_length38_0),to_char(col_numeric_length38_0)) from numerical ;
select NVL(to_char(col_numeric_length39_0),to_char(col_numeric_length39_0)) from numerical ;
select NVL(to_char(col_float),to_char(col_float)) from numerical ;
select NVL(to_char(col_float_length10),to_char(col_float_length10)) from numerical ;
select NVL(to_char(col_float_length38),to_char(col_float_length38)) from numerical ;
select NVL(to_char(col_float_length39),to_char(col_float_length39)) from numerical ;
select NVL(to_char(col_real),to_char(col_real)) from numerical ;
select NVL(to_char(col_double_precision),to_char(col_double_precision)) from numerical ;
select NVL(to_char(col_int),to_char(col_int)) from numerical ;
select NVL(to_char(col_integer),to_char(col_integer)) from numerical ;
select NVL(to_char(col_int8),to_char(col_int8)) from numerical ;
select NVL(to_char(col_int64),to_char(col_int64)) from numerical ;
select NVL(to_char(col_bigint),to_char(col_bigint)) from numerical ;
select NVL(to_char(col_int2),to_char(col_int2)) from numerical ;
select NVL(to_char(col_smallint),to_char(col_smallint)) from numerical ;
select NVL(to_char(col_int4),to_char(col_int4)) from numerical ;

---BUG导致报错
select NVL(to_char(col_decimal_length10_2),to_char(col_decimal_length10_2)) from numerical ;
select NVL(to_char(col_decimal_length10_3),to_char(col_decimal_length10_3)) from numerical ;
select NVL(to_char(col_decimal_length10_10),to_char(col_decimal_length10_10)) from numerical ;
select NVL(to_char(col_decimal_length38_38),to_char(col_decimal_length38_38)) from numerical ;
select NVL(to_char(col_numeric_length10_2),to_char(col_numeric_length10_2)) from numerical ;
select NVL(to_char(col_numeric_length10_3),to_char(col_numeric_length10_3)) from numerical ;
select NVL(to_char(col_numeric_length10_10),to_char(col_numeric_length10_10)) from numerical ;
select NVL(to_char(col_numeric_length38_38),to_char(col_numeric_length38_38)) from numerical ;


--to_char(to_number()))
select to_char(to_number(to_char(col_decimal))) from numerical ;
select to_char(to_number(to_char(col_decimal_length10_0))) from numerical ;
select to_char(to_number(to_char(col_decimal_length38_0))) from numerical ;
select to_char(to_number(to_char(col_decimal_length39_0))) from numerical ;
select to_char(to_number(to_char(col_numeric))) from numerical ;
select to_char(to_number(to_char(col_numeric_length10_0))) from numerical ;
select to_char(to_number(to_char(col_numeric_length38_0))) from numerical ;
select to_char(to_number(to_char(col_numeric_length39_0))) from numerical ;
select to_char(to_number(to_char(col_float))) from numerical ;
select to_char(to_number(to_char(col_float_length10))) from numerical ;
select to_char(to_number(to_char(col_float_length38))) from numerical ;
select to_char(to_number(to_char(col_float_length39))) from numerical ;
select to_char(to_number(to_char(col_real))) from numerical ;
select to_char(to_number(to_char(col_double_precision))) from numerical ;
select to_char(to_number(to_char(col_int))) from numerical ;
select to_char(to_number(to_char(col_integer))) from numerical ;
select to_char(to_number(to_char(col_int8))) from numerical ;
select to_char(to_number(to_char(col_int64))) from numerical ;
select to_char(to_number(to_char(col_bigint))) from numerical ;
select to_char(to_number(to_char(col_int2))) from numerical ;
select to_char(to_number(to_char(col_smallint))) from numerical ;
select to_char(to_number(to_char(col_int4))) from numerical ;

select to_char(to_number(to_char(col_decimal_length10_2))) from numerical ;
select to_char(to_number(to_char(col_decimal_length10_3))) from numerical ;
select to_char(to_number(to_char(col_decimal_length10_10))) from numerical ;
select to_char(to_number(to_char(col_decimal_length38_38))) from numerical ;
select to_char(to_number(to_char(col_numeric_length10_2))) from numerical ;
select to_char(to_number(to_char(col_numeric_length10_3))) from numerical ;
select to_char(to_number(to_char(col_numeric_length10_10))) from numerical ;
select to_char(to_number(to_char(col_numeric_length38_38))) from numerical ;

--ASCII(to_char())


select ASCII(to_char(col_decimal)) from numerical ;
select ASCII(to_char(col_decimal_length10_0)) from numerical ;
select ASCII(to_char(col_decimal_length38_0)) from numerical ;
select ASCII(to_char(col_decimal_length39_0)) from numerical ;
select ASCII(to_char(col_numeric)) from numerical ;
select ASCII(to_char(col_numeric_length10_0)) from numerical ;
select ASCII(to_char(col_numeric_length38_0)) from numerical ;
select ASCII(to_char(col_numeric_length39_0)) from numerical ;
select ASCII(to_char(col_float)) from numerical ;
select ASCII(to_char(col_float_length10)) from numerical ;
select ASCII(to_char(col_float_length38)) from numerical ;
select ASCII(to_char(col_float_length39)) from numerical ;
select ASCII(to_char(col_real)) from numerical ;
select ASCII(to_char(col_double_precision)) from numerical ;
select ASCII(to_char(col_int)) from numerical ;
select ASCII(to_char(col_integer)) from numerical ;
select ASCII(to_char(col_int8)) from numerical ;
select ASCII(to_char(col_int64)) from numerical ;
select ASCII(to_char(col_bigint)) from numerical ;
select ASCII(to_char(col_int2)) from numerical ;
select ASCII(to_char(col_smallint)) from numerical ;
select ASCII(to_char(col_int4)) from numerical ;

select ASCII(to_char(col_decimal_length10_2)) from numerical ;
select ASCII(to_char(col_decimal_length10_3)) from numerical ;
select ASCII(to_char(col_decimal_length10_10)) from numerical ;
select ASCII(to_char(col_decimal_length38_38)) from numerical ;
select ASCII(to_char(col_numeric_length10_2)) from numerical ;
select ASCII(to_char(col_numeric_length10_3)) from numerical ;
select ASCII(to_char(col_numeric_length10_10)) from numerical ;
select ASCII(to_char(col_numeric_length38_38)) from numerical ;

--to_char()||to_char()
select to_char(col_decimal)||to_char(col_decimal) from numerical ;
select to_char(col_decimal_length10_0)||to_char(col_decimal_length10_0) from numerical ;
select to_char(col_decimal_length38_0)||to_char(col_decimal_length38_0) from numerical ;
select to_char(col_decimal_length39_0)||to_char(col_decimal_length39_0) from numerical ;
select to_char(col_numeric)||to_char(col_numeric)) from numerical ;
select to_char(col_numeric_length10_0)||to_char(col_numeric_length10_0) from numerical ;
select to_char(col_numeric_length38_0)||to_char(col_numeric_length38_0) from numerical ;
select to_char(col_numeric_length39_0)||to_char(col_numeric_length39_0) from numerical ;
select to_char(col_float)||to_char(col_float) from numerical ;
select to_char(col_float_length10)||to_char(col_float_length10) from numerical ;
select to_char(col_float_length38)||to_char(col_float_length38) from numerical ;
select to_char(col_float_length39)||to_char(col_float_length39) from numerical ;
select to_char(col_real)||to_char(col_real) from numerical ;
select to_char(col_double_precision)||to_char(col_double_precision) from numerical ;
select to_char(col_int)||to_char(col_int) from numerical ;
select to_char(col_integer)||to_char(col_integer) from numerical ;
select to_char(col_int8)||to_char(col_int8) from numerical ;
select to_char(col_int64)||to_char(col_int64) from numerical ;
select to_char(col_bigint)||to_char(col_bigint) from numerical ;
select to_char(col_int2)||to_char(col_int2) from numerical ;
select to_char(col_smallint)||to_char(col_smallint) from numerical ;
select to_char(col_int4)||to_char(col_int4) from numerical ;


---BUG导致报错
select to_char(col_decimal_length10_2)||to_char(col_decimal_length10_2) from numerical ;
select to_char(col_decimal_length10_3)||to_char(col_decimal_length10_3) from numerical ;
select to_char(col_decimal_length10_10)||to_char(col_decimal_length10_10) from numerical ;
select to_char(col_decimal_length38_38)||to_char(col_decimal_length38_38) from numerical ;
select to_char(col_numeric_length10_2)||to_char(col_numeric_length10_2) from numerical ;
select to_char(col_numeric_length10_3)||to_char(col_numeric_length10_3) from numerical ;
select to_char(col_numeric_length10_10)||to_char(col_numeric_length10_10) from numerical ;
select to_char(col_numeric_length38_38)||to_char(col_numeric_length38_38) from numerical ;


--to_char(''+1)

select to_char(col_decimal+1) from numerical ;
select to_char(col_decimal_length10_0+1) from numerical ;
select to_char(col_decimal_length38_0+1) from numerical ;
select to_char(col_decimal_length39_0+1) from numerical ;
select to_char(col_numeric+1) from numerical ;
select to_char(col_numeric_length10_0+1) from numerical ;
select to_char(col_numeric_length38_0+1) from numerical ;
select to_char(col_numeric_length39_0+1) from numerical ;
select to_char(col_float+1) from numerical ;
select to_char(col_float_length10+1) from numerical ;
select to_char(col_float_length38+1) from numerical ;
select to_char(col_float_length39+1) from numerical ;
select to_char(col_real+1) from numerical ;
select to_char(col_double_precision+1) from numerical ;
select to_char(col_int+1) from numerical ;
select to_char(col_integer+1) from numerical ;
select to_char(col_int8+1) from numerical ;
select to_char(col_int64+1) from numerical ;
select to_char(col_bigint+1) from numerical ;
select to_char(col_int2+1) from numerical ;
select to_char(col_smallint+1) from numerical ;
select to_char(col_int4+1) from numerical ;

select to_char(col_decimal_length10_2+1) from numerical ;
select to_char(col_decimal_length10_3+1) from numerical ;
select to_char(col_decimal_length10_10+1) from numerical ;
select to_char(col_decimal_length38_38+1) from numerical ;
select to_char(col_numeric_length10_2+1) from numerical ;
select to_char(col_numeric_length10_3+1) from numerical ;
select to_char(col_numeric_length10_10+1) from numerical ;
select to_char(col_numeric_length38_38+1) from numerical ;


select to_char(col_decimal-1) from numerical ;
select to_char(col_decimal_length10_0-1) from numerical ;
select to_char(col_decimal_length38_0-1) from numerical ;
select to_char(col_decimal_length39_0-1) from numerical ;
select to_char(col_numeric-1) from numerical ;
select to_char(col_numeric_length10_0-1) from numerical ;
select to_char(col_numeric_length38_0-1) from numerical ;
select to_char(col_numeric_length39_0-1) from numerical ;
select to_char(col_float-1) from numerical ;
select to_char(col_float_length10-1) from numerical ;
select to_char(col_float_length38-1) from numerical ;
select to_char(col_float_length39-1) from numerical ;
select to_char(col_real-1) from numerical ;
select to_char(col_double_precision-1) from numerical ;
select to_char(col_int-1) from numerical ;
select to_char(col_integer-1) from numerical ;
select to_char(col_int8-1) from numerical ;
select to_char(col_int64-1) from numerical ;
select to_char(col_bigint-1) from numerical ;
select to_char(col_int2-1) from numerical ;
select to_char(col_smallint-1) from numerical ;
select to_char(col_int4-1) from numerical ;
select to_char(col_decimal_length10_2-1) from numerical ;
select to_char(col_decimal_length10_3-1) from numerical ;
select to_char(col_decimal_length10_10-1) from numerical ;
select to_char(col_decimal_length38_38-1) from numerical ;
select to_char(col_numeric_length10_2-1) from numerical ;
select to_char(col_numeric_length10_3-1) from numerical ;
select to_char(col_numeric_length10_10-1) from numerical ;
select to_char(col_numeric_length38_38-1) from numerical ;

--concat(to_char(),to_char())
select concat(to_char(col_decimal),to_char(col_decimal)) from numerical ;
select concat(to_char(col_decimal_length10_0),to_char(col_decimal_length10_0)) from numerical ;
select concat(to_char(col_decimal_length38_0),to_char(col_decimal_length38_0)) from numerical ;
select concat(to_char(col_decimal_length39_0),to_char(col_decimal_length39_0)) from numerical ;
select concat(to_char(col_numeric),to_char(col_numeric)) from numerical ;
select concat(to_char(col_numeric_length10_0),to_char(col_numeric_length10_0)) from numerical ;
select concat(to_char(col_numeric_length38_0),to_char(col_numeric_length38_0)) from numerical ;
select concat(to_char(col_numeric_length39_0),to_char(col_numeric_length39_0)) from numerical ;
select concat(to_char(col_float),to_char(col_float)) from numerical ;
select concat(to_char(col_float_length10),to_char(col_float_length10)) from numerical ;
select concat(to_char(col_float_length38),to_char(col_float_length38)) from numerical ;
select concat(to_char(col_float_length39),to_char(col_float_length39)) from numerical ;
select concat(to_char(col_real),to_char(col_real)) from numerical ;
select concat(to_char(col_double_precision),to_char(col_double_precision)) from numerical ;
select concat(to_char(col_int),to_char(col_int)) from numerical ;
select concat(to_char(col_integer),to_char(col_integer)) from numerical ;
select concat(to_char(col_int8),to_char(col_int8)) from numerical ;
select concat(to_char(col_int64),to_char(col_int64)) from numerical ;
select concat(to_char(col_bigint),to_char(col_bigint)) from numerical ;
select concat(to_char(col_int2),to_char(col_int2)) from numerical ;
select concat(to_char(col_smallint),to_char(col_smallint)) from numerical ;
select concat(to_char(col_int4),to_char(col_int4)) from numerical ;

---BUG导致报错
select concat(to_char(col_decimal_length10_2),to_char(col_decimal_length10_2)) from numerical ;
select concat(to_char(col_decimal_length10_3),to_char(col_decimal_length10_3)) from numerical ;
select concat(to_char(col_decimal_length10_10),to_char(col_decimal_length10_10)) from numerical ;
select concat(to_char(col_decimal_length38_38),to_char(col_decimal_length38_38)) from numerical ;
select concat(to_char(col_numeric_length10_2),to_char(col_numeric_length10_2)) from numerical ;
select concat(to_char(col_numeric_length10_3),to_char(col_numeric_length10_3)) from numerical ;
select concat(to_char(col_numeric_length10_10),to_char(col_numeric_length10_10)) from numerical ;
select concat(to_char(col_numeric_length38_38),to_char(col_numeric_length38_38)) from numerical ;



--upper(to_char())

---报错
select to_char(upper(col_decimal)) from numerical ;
select to_char(upper(col_decimal_length10_0)) from numerical ;
select to_char(upper(col_decimal_length38_0)) from numerical ;
select to_char(upper(col_decimal_length39_0)) from numerical ;
select to_char(upper(col_numeric)) from numerical ;
select to_char(upper(col_numeric_length10_0)) from numerical ;
select to_char(upper(col_numeric_length38_0)) from numerical ;
select to_char(upper(col_numeric_length39_0)) from numerical ;
select to_char(upper(col_float)) from numerical ;
select to_char(upper(col_float_length10)) from numerical ;
select to_char(upper(col_float_length38)) from numerical ;
select to_char(upper(col_float_length39)) from numerical ;
select to_char(upper(col_real)) from numerical ;
select to_char(upper(col_double_precision)) from numerical ;
select to_char(upper(col_int)) from numerical ;
select to_char(upper(col_integer)) from numerical ;
select to_char(upper(col_int8)) from numerical ;
select to_char(upper(col_int64)) from numerical ;
select to_char(upper(col_bigint)) from numerical ;
select to_char(upper(col_int2)) from numerical ;
select to_char(upper(col_smallint)) from numerical ;
select to_char(upper(col_int4)) from numerical ;

select to_char(upper(col_decimal_length10_2)) from numerical ;
select to_char(upper(col_decimal_length10_3)) from numerical ;
select to_char(upper(col_decimal_length10_10)) from numerical ;
select to_char(upper(col_decimal_length38_38)) from numerical ;
select to_char(upper(col_numeric_length10_2)) from numerical ;
select to_char(upper(col_numeric_length10_3)) from numerical ;
select to_char(upper(col_numeric_length10_10)) from numerical ;
select to_char(upper(col_numeric_length38_38)) from numerical ;

--lower(to_char())

select to_char(lower(col_decimal)) from numerical ;
select to_char(lower(col_decimal_length10_0)) from numerical ;
select to_char(lower(col_decimal_length38_0)) from numerical ;
select to_char(lower(col_decimal_length39_0)) from numerical ;
select to_char(lower(col_numeric)) from numerical ;
select to_char(lower(col_numeric_length10_0)) from numerical ;
select to_char(lower(col_numeric_length38_0)) from numerical ;
select to_char(lower(col_numeric_length39_0)) from numerical ;
select to_char(lower(col_float)) from numerical ;
select to_char(lower(col_float_length10)) from numerical ;
select to_char(lower(col_float_length38)) from numerical ;
select to_char(lower(col_float_length39)) from numerical ;
select to_char(lower(col_real)) from numerical ;
select to_char(lower(col_double_precision)) from numerical ;
select to_char(lower(col_int)) from numerical ;
select to_char(lower(col_integer)) from numerical ;
select to_char(lower(col_int8)) from numerical ;
select to_char(lower(col_int64)) from numerical ;
select to_char(lower(col_bigint)) from numerical ;
select to_char(lower(col_int2)) from numerical ;
select to_char(lower(col_smallint)) from numerical ;
select to_char(lower(col_int4)) from numerical ;

select to_char(lower(col_decimal_length10_2)) from numerical ;
select to_char(lower(col_decimal_length10_3)) from numerical ;
select to_char(lower(col_decimal_length10_10)) from numerical ;
select to_char(lower(col_decimal_length38_38)) from numerical ;
select to_char(lower(col_numeric_length10_2)) from numerical ;
select to_char(lower(col_numeric_length10_3)) from numerical ;
select to_char(lower(col_numeric_length10_10)) from numerical ;
select to_char(lower(col_numeric_length38_38)) from numerical ;
drop table if exists empl_temp;
drop table if exists numerical;
drop table if exists test_mytab;
drop table if exists STRINGS;
drop table if exists a;
drop table if exists b;
drop table if exists bool;
drop table if exists bytes;
drop table if exists foo;
drop table if exists dates;
drop table if exists accounts;
drop table if exists computers;
drop table if exists intervals1;
drop table if exists users;
drop table if exists serial1;
drop table if exists time1;
drop table if exists timestamps_test;
drop table if exists v;
drop table if exists numerical2;
drop TYPE if exists status;
drop table test_1;
