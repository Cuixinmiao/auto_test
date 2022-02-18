-- rownum test for v9.0.0-beta.1.xTP
-- Author: cuixiangling
-- Date: 2021/08/24

-- generate data
drop table if exists t1;
create table t1(a int,b varchar(10));
insert into t1 values(1,'abc');
insert into t1 values(5,'dfc');
insert into t1 values(8,'ghtr');
insert into t1 values(2,'daes');

drop table if exists t2;
create table t2(c int,d varchar(10));
insert into t2 values(1,'abc');
insert into t2 values(15,'dfc');
insert into t2 values(8,'dfhtr');
insert into t2 values(2,'ddes');

-- 使用比较类型 >, >= ,< ,<= ,!= ,between and，in，not in
-- 整数值：负值，0，1和大于1的值
-- 带有小数的值，例如-0.1，0.0，1.0，1.5等
-- 字符串和特殊符号：例如'12','000','abc','13ab','%'等
-- 包含null或者NULL
select * from t1 where rownum >0;
select * from t1 where rownum >1;
select * from t1 where rownum >-1;
select * from t1 where rownum >3;
select * from t1 where rownum >10;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >-0.1;
select * from t1 where rownum >0.0; 
select * from t1 where rownum >-1.0;
select * from t1 where rownum >1.0;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >0.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >1.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >10.8;
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >'0';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >'000';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >'-1';
select * from t1 where rownum >'12';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >'abcd';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >'13ab';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >'%%%&';
select * from t1 where rownum >null;
select * from t1 where rownum >NULL;
insert into t1 values(null,null);
select * from t1 where rownum >null;
select * from t1 where rownum >NULL;


select * from t1 where rownum >=0;
select * from t1 where rownum >=1;
select * from t1 where rownum >=-1;
select * from t1 where rownum >=3;
select * from t1 where rownum >=10;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >=-0.1;
select * from t1 where rownum >=0.0;
select * from t1 where rownum >=-1.0;
select * from t1 where rownum >=1.0;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >=0.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >=1.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum >=10.8;
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >='0';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >='000';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum >='-1';
select * from t1 where rownum >='12';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >='abcd';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >='13ab';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum >='%%%&';
select * from t1 where rownum >=null;
select * from t1 where rownum >=NULL;
select * from t1 where rownum >=0.000000;

-- qianbase has an ERROR: negative value for LIMIT,oracle is ok
select * from t1 where rownum <0;
select * from t1 where rownum <1;
-- qianbase has an ERROR: negative value for LIMIT,oracle is ok
select * from t1 where rownum <-1;
select * from t1 where rownum <3;
select * from t1 where rownum <10;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum <-0.1;
-- qianbase has an ERROR: negative value for LIMIT,oracle is ok
select * from t1 where rownum <0.0;
-- qianbase has an ERROR: negative value for LIMIT,oracle is ok
select * from t1 where rownum <-1.0;
select * from t1 where rownum <1.0;

-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum <0.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum <1.5;
-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum <10.8;

-- qianbase has no data set,oracle has data set
select * from t1 where rownum <'0';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum <'000';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum <'-1';
-- qianbase has no data set,oracle has data set
select * from t1 where rownum <'12';

-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum <'abcd';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum <'13ab';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum <'%%%&';
select * from t1 where rownum <null;
select * from t1 where rownum <NULL;


select * from t1 where rownum <=0;
select * from t1 where rownum <=1;
select * from t1 where rownum <=-1;
select * from t1 where rownum <=3;
select * from t1 where rownum <=10;
select * from t1 where rownum <=1.0;
-- qianbase has no data set,oracle has data set
select * from t1 where rownum <='12';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum <='%%%&';
select * from t1 where rownum <=null;
select * from t1 where rownum <=NULL;


select * from t1 where rownum != 5;
-- qianbase expect same as oracle
select * from t1 where rownum != 0;
select * from t1 where rownum != 1;
-- qianbase expect same as oracle
select * from t1 where rownum != -1;
select * from t1 where rownum != 1.0;
select * from t1 where rownum != 10000000;
select * from t1 where rownum != 100000000000000;

-- qianbase has a syntax error,oracle is ok
select * from t1 where rownum != 0.5;
-- qianbase expect same as oracle
select * from t1 where rownum != -5;
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum != 'abc';
-- qianbase has no result set, oracle has all data set
select * from t1 where rownum != '0';
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum != '^%#';
select * from t1 where rownum != null;
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum != '12';

-- qianbase has ERROR: row_number(): window functions are not allowed in WHERE, oracle is ok
select * from t1 where rownum like 12;
select * from t1 where rownum like '1%';

select * from t1 where rownum between -1 and 5;
select * from t1 where rownum between -1 and 0;
select * from t1 where rownum between -1 and 1;
-- qianbase has ERROR: negative value for LIMIT, oracle is ok
select * from t1 where rownum between -10 and -5;
select * from t1 where rownum between 0 and 3;
select * from t1 where rownum between 1 and 3;
select * from t1 where rownum between 0 and 5;
select * from t1 where rownum between 1 and 5;
select * from t1 where rownum between 0 and 10000;
select * from t1 where rownum between 1 and 10000;
-- below three rows has error on the oracle,qianbase is ok(no result set)
select * from t1 where rownum between 'a' and 'c';
select * from t1 where rownum between b'01' and b'0110';
select * from t1 where rownum between B'01' and B'0110';

-- qianbase has an syntax error, oracle is ok
select * from t1 where rownum between 0.5 and 5;
-- qianbase has an syntax error, oracle is ok
select * from t1 where rownum between 0 and 5.5;
-- qianbase has an ERROR: argument of LIMIT must be type int, not type decimal, oracle is ok
select * from t1 where rownum between 0.5 and 5.5;
select * from t1 where rownum between -0.0 and 5;
select * from t1 where rownum between 00 and 1;
select * from t1 where rownum between 1.0 and 5;
select * from t1 where rownum between 1.0 and 5.0;
-- qianbase is ok, oracle has error for invalid number
select * from t1 where rownum between '%' and '&&';

-- below three rows has error on the qianbase, oracle is ok for the below two rows(the last is error)
select * from t1 where rownum between to_number('01','xx') and to_number('011','xxx');
select * from t1 where rownum between cast(0 as int) and cast(5 as int);
select * from t1 where rownum between 0::int and 5::int;

-- qianbase unsupport the in clause,has error for ERROR: unsupported comparison operator: row_number() oracle is ok
select * from t1 where rownum in (1,2,3,4);
select * from t1 where rownum in (-1,2,3,null);
select * from t1 where rownum in (1,2,3,null);
select * from t1 where rownum not in (1,2,3,4);
select * from t1 where rownum not in (-1,2,3,null);
select * from t1 where rownum not in (1,2,3,null);

-- 判断值为表达式
-- qianbase has error ERROR: row_number(): window functions are not allowed in WHERE,oracle is ok
select * from t1 where rownum+3 <10;
-- qianbase has no result set on the below slause,oracle has result set
select * from t1 where rownum <a;
select * from t1 where rownum < a+3;

-- 多个rownum
-- qianbase has syntax error, oracle is ok
select * from t1 where rownum<10 and rownum>0;
select a,b from( select a,b,rownum as rm from t1) aa where rm>2 and rm <10;
select a,b from( select *,rownum as rm from t1) aa where rm>2 and rm <10;
select * from( select a,b,rownum as rm from t1) aa where rm>2 and rm <10;


-- 和limit offset一起使用
-- qianbase has syntax error, oracle is ok
select rownum, * from t1 where rownum < 10 limit 3;
select * from (select rownum, * from t1 where rownum < 10)aa limit 3;

-- rownum出现在投影列中
-- rownum单独使用
-- 查看输出的字段名是否为rownum
select rownum from t1;
select rownum from t1 where rownum<10;
select rownum from t1 where rownum<1;
select rownum from t1 where rownum<0;
select rownum from t1 where rownum<=10;
select rownum from t1 where rownum<=1;
select rownum from t1 where rownum<=0;

-- rownum作为函数的入参，例如sum（rownum）
-- qianbase has ERROR: sum(): row_number(): window functions are not allowed in aggregate, oracle is ok
select sum(rownum) from t1 where rownum<10;
select substr('abc',rownum,3) from t1 where rownum<10;
select substr('abc',rownum,3) from t1 where rownum<3;
select lpad('ab',rownum) from t1 where rownum <10;


-- rownum在表达式中使用 +，-，*，/，||，&，&&等
select rownum+1 from  t1 where rownum<10;
select rownum+1 from  t1 where rownum<10;
select rownum/2 from  t1 where rownum<10;
select rownum*0 from  t1 where rownum<10;
select rownum/0 from  t1 where rownum<10;
select rownum*0.5 from  t1 where rownum<10;
select rownum+0.5 from  t1 where rownum<10;
-- qianbase has an ERROR: unsupported binary operator: <int> || <decimal>,oracle is ok,same as +
select rownum||0.5 from  t1 where rownum<10;
select rownum||'abc' from  t1 where rownum<10;
select rownum||'0.5' from  t1 where rownum<10;

-- rownum在case when等中使用
SELECT CASE WHEN false THEN 0:::INT2 ELSE 1:::INT8 END;
SELECT CASE rownum WHEN 1 THEN 0 ELSE 1 END from t1;
SELECT CASE rownum WHEN 1 THEN a ELSE a+1 END from t1 where rownum<4;


-- 和row_number(),聚合函数一起使用
select rownum, row_number() over (partition by a order by a) from t1;
select rownum,count(*) from t1 group by a;
select rownum,count(*) from t1 ;


-- 多次出现rownum
select rownum + rownum + rownum from t1 where rownum<10;

-- 对rownum做显式类型转换
select rownum::string from t1 where rownum<10;
select cast(rownum as varchar(10)) from t1 where rownum<10;
-- 在临时表中使用rownum
SET experimental_enable_temp_tables = 'on';
create temp table tt as select rownum from t1;
create temp table tv as select cast(rownum as varchar(10)) from t1;
select * from tt;
select * from tv;

select *,rownum from tt where rownum<10;
select rownum from tv where rownum<5;


-- rownum在order by，group by，having等中出现
-- bug92
select * from t1 where rownum<10 order by rownum;
-- qianbase has an ERROR: row_number(): window functions are not allowed in GROUP BY, oracle is ok
select rownum from t1 where rownum<10 group by rownum;

-- rownum作为别名出现 如果不支持，可以考虑加上引号试试
select a rownum from t1;
select a "rownum" from t1;

-- 给rownum起一个别名
select rownum a from t1;
select rownum d from t1;
select rownum rownum from t1;
select rownum "rownum" from t1;
select rownum "Rownum" from t1;
select rownum as a from t1;
select rownum as d from t1;
select rownum as rownum from t1;
select rownum as "rownum" from t1;
select rownum as "Rownum" from t1;

-- 多表join中使用rownum
-- inner join
-- join的表是实体表
select rownum
from t1,t2
where a=c
and b is not null;

select rownum
from t1,t2
where a=c 
    and rownum<10
    and b is not null;

--qianbase has syntax error,oracle is ok
select rownum
from t1 join t2
    on a=c
    and rownum<10
    and b is not null;

-- qianbase has no result(because rownum has comp with field),oracle has result set
select a,rownum,b from t1 where a in (select rownum from t2 where rownum < c);

select a,rownum,b from t1 where a in (select rownum from t2 where rownum < 10 and a=c);
-- qianbase has ERROR: unsupported comparison operator: row_number() OVER () IN (SELECT row_number() OVER () FROM t2 WHERE a = c LIMIT 10 - 1 OFFSET 0),oracle is ok
select a,rownum,b from t1 where rownum in (select rownum from t2 where rownum < 10 and a=c);

-- join的表是驱动表 驱动表中都包含rownum
--qianbase has syntax error,oracle is ok
select rownum from (select rownum e from t1 where rownum<3) tt1 
join (select c from t2 where d is not null) tt2
on e=c and rownum <10;

select rownum from (select rownum e from t1 where rownum<3) tt1
join (select c from t2 where d is not null) tt2
on e=c
where rownum <10;


select rownum, * from t1;
select *, rownum from t1;
select rownum, * from t1 order by a;
select rownum, * from t1 order by a;
select rownum, * from t1 order by rownum;
select rownum, * from t1 where a = 1;
select rownum, * from t1 where rownum = 10;
select rownum, * from t1 where rownum > 10 order by a;
select rownum, * from t1 where rownum > 10 order by rownum;
select distinct rownum from t1;
select distinct rownum from t1 where rownum<10;
select rownum, * from t1 limit 5;
select rownum, t.* from (select a, a, a from t1) t;
select rownum, t.* from (select a, a, a from t1 where rownum <= 10) t;
select rownum, t.* from (select a, a, a from t1 where a <= 10) t;

-- 在with中使用rownum
with q1 as (select a,b from t1) select rownum, a from q1 where a <10;
with q1 as (select a, b, rownum from t1) select rownum, a, b from q1 where rownum <10;

-- 嵌套语句中使用rownum
-- 非相关子查询中使用rownum
-- 相关子查询中使用rownum
-- rownum作为驱动表的字段
select a,b from t1 where rownum in (select a from t1 where a <= 10);
select a,b from t1 where a in (select c from t2 where rownum <= 10);
select a,b,rownum from t1 inner join t2 on a = c;

select *,rownum from (select *, rownum as r1 from t1) tt1 inner join (select *,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum > 5 and rownum <15;
select *,rownum from (select *, rownum as r1 from t1) tt1 inner join (select *,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum<5;
select a,b,c,d,rownum,r1,r2 from (select a,b,rownum as r1 from t1) tt1 inner join (select c,d,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum<5;
select *,rownum from (select *, rownum from t1) tt1 inner join (select *,rownum from t2) tt2 on tt1.rownum = tt2.rownum where tt1.rownum > 5 and tt1.rownum <15;
select *,rownum from (select *, rownum from t1) tt1 inner join (select *,rownum from t2) tt2 on tt1.row_number=tt2.row_number where rownum<10;
select *,rownum from (select *, rownum from t1) tt1 inner join (select *,rownum from t2) tt2 on tt1.row_number=tt2.row_number and rownum<10;
select a,b,c,d,rownum,r1,r2 from (select a,b,rownum as r1 from t1) tt1 inner join (select c,d,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum<5 and r1<r2;
select a,b,c,d,rownum,r1,r2 from (select a,b,rownum as r1 from t1) tt1 inner join (select c,d,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum<5 and r1<rownum;
select * from (select a,b,c,d,rownum r3,r1,r2 from (select a,b,rownum as r1 from t1) tt1 inner join (select c,d,rownum as r2 from t2) tt2 on tt1.a = tt2.c where rownum<5) where r3<r1;
select *,rownum from (select *, rownum from t1) tt1 inner join (select *,rownum from t2) tt2 on tt1.row_number=tt2.row_number where rownum<10 and tt1.row_number<10 and tt2.row_number<2;

select * from (select a,b, rownum from t1) tt1 inner join (select c,d,rownum from t2) tt2 on 1=1;
select * from (select a,b, rownum e from t1) tt1 inner join (select c,d,rownum f from t2) tt2 on e=f;
select * from (select a,b, rownum e from t1) tt1 inner join (select c,d,rownum f from t2) tt2 on e=f and rownum<3;
select * from (select a,b, rownum e from t1) tt1 inner join (select c,d,rownum f from t2) tt2 on e=f where rownum<3;
select * from t1 where rownum<any(select rownum from t2 where a=c);
select * from t1 where a<any(select rownum from t2 where a=c);
select * from t1 where a<any(select rownum from t2 where a=c);
select * from t1 where a<=some(select rownum from t2 where a=c);
select * from t1 where a<some(select rownum from t2 where a=c);
select * from t1 where exists (select rownum from t2 where a=c);
select * from t1 where not exists (select rownum from t2 where a=c);


select *, rownum from t1 right join t2 on a = c;
select *, rownum from t1 right join t2 on a = c where rownum <15;
select *, rownum from t2 left join t1 on a = c;
select *, rownum from t2 left join t1 on a = c where rownum <15;
select *, rownum from t1 intersect select *, rownum from t2;
select a,b,rownum from t1 intersect select c,d, rownum from t2;
select *, rownum from t1 union select *, rownum from t2 order by a,b;
select a,b, rownum from t1 union select c,d, rownum from t2 order by a,b;
select *, rownum from t1 except select *, rownum from t2;
select a,b, rownum from t1 except select c,d, rownum from t2;

-- 和sequence一起使用
drop sequence if exists seq_1;
create sequence seq_1;
select rownum, nextval('seq_1'), * from t1;
select rownum, nextval('seq_1'), * from t1;
select rownum, nextval('seq_1'), * from t1;
drop sequence seq_1;

-- 视图中使用rownum
drop view if exists v1;
create view v1 as select rownum, a, b from t1 where rownum < 15;
select * from v1;
select rownum from v1;
select rownum from v1 where rownum<2;
drop view v1;

--在insert select,create as select，update，delete中使用rownum
drop table if exists tab_3;
create table tab_3 as select a, b, rownum c from t1;
insert into tab_3 select a,b,rownum from t1 where rownum < 10;
select * from tab_3;
update tab_3 set c=888888 where rownum=1;
delete from tab_3 where rownum < 2;
drop table tab_3;

-- 在分区表中使用rownum
drop table if exists pt;
CREATE TABLE pt(
   id int NOT NULL,
   city VARCHAR(50) NOT NULL,
   PRIMARY KEY (city ASC, id ASC)
 ) PARTITION BY LIST (city) (
   PARTITION us_west VALUES IN (('seattle'), ('san francisco'), ('los angeles')),
   PARTITION us_east VALUES IN (('new york'), ('boston'), ('washington dc')),
   PARTITION europe_west VALUES IN (('amsterdam'), ('paris'), ('rome'))
 );
insert into pt values(1,'seattle');
insert into pt values(2,'paris');
insert into pt values(5,'new york');
insert into pt values(6,'seattle');
insert into pt values(3,'los angeles');
select rownum,id from pt where rownum<10;
select rownum,id from pt where id<5 and rownum<10;
select rownum,id,city from pt where id<5 and rownum<10;
drop table pt;

-- 在dual表中使用rownum
select 1,2,rownum from dual;

-- union/union all/intersect/except
select rownum from t1 where rownum<3 union select rownum from t2 where rownum<5;
select rownum from t1 where rownum<3 union all select rownum from t2 where rownum<5;
select rownum from t1 where rownum<3 intersect select rownum from t2 where rownum<5;
select rownum from t1 where rownum<3 except select rownum from t2 where rownum<5;
select rownum from t2 except (select rownum from t1 where rownum<3);
(select rownum from t1 
	where rownum<3)
union 
select rownum from t2 
	where rownum<5;

(select rownum from t1 where rownum<3) union all select rownum from t2 where rownum<5;
(select rownum from t1 where rownum<3) intersect select rownum from t2 where rownum<5;
(select rownum from t1 where rownum<3) except select rownum from t2 where rownum<5;

(select rownum from t1 where rownum<3) union (select rownum from t2 where rownum<5);
(select rownum from t1 where rownum<3) union all (select rownum from t2 where rownum<5);
(select rownum from t1 where rownum<3) intersect (select rownum from t2 where rownum<5);
(select rownum from t1 where rownum<3) except (select rownum from t2 where rownum<5);

(select rownum from t1 where rownum<3) union select rownum from t2;
(select rownum from t1 where rownum<3) union all select rownum from t2;
(select rownum from t1 where rownum<3) intersect select rownum from t2;
(select rownum from t1 where rownum<3) except select rownum from t2;

(select rownum from t2 where rownum<5) 
 union select rownum from t1;

(select rownum from t2 where rownum<5) 
union all select rownum from t1;

(select rownum from t2 where rownum<5) 
intersect select rownum from t1;

(select rownum from t2 where rownum<5) except select rownum from t1;

select rownum from t2 union (select rownum from t1 where rownum<3);
select rownum from t2 union all (select rownum from t1 where rownum<3);
select rownum from t2 intersect (select rownum from t1 where rownum<3);
select rownum from t2 except (select rownum from t1 where rownum<3); 

select c,d, rownum from t2 union (select a,b ,rownum from t1 where rownum<3) order by c;
select c,d, rownum from t2 union all (select a,b,rownum from t1 where rownum<3) order by c;
select c,d, rownum from t2 intersect (select a,b,rownum from t1 where rownum<3) order by c;
select c,d,rownum from t2 except (select a,b, rownum from t1 where rownum<3) order by c;


-- rownum作为数据库名，表名，字段名等
-- rownum不加引号
-- 加引号 作为字段名，要考虑和rownum同时使用的情况
-- rownum字母的大小写测试
create table rownum(a int);
create table Rownum(a int);
drop table if exists "rownum";
create table "rownum"(a int);
insert into "rownum" values(1);
insert into "rownum" values(-1);
select * from rownum;
select * from "rownum";
select rownum from "rownum";
select rownum from "rownum" where rownum<2;
drop table "rownum";

drop table if exists "Rownum";
create table "Rownum"("rownum" int);
insert into "Rownum" values(5);
insert into "Rownum" values(2);
select "rownum",rownum from "Rownum" where rownum<5;
select "rownum"+rownum from "Rownum" where rownum<5;
drop table "Rownum";

drop table t1;
drop table t2;
