--FIND_IN_SET(str,strlist)
--两个参数均为常量，字符串
select find_in_set('a','a,b,c,d,r');
select find_in_set('b','a,b,c,d,r');
select find_in_set('r','a,b,c,d,r');

select find_in_set('f','a,b,c,d,r');

select find_in_set(null,'a,b,c,d,r');
select find_in_set('a',null);
select find_in_set(null,NULL);
select find_in_set(null,'');
select find_in_set('null','null');

select find_in_set('','a,b,c,d,r');
select find_in_set('a','');
select find_in_set('','');

select find_in_set(',','a,b,c,d,r');
select find_in_set('a,','a,b,c,d,r');
select find_in_set('a,b','a,b,c,d,r');
select find_in_set(',k','a,b,c,d,r');
select find_in_set(',k,','a,b,c,d,r');
select find_in_set('a,','');
select find_in_set(',',null);

select find_in_set('f','a');
select find_in_set('f','f');
select find_in_set('f,','a');
select find_in_set('','a');
select find_in_set(null,'a');

select find_in_set('a,b','r');
select find_in_set('a,b','a');

select find_in_set('qwerty','acc,b,cdd,d,r');
select find_in_set('qwerty','acc,b,cdd,d,rqwerty');

select find_in_set('a	','a,b,c,d,r');
select find_in_set(' a','a,b,c,d,r');
select find_in_set(' a',' a,b,c,d,r');

select find_in_set('a','A');
select find_in_set('(!@#$%^&*()\/?.<>~|";）','A');
select find_in_set('','A');							
select find_in_set('add','add,dd');						--半角
select find_in_set('ａｄｄ','ａｄｄ，ｄｄ');　　　  	--全角，为全角输入
select find_in_set('ａｄｄ','ａｄｄ,ｄｄａ');			--全角,为半角输入
select find_in_set('中国','A中国,中国');
select find_in_set('中国qw#','A中国,中国qw#');

select find_in_set('china','a,china,usa,china,japan');

select find_in_set("a","a");							--qianbase报错，双引号包围为字段名；mysql执行成功；

--强制类型转换
select find_in_set(12::varchar,'12,wer,234asd');
select find_in_set(cast(12 as varchar),'12,wer,234asd');


--string数据类型
--character
drop table if exists str1;
create table str1(a STRING, b STRING(5), c TEXT);
INSERT INTO str1 VALUES ('a', 'e5f6', 'g7h8i9');
INSERT INTO str1 VALUES ('w', 'ef62', 'ef62');
INSERT INTO str1 VALUES ('q', 'e', 'e,f,e,w');
INSERT INTO str1 VALUES ('r', 'null,', 'e,f,null,w');
INSERT INTO str1 VALUES ('t', '', null);
INSERT INTO str1 VALUES ('y', null, null);
INSERT INTO str1 VALUES ('ｙ', 'ｑｗｅｒ', 'ｑｗｅｒ,ｔｙｔ？,？？＄＄,＄');
INSERT INTO str1 VALUES ('中国>', null, '中国,中国>,');
SELECT * FROM str1;

select find_in_set(a,c) from str1;
select find_in_set(b,c) from str1;

drop table if exists str2;
create table str2(a CHARACTER, b CHARACTER(40), c string(20));
INSERT INTO str2 VALUES ('a', 'e5f6', 'g7h8i9');
INSERT INTO str2 VALUES ('w', 'ef62', 'ef62');
INSERT INTO str2 VALUES ('q', 'e', 'e,f,e,w');
INSERT INTO str2 VALUES ('r', 'x,', 'e,f,e,w');
INSERT INTO str2 VALUES ('t', '', null);
INSERT INTO str2 VALUES ('y', null, null);
INSERT INTO str2 VALUES ('', '?中国@', '中国$,中国%,?中国@');
SELECT * FROM str2;
select find_in_set(a,c) from str2;
select find_in_set(b,c) from str2;



drop table if exists str3;
create table str3(a CHAR, b CHAR(40), c CHARACTER(20));
INSERT INTO str3 VALUES ('a', 'e5f6', 'g7h8i9');
INSERT INTO str3 VALUES ('w', 'ef62', 'ef62');
INSERT INTO str3 VALUES ('q', 'e', 'e,f,e,w');
INSERT INTO str3 VALUES ('r', 'x,', 'e,f,e,w');
INSERT INTO str3 VALUES ('t', '', null);
INSERT INTO str3 VALUES ('y', null, null);
INSERT INTO str3 VALUES ('', '?中国@', '中国$,中国%,?中国@');
SELECT * FROM str3;
select find_in_set(a,c) from str3;
select find_in_set(b,c) from str3;



drop table if exists str4;
create table str4(a VARCHAR, b VARCHAR(40), c CHAR(20));
INSERT INTO str4 VALUES ('a', 'e5f6', 'g7h8i9');
INSERT INTO str4 VALUES ('w', 'ef62', 'ef62');
INSERT INTO str4 VALUES ('q', 'e', 'e,f,e,w');
INSERT INTO str4 VALUES ('r', 'x,', 'e,f,e,w');
INSERT INTO str4 VALUES ('t', '', null);
INSERT INTO str4 VALUES ('y', null, null);
INSERT INTO str4 VALUES ('', '?中国@', '中国$,中国%,?中国@');
SELECT * FROM str4;
select find_in_set(a,c) from str4;
select find_in_set(b,c) from str4;


drop table if exists str5;
create table str5(a VARCHAR, b CHARACTER VARYING(40), c CHAR VARYING(20));
INSERT INTO str5 VALUES ('a', 'e5f6', 'g7h8i9');
INSERT INTO str5 VALUES ('w', 'ef62', 'ef62');
INSERT INTO str5 VALUES ('q', 'e', 'e,f,e,w');
INSERT INTO str5 VALUES ('r', 'x,', 'e,f,e,w');
INSERT INTO str5 VALUES ('t', '', null);
INSERT INTO str5 VALUES ('y', null, null);
INSERT INTO str5 VALUES ('', '?中国@', '中国$,中国%,?中国@');
SELECT * FROM str5;
select find_in_set(a,c) from str5;
select find_in_set(b,c) from str5;


--参数为函数
select find_in_set(substring('qwerty',1,3),'qwe,ty,123,d');
select find_in_set('qwe,ty,123,d',substring('qwerty',1,3));

select find_in_set(substring('qwerty',1,3),'substring('qwerty',1,3),1qwe,ty,123,d');

select find_in_set(concat('qw','er'),'qwer,cc,w12');
select find_in_set(concat('qw','er'),null);

select find_in_set('',left('qwer',2));
select find_in_set(left('中国人民',2),left('中国人民#',2));


--三种类型混合
drop table if exists mul1;
create table mul1(a CHAR(20), b TEXT, c VARCHAR(20));
INSERT INTO mul1 VALUES ('a', '', 'g7h8i9');
INSERT INTO mul1 VALUES ('qwer', 'ef62,q,ww', 'ef62');
INSERT INTO mul1 VALUES ('q', 'q', 'e,f,e,w');
INSERT INTO mul1 VALUES ('y', null, null);
INSERT INTO mul1 VALUES ('', '?中国@', '中国$,中国%,?中国@');
SELECT * FROM mul1;
select find_in_set(left('qwer',1),b) from mul1;
select find_in_set(a,'a,qwer,q,y') from mul1;
select find_in_set(b,a) from mul1;

--查看返回类型，目前查看到的结果为int8
drop table if exists tab1;
create table tab1 as select find_in_set(left('qwer',1),b) from mul1;
select * from tab1;
show columns from tab1;


--DDL
--create...default
drop table if exists ddltab1;
create table ddltab1(id int default find_in_set('abs','aaa,qwer,esgyn100,abs,dd,abs'),name varchar(20));
insert into ddltab1 values(1,'esgyn1');
insert into ddltab1(name) values('esgyn2');
select * from ddltab1;

drop table if exists ddltab2;
create table ddltab2(id int default find_in_set(left('absxx',3),'aaa,qwer,esgyn100,abs,dd,abs'),age int8 default find_in_set('a','a,d,r') not null,name string);
insert into ddltab2 values(1,10,'esgyn1');
insert into ddltab2(name) values('esgyn2');
select * from ddltab2;

drop table if exists ddltab3;
create table ddltab3(id int default find_in_set(left('absxx',3),'aaa,qwer,esgyn100,abs,dd,abs') primary  key,age int8 default find_in_set(null,'a,d,r') not null,name string);
insert into ddltab3 values(1,10,'esgyn1');
insert into ddltab3(name) values('esgyn2');
insert into ddltab3(age,name) values(12,'esgyn2');
insert into ddltab3(age,name) values(12,'esgyn2');
select * from ddltab3;

--DML
--insert、delete、update
drop table if exists dmltab1;
create table dmltab1(id int,name varchar(100),age int);
insert into dmltab1 values(1,'esgyn',18);
insert into dmltab1 values(find_in_set('as','ss,as,qwrt'),'esgyn100',3);
insert into dmltab1 values(abs(find_in_set('as','ss,as,qwrt')),'esgyn100',3);
insert into dmltab1 values(find_in_set(left('中国人民',2),left('中国人民#',2)),'esgyn100',3);
insert into dmltab1 values(find_in_set('as','ss,null,as,qwrt'),'esgyn200',20);
insert into dmltab1 values(find_in_set('as','ss,null,xx,as,qwrt'),'esgyn200,ss,dd,esgyn100',21);
select * from dmltab1;

drop table if exists dmltab2;
create table dmltab2(id int8);
insert into dmltab2 select find_in_set('esgyn100',name) from dmltab1;
select * from dmltab2;

update dmltab1 set id=find_in_set('as','ss,null,as,qwrt') where name='esgyn';
select * from dmltab1;
update dmltab1 set id=100 where find_in_set('esgyn100',name)>2;
select * from dmltab1;
update dmltab1 set id=find_in_set('as','ss,null,as,qwrt') where find_in_set('esgyn100',name)!=2;
select * from dmltab1;
delete from dmltab1 where find_in_set('esgyn100',name)<2;
select * from dmltab1;

--upsert
drop table if exists dmltab3;
create table dmltab3(id int primary key,balance decimal);
ALTER TABLE dmltab3 ADD CONSTRAINT id_balance_unique UNIQUE (balance);
insert into dmltab3 values(1,10000.5);
UPSERT INTO dmltab3 (id, balance) VALUES (2, 6325.20);
UPSERT INTO dmltab3 (id, balance) VALUES (3, 1970.4), (4, 2532.9), (5, 4473.0);
select * from dmltab3;
UPSERT INTO dmltab3 (id, balance) VALUES (find_in_set('as','er,d,,null,as'), find_in_set('as','er,d,,null,as')::decimal);
select * from dmltab3;

UPSERT INTO dmltab3 VALUES (find_in_set('as','er,d,,null,,,as'), 10000.5);								--非主键冲突报错
INSERT INTO dmltab3 VALUES (find_in_set('as','er,d,,null,,,as,ad,d'), 10000.5) ON CONFLICT (balance) DO UPDATE SET id = excluded.id;     	---更新了
select * from dmltab3;

--DQL
--create table
drop table if exists dqltab1;
create table dqltab1(id decimal primary key,name char(40),bir date,num int);
insert into dqltab1 values(1,'esgyn100','2000-11-12',1);
insert into dqltab1 values(2,'esgyn200','1998-12-1',2);
insert into dqltab1 values(3,'',null,3);
insert into dqltab1 values(4,null,null,4);
select * from dqltab1;

drop table if exists dqltab2;
create table dqltab2(id decimal primary key,name char(40),bir date,num int);
insert into dqltab2 values(1,'esgyn100','2000-11-12',1);
insert into dqltab2 values(2,'esgyn200','1998-12-1',2);
insert into dqltab2 values(3,'',null,3);
insert into dqltab2 values(4,null,null,4);
select * from dqltab2;


--in --qianbase decimal与int之间不能相互转换；mysql decimal与int之间可以相互转换
select id from dqltab1 where num in(2,find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'));


--order by
select * from dqltab1 order by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') desc;	
select * from dqltab1 order by find_in_set(find_in_set(name,'ss,esgyn100,esgyn200,esgyn300')::string,'ss,esgyn100,esgyn200,esgyn300') desc;															--默认为升序
select * from dqltab1 order by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),id;				--默认为升序
select * from dqltab1 order by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(bir::string,'ss,esgyn100,esgyn200,esgyn300'),id,find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(name,'ss,esgyn100,esgyn200,esgyn300');	

--group by
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1 group by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300');
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1 group by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(bir::string,'ss,esgyn100,esgyn200,esgyn300');

--混合
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1 order by find_in_set(find_in_set(name,'ss,esgyn100,esgyn200,esgyn300')::string,'ss,esgyn100,esgyn200,esgyn300') group by find_in_set(name,'ss,esgyn100,esgyn200,esgyn300'),find_in_set(bir::string,'ss,esgyn100,esgyn200,esgyn300');	


--子查询
--非相关子查询
select find_in_set(a.name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1 a where exists(select find_in_set(b.name,'ss,esgyn100,esgyn200,esgyn300') from dqltab2 b);

--集合查询
--union
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1
union
select find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle') from dqltab2 order by find_in_set;

--unionall
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1
union all
select find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle') from dqltab2 order by find_in_set;

--intersect
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1
intersect
select find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle') from dqltab2;


--except, --qianbase支持，mysql不支持
select find_in_set(name,'ss,esgyn100,esgyn200,esgyn300') from dqltab1
except
select find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle') from dqltab2;


--内连接
select * from dqltab1 a
inner join dqltab2 b
on find_in_set(a.name,'ss,esgyn100,esgyn200,esgyn300')=find_in_set(b.name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle');

--外连接
select * from dqltab1 a
left outer join dqltab2 b
on find_in_set(a.name,'ss,esgyn100,esgyn200,esgyn300')=find_in_set(b.name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle');

--交叉连接
select * from dqltab1 a
cross join dqltab2 b
where find_in_set(a.name,'ss,esgyn100,esgyn200,esgyn300')=find_in_set(b.name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle');


--作为数值函数的参数
select sum(find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle')) from dqltab2;
select abs(find_in_set(name,'ss,mysql,esgyn100,oracle,esgyn200,esgyn300,oracle')) from dqltab2;


--其他数据类型,目前均不支持
--bool
select find_in_set(cast(0 as bool),cast(0 as bool));
select find_in_set(cast(0 as bool)::varchar,cast(0 as bool)::varchar);

--byte
drop table if exists bytes;
CREATE TABLE bytes (a INT PRIMARY KEY, b BYTES);
INSERT INTO bytes VALUES (1, b'\141\142\143'), (2, b'\x61\x62\x63'), (3, b'\141\x62\c');
-- SELECT * FROM bytes;
select find_in_set(b,b) from bytes;
select find_in_set(b::char(10),b::char(10)) from bytes;

--date
select find_in_set(cast('2012-12-3' as date),cast('2012-12-3' as date));

--time
select find_in_set(cast('03:12:23' as time),cast('03:12:23' as time));
select find_in_set(cast('03:12:23' as time)::varchar(20),cast('03:12:23' as time)::char(20));

--timestamp
select find_in_set(cast('2016-01-25 10:10:10.555555' as timestamp),cast('2016-01-25 10:10:10.555555' as timestamp));
select find_in_set(cast('2016-01-25 10:10:10.555555' as timestamp)::varchar(20),cast('2016-01-25 10:10:10.555555' as timestamp)::char(20));

--decimal
select find_in_set(cast(1 as decimal),cast(1 as decimal));
select find_in_set(cast(1 as decimal)::text,cast(1 as decimal)::text);

--int
select find_in_set(cast(1 as int),cast(1 as int));
select find_in_set(cast(1 as int)::CHARACTER(10),cast(1 as int)::CHARACTER VARYING(9));

--float
select find_in_set(cast(1 as float),cast(1 as float));
select find_in_set(cast(1 as float)::CHAR VARYING,cast(1 as float)::CHAR VARYING(10));

--inet
select find_in_set(cast('192.168.0.1' as inet),cast('192.168.0.1' as inet));
select find_in_set(cast('192.168.0.1' as inet)::STRING,cast('192.168.0.1' as inet)::STRING);

--uuid
select find_in_set(cast('63616665-6630-3064-6465-616462656562' as uuid),cast('63616665-6630-3064-6465-616462656562' as uuid));
select find_in_set(cast('63616665-6630-3064-6465-616462656562' as uuid)::STRING(30),cast('63616665-6630-3064-6465-616462656562' as uuid)::string);

--两个参数均为数值，目前不支持
select find_in_set(12,12);   							--qianbase报错，mysql支持
select find_in_set(12::varchar(12),12::varchar(12));	--qianbase支持，mysql报错；
select find_in_set(cast(12 as char),cast(12 as char));	--qianbase支持，mysql支持

--两个参数均为decimal
select find_in_set(12.123,12.123); 						--qianbase报错，mysql支持


--两个参数为date
select find_in_set('2019-12-23'::date,'2019-12-23'::date); 
select find_in_set(cast('2019-12-26' as date),cast('201-12-26' as date));			--qianbase报错，mysql支持
drop table ddltab1; 
drop table ddltab2; 
drop table ddltab3; 
drop table dmltab1; 
drop table dmltab2; 
drop table dmltab3; 
drop table dqltab1; 
drop table dqltab2;
drop table mul1;
drop table str1;
drop table str2;
drop table str3;
drop table str4;
drop table str5;
drop table tab1;
drop table bytes;
