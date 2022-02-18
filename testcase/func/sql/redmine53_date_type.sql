-- create by cuixiangling
-- DATE: 2021-09-10

-- implicit cast and explicit between date and timestamp/timestamptz

drop table if exists td;
create table td(a date);
insert into td values('2021-09-08 12:58:35');
insert into td values('2021-09-06');
insert into td values('2021-09-09 16:01:05.88');
insert into td values('2021-05-08 12:58:35.09+08');

drop table if exists tt;
create table tt(b timestamp);
insert into tt select * from td;
insert into tt select a::timestamp  from td;


drop table if exists ttz;
create table ttz(c timestamptz);
insert into ttz select * from td;
insert into ttz select a::timestamptz from td;
insert into ttz select a from td;

insert into tt values('2021-08-08 10:08:50');
insert into tt values('2011-08-08 1:08:50.9876');
insert into ttz values('2015-04-08 12:45:30.098+08');
insert into td select * from tt;
insert into td select b::date from tt;
insert into ttz select b::timestamptz from tt;
insert into tt select * from ttz;
select * from tt;
select * from td;

-- to_char
select to_char(a,'AD A.D. AM A.M. BC B.C. CC SCC D DAY DD DDD DY FF1 FF2 FF3 FF4 FF5 FF6 HH HH12 HH24 MI MM MON MONTH PM P.M. Q RM SS SSSSS WW W X Y,YYY YEAR SYEAR YYYY SYYYY YYY YY Y') from td;
select to_char(a,'DL') from td;
select to_char(a,'DS') from td;
select to_char(a,'E') from td;
select to_char(a,'EE') from td;
select to_char(a,'FM') from td;
select to_char(a,'FX') from td;
select to_char(a,'IW') from td;
select to_char(a,'IYYY') from td;
select to_char(a,'IYY') from td;
select to_char(a,'IY') from td;
select to_char(a,'I') from td;
select to_char(a,'J') from td;
select to_char(a,'RR') from td;
select to_char(a,'RRRR') from td;
select to_char(a,'TS') from td;
select to_char(a,'TZD') from td;
select to_char(a,'TZH') from td;
select to_char(a,'TZM') from td;
select to_char(a,'TZR') from td;
select * from ttz;
-- 带有函数的插入和比较 to_char
insert into td select to_char(date'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss') from dual;
insert into td select to_char(date'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss') from dual;
insert into td select to_char(timestamp'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss') from dual;

insert into td select to_char(date'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss')::date from dual;
insert into td select to_char(date'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss')::date from dual;
insert into td select to_char(timestamp'2014-08-09 17:35:09.09','yyyy-mm-dd hh24:mi:ss')::date from dual;

-- 和timestamp/timestamptz隐式转换 常量插入和比较 包含毫秒
insert into td select '2013-6-19 15:15:19.909' from dual;
insert into td select '2013-6-19 15:15:19.909+08' from dual;

-- 和timestamp/timestamptz隐式转换 常量插入和比较 不包含毫秒
insert into td select '2013-6-19 15:15:19' from dual;
insert into td select '2013-6-19 15:15:19+08' from dual;

select * from td;

drop table td;

-- ddl default设置成不包含时分秒
create table td(a int,b date not null default '2021-08-05');
insert into td(a) values(1);
select * from td;

-- ddl default设置成包含时分秒
drop table td;
create table td(a int,b date not null default '2021-08-05 10:05:09');
insert into td(a) values(1);
select * from td;

-- ddl default设置成包含毫秒
drop table td;
create table td(a int,b date not null default '2021-08-05 10:05:09.9876543');
insert into td(a) values(1);
insert into td(b) values('2021-08-05 10:05:09.999999999999999999');
select * from td;


drop table td;
create table td(a int,b timestamp not null default '2021-08-05 10:05:09.9876543');
insert into td(a) values(1);
insert into td(b) values('2021-08-05 10:05:09.999999999999999999');
select * from td;
drop table td;

-- 按照PRD中的表格进行边界值测试 xtp date范围 4714-11-24 BC 到 5874897-12-31
create table td(a date);
insert into td values('4714-11-24 BC');
insert into td values('-4714-11-24');
insert into td values('4714-11-25 BC');
insert into td values('4714-11-23 BC');
insert into td values('5874897-12-31');
insert into td values('5874898-1-31');
insert into td values('5874898-1-31');
insert into td values('587489-0-31');
insert into td values('4715-11-24 BC');
insert into td values('4713-11-24 BC');
insert into td values('2021-11-24 BC');
insert into td values('4713-11-24 AD');
insert into td values('0-11-24');
insert into td values('00-11-24');
insert into td values('000-11-24');
insert into td values('0000-11-24');
insert into td values('-000000-11-24');
insert into td values('00000-11-24');
insert into td values('21-11-24');
insert into td values('1-12-28');
insert into td values('01-12-28');
insert into td values('001-12-28');
insert into td values('70-11-24');
insert into td values('69-11-24');
insert into td values('0021-11-24');
insert into td values('0070-11-24');
insert into td values('0069-11-24');
insert into td values('021-11-24');
insert into td values('070-11-24');
insert into td values('069-11-24');
insert into td values('-70-11-24');
insert into td values('-0070-11-24');
insert into td values('-1970-11-24');
insert into td values( '2021-01');
insert into td values( '2021-01-01 12:00');
insert into td values( '2021-01-01');
insert into td values('2021-08-05 10:05:09.9999999');
insert into tt values('1970-11-24 BC');
insert into tt values('-1970-11-24');
select to_char(a,'AD') from td;
update td set a=sysdate where a > '2021-05-08';
select * from td where to_char(a,'AD')='AD';
select count(*) from td;
update td set a=current_timestamp() where a > '2021-05-08';
select * from td;
select * from td where to_char(a,'AD')='AD';
select count(*) from td;
delete from td where a>'2021-05-08 12:10:35';
insert into td select sysdate from dual;
insert into td select * from td;
select * from td where to_char(a,'AD')='AD' order by a;
select * from td where to_char(a,'AD')='AD' order by a desc;
select * from td where to_char(a,'AD')='AD' order by a asc;

insert into td values('-0010-01-12 12:45:56');
insert into td values('0010-11-24 09:08:45.456 BC');
insert into td values('00-01-15 10:05:06');
insert into td values('-0010-01-12 12:05:56');
insert into td values('10-11-24 09:18:45.456');
insert into td values('0010-11-24 09:38:45.456');
insert into td values('1970-11-24 AD');
-- 支持的格式 / - : 其他
insert into td values('1970/11/24');
insert into td values('1970:11:24');
insert into td values('1970//11//24');
insert into td values('1970/11/24 10:24:35');
insert into td values('1970/11/24 10-24-07');


update td set a=current_timestamp() where a > to_char(date'2021-05-08','YYYY-MM-DD HH:MI:SS');

-- 日期函数 见redmine103和136 testcases


-- date和int以及其他数据类型的强转  cast
select a::int from td;
select * from td where a in (select a::int::date from td);
select a,to_char(a,'BC') from td where a::int<0;
select a,to_char(a,'BC') from td where a::int>0;
select aa, count(*) from (select to_char(a,'BC') aa from td) group by aa;
select aa,count(*) from (select to_char(a,'AD') aa from td) group by aa;
select a,b from td ,tt where a::int=b::int;
select a,to_char(a,'BC') from td where a<0::date;

-- date类型在select中应用 表达式 + - * / 
select date'2021-09-21 12:45:15.999' from dual;
select date'2021-09-21' from dual;
select a+1,a from td;
select a+1.2,a from td;
delete from td where a='4714-11-24 BC';
select a-0.2,a from td;
select a*0.2,a from td;
select a*1,a from td;
select a/1,a from td;
select a||a,a from td;
select a+a,a from td;
select a,b from td,tt where a=b;
select a,b from td,tt where a=b;
select a::int-b::int from td,tt where a=b;
select a::int+b::int from td,tt where a=b;
select (a::int+b::int)::date from td,tt where a=b;
select (a::int-b::int)::date from td,tt where a=b;


drop table tt;
drop table td;
drop table ttz;
