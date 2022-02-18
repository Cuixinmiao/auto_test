-----Syntax ：[ DEFAULT  return_value ON CONVERSION ERROR]

---- R-298
SELECT TO_NUMBER('2,00' DEFAULT 0 ON CONVERSION ERROR) "Value"  FROM DUAL;

drop table if exists STRINGS;

CREATE TABLE STRINGS (
col_VARCHAR_length VARCHAR(10) ,
col_CHAR_length CHAR(10)
);
insert into STRINGS values('111','2,22');
insert into STRINGS values('-111','-2,22');
insert into STRINGS values('0.111','0,111');
insert into STRINGS values('-0.111','-0,111');
insert into STRINGS values('1.03E+08','1,03E+08');
insert into STRINGS values('-1.03E+08','-1,03E+08');
insert into STRINGS values('0.0','0,0');
insert into STRINGS values('-0.0','-0,0');

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT 0 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT 0 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

----return_value 
-----'字符串'---
SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '0' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '0' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '10' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '10' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '1.0' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '1.0' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '1.03E+08' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '1.03E+08' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '-0' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '-0' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '-10' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '-10' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '-1.0' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '-1.0' ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT '-1.03E+08' ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT '-1.03E+08' ON CONVERSION ERROR) "Value2"  FROM STRINGS;


-----'数值---小数\整数\科学计数'---
SELECT TO_NUMBER(col_VARCHAR_length DEFAULT 0 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT 0 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT 10 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT 10 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT 1.0 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT 1.0 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT 1.03E+08 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT 1.03E+08ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT -0 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT -0 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT -10 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT -10 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT -1.0 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT -1.0 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT -1.03E+08 ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT -1.03E+08 ON CONVERSION ERROR) "Value2"  FROM STRINGS;

---"字符串"

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT "测试" ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT "测试" ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT "abc" ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT "abc" ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT "abc123" ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT "abc123" ON CONVERSION ERROR) "Value2"  FROM STRINGS;
 
SELECT TO_NUMBER(col_VARCHAR_length DEFAULT "测试123" ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT "测试123" ON CONVERSION ERROR) "Value2"  FROM STRINGS;

SELECT TO_NUMBER(col_VARCHAR_length DEFAULT "测试123abc" ON CONVERSION ERROR) "Value1",TO_NUMBER(col_CHAR_length DEFAULT "测试123abc" ON CONVERSION ERROR) "Value2"  FROM STRINGS;


-----Syntax ：[, 'nlsparam' ]

SELECT TO_NUMBER('-AusDollars100','L9G999D99',
   ' NLS_NUMERIC_CHARACTERS = '',.''
     NLS_CURRENCY            = ''AusDollars''
   ') "Amount"
     FROM DUAL;


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
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

---别名
select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_string)=0.11111111 and
to_number(col_string_length)=0.11111111 and
to_number(col_text)=0.11111111 and
to_number(col_varchar)=0.11111111 and
to_number(col_varchar_length)=0.11111111 and
col_char = '1' and 
to_number(col_char_length)=0.11111111;

select * from strings;

--整数
INSERT INTO strings VALUES ('11111111', '11111111', '11111111','11111111', '11111111','1','11111111');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

---别名
select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_STRING)=11111111 and
to_number(col_string)=11111111 and
to_number(col_string_length)=11111111 and
to_number(col_text)=11111111 and
to_number(col_varchar)=11111111 and
to_number(col_varchar_length)=11111111 and
col_char = '1' and 
to_number(col_char_length)=11111111;

select * from strings;

--科学计数法：
INSERT INTO strings VALUES ('1.03E+08', '1.03E+08','1.03E+08','1.03E+08','1.03E+08','1','1.03E+08');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_STRING)=1.03E+8 and
to_number(col_string)=1.03E+8 and
to_number(col_string_length)=1.03E+8 and
to_number(col_text)=1.03E+8 and
to_number(col_varchar)=1.03E+8 and
to_number(col_varchar_length)=1.03E+8 and
col_char = '1' and 
to_number(col_char_length)=1.03E+8;

select * from strings;

---16进制

INSERT INTO strings VALUES ('0A', '0A', '0A', '0A', '0A', 'A', '0A');

select 
to_number(col_string,'XX'),
to_number(col_string_length,'XX'),
to_number(col_text,'XX'),
to_number(col_varchar,'XX'),
to_number(col_varchar_length,'XX'),
to_number(col_char,'XX'),
to_number(col_char_length,'XX')
from strings;

select 
to_number(col_string,'XX')col_string,
to_number(col_string_length,'XX')col_string_length,
to_number(col_text,'XX')col_text,
to_number(col_varchar,'XX')col_varchar,
to_number(col_varchar_length,'XX')col_varchar_length,
to_number(col_char,'XX')col_char,
to_number(col_char_length,'XX')col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string,'XX')=10 and
to_number(col_string_length,'XX')=10 and
to_number(col_text,'XX')=10 and
to_number(col_varchar,'XX')=10 and
to_number(col_varchar_length,'XX')=10 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=10;

select * from strings;

INSERT INTO strings VALUES ('aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'a', 'aaaaaaaa');

select 
to_number(col_string,'XX'),
to_number(col_string_length,'XX'),
to_number(col_text,'XX'),
to_number(col_varchar,'XX'),
to_number(col_varchar_length,'XX'),
to_number(col_char,'XX'),
to_number(col_char_length,'XX')
from strings;

select 
to_number(col_string,'XX')col_string,
to_number(col_string_length,'XX')col_string_length,
to_number(col_text,'XX')col_text,
to_number(col_varchar,'XX')col_varchar,
to_number(col_varchar_length,'XX')col_varchar_length,
to_number(col_char,'XX')col_char,
to_number(col_char_length,'XX')col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string,'XX')=2863311530 and
to_number(col_string_length,'XX')=2863311530 and
to_number(col_text,'XX')=2863311530 and
to_number(col_varchar,'XX')=2863311530 and
to_number(col_varchar_length,'XX')=2863311530 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=2863311530;

select * from strings;

----有-号
----字符类型
drop table if exists STRINGS;
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
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

---别名
select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_string)=0.1111111 and
to_number(col_string_length)=0.1111111 and
to_number(col_text)=0.1111111 and
to_number(col_varchar)=0.1111111 and
to_number(col_varchar_length)=0.1111111 and
col_char = '1' and 
to_number(col_char_length)=0.1111111;

select * from strings;

--整数
INSERT INTO strings VALUES ('-1111111', '-1111111', '-1111111','-1111111', '-1111111','1','-1111111');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

---别名
select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_string)=1111111 and
to_number(col_string_length)=1111111 and
to_number(col_text)=1111111 and
to_number(col_varchar)=1111111 and
to_number(col_varchar_length)=1111111 and
col_char = '1' and 
to_number(col_char_length)=1111111;

select * from strings;

--科学计数法：
INSERT INTO strings VALUES ('-1.03E+08', '-1.03E+08','-1.03E+08','-1.03E+08','-1.03E+08','1','-1.03E+08');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string)=1.03E+8 and
to_number(col_string_length)=1.03E+8 and
to_number(col_text)=1.03E+8 and
to_number(col_varchar)=1.03E+8 and
to_number(col_varchar_length)=1.03E+8 and
col_char = '1' and 
to_number(col_char_length)=1.03E+8;

select * from strings;

---16进制

INSERT INTO strings VALUES ('-0A', '-0A', '-0A', '-0A', '-0A', 'A', '-0A');

select 
to_number(col_string,'XX'),
to_number(col_string_length,'XX'),
to_number(col_text,'XX'),
to_number(col_varchar,'XX'),
to_number(col_varchar_length,'XX'),
to_number(col_char,'XX'),
to_number(col_char_length,'XX')
from strings;

select 
to_number(col_string,'XX')col_string,
to_number(col_string_length,'XX')col_string_length,
to_number(col_text,'XX')col_text,
to_number(col_varchar,'XX')col_varchar,
to_number(col_varchar_length,'XX')col_varchar_length,
to_number(col_char,'XX')col_char,
to_number(col_char_length,'XX')col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string,'XX')=10 and
to_number(col_string_length,'XX')=10 and
to_number(col_text,'XX')=10 and
to_number(col_varchar,'XX')=10 and
to_number(col_varchar_length,'XX')=10 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=10;

select * from strings;

INSERT INTO strings VALUES ('-aaaaaaa', '-aaaaaaa', '-aaaaaaa', '-aaaaaaa', '-aaaaaaa', 'a', '-aaaaaaa');

select 
to_number(col_string,'XX'),
to_number(col_string_length,'XX'),
to_number(col_text,'XX'),
to_number(col_varchar,'XX'),
to_number(col_varchar_length,'XX'),
to_number(col_char,'XX'),
to_number(col_char_length,'XX')
from strings;

select 
to_number(col_string,'XX')col_string,
to_number(col_string_length,'XX')col_string_length,
to_number(col_text,'XX')col_text,
to_number(col_varchar,'XX')col_varchar,
to_number(col_varchar_length,'XX')col_varchar_length,
to_number(col_char,'XX')col_char,
to_number(col_char_length,'XX')col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string,'XX')=2863311530 and
to_number(col_string_length,'XX')=2863311530 and
to_number(col_text,'XX')=2863311530 and
to_number(col_varchar,'XX')=2863311530 and
to_number(col_varchar_length,'XX')=2863311530 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=2863311530;

select * from strings;



---字母

INSERT INTO strings VALUES ('abcdefg','abcdefg','abcdefg', 'abcdefg', 'abcdefg', 'g', 'abcdefg');


select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

select * from strings;

truncate strings;

---中文字符:
INSERT INTO strings VALUES ('测','测','测', '测', '测', '测', '测');


select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

select * from strings;

truncate strings;

-----特殊字符
INSERT INTO strings VALUES ('~!@#$%^&*?', '~!@#$%^&*?', '~!@#$%^&*?','~!@#$%^&*?','~!@#$%^&*?', '~', '~!@#$%^&*?');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;
select * from strings;

truncate strings;

----字母\中文\特殊字符
INSERT INTO strings VALUES ('a测#', 'a测#','a测#','a测#', 'a测#', '测', 'a测#');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;
select * from strings;

truncate strings;


------null值
INSERT INTO strings VALUES (null, null,null,null, null, null, null);

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;

delete from strings where 
to_number(col_string)is NULL and
to_number(col_string_length)is NULL and
to_number(col_text)is NULL and
to_number(col_varchar)is NULL and
to_number(col_varchar_length)is NULL and
to_number(col_char)is NULL and
to_number(col_char_length)is NULL;



select * from strings;

----空串''
INSERT INTO strings VALUES ('', '','','', '', '', '');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_string)='' and
to_number(col_string_length)='' and
to_number(col_text)='' and
to_number(col_varchar)='' and
to_number(col_varchar_length)='' and
to_number(col_char)='' and
to_number(col_char_length)='';


----空串' '
INSERT INTO strings VALUES (' ', ' ',' ',' ', ' ', ' ', ' ');

select 
to_number(col_string),
to_number(col_string_length),
to_number(col_text),
to_number(col_varchar),
to_number(col_varchar_length),
--to_number(col_char),
to_number(col_char_length)
from strings;

select 
to_number(col_string)col_string,
to_number(col_string_length)col_string_length,
to_number(col_text)col_text,
to_number(col_varchar)col_varchar,
to_number(col_varchar_length)col_varchar_length,
--to_number(col_char)col_char,
to_number(col_char_length)col_char_length
from strings;

SELECT 
TO_NUMBER(COL_STRING)"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH)"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT)"COL_TEXT",
TO_NUMBER(COL_VARCHAR)"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH)"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR)"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH)"COL_CHAR_LENGTH"
FROM STRINGS;


delete from strings where 
to_number(col_string)=' ' and
to_number(col_string_length)=' ' and
to_number(col_text)=' ' and
to_number(col_varchar)=' ' and
to_number(col_varchar_length)=' ' and
to_number(col_char)=' ' and
to_number(col_char_length)=' ';


----fmt
---，(9,999) 返回指定位置的逗号

select TO_NUMBER('123456','999,999') from dual;
select TO_NUMBER('123456','999,999,') from dual;


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

INSERT INTO strings VALUES ('10000', '10000', '10000','10000', '10000','1','10000');

---指定1个逗号
SELECT 
TO_NUMBER(COL_STRING,'999999,9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999,9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999,9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999,9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999,9999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999,9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999,9999')"COL_CHAR_LENGTH"
FROM STRINGS;

---指定多个逗号
SELECT 
TO_NUMBER(COL_STRING,'9,999,999,999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9,999,999,999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9,999,999,999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9,999,999,999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9,999,999,999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9,999,999,999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9,999,999,999')"COL_CHAR_LENGTH"
FROM STRINGS;

---逗号元素作为数字格式模型的开头
SELECT 
TO_NUMBER(COL_STRING,',999999,9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,',999999,9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,',999999,9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,',999999,9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,',999999,9999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,',999999,9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,',999999,9999')"COL_CHAR_LENGTH"
FROM STRINGS;


---在句点的右侧
SELECT 
TO_NUMBER(COL_STRING,'9999999999.,')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999.,')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999.,')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999.,')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999.,')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999.,')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999.,')"COL_CHAR_LENGTH"
FROM STRINGS;

---不在句点的右侧
SELECT 
TO_NUMBER(COL_STRING,'9999999999,.')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999,.')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999,.')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999,.')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999,.')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999,.')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999,.')"COL_CHAR_LENGTH"
FROM STRINGS;

 
---在十进制字符的右侧

SELECT 
TO_NUMBER(COL_STRING,'9999999999,')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999,')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999,')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999,')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999,')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999,')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999,')"COL_CHAR_LENGTH"
FROM STRINGS;

 

----(99.99) 返回小数点，即指定位置的句号(.)
---数字格式模型中指定一个句点
SELECT 
TO_NUMBER(COL_STRING,'9999999999.')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999.')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999.')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999.')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999.')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999.')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999.')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('100.0', '100.0', '100.0','100.0', '100.0','1','100.0');

SELECT 
TO_NUMBER(COL_STRING,'99999999.9')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999999.9')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999999.9')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999999.9')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999999.9')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'99999999.9')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999999.9')"COL_CHAR_LENGTH"
FROM STRINGS;



----数字格式模型中指定多个句点

truncate STRINGS;

INSERT INTO strings VALUES ('1000.000.0', '1000.000.0', '1000.000.0','1000.000.0', '1000.000.0','1','1000.000.0');

SELECT 
TO_NUMBER(COL_STRING,'9999.999.9')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999.999.9')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999.999.9')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999.999.9')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999.999.9')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9999.999.9')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999.999.9')"COL_CHAR_LENGTH"
FROM STRINGS;

---($9999) 返回带有前导美元符号的值。

truncate STRINGS;

INSERT INTO strings VALUES ('$1000', '$1000', '$1000','$1000', '$1000','1','$1000');

SELECT 
TO_NUMBER(COL_STRING,'$9999999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'$9999999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'$9999999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'$9999999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'$9999999999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'$9999999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'$9999999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---(L9999) 返回带有前导人民币符号的值。

INSERT INTO strings VALUES ('¥1000', '¥1000', '¥1000','¥1000', '¥1000','1','¥1000');

SELECT 
TO_NUMBER(COL_STRING,'L9999999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'L9999999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'L9999999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'L9999999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'L9999999999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'L9999999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'L9999999999')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate STRINGS;

---(€9999) 返回带有前导欧元符号的值。

INSERT INTO strings VALUES ('€1000', '€1000', '€1000','€1000', '€1000','1','€1000');

 SELECT 
TO_NUMBER(COL_STRING,'U9999999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'U9999999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'U9999999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'U9999999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'U9999999999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'U9999999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'U9999999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

----(09999990) 返回前导零。返回尾随零

 
INSERT INTO strings VALUES ('010010', '010010', '010010','010010', '010010','0','010010');

SELECT 
TO_NUMBER(COL_STRING,'09999990')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'09999990')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'09999990')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'09999990')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'09999990')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'09999990')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'09999990')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

----(9999) 返回具有指定位数的值

--正数则带有前导空格

INSERT INTO strings VALUES (' 010010', ' 010010', ' 010010',' 010010', ' 010010','0',' 010010');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--正数则带有前导空格+'+'

INSERT INTO strings VALUES (' +010010', ' +010010', ' +010010',' +010010', ' +010010','0',' +010010');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--正数则带有前导'+'+空格

INSERT INTO strings VALUES (' + 010010', ' + 010010', ' + 010010',' + 010010', ' + 010010','0',' + 010010');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--负数则带有前导空格+减号

INSERT INTO strings VALUES (' -010010', ' -010010', ' -010010',' -010010', ' -010010','0',' -010010');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--负数则带有前导减号+空格

INSERT INTO strings VALUES (' - 010010', ' - 010010', ' - 010010',' - 010010', ' - 010010','0',' - 010010');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--前导零是空白

INSERT INTO strings VALUES (' 0 ', ' 0 ', ' 0 ',' 0 ', ' 0 ','0',' 0 ');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--前导零是空白+0+空白+0+空白

INSERT INTO strings VALUES (' 0 0 ', ' 0 0 ', ' 0 0 ',' 0 0 ', ' 0 0 ','0',' 0 0 ');

SELECT 
TO_NUMBER(COL_STRING,'999999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---B9999
---当整数部分为零时，定点数的整数部分返回空白
--整数

INSERT INTO strings VALUES ('10010', '10010', '10010','10010', '10010','0','10010');

SELECT 
TO_NUMBER(COL_STRING,'B99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('010010', '010010', '010010','010010', '010010','1','010010');

SELECT 
TO_NUMBER(COL_STRING,'B99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


--小数
INSERT INTO strings VALUES ('0.10010', '0.10010', '0.10010','0.10010', '0.10010','1','0.10010');

SELECT 
TO_NUMBER(COL_STRING,'B9.99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B9.99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B9.99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B9.99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B9.99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B9.99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B9.99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('1.10010', '1.10010', '1.10010','1.10010', '1.10010','1','1.10010');

SELECT 
TO_NUMBER(COL_STRING,'B9.99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B9.99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B9.99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B9.99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B9.99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B9.99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B9.99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('1.0000', '1.0000', '1.0000','1.0000', '1.0000','1','1.0000');

SELECT 
TO_NUMBER(COL_STRING,'B9.99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B9.99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B9.99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B9.99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B9.99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B9.99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B9.99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('11.0000', '11.0000', '11.0000','11.0000', '11.0000','1','11.0000');

SELECT 
TO_NUMBER(COL_STRING,'B99.99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'B99.99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'B99.99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'B99.99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'B99.99999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'B99.99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'B99.99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---EEEE  
---(9.9EEEE) 返回使用科学记数法的值

INSERT INTO strings VALUES ('1.234e-3', '1.234e-3', '1.234e-3','1.234e-3', '1.234e-3','1','1.234e-3');

SELECT 
TO_NUMBER(COL_STRING,'9.999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9.999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9.999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9.999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9.999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9.999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9.999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


INSERT INTO strings VALUES ('-1.234e-3', '-1.234e-3', '-1.234e-3','-1.234e-3', '-1.234e-3','1','-1.234e-3');

SELECT 
TO_NUMBER(COL_STRING,'9.999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9.999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9.999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9.999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9.999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9.999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9.999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


INSERT INTO strings VALUES ('3e3', '3e3', '3e3','3e3', '3e3','1','3e3');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('-3e3', '-3e3', '-3e3','-3e3', '-3e3','1','-3e3');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---边界

INSERT INTO strings VALUES ('1e999', '1e999', '1e999','1e999', '1e999','1','1e999');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


INSERT INTO strings VALUES ('1e-999', '1e-999', '1e-999','1e-999', '1e-999','1','1e-999');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('1e1000', '1e1000', '1e1000','1e1000', '1e1000','1','1e1000');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


INSERT INTO strings VALUES ('1e-1000', '1e-1000', '1e-1000','1e-1000', '1e-1000','1','1e-1000');

SELECT 
TO_NUMBER(COL_STRING,'9999EEEE')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999EEEE')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999EEEE')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999EEEE')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999EEEE')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9999EEEE')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999EEEE')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


----(9999MI) 
----返回带有尾随减号 (-) 的负值
INSERT INTO strings VALUES ('10010-', '10010-', '10010-','10010-', '10010-','0','10010-');
SELECT 
TO_NUMBER(COL_STRING,'99999MI')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999MI')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999MI')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999MI')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999MI')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999MI')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999MI')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


----返回带有尾随空白的正值
----MI 格式元素在数字格式模型的最后一个位置

INSERT INTO strings VALUES ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','0','10010 ');
SELECT 
TO_NUMBER(COL_STRING,'99999MI')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999MI')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999MI')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999MI')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999MI')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999MI')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999MI')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

----MI 格式元素在数字格式模型的中间位置
INSERT INTO strings VALUES ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','0','10010 ');
SELECT 
TO_NUMBER(COL_STRING,'999MI99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999MI99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999MI99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999MI99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999MI99')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'999MI99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999MI99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;
----MI 格式元素在数字格式模型的开始位置
INSERT INTO strings VALUES ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','0','10010 ');
SELECT 
TO_NUMBER(COL_STRING,'MI99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'MI99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'MI99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'MI99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'MI99999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'MI99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'MI99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


---9999PR
---在 <尖括号> 中返回负值
---PR格式元素在数字格式模型的最后一个位置
INSERT INTO strings VALUES ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','0','<10010>');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('<1.0010>', '<1.0010>', '<1.0010>','<1.0010>', '<1.0010>','0','<1.0010>');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('<-1.0010>', '<-1.0010>', '<-1.0010>','<-1.0010>', '<-1.0010>','0','<-1.0010>');
SELECT 
TO_NUMBER(COL_STRING,'9.9999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9.9999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9.9999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9.9999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9.9999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'9.9999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9.9999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


---返回带有前导和尾随空白的正值
INSERT INTO strings VALUES ('10010 ', '10010 ', '10010 ','10010 ', '10010 ','0','10010 ');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('10010- ', '10010- ', '10010 ','10010 ', '10010 ','0','10010 ');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('<10010 >', '<10010 >', '<10010 >','<10010 >', '<10010 >','0','<10010 >');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('<1.0010 >', '<1.0010 >', '<1.0010 >','<1.0010 >', '<1.0010 >','0','<1.0010 >');
SELECT 
TO_NUMBER(COL_STRING,'99999PR')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999PR')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999PR')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999PR')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999PR')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999PR')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999PR')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---PR格式元素在数字格式模型的中间位置
INSERT INTO strings VALUES ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','0','<10010>');
SELECT 
TO_NUMBER(COL_STRING,'999PR99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999PR99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999PR99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999PR99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999PR99')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'999PR99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999PR99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;
---PR格式元素在数字格式模型的开始位置
INSERT INTO strings VALUES ('<10010>', '<10010>', '<10010>','<10010>', '<10010>','0','<10010>');
SELECT 
TO_NUMBER(COL_STRING,'PR99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'PR99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'PR99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'PR99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'PR99999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'PR99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'PR99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


---S99999999S
--返回带前导减号 (-) 的负值
INSERT INTO strings VALUES ('-10010', '-10010', '-10010','-10010', '-10010','0','-10010');
SELECT 
TO_NUMBER(COL_STRING,'S99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('-10.010', '-10.010', '-10.010','-10.010', '-10.010','0','-10.010');
SELECT 
TO_NUMBER(COL_STRING,'S99.999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99.999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99.999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99.999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99.999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99.999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99.999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('-0.010', '-0.010', '-0.010','-0.010', '-0.010','0','-0.010');
SELECT 
TO_NUMBER(COL_STRING,'S99.999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99.999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99.999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99.999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99.999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99.999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99.999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


--返回带前导加号 (+) 的正值
INSERT INTO strings VALUES ('+10010', '+10010', '+10010','+10010', '+10010','0','+10010');
SELECT 
TO_NUMBER(COL_STRING,'S99999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('+10.010', '+10.010', '+10.010','+10.010', '+10.010','0','+10.010');
SELECT 
TO_NUMBER(COL_STRING,'S99.999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99.999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99.999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99.999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99.999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99.999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99.999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('+0.010', '+0.010', '+0.010','+0.010', '+0.010','0','+0.010');
SELECT 
TO_NUMBER(COL_STRING,'S99.999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S99.999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S99.999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S99.999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S99.999')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'S99.999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S99.999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--返回带尾随减号 (-) 的负值

INSERT INTO strings VALUES ('10010-', '10010-', '10010-','10010-', '10010-','0','10010-');
SELECT 
TO_NUMBER(COL_STRING,'99999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('10.010-', '10.010-', '10.010-','10.010-', '10.010-','0','10.010-');
SELECT 
TO_NUMBER(COL_STRING,'99.999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99.999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99.999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99.999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99.999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99.999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99.999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('0.010-', '0.010-', '0.010-','0.010-', '0.010-','0','0.010-');
SELECT 
TO_NUMBER(COL_STRING,'99.999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99.999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99.999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99.999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99.999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99.999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99.999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--返回带尾随加号 (+) 的正值
INSERT INTO strings VALUES ('10010+', '10010+', '10010+','10010+', '10010+','0','10010+');
SELECT 
TO_NUMBER(COL_STRING,'99999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('10.010+', '10.010+', '10.010+','10.010+', '10.010+','0','10.010+');
SELECT 
TO_NUMBER(COL_STRING,'99.999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99.999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99.999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99.999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99.999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99.999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99.999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('0.010+', '0.010+', '0.010+','0.010+', '0.010+','0','0.010+');
SELECT 
TO_NUMBER(COL_STRING,'99.999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99.999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99.999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99.999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99.999S')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99.999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99.999S')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

--S格式元素在数字格式模型的中间位置
INSERT INTO strings VALUES ('10010+', '10010+', '10010+','10010+', '10010+','0','10010+');
SELECT 
TO_NUMBER(COL_STRING,'999S99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999S99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999S99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999S99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999S99')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'999S99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999S99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('10.010+', '10.010+', '10.010+','10.010+', '10.010+','0','10.010+');
SELECT 
TO_NUMBER(COL_STRING,'99.9S9')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99.9S9')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99.9S9')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99.9S9')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99.9S9')"COL_VARCHAR_LENGTH",
---TO_NUMBER(COL_CHAR,'99.9S9')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99.9S9')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;


--需与oracle对比,当S和$都存在时，确认S和货币$的先后顺序？
---($9999) 返回带有前导美元符号的值。

truncate STRINGS;

INSERT INTO strings VALUES ('-$1000', '-$1000', '-$1000','-$1000', '-$1000','1','-$1000');

SELECT 
TO_NUMBER(COL_STRING,'S$9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S$9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S$9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S$9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S$9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'S$9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S$9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('$1000-', '$1000-', '$1000-','$1000-', '$1000-','1','$1000-');

SELECT 
TO_NUMBER(COL_STRING,'$9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'$9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'$9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'$9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'$9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'$9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'$9999S')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate STRINGS;

INSERT INTO strings VALUES ('+$1000', '+$1000', '+$1000','+$1000', '+$1000','1','+$1000');

SELECT 
TO_NUMBER(COL_STRING,'S$9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'S$9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'S$9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'S$9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'S$9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'S$9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'S$9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('$1000+', '$1000+', '$1000+','$1000+', '$1000+','1','$1000+');

SELECT 
TO_NUMBER(COL_STRING,'$9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'$9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'$9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'$9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'$9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'$9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'$9999S')"COL_CHAR_LENGTH"
FROM STRINGS;


---(L9999) 返回带有前导人民币符号的值。

truncate STRINGS;

INSERT INTO strings VALUES ('-¥1000', '-¥1000', '-¥1000','-¥1000', '-¥1000','1','-¥1000');

SELECT 
TO_NUMBER(COL_STRING,'SL9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'SL9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'SL9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'SL9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'SL9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'SL9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'SL9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('¥1000-', '¥1000-', '¥1000-','¥1000-', '¥1000-','1','¥1000-');

SELECT 
TO_NUMBER(COL_STRING,'L9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'L9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'L9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'L9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'L9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'L9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'L9999S')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate STRINGS;

INSERT INTO strings VALUES ('+¥1000', '+¥1000', '+¥1000','+¥1000', '+¥1000','1','+¥1000');

SELECT 
TO_NUMBER(COL_STRING,'SL9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'SL9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'SL9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'SL9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'SL9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'SL9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'SL9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('¥1000+', '¥1000+', '¥1000+','¥1000+', '¥1000+','1','¥1000+');

SELECT 
TO_NUMBER(COL_STRING,'L9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'L9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'L9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'L9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'L9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'L9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'L9999S')"COL_CHAR_LENGTH"
FROM STRINGS;



---(€9999) 返回带有前导欧元符号的值。

truncate STRINGS;

INSERT INTO strings VALUES ('-€1000', '-€1000', '-€1000','-€1000', '-€1000','1','-€1000');

SELECT 
TO_NUMBER(COL_STRING,'SU9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'SU9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'SU9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'SU9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'SU9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'SU9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'SU9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('€1000-', '€1000-', '€1000-','€1000-', '€1000-','1','€1000-');

SELECT 
TO_NUMBER(COL_STRING,'U9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'U9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'U9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'U9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'U9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'U9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'U9999S')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate STRINGS;

INSERT INTO strings VALUES ('+€1000', '+€1000', '+€1000','+€1000', '+€1000','1','+€1000');

SELECT 
TO_NUMBER(COL_STRING,'SU9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'SU9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'SU9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'SU9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'SU9999')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'SU9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'SU9999')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('€1000+', '€1000+', '€1000+','€1000+', '€1000+','1','€1000+');

SELECT 
TO_NUMBER(COL_STRING,'U9999S')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'U9999S')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'U9999S')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'U9999S')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'U9999S')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'U9999S')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'U9999S')"COL_CHAR_LENGTH"
FROM STRINGS;

--（999V99)
---返回一个乘以 10n 的值（其中 n 是 V 后面的 9 的个数）

truncate STRINGS;

INSERT INTO strings VALUES ('1000', '1000', '1000','1000', '1000','1','1000');

SELECT 
TO_NUMBER(COL_STRING,'9999V99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999V99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999V99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999V99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999V99')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9999V99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999V99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('-1000', '-1000', '-1000','-1000', '-1000','1','-1000');

SELECT 
TO_NUMBER(COL_STRING,'9999V99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999V99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999V99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999V99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999V99')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9999V99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999V99')"COL_CHAR_LENGTH"
FROM STRINGS;

INSERT INTO strings VALUES ('0.111', '0.111', '0.111','0.111', '0.111','1','0.111');

SELECT 
TO_NUMBER(COL_STRING,'9.999V99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9.999V99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9.999V99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9.999V99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9.999V99')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9.999V99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9.999V99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('-0.111', '-0.111', '-0.111','-0.111', '-0.111','1','-0.111');

SELECT 
TO_NUMBER(COL_STRING,'9.999V99')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9.999V99')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9.999V99')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9.999V99')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9.999V99')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9.999V99')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9.999V99')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

---(XXXXxxxx)
---16进制

INSERT INTO strings VALUES ('0A0A', '0A0A', '0A0A', '0A0A', '0A0A', 'A', '0A0A');

SELECT 
TO_NUMBER(COL_STRING,'XXXX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XXXX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XXXX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XXXX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XXXX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XXXX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XXXX')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate strings;

INSERT INTO strings VALUES ('aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'a', 'aaaaaaaa');

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('78', '78', '78', '78', '78', '7', '78');

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('-78', '-78', '-78', '-78', '-78', '7', '-78');

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate strings;

INSERT INTO strings VALUES ('7.8', '7.8', '7.8', '7.8', '7.8', '7', '7.8');

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '7', '-7.8');

SELECT 
TO_NUMBER(COL_STRING,'XX')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'XX')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'XX')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'XX')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'XX')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'XX')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'XX')"COL_CHAR_LENGTH"
FROM STRINGS;


truncate strings;

INSERT INTO strings VALUES ('7.8', '7.8', '7.8', '7.8', '7.8', '7', '7.8');

SELECT 
TO_NUMBER(COL_STRING,'X.X')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'X.X')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'X.X')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'X.X')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'X.X')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'X.X')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'X.X')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('-7.8', '-7.8', '-7.8', '-7.8', '-7.8', '7', '-7.8');

SELECT 
TO_NUMBER(COL_STRING,'X.X')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'X.X')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'X.X')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'X.X')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'X.X')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'X.X')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'X.X')"COL_CHAR_LENGTH"
FROM STRINGS;



truncate strings;

INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');

SELECT 
TO_NUMBER(COL_STRING,'X')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'X')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'X')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'X')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'X')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'X')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'X')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('-0', '-0', '-0', '-0', '-0', '-0', '-0');

SELECT 
TO_NUMBER(COL_STRING,'-X')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'-X')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'-X')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'-X')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'-X')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'-X')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'-X')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;

INSERT INTO strings VALUES ('-0', '-0', '-0', '-0', '-0', '-0', '-0');

SELECT 
TO_NUMBER(COL_STRING,'X')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'X')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'X')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'X')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'X')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'X')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'X')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate strings;



---，(9G999) 返回指定位置的逗号

select TO_NUMBER('123456','999G999') from dual;
select TO_NUMBER('123456','999G999G') from dual;

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

INSERT INTO strings VALUES ('10000', '10000', '10000','10000', '10000','1','10000');

---指定1个逗号
SELECT 
TO_NUMBER(COL_STRING,'999999G9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'999999G9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'999999G9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'999999G9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'999999G9999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'999999G9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'999999G9999')"COL_CHAR_LENGTH"
FROM STRINGS;

---指定多个逗号
SELECT 
TO_NUMBER(COL_STRING,'9G999G999G999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9G999G999G999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9G999G999G999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9G999G999G999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9G999G999G999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9G999G999G999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9G999G999G999')"COL_CHAR_LENGTH"
FROM STRINGS;

---逗号元素作为数字格式模型的开头
SELECT 
TO_NUMBER(COL_STRING,',999999G9999')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,',999999G9999')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,',999999G9999')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,',999999G9999')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,',999999G9999')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,',999999G9999')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,',999999G9999')"COL_CHAR_LENGTH"
FROM STRINGS;


---在句点的右侧
SELECT 
TO_NUMBER(COL_STRING,'9999999999DG')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999DG')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999DG')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999DG')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999DG')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999DG')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999DG')"COL_CHAR_LENGTH"
FROM STRINGS;

---不在句点的右侧
SELECT 
TO_NUMBER(COL_STRING,'9999999999GD')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999GD')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999GD')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999GD')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999GD')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999GD')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999GD')"COL_CHAR_LENGTH"
FROM STRINGS;

 
---在十进制字符的右侧

SELECT 
TO_NUMBER(COL_STRING,'9999999999G')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999G')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999G')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999G')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999G')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999G')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999G')"COL_CHAR_LENGTH"
FROM STRINGS;

 

----(99D99) 返回小数点，即指定位置的句号(.)
---数字格式模型中指定一个句点
SELECT 
TO_NUMBER(COL_STRING,'9999999999D')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999999999D')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999999999D')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999999999D')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999999999D')"COL_VARCHAR_LENGTH",
TO_NUMBER(COL_CHAR,'9999999999D')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999999999D')"COL_CHAR_LENGTH"
FROM STRINGS;

truncate STRINGS;

INSERT INTO strings VALUES ('100.0', '100.0', '100.0','100.0', '100.0','1','100.0');

SELECT 
TO_NUMBER(COL_STRING,'99999999D9')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'99999999D9')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'99999999D9')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'99999999D9')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'99999999D9')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'99999999D9')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'99999999D9')"COL_CHAR_LENGTH"
FROM STRINGS;



----数字格式模型中指定多个句点

truncate STRINGS;

INSERT INTO strings VALUES ('1000.000.0', '1000.000.0', '1000.000.0','1000.000.0', '1000.000.0','1','1000.000.0');

SELECT 
TO_NUMBER(COL_STRING,'9999D999D9')"COL_STRING",
TO_NUMBER(COL_STRING_LENGTH,'9999D999D9')"COL_STRING_LENGTH",
TO_NUMBER(COL_TEXT,'9999D999D9')"COL_TEXT",
TO_NUMBER(COL_VARCHAR,'9999D999D9')"COL_VARCHAR",
TO_NUMBER(COL_VARCHAR_LENGTH,'9999D999D9')"COL_VARCHAR_LENGTH",
--TO_NUMBER(COL_CHAR,'9999D999D9')"COL_CHAR",
TO_NUMBER(COL_CHAR_LENGTH,'9999D999D9')"COL_CHAR_LENGTH"
FROM STRINGS;

---------------补充case
drop table if exists test_mytab;

CREATE TABLE test_mytab(
a STRING,
b STRING(13),
c TEXT ,
d VARCHAR ,
e CHAR(10)
);

insert into test_mytab values
('1','288.108245','6583471.890037','12000','3688.88'),
('2','388.887540','7911872.930485','15000','2367.77'),
('3','520.131415','9921314.882911','18777','4356.99'),
('-1','-678.289072','-0.013745','-1000000','-88.66'),
('0','0','0','0','0');

CREATE TABLE test_mytab(
a VARCHAR(23),
b VARCHAR(23),
c VARCHAR(23),
d VARCHAR(23),
e CHAR(20)
);

insert into test_mytab values('1','288.108245','6583471.890037','12000','3688.88');
insert into test_mytab values('2','388.887540','7911872.930485','15000','2367.77');
insert into test_mytab values('3','520.131415','9921314.882911','18777','4356.99');
insert into test_mytab values('-1','-678.289072','-0.013745','-1000000','-88.66');
insert into test_mytab values('0','0','0','0','0');


--STRING'999,99'
select a,to_number(a,'999,99') from test_mytab;

--STRING_lengh'999,99'
select b,to_number(b,'999,99') from test_mytab;

---报错
--TEXT'999,99'
select c,to_number(c,'999,99') from test_mytab;
---报错
--VARCHAR'999,99'
select d,to_number(d,'999,99') from test_mytab;

--CHAR'999,99'
select e,to_number(e,'999,99') from test_mytab;

--STRING'999,999'
select a,to_number(a,'999,999') from test_mytab;

--STRING_lengh'999,999'
select b,to_number(b,'999,999') from test_mytab;

--TEXT'999,999'
select c,to_number(c,'999,999') from test_mytab;

--VARCHAR'999,999'
select d,to_number(d,'999,999') from test_mytab;

--CHAR'999,999'
select e,to_number(e,'999,999') from test_mytab;

--STRING',999'
select a,to_number(a,',999') from test_mytab;

--STRING_lengh',999'
select b,to_number(b,',999') from test_mytab;

--TEXT',999'
select c,to_number(c,',999') from test_mytab;

--VARCHAR',999'
select d,to_number(d,',999') from test_mytab;

--CHAR',999'
select e,to_number(e,',999') from test_mytab;

--STRING'9,'
select a,to_number(a,'9,') from test_mytab;

--STRING_lengh'9,'
select b,to_number(b,'9,') from test_mytab;

--TEXT'9,'
select c,to_number(c,'9,') from test_mytab;

--VARCHAR'9,'
select d,to_number(d,'9,') from test_mytab;

--CHAR'9,'
select e,to_number(e,'9,') from test_mytab;

--STRING'999.99'
select a,to_number(a,'999.99') from test_mytab;

--STRING_lengh'999.99'
select b,to_number(b,'999.99') from test_mytab;

--TEXT'999.99'
select c,to_number(c,'999.99') from test_mytab;

--VARCHAR'999.99'
select d,to_number(d,'999.99') from test_mytab;

--CHAR'999.99'
select e,to_number(e,'999.99') from test_mytab;

--STRING'999.999'
select a,to_number(a,'999.999') from test_mytab;

--STRING_lengh'999.999'
select b,to_number(b,'999.999') from test_mytab;

--TEXT'999.999'
select c,to_number(c,'999.999') from test_mytab;

--VARCHAR'999.999'
select d,to_number(d,'999.999') from test_mytab;

--CHAR'999.999'
select e,to_number(e,'999.999') from test_mytab;

--STRING'.999'
select a,to_number(a,'.999') from test_mytab;

--STRING_lengh'.999'
select b,to_number(b,'.999') from test_mytab;

--TEXT'.999'
select c,to_number(c,'.999') from test_mytab;

--VARCHAR'.999'
select d,to_number(d,'.999') from test_mytab;

--CHAR'.999'
select e,to_number(e,'.999') from test_mytab;

--STRING'9.'
select a,to_number(a,'9.') from test_mytab;

--STRING_lengh'9.'
select b,to_number(b,'9.') from test_mytab;

--TEXT'9.'
select c,to_number(c,'9.') from test_mytab;

--VARCHAR'9.'
select d,to_number(d,'9.') from test_mytab;

--CHAR'9.'
select e,to_number(e,'9.') from test_mytab;

--STRING'$999.9900'
select a,to_number(a,'$999.9900') from test_mytab;

--STRING_lengh'$999.9900'
select b,to_number(b,'$999.9900') from test_mytab;

--TEXT'$999.9900'
select c,to_number(c,'$999.9900') from test_mytab;

--VARCHAR'$999.9900'
select d,to_number(d,'$999.9900') from test_mytab;

--CHAR'$999.9900'
select e,to_number(e,'$999.9900') from test_mytab;

--STRING'$000,999,999'
select a,to_number(a,'$000,999,999') from test_mytab;

--STRING_lengh'$000,999,999'
select b,to_number(b,'$000,999,999') from test_mytab;

--TEXT'$000,999,999'
select c,to_number(c,'$000,999,999') from test_mytab;

--VARCHAR'$000,999,999'
select d,to_number(d,'$000,999,999') from test_mytab;

--CHAR'$000,999,999'
select e,to_number(e,'$000,999,999') from test_mytab;

--STRING'$999999'
select a,to_number(a,'$999999') from test_mytab;

--STRING_lengh'$999999'
select b,to_number(b,'$999999') from test_mytab;

--TEXT'$999999'
select c,to_number(c,'$999999') from test_mytab;

--VARCHAR'$999999'
select d,to_number(d,'$999999') from test_mytab;

--CHAR'$999999'
select e,to_number(e,'$999999') from test_mytab;

--STRING'00999.9900'
select a,to_number(a,'00999.9900') from test_mytab;

--STRING_lengh'00999.9900'
select b,to_number(b,'00999.9900') from test_mytab;

--TEXT'00999.9900'
select c,to_number(c,'00999.9900') from test_mytab;

--VARCHAR'00999.9900'
select d,to_number(d,'00999.9900') from test_mytab;

--CHAR'00999.9900'
select e,to_number(e,'00999.9900') from test_mytab;

--STRING'0999,999000'
select a,to_number(a,'0999,999000') from test_mytab;

--STRING_lengh'0999,999000'
select b,to_number(b,'0999,999000') from test_mytab;

--TEXT'0999,999000'
select c,to_number(c,'0999,999000') from test_mytab;

--VARCHAR'0999,999000'
select d,to_number(d,'0999,999000') from test_mytab;

--CHAR'0999,999000'
select e,to_number(e,'0999,999000') from test_mytab;

--STRING'99999900'
select a,to_number(a,'99999900') from test_mytab;

--STRING_lengh'99999900'
select b,to_number(b,'99999900') from test_mytab;

--TEXT'99999900'
select c,to_number(c,'99999900') from test_mytab;

--VARCHAR'99999900'
select d,to_number(d,'99999900') from test_mytab;

--CHAR'99999900'
select e,to_number(e,'99999900') from test_mytab;

--STRING'00999999'
select a,to_number(a,'00999999') from test_mytab;

--STRING_lengh'00999999'
select b,to_number(b,'00999999') from test_mytab;

--TEXT'00999999'
select c,to_number(c,'00999999') from test_mytab;

--VARCHAR'00999999'
select d,to_number(d,'00999999') from test_mytab;

--CHAR'00999999'
select e,to_number(e,'00999999') from test_mytab;

--STRING'999999999'
select a,to_number(a,'999999999') from test_mytab;

--STRING_lengh'999999999'
select b,to_number(b,'999999999') from test_mytab;


--TEXT'999999999'
select c,to_number(c,'999999999') from test_mytab;

--VARCHAR'999999999'
select d,to_number(d,'999999999') from test_mytab;

--CHAR'999999999'
select e,to_number(e,'999999999') from test_mytab;

--STRING'b999999999'
select a,to_number(a,'b999999999') from test_mytab;

--STRING_lengh'b999999999'
select b,to_number(b,'b999999999') from test_mytab;

--TEXT'b999999999'
select c,to_number(c,'b999999999') from test_mytab;

--VARCHAR'b999999999'
select d,to_number(d,'b999999999') from test_mytab;

--CHAR'b999999999'
select e,to_number(e,'b999999999') from test_mytab;

--STRING'c999999999'
select a,to_number(a,'c999999999') from test_mytab;

--STRING_lengh'c999999999'
select b,to_number(b,'c999999999') from test_mytab;

--TEXT'c999999999'
select c,to_number(c,'c999999999') from test_mytab;

--VARCHAR'c999999999'
select d,to_number(d,'c999999999') from test_mytab;

--CHAR'c999999999'
select e,to_number(e,'c999999999') from test_mytab;

--STRING'd999999999'
select a,to_number(a,'d999999999') from test_mytab;

--STRING_lengh'd999999999'
select b,to_number(b,'d999999999') from test_mytab;

--TEXT'd999999999'
select c,to_number(c,'d999999999') from test_mytab;

--VARCHAR'd999999999'
select d,to_number(d,'d999999999') from test_mytab;

--CHAR'd999999999'
select e,to_number(e,'d999999999') from test_mytab;

--STRING'999999.99eeee'
select a,to_number(a,'999999.99eeee') from test_mytab;

--STRING_lengh'999999.99eeee'
select b,to_number(b,'999999.99eeee') from test_mytab;

--TEXT'999999.99eeee'
select c,to_number(c,'999999.99eeee') from test_mytab;

--VARCHAR'999999.99eeee'
select d,to_number(d,'999999.99eeee') from test_mytab;

--CHAR'999999.99eeee'
select e,to_number(e,'999999.99eeee') from test_mytab;

--STRING'9g999g9g9999'
select a,to_number(a,'9g999g9g9999') from test_mytab;

--STRING_lengh'9g999g9g9999'
select b,to_number(b,'9g999g9g9999') from test_mytab;

--TEXT'9g999g9g9999'
select c,to_number(c,'9g999g9g9999') from test_mytab;

--VARCHAR'9g999g9g9999'
select d,to_number(d,'9g999g9g9999') from test_mytab;

--CHAR'9g999g9g9999'
select e,to_number(e,'9g999g9g9999') from test_mytab;

--STRING'g9g999g9g9999'
select a,to_number(a,'g9g999g9g9999') from test_mytab;

--STRING_lengh'g9g999g9g9999'
select b,to_number(b,'g9g999g9g9999') from test_mytab;

--TEXT'g9g999g9g9999'
select c,to_number(c,'g9g999g9g9999') from test_mytab;

--VARCHAR'g9g999g9g9999'
select d,to_number(d,'g9g999g9g9999') from test_mytab;

--CHAR'g9g999g9g9999'
select e,to_number(e,'g9g999g9g9999') from test_mytab;

--STRING'9g999g9g9999g'
select a,to_number(a,'9g999g9g9999g') from test_mytab;

--STRING_lengh'9g999g9g9999g'
select b,to_number(b,'9g999g9g9999g') from test_mytab;

--TEXT'9g999g9g9999g'
select c,to_number(c,'9g999g9g9999g') from test_mytab;

--VARCHAR'9g999g9g9999g'
select d,to_number(d,'9g999g9g9999g') from test_mytab;

--CHAR'9g999g9g9999g'
select e,to_number(e,'9g999g9g9999g') from test_mytab;

--STRING'g9g999g9g9999g'
select a,to_number(a,'g9g999g9g9999g') from test_mytab;

--STRING_lengh'g9g999g9g9999g'
select b,to_number(b,'g9g999g9g9999g') from test_mytab;

--TEXT'g9g999g9g9999g'
select c,to_number(c,'g9g999g9g9999g') from test_mytab;

--VARCHAR'g9g999g9g9999g'
select d,to_number(d,'g9g999g9g9999g') from test_mytab;

--CHAR'g9g999g9g9999g'
select e,to_number(e,'g9g999g9g9999g') from test_mytab;

--STRING'999999999mi'
select a,to_number(a,'999999999mi') from test_mytab;

--STRING_lengh'999999999mi'
select b,to_number(b,'999999999mi') from test_mytab;

--TEXT'999999999mi'
select c,to_number(c,'999999999mi') from test_mytab;

--VARCHAR'999999999mi'
select d,to_number(d,'999999999mi') from test_mytab;

--CHAR'999999999mi'
select e,to_number(e,'999999999mi') from test_mytab;

--STRING'999999999pr'
select a,to_number(a,'999999999pr') from test_mytab;

--STRING_lengh'999999999pr'
select b,to_number(b,'999999999pr') from test_mytab;

--TEXT'999999999pr'
select c,to_number(c,'999999999pr') from test_mytab;

--VARCHAR'999999999pr'
select d,to_number(d,'999999999pr') from test_mytab;

--CHAR'999999999pr'
select e,to_number(e,'999999999pr') from test_mytab;

--STRING'rn'
select a,to_number(a,'rn') from test_mytab;

--STRING_lengh'rn'
select b,to_number(b,'rn') from test_mytab;

--TEXT'rn'
select c,to_number(c,'rn') from test_mytab;

--VARCHAR'rn'
select d,to_number(d,'rn') from test_mytab;

--CHAR'rn'
select e,to_number(e,'rn') from test_mytab;

--STRING's999999999'
select a,to_number(a,'s999999999') from test_mytab;

--STRING_lengh's999999999'
select b,to_number(b,'s999999999') from test_mytab;

--TEXT's999999999'
select c,to_number(c,'s999999999') from test_mytab;

--VARCHAR's999999999'
select d,to_number(d,'s999999999') from test_mytab;

--CHAR's999999999'
select e,to_number(e,'s999999999') from test_mytab;

--STRING'99999v9999'
select a,to_number(a,'99999v9999') from test_mytab;

--STRING_lengh'99999v9999'
select b,to_number(b,'99999v9999') from test_mytab;

--TEXT'99999v9999'
select c,to_number(c,'99999v9999') from test_mytab;

--VARCHAR'99999v9999'
select d,to_number(d,'99999v9999') from test_mytab;

--CHAR'99999v9999'
select e,to_number(e,'99999v9999') from test_mytab;

----不支持
--STRING'fm999999999.9900'
select a,to_number(a,'fm999999999.9900') from test_mytab;

--STRING_lengh'fm999999999.9900'
select b,to_number(b,'fm999999999.9900') from test_mytab;

--TEXT'fm999999999.9900'
select c,to_number(c,'fm999999999.9900') from test_mytab;

--VARCHAR'fm999999999.9900'
select d,to_number(d,'fm999999999.9900') from test_mytab;

--CHAR'fm999999999.9900'
select e,to_number(e,'fm999999999.9900') from test_mytab;



----------------

-------数值类型
drop table if exists numerics1;
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
col_int4 int4
);

insert into numerical values(1,1,1,1,0.1,1,0.1,1,1,1,1,1,0.1,1,0.1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);


select to_number(col_decimal)  from  numerical;
select to_number(col_decimal_length10_0)  from  numerical;
select to_number(col_decimal_length10_2)  from  numerical;
select to_number(col_decimal_length10_3)  from  numerical;
select to_number(col_decimal_length10_10)  from  numerical;
select to_number(col_decimal_length38_0)  from  numerical;
select to_number(col_decimal_length38_38)  from  numerical;
select to_number(col_decimal_length39_0)  from  numerical;
select to_number(col_numeric)  from  numerical;
select to_number(col_numeric_length10_0)  from  numerical;
select to_number(col_numeric_length10_2)  from  numerical;
select to_number(col_numeric_length10_3)  from  numerical;
select to_number(col_numeric_length10_10)  from  numerical;
select to_number(col_numeric_length38_0)  from  numerical;
select to_number(col_numeric_length38_38)  from  numerical;
select to_number(col_numeric_length39_0)  from  numerical;
select to_number(col_float)  from  numerical;
select to_number(col_float_length10_0)  from  numerical;
select to_number(col_float_length38_0)  from  numerical;
select to_number(col_float_length38_38)  from  numerical;
select to_number(col_float_length10_2)  from  numerical;
select to_number(col_float_length10_3)  from  numerical;
select to_number(col_int)  from  numerical;
select to_number(col_integer)  from  numerical;
select to_number(col_int8)  from  numerical;
select to_number(col_int64)  from  numerical;
select to_number(col_bigint)  from  numerical;
select to_number(col_int2)  from  numerical;
select to_number(col_smallint)  from  numerical;
select to_number(col_int4)  from  numerical;

select to_number(cast(col_decimal as string))  from  numerical;
select to_number(cast(col_decimal_length10_0 as string))  from  numerical;
select to_number(cast(col_decimal_length10_2 as string))  from  numerical;
select to_number(cast(col_decimal_length10_3 as string))  from  numerical;
select to_number(cast(col_decimal_length10_10 as string))  from  numerical;
select to_number(cast(col_decimal_length38_0 as string))  from  numerical;
select to_number(cast(col_decimal_length38_38 as string))  from  numerical;
select to_number(cast(col_decimal_length39_0 as string))  from  numerical;
select to_number(cast(col_numeric as string))  from  numerical;
select to_number(cast(col_numeric_length10_0 as string))  from  numerical;
select to_number(cast(col_numeric_length10_2 as string))  from  numerical;
select to_number(cast(col_numeric_length10_3 as string))  from  numerical;
select to_number(cast(col_numeric_length10_10 as string))  from  numerical;
select to_number(cast(col_numeric_length38_0 as string))  from  numerical;
select to_number(cast(col_numeric_length38_38 as string))  from  numerical;
select to_number(cast(col_numeric_length39_0 as string))  from  numerical;
select to_number(cast(col_float as string))  from  numerical;
select to_number(cast(col_float_length10_0 as string))  from  numerical;
select to_number(cast(col_float_length38_0 as string))  from  numerical;
select to_number(cast(col_float_length38_38 as string))  from  numerical;
select to_number(cast(col_float_length10_2 as string))  from  numerical;
select to_number(cast(col_float_length10_3 as string))  from  numerical;
select to_number(cast(col_int as string))  from  numerical;
select to_number(cast(col_integer as string))  from  numerical;
select to_number(cast(col_int8 as string))  from  numerical;
select to_number(cast(col_int64 as string))  from  numerical;
select to_number(cast(col_bigint as string))  from  numerical;
select to_number(cast(col_int2 as string))  from  numerical;
select to_number(cast(col_smallint as string))  from  numerical;
select to_number(cast(col_int4 as string))  from  numerical;

---非数值和字符类型
--array
drop table if exists a;
CREATE TABLE a (b STRING[]);
INSERT INTO a VALUES (ARRAY['123', '123', '123']);
select to_number(b)  from  a;


--bit
drop table if exists b;
CREATE TABLE b (x BIT, y BIT(3), z VARBIT, w VARBIT(3));
INSERT INTO b(x, y, z, w) VALUES (B'1', B'101', B'1', B'1');
select to_number(x)  from  b;
select to_number(y)  from  b;
select to_number(z)  from  b;
select to_number(w)  from  b;

--bool
drop table if exists bool;
CREATE TABLE bool (a INT PRIMARY KEY, b BOOL, c BOOLEAN);
INSERT INTO bool VALUES (12345, true, CAST(0 AS BOOL));
select to_number(a)  from bool;
select to_number(b)  from bool;
select to_number(c)  from bool;

--bytes
drop table if exists bytes;
CREATE TABLE bytes (a INT PRIMARY KEY, b BYTES);
INSERT INTO bytes VALUES (1, b'\141\142\143'), (2, b'\x61\x62\x63'), (3, b'\141\x62\c');
select to_number(a)  from bytes;
select to_number(b)  from bytes;
truncate bytes;
INSERT INTO bytes VALUES (4, '123');
select to_number(a)  from bytes;
select to_number(b)  from bytes;

--string collate en
drop table if exists foo;
CREATE TABLE foo (a STRING COLLATE en PRIMARY KEY);
INSERT INTO foo VALUES ('123' COLLATE en);
select to_number(a)  from foo;

--date
drop table if exists dates;
CREATE TABLE dates (a DATE PRIMARY KEY);
INSERT INTO dates VALUES (DATE '2018-11-02');
select to_number(a)  from dates;

select * from dates;

select to_number(to_char(to_date(a,'YYYY-MM-DD'),'MM'),'99') from dates;
 
select to_number(to_char(to_date('2018-11-02','YYYY-MM-DD'),'MM'),'99') from dual;

--enum
drop TYPE if exists status;
CREATE TYPE status AS ENUM ('123', '456', '789');
SHOW ENUMS;
drop table if exists accounts;
CREATE TABLE accounts (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        balance DECIMAL,
        status status
);
INSERT INTO accounts(balance,status) VALUES (500.50,'123');
SELECT count(*) FROM accounts;
select to_number(id)  from accounts;
select to_number(balance)  from accounts;
select to_number(status)  from accounts;

--inet
drop table if exists computers;
CREATE TABLE computers (
    ip INET PRIMARY KEY
  );
INSERT INTO computers VALUES ('192.168.0.1');
select to_number(ip)  from accounts;
truncate accounts;
INSERT INTO computers VALUES ('192.168.0.2/10');
select to_number(ip)  from accounts;
truncate accounts;
INSERT INTO computers  VALUES ('2001:4f8:3:ba:2e0:81ff:fe22:d1f1/120');
select to_number(ip)  from accounts;
truncate accounts;
 
--interval
drop table if exists intervals1;
CREATE TABLE intervals1 (b INTERVAL);
INSERT INTO  intervals1  VALUES (INTERVAL '1 year 2 months 3 days 4 hours 5 minutes 6 seconds');
select to_number(b)  from intervals1;
truncate intervals1;
INSERT INTO  intervals1  VALUES (INTERVAL '1-2 3 4:5:6');
select to_number(b)  from intervals1;
truncate intervals1;
INSERT INTO  intervals1  VALUES ('1-2 3 4:5:6');
select to_number(b)  from intervals1;
truncate intervals1;

--jsonb
drop table if exists users;
CREATE TABLE users (
    user_profile JSONB
  );
INSERT INTO users (user_profile) VALUES ('{"222": "111", "333": "111", "444": "111", "666" : 547}');
select to_number(user_profile)  from users;

--serial
drop table if exists serial1;
CREATE TABLE serial1 (a SERIAL );
INSERT INTO serial1 (a) VALUES (123);
select to_number(a)  from serial1;
truncate serial1;
INSERT INTO serial1 (a) VALUES ('123');
select to_number(a)  from serial1;
truncate serial1;

--time
drop table if exists time1;
CREATE TABLE time1(time_val TIME);
INSERT INTO time1 VALUES (TIME '05:40:00');
select * from time1;
select to_number(time_val)  from time1;



--timestamp
drop table if exists timestamps_test;
CREATE TABLE timestamps_test (b TIMESTAMPTZ);
INSERT INTO timestamps_test VALUES (TIMESTAMPTZ '2016-03-26 10:10:10-05:00');
select * from timestamps_test;
select to_number(b)  from timestamps_test;

--uuid
drop table if exists v;
CREATE TABLE v (token uuid);
INSERT INTO v VALUES ('63616665-6630-3064-6465-616462656562');
SELECT * FROM v;
select to_number(token)  from v;
truncate v;
INSERT INTO v VALUES ('63616665663030646465616462656562');
SELECT * FROM v;
select to_number(token)  from v;


--查询
----where
drop TABLE if exists STRINGS;
CREATE TABLE STRINGS (
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10) ,
col_CHAR CHAR, 
col_CHAR_length CHAR(10)
);

INSERT INTO strings VALUES ('aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'aaaaaaaa', 'a', 'aaaaaaaa');
INSERT INTO strings VALUES ('0A', '0A', '0A', '0A', '0A', 'A', '0A');

SELECT * FROM STRINGS where
to_number(col_string,'XX')=2863311530 and
to_number(col_string_length,'XX')=2863311530 and
to_number(col_text,'XX')=2863311530 and
to_number(col_varchar,'XX')=2863311530 and
to_number(col_varchar_length,'XX')=2863311530 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=2863311530;

SELECT * FROM STRINGS where
(to_number(col_string,'XX')=10 and
to_number(col_string_length,'XX')=10 and
to_number(col_text,'XX')=10 and
to_number(col_varchar,'XX')=10 and
to_number(col_varchar_length,'XX')=10 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=10) or (to_number(col_string,'XX')=2863311530 and
to_number(col_string_length,'XX')=2863311530 and
to_number(col_text,'XX')=2863311530 and
to_number(col_varchar,'XX')=2863311530 and
to_number(col_varchar_length,'XX')=2863311530 and
to_number(col_char,'XX')=10 and
to_number(col_char_length,'XX')=2863311530);

truncate STRINGS;

INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
INSERT INTO strings VALUES ('100.000 ', '100.000 ', '100.000 ', '100.000 ', '100.000 ', '1', '100.000 ');

SELECT * FROM STRINGS where
to_number(col_string)=123 and
to_number(col_string_length)=123 and
to_number(col_text)=123 and
to_number(col_varchar)=123 and
to_number(col_varchar_length)=123 and
to_number(col_char)=1 and
to_number(col_char_length)=123;


SELECT * FROM STRINGS where
to_number(col_string)=100 and
to_number(col_string_length)=100 and
to_number(col_text)=100 and
to_number(col_varchar)=100 and
to_number(col_varchar_length)=100 and
to_number(col_char)=1 and
to_number(col_char_length)=100;

SELECT * FROM STRINGS where to_number(col_string)=100 ;     -------R-326
SELECT * FROM STRINGS where to_number(col_string_length)=100 ;  -------R-326
SELECT * FROM STRINGS where to_number(col_text)=100 ;  -------R-326
SELECT * FROM STRINGS where to_number(col_varchar)=100 ;  -------R-326
SELECT * FROM STRINGS where to_number(col_varchar_length)=100 ;  -------R-326
 
truncate STRINGS;

INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');
INSERT INTO strings VALUES ('-100.000 ', '-100.000 ', '-100.000 ', '-100.000 ', '-100.000 ', '1', '-100.000 ');

SELECT * FROM STRINGS where
to_number(col_string)=-123 and
to_number(col_string_length)=-123 and
to_number(col_text)=-123 and
to_number(col_varchar)=-123 and
to_number(col_varchar_length)=-123 and
to_number(col_char)=1 and
to_number(col_char_length)=-123;


SELECT * FROM STRINGS where
to_number(col_string)=-100 and
to_number(col_string_length)=-100 and
to_number(col_text)=-100 and
to_number(col_varchar)=-100 and
to_number(col_varchar_length)=-100 and
to_number(col_char)=1 and
to_number(col_char_length)=-100;

SELECT * FROM STRINGS where to_number(col_string)=-100 ;      
SELECT * FROM STRINGS where to_number(col_string_length)=-100 ;   
SELECT * FROM STRINGS where to_number(col_text)=-100 ;  
SELECT * FROM STRINGS where to_number(col_varchar)=-100 ;   
SELECT * FROM STRINGS where to_number(col_varchar_length)=-100 ;   
SELECT * FROM STRINGS where to_number(col_char_length)=-100 ;   

SELECT to_number(col_string)  FROM STRINGS;
SELECT to_number(col_string_length)  FROM STRINGS;
SELECT to_number(col_text)  FROM STRINGS;
SELECT to_number(col_varchar)  FROM STRINGS;
SELECT to_number(col_varchar_length)  FROM STRINGS;
SELECT to_number(col_char_length)  FROM STRINGS;

select to_number('-100.000') from dual;

truncate STRINGS;


----order by
INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');
INSERT INTO strings VALUES ('-456', '-456', '-456', '-456', '-456', '1', '-456');
INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
INSERT INTO strings VALUES ('456', '456', '456', '456', '456', '1', '456');
INSERT INTO strings VALUES ('1', '1', '1', '1', '1', '1', '1');
INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');

SELECT to_number(col_string)  FROM STRINGS order by to_number(col_string) ;
SELECT to_number(col_string_length)  FROM STRINGS order by to_number(col_string_length) ;
SELECT to_number(col_text)  FROM STRINGS order by to_number(col_text) ;
SELECT to_number(col_varchar)  FROM STRINGS order by to_number(col_varchar) ;
SELECT to_number(col_varchar_length)  FROM STRINGS order by to_number(col_varchar_length) ;
SELECT to_number(col_char_length)  FROM STRINGS order by to_number(col_char_length) ;

SELECT to_number(col_string)  FROM STRINGS order by col_string;
SELECT to_number(col_string_length)  FROM STRINGS order by col_string_length;
SELECT to_number(col_text)  FROM STRINGS order by col_text;
SELECT to_number(col_varchar)  FROM STRINGS order by col_varchar;
SELECT to_number(col_varchar_length)  FROM STRINGS order by col_varchar_length;
SELECT to_number(col_char_length)  FROM STRINGS order by col_char_length;

SELECT to_number(col_string)  FROM STRINGS order by col_string;
SELECT to_number(col_string_length)  FROM STRINGS order by col_string;
SELECT to_number(col_text)  FROM STRINGS order by col_string;
SELECT to_number(col_varchar)  FROM STRINGS order by col_string;
SELECT to_number(col_varchar_length)  FROM STRINGS order by col_string;
SELECT to_number(col_char_length)  FROM STRINGS order by col_string;

truncate STRINGS;

----join
INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');
INSERT INTO strings VALUES ('-456', '-456', '-456', '-456', '-456', '1', '-456');
INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
INSERT INTO strings VALUES ('456', '456', '456', '456', '456', '1', '456');
INSERT INTO strings VALUES ('1', '1', '1', '1', '1', '1', '1');
INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');

drop table if exists STRINGS1;
CREATE TABLE STRINGS1 (
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10) ,
col_CHAR CHAR, 
col_CHAR_length CHAR(10)
);

INSERT INTO strings1 VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');

--INNER JOIN
SELECT  to_number(STRINGS.col_string)"STRINGS.col_string" ,to_number(STRINGS1.col_string)"STRINGS1.col_string" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_string= STRINGS1.col_string;
SELECT  to_number(STRINGS.col_string_length)"STRINGS.col_string_length" ,to_number(STRINGS1.col_string_length)"STRINGS1.col_string_length" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_string_length= STRINGS1.col_string_length;
SELECT  to_number(STRINGS.col_text)"STRINGS.col_text" ,to_number(STRINGS1.col_text)"STRINGS1.col_text" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_text= STRINGS1.col_text;
SELECT  to_number(STRINGS.col_varchar)"STRINGS.col_varchar" ,to_number(STRINGS1.col_varchar)"STRINGS1.col_varchar" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_varchar= STRINGS1.col_varchar;
SELECT  to_number(STRINGS.col_varchar_length)"STRINGS.col_varchar_length" ,to_number(STRINGS1.col_varchar_length)"STRINGS1.col_varchar_length" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_varchar_length= STRINGS1.col_varchar_length;
SELECT  to_number(STRINGS.col_char_length)"STRINGS.col_char_length" ,to_number(STRINGS1.col_char_length)"STRINGS1.col_char_length" FROM STRINGS INNER JOIN strings1 ON STRINGS.col_char_length= STRINGS1.col_char_length;

--join
SELECT  to_number(STRINGS.col_string)"STRINGS.col_string" ,to_number(STRINGS1.col_string)"STRINGS1.col_string" FROM STRINGS  JOIN strings1 ON STRINGS.col_string= STRINGS1.col_string;
SELECT  to_number(STRINGS.col_string_length)"STRINGS.col_string_length" ,to_number(STRINGS1.col_string_length)"STRINGS1.col_string_length" FROM STRINGS  JOIN strings1 ON STRINGS.col_string_length= STRINGS1.col_string_length;
SELECT  to_number(STRINGS.col_text)"STRINGS.col_text" ,to_number(STRINGS1.col_text)"STRINGS1.col_text" FROM STRINGS  JOIN strings1 ON STRINGS.col_text= STRINGS1.col_text;
SELECT  to_number(STRINGS.col_varchar)"STRINGS.col_varchar" ,to_number(STRINGS1.col_varchar)"STRINGS1.col_varchar" FROM STRINGS  JOIN strings1 ON STRINGS.col_varchar= STRINGS1.col_varchar;
SELECT  to_number(STRINGS.col_varchar_length)"STRINGS.col_varchar_length" ,to_number(STRINGS1.col_varchar_length)"STRINGS1.col_varchar_length" FROM STRINGS  JOIN strings1 ON STRINGS.col_varchar_length= STRINGS1.col_varchar_length;
SELECT  to_number(STRINGS.col_char_length)"STRINGS.col_char_length" ,to_number(STRINGS1.col_char_length)"STRINGS1.col_char_length" FROM STRINGS  JOIN strings1 ON STRINGS.col_char_length= STRINGS1.col_char_length;

--LEFT JOIN

SELECT  to_number(STRINGS.col_string)"STRINGS.col_string" ,to_number(STRINGS1.col_string)"STRINGS1.col_string" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_string= STRINGS1.col_string;
SELECT  to_number(STRINGS.col_string_length)"STRINGS.col_string_length" ,to_number(STRINGS1.col_string_length)"STRINGS1.col_string_length" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_string_length= STRINGS1.col_string_length;
SELECT  to_number(STRINGS.col_text)"STRINGS.col_text" ,to_number(STRINGS1.col_text)"STRINGS1.col_text" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_text= STRINGS1.col_text;
SELECT  to_number(STRINGS.col_varchar)"STRINGS.col_varchar" ,to_number(STRINGS1.col_varchar)"STRINGS1.col_varchar" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_varchar= STRINGS1.col_varchar;
SELECT  to_number(STRINGS.col_varchar_length)"STRINGS.col_varchar_length" ,to_number(STRINGS1.col_varchar_length)"STRINGS1.col_varchar_length" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_varchar_length= STRINGS1.col_varchar_length;
SELECT  to_number(STRINGS.col_char_length)"STRINGS.col_char_length" ,to_number(STRINGS1.col_char_length)"STRINGS1.col_char_length" FROM STRINGS  LEFT JOIN strings1 ON STRINGS.col_char_length= STRINGS1.col_char_length;

--RIGHT JOIN

SELECT  to_number(STRINGS.col_string)"STRINGS.col_string" ,to_number(STRINGS1.col_string)"STRINGS1.col_string" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_string= STRINGS1.col_string;
SELECT  to_number(STRINGS.col_string_length)"STRINGS.col_string_length" ,to_number(STRINGS1.col_string_length)"STRINGS1.col_string_length" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_string_length= STRINGS1.col_string_length;
SELECT  to_number(STRINGS.col_text)"STRINGS.col_text" ,to_number(STRINGS1.col_text)"STRINGS1.col_text" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_text= STRINGS1.col_text;
SELECT  to_number(STRINGS.col_varchar)"STRINGS.col_varchar" ,to_number(STRINGS1.col_varchar)"STRINGS1.col_varchar" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_varchar= STRINGS1.col_varchar;
SELECT  to_number(STRINGS.col_varchar_length)"STRINGS.col_varchar_length" ,to_number(STRINGS1.col_varchar_length)"STRINGS1.col_varchar_length" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_varchar_length= STRINGS1.col_varchar_length;
SELECT  to_number(STRINGS.col_char_length)"STRINGS.col_char_length" ,to_number(STRINGS1.col_char_length)"STRINGS1.col_char_length" FROM STRINGS  RIGHT JOIN strings1 ON STRINGS.col_char_length= STRINGS1.col_char_length;

 
--FULL OUTER JOIN

SELECT  to_number(STRINGS.col_string)"STRINGS.col_string" ,to_number(STRINGS1.col_string)"STRINGS1.col_string" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_string= STRINGS1.col_string;
SELECT  to_number(STRINGS.col_string_length)"STRINGS.col_string_length" ,to_number(STRINGS1.col_string_length)"STRINGS1.col_string_length" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_string_length= STRINGS1.col_string_length;
SELECT  to_number(STRINGS.col_text)"STRINGS.col_text" ,to_number(STRINGS1.col_text)"STRINGS1.col_text" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_text= STRINGS1.col_text;
SELECT  to_number(STRINGS.col_varchar)"STRINGS.col_varchar" ,to_number(STRINGS1.col_varchar)"STRINGS1.col_varchar" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_varchar= STRINGS1.col_varchar;
SELECT  to_number(STRINGS.col_varchar_length)"STRINGS.col_varchar_length" ,to_number(STRINGS1.col_varchar_length)"STRINGS1.col_varchar_length" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_varchar_length= STRINGS1.col_varchar_length;
SELECT  to_number(STRINGS.col_char_length)"STRINGS.col_char_length" ,to_number(STRINGS1.col_char_length)"STRINGS1.col_char_length" FROM STRINGS  FULL OUTER JOIN strings1 ON STRINGS.col_char_length= STRINGS1.col_char_length;

----union all\union

SELECT to_number(col_string)  FROM STRINGS union all SELECT to_number(col_string)  FROM STRINGS1;
SELECT to_number(col_string_length)  FROM STRINGS union all SELECT to_number(col_string_length)  FROM STRINGS1;
SELECT to_number(col_text)  FROM STRINGS union all SELECT to_number(col_text)  FROM STRINGS1;
SELECT to_number(col_varchar)  FROM STRINGS union all SELECT to_number(col_varchar)  FROM STRINGS1;
SELECT to_number(col_varchar_length)  FROM STRINGS union all SELECT to_number(col_varchar_length)  FROM STRINGS1;
SELECT to_number(col_char_length)  FROM STRINGS union all SELECT to_number(col_char_length)  FROM STRINGS1;


SELECT to_number(col_string)  FROM STRINGS union  SELECT to_number(col_string)  FROM STRINGS1;
SELECT to_number(col_string_length)  FROM STRINGS union  SELECT to_number(col_string_length)  FROM STRINGS1;
SELECT to_number(col_text)  FROM STRINGS union  SELECT to_number(col_text)  FROM STRINGS1;
SELECT to_number(col_varchar)  FROM STRINGS union  SELECT to_number(col_varchar)  FROM STRINGS1;
SELECT to_number(col_varchar_length)  FROM STRINGS union  SELECT to_number(col_varchar_length)  FROM STRINGS1;
SELECT to_number(col_char_length)  FROM STRINGS union  SELECT to_number(col_char_length)  FROM STRINGS1;

----except

SELECT to_number(col_string)  FROM STRINGS except  SELECT to_number(col_string)  FROM STRINGS1;
SELECT to_number(col_string_length)  FROM STRINGS except  SELECT to_number(col_string_length)  FROM STRINGS1;
SELECT to_number(col_text)  FROM STRINGS except  SELECT to_number(col_text)  FROM STRINGS1;
SELECT to_number(col_varchar)  FROM STRINGS except  SELECT to_number(col_varchar)  FROM STRINGS1;
SELECT to_number(col_varchar_length)  FROM STRINGS except  SELECT to_number(col_varchar_length)  FROM STRINGS1;
SELECT to_number(col_char_length)  FROM STRINGS except  SELECT to_number(col_char_length)  FROM STRINGS1;


----intersect

SELECT to_number(col_string)  FROM STRINGS intersect  SELECT to_number(col_string)  FROM STRINGS1;
SELECT to_number(col_string_length)  FROM STRINGS intersect  SELECT to_number(col_string_length)  FROM STRINGS1;
SELECT to_number(col_text)  FROM STRINGS intersect  SELECT to_number(col_text)  FROM STRINGS1;
SELECT to_number(col_varchar)  FROM STRINGS intersect  SELECT to_number(col_varchar)  FROM STRINGS1;
SELECT to_number(col_varchar_length)  FROM STRINGS intersect  SELECT to_number(col_varchar_length)  FROM STRINGS1;
SELECT to_number(col_char_length)  FROM STRINGS intersect  SELECT to_number(col_char_length)  FROM STRINGS1;

truncate STRINGS;


----distinct
INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');
INSERT INTO strings VALUES ('-456', '-456', '-456', '-456', '-456', '1', '-456');
INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
INSERT INTO strings VALUES ('456', '456', '456', '456', '456', '1', '456');
INSERT INTO strings VALUES ('1', '1', '1', '1', '1', '1', '1');
INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');
INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');
INSERT INTO strings VALUES ('-456', '-456', '-456', '-456', '-456', '1', '-456');
INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
INSERT INTO strings VALUES ('456', '456', '456', '456', '456', '1', '456');
INSERT INTO strings VALUES ('1', '1', '1', '1', '1', '1', '1');
INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');

SELECT distinct to_number(col_string)  FROM STRINGS;
SELECT distinct to_number(col_string_length)  FROM STRINGS;
SELECT distinct to_number(col_text)  FROM STRINGS;
SELECT distinct to_number(col_varchar)  FROM STRINGS;
SELECT distinct to_number(col_varchar_length)  FROM STRINGS;
SELECT distinct to_number(col_char_length)  FROM STRINGS;

--function
----to_char()

SELECT to_char(to_number(col_string))  FROM STRINGS;
SELECT to_char(to_number(col_string_length))  FROM STRINGS;
SELECT to_char(to_number(col_text))  FROM STRINGS;
SELECT to_char(to_number(col_varchar))  FROM STRINGS;
SELECT to_char(to_number(col_varchar_length))  FROM STRINGS;
SELECT to_char(to_number(col_char_length))  FROM STRINGS;

SELECT to_number(to_char(to_number(col_string)))  FROM STRINGS;
SELECT to_number(to_char(to_number(col_string_length)))  FROM STRINGS;
SELECT to_number(to_char(to_number(col_text)))  FROM STRINGS;
SELECT to_number(to_char(to_number(col_varchar)))  FROM STRINGS;
SELECT to_number(to_char(to_number(col_varchar_length)))  FROM STRINGS;
SELECT to_number(to_char(to_number(col_char_length)))  FROM STRINGS;

SELECT to_number(to_number(to_char(to_number(col_string))))  FROM STRINGS;
SELECT to_number(to_number(to_char(to_number(col_string_length))))  FROM STRINGS;
SELECT to_number(to_number(to_char(to_number(col_text))))  FROM STRINGS;
SELECT to_number(to_number(to_char(to_number(col_varchar))))  FROM STRINGS;
SELECT to_number(to_number(to_char(to_number(col_varchar_length))))  FROM STRINGS;
SELECT to_number(to_number(to_char(to_number(col_char_length))))  FROM STRINGS;

SELECT to_number(to_char(col_string))  FROM STRINGS;
SELECT to_number(to_char(col_string_length))  FROM STRINGS;
SELECT to_number(to_char(col_text))  FROM STRINGS;
SELECT to_number(to_char(col_varchar))  FROM STRINGS;
SELECT to_number(to_char(col_varchar_length))  FROM STRINGS;
SELECT to_number(to_char(col_char_length))  FROM STRINGS;


----avg ()
SELECT avg(to_number(col_string))  FROM STRINGS;
SELECT avg(to_number(col_string_length))  FROM STRINGS;
SELECT avg(to_number(col_text))  FROM STRINGS;
SELECT avg(to_number(col_varchar))  FROM STRINGS;
SELECT avg(to_number(col_varchar_length))  FROM STRINGS;
SELECT avg(to_number(col_char_length))  FROM STRINGS;


----count()
SELECT count(to_number(col_string))  FROM STRINGS;
SELECT count(to_number(col_string_length))  FROM STRINGS;
SELECT count(to_number(col_text))  FROM STRINGS;
SELECT count(to_number(col_varchar))  FROM STRINGS;
SELECT count(to_number(col_varchar_length))  FROM STRINGS;
SELECT count(to_number(col_char_length))  FROM STRINGS;


----min ()

SELECT min(to_number(col_string))  FROM STRINGS;
SELECT min(to_number(col_string_length))  FROM STRINGS;
SELECT min(to_number(col_text))  FROM STRINGS;
SELECT min(to_number(col_varchar))  FROM STRINGS;
SELECT min(to_number(col_varchar_length))  FROM STRINGS;
SELECT min(to_number(col_char_length))  FROM STRINGS;

----max()
SELECT max(to_number(col_string))  FROM STRINGS;
SELECT max(to_number(col_string_length))  FROM STRINGS;
SELECT max(to_number(col_text))  FROM STRINGS;
SELECT max(to_number(col_varchar))  FROM STRINGS;
SELECT max(to_number(col_varchar_length))  FROM STRINGS;
SELECT max(to_number(col_char_length))  FROM STRINGS;

----concat()
---报错
SELECT concat(to_number(col_string),to_number(col_string))  FROM STRINGS;
SELECT concat(to_number(col_string_length),to_number(col_string))  FROM STRINGS;
SELECT concat(to_number(col_text),to_number(col_string))  FROM STRINGS;
SELECT concat(to_number(col_varchar),to_number(col_string))  FROM STRINGS;
SELECT concat(to_number(col_varchar_length),to_number(col_string))  FROM STRINGS;
SELECT concat(to_number(col_char_length),to_number(col_string))  FROM STRINGS;
----abs()
SELECT ABS(to_number(col_string))  FROM STRINGS;
SELECT ABS(to_number(col_string_length))  FROM STRINGS;
SELECT ABS(to_number(col_text))  FROM STRINGS;
SELECT ABS(to_number(col_varchar))  FROM STRINGS;
SELECT ABS(to_number(col_varchar_length))  FROM STRINGS;
SELECT ABS(to_number(col_char_length))  FROM STRINGS;


----to_date()
drop table if exists dates;
create table dates (a date);
INSERT INTO dates VALUES (date '2021-10-21'),(date '2021-10-22'),(date '2021-10-23'),(date '2021-10-24'),(date '2021-10-25'),(date '2021-10-26'),(date '2021-10-26');
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'MM'),'99') from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'DD'),'99') from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'YY'),'99') from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'YYYY'),'99') from dates;

select to_number(to_char(to_date(a,'YYYY-MM-DD'),'MM')) from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'DD')) from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'YY')) from dates;
select to_number(to_char(to_date(a,'YYYY-MM-DD'),'YYYY')) from dates;


select to_number(to_char(to_date('2021-10-21','YYYY-MM-DD'),'MM'),'99') from dual;
select to_number(to_char(to_date('2021-10-21','YYYY-MM-DD'),'DD'),'99') from dual;
select to_number(to_char(to_date('2023-10-21','YYYY-MM-DD'),'YY'),'99') from dual;
select to_number(to_char(to_date('2021-10-21','YYYY-MM-DD'),'YYYY'),'99') from dual;


----ceil()
SELECT ceil(to_number(col_string))  FROM STRINGS;
SELECT ceil(to_number(col_string_length))  FROM STRINGS;
SELECT ceil(to_number(col_text))  FROM STRINGS;
SELECT ceil(to_number(col_varchar))  FROM STRINGS;
SELECT ceil(to_number(col_varchar_length))  FROM STRINGS;
SELECT ceil(to_number(col_char_length))  FROM STRINGS;


----sum()
SELECT SUM(to_number(col_string))  FROM STRINGS;
SELECT SUM(to_number(col_string_length))  FROM STRINGS;
SELECT SUM(to_number(col_text))  FROM STRINGS;
SELECT SUM(to_number(col_varchar))  FROM STRINGS;
SELECT SUM(to_number(col_varchar_length))  FROM STRINGS;
SELECT SUM(to_number(col_char_length))  FROM STRINGS;

----nvl()

drop TABLE if exists STRINGS;
CREATE TABLE STRINGS (
col_STRING STRING , 
col_STRING_length STRING(10), 
col_text TEXT ,
col_VARCHAR VARCHAR ,
col_VARCHAR_length VARCHAR(10) ,
col_CHAR CHAR, 
col_CHAR_length CHAR(10)
);
INSERT INTO strings VALUES ('', '', '', '', '', '', '');

SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

truncate strings;
INSERT INTO strings VALUES ('-123', '-123', '-123', '-123', '-123', '1', '-123');

SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

INSERT INTO strings VALUES ('-456', '-456', '-456', '-456', '-456', '1', '-456');
SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

truncate strings;
INSERT INTO strings VALUES ('123', '123', '123', '123', '123', '1', '123');
SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

truncate strings;
INSERT INTO strings VALUES ('456', '456', '456', '456', '456', '1', '456');
SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

truncate strings;
INSERT INTO strings VALUES ('1', '1', '1', '1', '1', '1', '1');
SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;

truncate strings;
INSERT INTO strings VALUES ('0', '0', '0', '0', '0', '0', '0');
SELECT NVL(to_number(col_string),1)  FROM STRINGS;
SELECT NVL(to_number(col_STRING_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_text),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_VARCHAR_length),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR),1)  FROM STRINGS;
SELECT NVL(to_number(col_CHAR_length),1)  FROM STRINGS;
truncate strings;

drop table if exists test_mytab;
drop table if exists numerics1;
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
drop TABLE if exists STRINGS;
drop TYPE if exists status;
