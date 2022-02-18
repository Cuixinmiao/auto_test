-- author: cuixiangling
-- date: 20211026
select to_date('20191010','yyyymmdd') from dual;
select to_date('120304','hh24miss') from dual;
select to_date('1992-10-20','yyyy-mm-dd') from dual;
select to_date('2001-10-10 11:12','yyyy-mm-dd hh24:mi') from dual;
select to_date('1991','yyyy') from dual;
select to_date('1991-11','yyyy-mm') from dual;
select to_date('10-10','mm-dd') from dual;
select to_date('10-10 09:01','mm-dd hh24:mi') from dual;
select to_date('1991-10-10 11:12:13','yyyy-mm-dd hh24:mi:ss') from dual;
select to_date('1991-10-10 11:12:13 PM','yyyy-mm-dd hh12:mi:ss AM') from dual;
select to_date('1991-10-10 11:12:13 AM','yyyy-mm-dd hh12:mi:ss AM') from dual;
select to_date(to_char(sysdate,'yyyy-mm-dd hh12:mi:ss AM'),'yyyy-mm-dd hh12:mi:ss AM') from dual;
select to_date(sysdate,'yyyy-mm-dd hh12:mi:ss AM') from dual;

drop table if exists td;
create table td(a date);
insert into td values('5874897-11-24');
insert into td values('5874898-11-24');
select * from td;
drop table td;

drop table if exists ttime;
create table ttime(a string,b varchar(30),c text);
insert into ttime values('1991-10-10 11:12:13','1991-10-10 11:12:13.789','1991-10-10 11:12:13.798+8');
select to_date('1991/10/10','yyyy/mm/dd') from dual;

select to_date(a,'yyyy-mm-dd hh24:mi:ss'),to_date(b,'yyyy-mm-dd hh24:mi:ss.ff3'),to_date(c,'yyyy-mm-dd') from ttime;
select to_date(c,'yyyy-mm-dd') from ttime;
select to_date(b,'yyyy-mm-dd hh24:mi:ss.ff3') from ttime;
select to_date(a,'yyyy-mm-dd hh24:mi:ss') from ttime;
delete from ttime where a is not null;

insert into ttime values('1991-10-10 11:12:13','1991-10-10 11:12:13','1991-10-10 11:12:13');
select to_date(a,'yyyy-mm-dd hh24:mi:ss'),to_date(b,'yyyy-mm-dd hh24:mi:ss'),to_date(c,'yyyy-mm-dd') from ttime;
select to_date(c,'yyyy-mm-dd') from ttime;
select to_date(b,'yyyy-mm-dd hh24:mi:ss') from ttime;
select to_date(a,'yyyy-mm-dd hh24:mi:ss') from ttime;

delete from ttime where a is not null;
insert into ttime values('10-10','10/10','10:10');
select to_date(a,'mm-dd') from ttime;
select to_date(a,'mm/dd') from ttime;
select to_date(a,'mm:dd') from ttime;
select to_date(a,'mm,dd') from ttime;
select to_date(a,'mm;dd') from ttime;
select to_date(a,'mm$dd') from ttime;


select to_date('10-10','mmdd') from dual;
select to_date('1010','mm dd') from dual;
select to_date('10 10','mm dd') from dual;
select to_date('0 10','mm dd') from dual;
select to_date('1 10','mm dd') from dual;
select to_date('2 28','mm dd') from dual;
select to_date('2 30','mm dd') from dual;
select to_date('2 29','mm dd') from dual;
select to_date('11 31','mm dd') from dual;
select to_date('10 30','mm dd') from dual;
select to_date('11 30','mm dd') from dual;

select to_date('10:25','mm,dd') from dual;
select to_date('10:25','mm;dd') from dual;
select to_date('10:25','mm$dd') from dual;
select to_date('10:25','mm  dd') from dual;

select to_date('2001-01','yyyy-mm') from dual;
select to_date('2501-02','yyy,y-mm') from dual;
select to_date('1901-05','yy-mm') from dual;
select to_date('1501-11','y-mm') from dual;
select to_date('1801-12','yy-mm') from dual;
select to_date('1981-13','yy-mm') from dual;
select to_date('1','mm') from dual;
select to_date('1','y') from dual;
select to_date('1','yy') from dual;
select to_date('1','yyy') from dual;
select to_date('1','yyyy') from dual;
select to_date('28','hh') from dual;
select to_date('1','hh') from dual;
select to_date('24','hh') from dual;
select to_date('24','hh24') from dual;
select to_date('0','hh24') from dual;
select to_date('0','hh12') from dual;
select to_date('12','hh12') from dual;
select to_date('0','hh') from dual;
select to_date('12','hh') from dual;
select to_date('12','hh24') from dual;
select to_date('28','hh24') from dual;
select to_date('-1','hh24') from dual;
select to_date('00','hh24') from dual;
select to_date('00','hh') from dual;
select to_date('0000','hh24') from dual;
select to_date('00','mm') from dual;
select to_date('01','mm') from dual;
select to_date('010','mm') from dual;
select to_date('10','dd') from dual;
select to_date('28','dd') from dual;
select to_date('29','dd') from dual;
select to_date('30','dd') from dual;
select to_date('31','dd') from dual;
select to_date('27','DD') from dual;
select to_date('27','YYY') from dual;
select to_date('27','YY') from dual;
select to_date('08','mm') from dual;
select to_date('12','mm') from dual;
select to_date('3','dd') from dual;
select to_date('003','dd') from dual;
select to_date('13','mi') from dual;
select to_date('003','mi') from dual;
select to_date('13','ss') from dual;
select to_date('003','ss') from dual;
select to_date('3','mi') from dual;
select to_date('3','ss') from dual;
select to_date('59','ss') from dual;

select to_date('59','mi') from dual;
select to_date('60','ss') from dual;
select to_date('60','mi') from dual;

select to_date('0','mi') from dual;
select to_date('00','mi') from dual;
select to_date('0','ss') from dual;
select to_date('00','ss') from dual;
select to_date('32','dd') from dual;

select to_date('4714','YYYY') from dual;
select to_date('9999','YYYY') from dual;
select to_date('9999-12-31 12:56:60','YYYY-mm-dd hh24:mi:ss') from dual;
select to_date('9999-12-31 12:59:59','YYYY-mm-dd hh24:mi:ss') from dual;
select to_date('9999-12-31 23:59:60','YYYY-mm-dd hh24:mi:ss') from dual;
select to_date('0','y') from dual;
select to_date('1','y') from dual;
select to_date('10','yy') from dual;
select to_date('100','yyy') from dual;
select to_date('0100','yyy') from dual;
select to_date('0000','yyyy') from dual;
select to_date('0001','yyyy') from dual;
select to_date('0001','ff4') from dual;
select to_date('1998-10-1') from dual;
select to_date('1998-10-1','yyyy-mm-dd') from dual;
select to_date('1998-1','yyyy-mm') from dual;
select to_date('1998-12','yyyy-mm') from dual;
select to_date('1998-13','yyyy-mm') from dual;
select to_date('1998-02','yyyy-mm') from dual;
select to_date('1998-2-29','yyyy-mm-dd') from dual;

select to_date('1998-03-31','yyyy-mm-dd') from dual;
select to_date('2000-2-29','yyyy-mm-dd') from dual;
select to_date('2000-2-30','yyyy-mm-dd') from dual;
select to_date('2000-05-29 12:05:09','yyyy-mm-dd hh-mm-ss') from dual;
select to_date('2000-05-29 12:05:09','yyyy-mm-dd hh-mm-ss') from dual;
select to_date('12:05:09','hh-mi-ss') from dual;
select to_date('12-05-09','hh-mi-ss') from dual;
select to_date('12-05-09','hh-mi') from dual;
select to_date('05-09','hh-mi') from dual;
select to_date('05-09','dd-mm') from dual;
select to_date('05-09','dd-yy') from dual;
select to_date('05-9','dd-yy') from dual;
select to_date('9','yy') from dual;
select to_date('9','dd') from dual;
select to_date('9','hh') from dual;
select to_date('9','mi') from dual;
select to_date('9','ss') from dual;
select to_date('19-1987','dd-yyyy') from dual;
select to_date('2015 9','yyyy hh') from dual;
select to_date('2518 10','yyyy mm') from dual;
select to_date('2518 12','yyyy mm') from dual;
select to_date('2518   12','yyyy   mm') from dual;
select to_date('2518---12','yyyy---mm') from dual;
select to_date('2518	12','yyyy	mm') from dual;
select to_date('2518      12','yyyy         mm') from dual;
-- the first para is empty
select to_date('','yyyy') from dual;
drop table if exists ta;
create table ta as select to_date('','yyyy') a from dual;
select count(*) from ta where a is null;
insert into ta select to_date('','yyyy') a from dual;
select count(*) from ta where a is null;
drop table ta;

select to_date(' ','yyyy') a from dual;
select to_date(' ','mm') from dual;
select to_date('  ','hh') from dual;
drop table if exists ta;
create table ta as select to_date('   ','yyyy') a from dual;
select count(*) from ta where a is null;
insert into ta select to_date(' ','yyyy') a from dual;
select count(*) from ta where a is null;
drop table ta;

select to_date('2021-12-01 12:05:05 AM','yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date('12','mm AM') from dual;
select to_date('12-01','mm-dd AM') from dual;
select to_date('2051-12-01','yyyy-mm-dd AM') from dual;
select to_date('2051-12-01 10:10:10','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('2051-12-01 10:10:10','yyyy-mm-dd hh:mi:ss PM') from dual;

select to_date('2021-12-01 13:05:05 PM','yyyy-mm-dd hh:mi:ss') from dual;
select to_date('2021-12-01 13:05:05 AM','yyyy-mm-dd hh:mi:ss') from dual;

select to_date('3 AM', 'hh AM') from dual;
select to_date('03 AM', 'hh AM') from dual;

-- oracle第二个参数没有分割符时，第一个参数必须无分隔符，qianbase两个参数无此限制
select to_date('28010806','yyyymmdd') from dual;
select to_date('2801-0806','yyyymmdd') from dual;
select to_date('2801/0806','yyyymmdd') from dual;
select to_date('2801/08-06','yyyymmdd') from dual;
select to_date('2801/08-06','yyyy-mm-dd') from dual;
select to_date('2801/08-06','yyyy-dd-mm') from dual;

select to_date('28010806 12:34:45','yyyymmddhh24miss') from dual;
select to_date('2801080612:34:45','yyyymmddhh24miss') from dual;
select to_date('28010806 12:34:45','yyyymmdd hh24miss') from dual;
select to_date('28010806 123445','yyyymmdd hh24miss') from dual;
select to_date('28010806123445','yyyymmddhh24miss') from dual;
select to_date('28010806123445','yyyymmddhh24miss') from dual;
select to_date('28010806143445','yyyymmddhhmiss') from dual;
select to_date('28010806143460','yyyymmddhh24miss') from dual;

drop table if exists t;
create table t(a timestamp);
insert into t values('2801-08-06 14:35:60');
insert into t values('2801-08-06 14:35:6');
select * from t;
drop table t;

select to_date('2801-08-06 12:6:6 am','yyyy-mm-dd hh:mi:ss am') from dual;
select to_date('2801-08-06 12:6:6 am','yyyy-mm-dd hh:mi:ss pm') from dual;
select to_date('2801-08-06 12:6:6 pm','yyyy-mm-dd hh:mi:ss pm') from dual;
select to_date('2801-08-06 11:6:6 am','yyyy-mm-dd hh:mi:ss pm') from dual;

select to_date('2051-05-04','yyyy-mm-dd') from dual;
select to_date('2051-05-04','yyyy-mm-dd hh24:mi') from dual;

select to_date('05-04-2000','dd-mm-yyyy') from dual;
select to_date('abc','mm-dd') from dual;
select to_date(null,'mm-dd') from dual;
select to_date(NULL,'mm-dd') from dual;
select to_date('05-06'||'12:34','mm-dd hh24:mi') from dual;
select to_date(to_char(timestamp'2801-08-06 11:6:6','yyyy-mm-dd hh12:mi:ss'),'yyyy-mm-dd hh24:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 12:6:6','yyyy-mm-dd hh12:mi:ss'),'yyyy-mm-dd hh24:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 12:6:6','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 12:6:6','yyyy-mm-dd hh12:mi:ss'),'yyyy-mm-dd hh:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 23:6:6','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 23:6:6','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') from dual;
select to_date(to_char(timestamp'2801-08-06 0:6:6','yyyy-mm-dd hh:mi:ss'),'yyyy-mm-dd hh24:mi:ss') from dual;

select to_date('','yyyy-mm-dd hh24:mi:ss') from dual;
select to_date('中文','yyyy-mm-dd hh24:mi:ss') from dual;
select to_date('%$#@!','yyyy-mm-dd hh24:mi:ss') from dual;
select to_date('05-04-2000','dd-mm-yyyy','dd-mm-yyyy') from dual;
select to_date('05-04-2000','dd;mm;yyyy') from dual;
select to_date('05-04-2000','dd\mm\yyyy') from dual;
select to_date('05','DAY') from dual;
select to_date('5','DAY') from dual;
select to_date('05-04-2000 AD','dd-mm-yyyy AD') from dual;
select to_date('05-04-2000 BC','dd-mm-yyyy BC') from dual;
select to_date('05-04-2000 WW','dd-mm-yyyy WW') from dual;
select to_date('05-04-2000','dd-mm-year') from dual;
select to_date('2000','year') from dual;
支持不写分割符或者 '-' ， '/' ， ',' ，';' ， ':' ，' '
select to_date('05-04-2000','dd-dd-yyyy') from dual;
select to_date('05;04;2000','mm-dd-yyyy') from dual;
select to_date('05;04;2000','mm:dd:yyyy') from dual;
select to_date('05;04;2000','mm:dd/yyyy') from dual;
select to_date('05;04-2000','mm;dd:yyyy') from dual;
select to_date('05;04;2','mm:dd/y') from dual;
select to_date('05;04-200','mm;dd:yyy') from dual;
select to_date('05;04-02','mm;dd:yy') from dual;
select to_date('05;04-0002','mm;dd:yyyy') from dual;
select to_date('05;04-0002','mm;dd,yyyy') from dual;
select to_date(to_date('05;04-0002','mm;dd,yyyy'),'dd-mm-yyyy') from dual;
select to_date('1991-10-10 11:12:13 PM','yyyy-mm-dd hh12:mi:ss AM') from dual;

drop table if exists t;
create table t as select to_date('05;04-0002','mm;dd:yyyy') a from dual;
select * from [show create table t];
select * from t;
drop table t;

create table t as select to_date('05;04-0002','mm;dd,yyyy') a from dual;
select * from t;
select to_date(a::string,'  ') from t;
select to_date(a::string,' ') from t;


drop table t;
create table t(a timestamp);
insert into t select to_date('05;04-0002','mm;dd,yyyy') a from dual;
select * from t;
select to_date(a::string,'') from t;
select to_date(a::string,'  ') from t;
select to_date(a::string,' ') from t;
select to_date(a::string,'yyyy-mm-dd hh12:mi:ss') from t;
select to_date(to_char(a,'yyyy-mm-dd'),'yyyy-mm-dd') from t;
select to_date(to_char(a,'yyyy-mm'),'yyyy-mm') from t;

drop table t;
create table t(a varchar(30),b varchar(30));
insert into t values('28010806','yyyymmdd') ;
insert into t values('2801-0806','yyyymmdd');
insert into t values('2801/0806','yyyymmdd');
insert into t values('2801/08-06','yyyymmdd'); 
insert into t values('2801/08-06','yyyy-mm-dd');
insert into t values('2801/08-06','yyyy-dd-mm');
insert into t values('28010806 12:34:45','yyyymmddhh24miss');
insert into t values('2801080612:34:45','yyyymmddhh24miss');
insert into t values('28010806 12:34:45','yyyymmdd hh24miss');
insert into t values('28010806 123445','yyyymmdd hh24miss');
insert into t values('28010806123445','yyyymmddhh24miss');
insert into t values('28010806123445','yyyymmddhh24miss');
select to_date(a,b) from t;
delete from t where a is not null;
insert into t values('28010806143445','yyyymmddhhmiss');
insert into t values('28010806143460','yyyymmddhh24miss');
select to_date(a,b) from t;
delete from t where a is not null;
insert into t values('28010806','');
insert into t values('28010806',null);
select to_date(a,b) from t;
delete from t where b ='';
select to_date(a,b) from t;
insert into t values(null,null);
select to_date(a,b) from t;
drop table t;

create table t(a char(30),b varchar(30),c timestamp);
insert into t(a,b) values('20191010','yyyymmdd');
insert into t(a,b) values('120304','hh24miss');
insert into t(a,b) values('1992-10-20','yyyy-mm-dd');
insert into t(a,b) values('2001-10-10 11:12','yyyy-mm-dd hh24:mi');
insert into t(a,b) values('1991','yyyy');
insert into t(a,b) values('1991-11','yyyy-mm');
insert into t(a,b) values('10-10','mm-dd');
insert into t(a,b) values('10-10 09:01','mm-dd hh24:mi');
insert into t(a,b) values('1991-10-10 11:12:13','yyyy-mm-dd hh24:mi:ss');
insert into t(a,b) values('1991-10-10 11:12:13 PM','yyyy-mm-dd hh12:mi:ss AM');
insert into t(a,b) values('1991-10-10 11:12:13 AM','yyyy-mm-dd hh12:mi:ss AM');
insert into t(a,b) values(to_char(sysdate,'yyyy-mm-dd hh12:mi:ss AM'),'yyyy-mm-dd hh12:mi:ss AM');
insert into t(a,b) values(sysdate::string,'yyyy-mm-dd hh12:mi:ss AM');
select to_date(a,b) from t where a not like '%AM%' and a not like '%PM%' and b not like '%AM%';
select to_date(a,b) from t where a like '%AM%' or a like '%PM%' and b like '%AM%';
select to_date(a,b) from t where a like '%AM%' or a like '%PM%' or b like '%AM%';
select to_date('',b) from t;
select to_date(' ',b) from t;
select to_date('  ',b) from t;
update t set c='1991-10-10 11:12:13' where c is null;
select to_date(c,b) from t;
select to_date(c::string,b) from t where b='yyyy-mm-dd hh24:mi:ss';

drop table t;
create table t(a char(50),b varchar(30));
insert into t values('2021-10-10','yyyy-dd-mm');
insert into t values('2021-10-10 10:35:25','yyyy-dd-mm hh:mi:ss');
insert into t values('2021/10/10 10:35:25','yyyy-dd-mm hh:mi:ss');
insert into t values('2021,10,10 10:35:25','yyyy-dd-mm hh:mi:ss');
select to_date(a,b) from t union select to_date(a,b) from t;
select to_date(a,b) from t union all select to_date(a,b) from t;
select to_date(a,b) from t intersect select to_date(a,b) from t;
select to_date(a,b) from t except select to_date(a,b) from t;
drop table if exists tt;
create table tt as select to_date(a,b) a from t;
select * from [show create table tt];
select * from tt;
drop table tt;
select to_date(a,b) from t;
select * from t where a::timestamp=to_date(a,b);
select * from (select * from t where a not like '%,%') tt where tt.a::timestamp=to_date(a,b);
select * from t where a=to_char(to_date(a,b),b);
update t set a=to_char(to_date(a,b),b) where a=to_char(to_date(a,b),b);
select length(b) from t;
update t set b=a where a=to_char(to_date(a,b),b);
select length(b) from t;
delete from t where a=b;
select max(a) from t where to_date(a,b) is not null group by to_date(a,b);
select max(a) from t where to_date(a,b) is not null group by to_date(a,b) order by to_date(a,b);

drop table t;
create table t(a char(50),b varchar(30));
insert into t values('2021-10-10','yyyy-dd-mm');
insert into t values('2021-10-10 10:35:25','yyyy-dd-mm hh:mi:ss');
insert into t values('2021/10/10 10:35:25','yyyy-dd-mm hh:mi:ss');
insert into t values('2021,10,10 10:35:25','yyyy-dd-mm hh:mi:ss');
insert into t values(null,null);
drop table if exists tt;
create table tt as select to_date(a,b) a from t;
select * from [show create table tt];
select * from tt;
drop table tt;

drop table t;
create table t(a int,b date,c char(50),d timestamptz);
insert into t values(687118200,'1991-10-10','1991-10-10 20:35:15','1991-10-10 20:35:15+8');
select to_date(a,'yyyy-mm-dd hh24:mi:ss'),to_date(b,'yyyy-mm-dd'),to_date(c,'yyyy-mm-dd hh24:mi:ss'),to_date(d,'yyyy-mm-dd hh24:mi:ss') from t;
select to_date(a::timestamp::string,'yyyy-mm-dd hh24:mi:ss'),to_date(b::string,'yyyy-mm-dd'),to_date(c,'yyyy-mm-dd hh24:mi:ss'),to_date(d::string,'yyyy-mm-dd hh24:mi:ss') from t;
select to_date(a::timestamp::string,'yyyy-mm-dd hh24:mi:ss'),to_date(b::string,'yyyy-mm-dd') from t;

select to_date('1991-10-10 23:12:13 PM','yyyy-mm-dd hh12:mi:ss AM') from dual;
select to_date('1991-10-10 0:12:13 PM','yyyy-mm-dd hh12:mi:ss AM') from dual;
select to_date('1991-10-10 23:00:13 AM','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('1991-10-10 00:00:13 AM','yyyy-mm-dd hh:mi:ss AM') from dual;

select to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('1991-10-10 12:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date(null,null) from dual;
select to_char('','') from dual;
select to_number('','') from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM')+1 from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM')::date+1 from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM')::date-100 from dual;
select (to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM')::int+3600*24)::timestamp from dual;


drop table if exists tt;
create table tt(a timestamp);
insert into tt values ('1991-10-10 12:09:59 AM');
insert into tt values ('1991-10-10 12:09:59 PM');
insert into tt values ('1991-10-10 06:09:59 AM');
insert into tt values ('1991-10-10 06:09:59 PM');
insert into tt values (to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM'));
select * from tt;
insert into tt select systimestamp from dual;
insert into tt select sysdate from dual;
insert into tt values ('1991-10-10 13:00:13 AM');
insert into tt values ('1991-10-10 00:00:13 AM');
insert into tt values ('1991-10-10 00:00:13 PM');
select * from tt;
drop table tt;
create table tt(b int,a timestamp not null default to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM'));
insert into tt(b) values(1);
select * from tt;
drop table tt;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual union select to_date('1991-10-10 06:09:59 AM','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual union all select to_date('1991-10-10 06:09:59 AM','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual except select to_date('1991-10-10 06:09:59 AM','yyyy-mm-dd hh:mi:ss AM') from dual;
select to_date('1991-10-10 06:09:59 PM','yyyy-mm-dd hh:mi:ss PM') from dual intersect select to_date('1991-10-10 06:09:59 AM','yyyy-mm-dd hh:mi:ss AM') from dual;


SELECT sysdate::date-current_date FROM DUAL;
SELECT SYSTIMESTAMP-clock_timestamp() FROM DUAL;
SELECT SYSTIMESTAMP-sysdate FROM DUAL;

drop table ts;
create table ts as select sysdate sd from dual;
select * from [show create table ts];
insert into ts select systimestamp from ts;
insert into ts select sysdate from ts;
select * from ts;

drop table ts;
create table ts as select systimestamp sd from dual;
select * from [show create table ts];
insert into ts select systimestamp from ts;
insert into ts select sysdate from ts;
insert into ts values('1991-10-10');
select * from ts;
drop table ts;
create table ts as select to_date(null,null) a from dual;
create table ts as select to_number(null,null) a from dual;
create table ts as select to_char(null,null) a from dual;

select to_date(null,null) from dual;
select to_number(null,null) from dual;
select to_char(null,null) from dual;
select to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM') from dual;
select substr(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM'),1,2) from dual;
select length(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM')) from dual;
select substr(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM'),10,8) from dual;
select nvl(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM'),10,8) from dual;
select nvl(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM'),'10') from dual;
-- 以下修改完代码，要和oracle再对比测试
select to_date(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss AM'),'yyyy-mm-dd hh:mi:ss PM') from dual;
select to_date(to_char(to_date('1991-10-10 12:09:59 AM','yyyy-mm-dd hh:mi:ss PM'),'yyyy-mm-dd hh:mi:ss AM'),'yyyy-mm-dd hh:mi:ss AM') from dual;
drop table ttime;
