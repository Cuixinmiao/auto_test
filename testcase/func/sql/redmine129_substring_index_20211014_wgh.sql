drop DATABASE if exists test_substring_index_db;
create database test_substring_index_db;
use test_substring_index_db;

--douhongchao CASE
select SUBSTRING_INDEX('W,lss,151,152,16','1',1) from dual;
select SUBSTRING_INDEX('!,lss,151,152,16','1',1) from dual;
select SUBSTRING_INDEX('1,@,151,152,16','1',1) from dual;
select SUBSTRING_INDEX('1,@,151,152,16','1',2) from dual;
select SUBSTRING_INDEX('1,null,151,152,16',',',2) from dual;
select SUBSTRING_INDEX('1,null,151,152,16',null,2) from dual;
select SUBSTRING_INDEX('123你1你','你',1) from dual;
select SUBSTRING_INDEX('123 1 ',' ',2) from dual;
select SUBSTRING_INDEX('123Q1 ','Q',1) from dual;
select SUBSTRING_INDEX('123@1 ','@',1) from dual;
select SUBSTRING_INDEX('123"1 ','"',1) from dual;
select SUBSTRING_INDEX('123.1 ','.',1) from dual;
select SUBSTRING_INDEX('123\'1','\'',1) from dual; --mysql 
select SUBSTRING_INDEX('123)1',')',1) from dual;
select SUBSTRING_INDEX('123|1','|',1) from dual;
select SUBSTRING_INDEX('4123|12','1',1.1) from dual; --mysql 4舍5入
select SUBSTRING_INDEX('4123|12','1',12) from dual;


--str 参数测试
select substring_index('www.esgyn.com','.',1);
select substring_index('WWW.ESGYN.COM','.',2);
select substring_index('www.ESGYN.Com','.',-2);
select substring_index('(!@#$%^&*()\/?<>~|;)111.(!@#$%^&*()\/?.<>~|;)222.(!@#$%^&*()\/?.<>~|;)333','.',2);
select substring_index('(!@#$%^&*()\/?<>~|;)111.(!@#$%^&*()\/?.<>~|;)222.(!@#$%^&*()\/?.<>~|;)222','.',-2);
select substring_index('！@#￥%……&*（100）.！@#￥%……&*（200）.！@#￥%……&*（300）','.',2);
select substring_index('！@#￥%……&*（100）.！@#￥%……&*（200）.！@#￥%……&*（300）','.',-2);
select substring_index('{（1）}.{（2）}.{（3）}','.',2);
select substring_index('{（1）}.{（2）}.{（3）}','.',-2);
--mysql 报参数个数不对，xtp执行成功，需要提交bug
select substring_index(null,111,'.',1);  
select substring_index('www esgyn com',' ','3',null);


select substring_index('null','.',1);
select substring_index(null,'.',1);
select substring_index('null,null,100',',',2);
select substring_index('null,null,100',',',-2);
select substring_index('',',',2);
select substring_index('aaa,bbb',',',0);
select substring_index('Replication Zone，通过zone，可以配置集群中replica的副本数量，限定数据存储地点，配置垃圾回收（较旧的MVCC数据）时间等，配置粒度从cluster，database，table，到row。配置方法通过参数写入YAML文件配置，共有这些配置参数','，',100);
select substring_index('Replication Zone，通过zone，可以配置集群中replica的副本数量，限定数据存储地点，配置垃圾回收（较旧的MVCC数据）时间等，配置粒度从cluster，database，table，到row。配置方法通过参数写入YAML文件配置，共有这些配置参数','，',-7);
select substring_index('abcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgdddddddddddddddddddddddddddd00000000000000000000000000000000000000abcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgddddddddddddddddddddddddddddabcdefadfdfdgdgadddddddddddddddddddddgdgdgdgdgdgdddddddddddddddddddddddddddd00000000000000000000000000000000000000&11111111111111111111111111111111122222222222222222333333333333333344444444444444555555555555','&','1');


--delim参数测试
select substring_index('中国。天津。南开','。',2);
select substring_index('中国。天津。南开','。',-2);
select substring_index('中国·天津·南开','·',-2);
select substring_index('www''esgyn''','''',2);
select substring_index('www''esgyn''','''',1);
select substring_index('www@esgyn@com','@',2);
select substring_index('www@esgyn@com','@',-2);
select substring_index('www$esgyn$com','$',2);
select substring_index('www$esgyn$com','$',-2);
select substring_index('www`esgyn`com','`',2);
select substring_index('www`esgyn`com','`',-2);
select substring_index('www%esgyn%com','%',2);
select substring_index('www%esgyn%com','%',-2);
select substring_index('www#esgyn#com','#',2);
select substring_index('www#esgyn#com','#',-2);
select substring_index('www^esgyn^com','^',2);
select substring_index('www^esgyn^com','^',-2);
select substring_index('www&esgyn&com','&',2);
select substring_index('www&esgyn&com','&',-2);
select substring_index('www*esgyn*com','*',2);
select substring_index('www*esgyn*com','*',-2);
select substring_index('www(esgyn(com','(',2);
select substring_index('www(esgyn(com','(',-2);
select substring_index('www_esgyn_com','_',2);
select substring_index('www_esgyn_com','_',-2);
select substring_index('www+esgyn+com','+',2);
select substring_index('www+esgyn+com','+',-2);
select substring_index('wwwesgyncom','',2);
select substring_index('www esgyn com',' ',2);
select substring_index('www esgyn com','  ',1);
select substring_index('www  esgyn com','  ',1);
select substring_index('www dd  esgyn com',' ',-4);
select substring_index('www|esgyn|com','|',2);
select substring_index('www|esgyn|com','|',-2);
select substring_index('www"esgyn"com','"',2);
select substring_index('www"esgyn"com','"',-2);
select substring_index('www?esgyn?com','?',2);
select substring_index('www?esgyn?com','?',-2);
select substring_index('www~esgyn~com','~',2);
select substring_index('www~esgyn~com','~',-2);
select substring_index('www！esgyn！com','！',2);
select substring_index('www!esgyn！com','！',-2);
select substring_index('www￥esgyn￥com','￥',2);
select substring_index('www￥esgyn￥com','￥',-2);
select substring_index('www（esgyn（com','（',2);
select substring_index('www（esgyn（com','（',-2);
select substring_index('www、esgyn、com','、',2);
select substring_index('www、esgyn、com','、',-2);
select substring_index('www……esgyn……com','……',2);
select substring_index('www……esgyn……com','……',-2);
select substring_index('waaww A esagyn A coam','A',2);
select substring_index('wwAAw a esAgyn a coAm','a',-2);
select substring_index('wwAAw  esAgyn a coAm','a',-2);
select substring_index('wwAAw a esAgyn a coAm','a',-2);
select substring_index('www null esgyn null com','null',2);
select substring_index('www null esgyn null com','null',-2);
select substring_index('www null esgyn null com',null,2);
select substring_index('www null esgyn null com',null,-2);
select substring_index('www 中 esgyn 中 com','中',2);
select substring_index('www 中 esgyn 中 com','中',-2);
select substring_index('www 華 esgyn 華 com','華',2);
select substring_index('www 華 esgyn 華 com','華',-2);
select substring_index('www 瓣 esgyn 瓣 com','瓣',-2);
select substring_index('www 瓣 esgyn 瓣 com','瓣',-2);
select substring_index('www 0x81 esgyn 0x81 com','0x81',2);
select substring_index('www 0x81 esgyn 0x81 com','0x81',-2);
select substring_index('www 中華瓣 esgyn 中華瓣 com','中華瓣',2);
select substring_index('www 中華瓣 esgyn 中華瓣 com','中華瓣',-2);
select substring_index('www 123中華瓣 esgyn 123中華瓣 com','123中華瓣',2);
select substring_index('www 123中華瓣 esgyn 123中華瓣 com','123中華瓣',-2);
select substring_index('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com','!@#$%^&*()\/?<>',2);
select substring_index('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com','!@#$%^&*()\/?<>',-2);
select substring_index('www AaA esgyn AaA com','AaA',2);
select substring_index('www AaA esgyn AaA com','AaA',-2);
select substring_index('www NUllnull esgyn NUllnull com','NUllnull',2);
select substring_index('www NUllnull esgyn NUllnull com','NUllnull',-2);
select substring_index('www ''" esgyn ''" com','''"',2);
select substring_index('www ''" esgyn ''" com','''"',-2);
select substring_index('www ''"" esgyn ''" com','''"',2);
select substring_index('www ''"" esgyn ''" com','''"',-2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',-2);
select substring_index('www{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}com','{分隔符}',6);
select substring_index('www{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}comwww{分隔符}esgyn{分隔符}com','{分隔符}',-8);

--count参数测试
select SUBSTRING_INDEX('4123|12','1',1.1::int) from dual;
select SUBSTRING_INDEX('4123|12','1',1.5::int) from dual;
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',-9223372036854775807);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775808);
--超过int 越界报如下错误
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',-9223372036854775808);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}','！！');
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',0);

--参数为字段测试及insert DELETE
--str为字段
drop table if EXISTS houseinfo ;
CREATE TABLE houseinfo(houseCode VARCHAR(50),lou VARCHAR(200),men VARCHAR(200),fang VARCHAR(200));
drop table if EXISTS houseinfo_insert ;
CREATE TABLE houseinfo_insert(houseCode VARCHAR(50),lou VARCHAR(200),men VARCHAR(200),fang VARCHAR(200));
INSERT INTO houseinfo VALUES('11-2-5','11',2,'5');
INSERT INTO houseinfo VALUES('11栋-2层-003室','11栋','2层','003室');
INSERT INTO houseinfo VALUES('11栋-2层-4室','11栋','2层','4室');
INSERT INTO houseinfo VALUES('11栋-3层-001室','11栋','3层','001室');
INSERT INTO houseinfo VALUES('11栋-3层-002室','11栋','3层','002室');
INSERT INTO houseinfo VALUES('11栋-3层-003室','11栋','3层','003室');
INSERT INTO houseinfo VALUES('11栋-2层-6室','11栋','2层','6室');
INSERT INTO houseinfo VALUES(null,'11栋','2层','6室');
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,'-',1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,'-',2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,'-',-1) AS fang FROM houseinfo hi;
insert into houseinfo_insert SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,'-',1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,'-',2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,'-',-1) AS fang FROM houseinfo hi;

--str delim为字段  --order BY
drop table if EXISTS houseinfo2 ;
drop table if EXISTS houseinfo2_insert ;
CREATE TABLE houseinfo2(houseCode VARCHAR(50),lou VARCHAR(200),men VARCHAR(200),fang VARCHAR(200),delim varchar(20));
CREATE TABLE houseinfo2_insert(houseCode VARCHAR(50),lou VARCHAR(200),men VARCHAR(200),fang VARCHAR(200),delim varchar(20));
INSERT INTO houseinfo2 VALUES('11!@#$%^&*()\/?<>2!@#$%^&*()\/?‘’''<>5','11','2','5','!@#$%^&*()\/?‘’''<>');
INSERT INTO houseinfo2 VALUES('11栋{分隔符}2层{分隔符}003室','11栋','2层','003室','{分隔符}');
INSERT INTO houseinfo2 VALUES('11栋NULL2层NULL4室','11栋','2层','4室','NULL');
INSERT INTO houseinfo2 VALUES('11栋NULL3层NULL001室','11栋','3层','001室',NULL);
INSERT INTO houseinfo2 VALUES('11栋 3层 002室','11栋','3层','002室',' ');
INSERT INTO houseinfo2 VALUES('11栋AaA3层AaA003室','11栋','3层','003室','AaA');
INSERT INTO houseinfo2 VALUES('11栋0x81華2层0x81華6室','11栋','2层','6室','0x81華');
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi order by men,fang;
INSERT INTO houseinfo2_insert SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang,delim FROM houseinfo2 hi order by men,fang;
SELECT * FROM houseinfo2_insert;

---UNION
select substring_index(null,',',2) UNION select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
select substring_index(null,',',2) UNION select substring_index('www{分隔符}esgyn{分隔符}com',NULL,2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807) UNION select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi UNION SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi order by men,fang;
---UNION ALL
select substring_index(null,',',2) UNION ALL select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
select substring_index(null,',',2) UNION ALL select substring_index('www{分隔符}esgyn{分隔符}com',NULL,2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807) UNION ALL select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi UNION ALL SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi order by men,fang;

--INTERSECT
select substring_index(null,',',2) INTERSECT select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
select substring_index(null,',',2) INTERSECT select substring_index('www{分隔符}esgyn{分隔符}com',NULL,2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807) INTERSECT select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi INTERSECT SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi order by men,fang;

--except
select substring_index(null,',',2) except select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
select substring_index(null,',',2) except select substring_index('www{分隔符}esgyn{分隔符}com',NULL,2);
select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807) except select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',2);
SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi except SELECT hi.houseCode,SUBSTRING_INDEX(hi.houseCode,hi.delim,1) AS lou,SUBSTRING_INDEX(SUBSTRING_INDEX(hi.houseCode,hi.delim,2),'-',-1) AS men,SUBSTRING_INDEX(hi.houseCode,hi.delim,-1) AS fang FROM houseinfo2 hi order by men,fang;


--三个均为字段
drop table if EXISTS t1;
drop table if EXISTS tx;
create table t1 (strcol varchar(200),delimcol varchar(200),counts int);
create table tx (strcol varchar(200));
insert into t1 values('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com!@#$%^&*()\/?<>dddddddddd!@#$%^&*()\/?<>','!@#$%^&*()\/?<>',3);
insert into t1 values('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com','!@#$%^&*()\/?<>',-2);
insert into t1 values('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807);
insert into t1 values('www{分隔符}esgyn{分隔符}com','{分隔符}',-9223372036854775807);

select substring_index(strcol,delimcol,counts) from t1;
select LENGTH(substring_index(strcol,delimcol,counts))from t1;

--INSERT INTO SELECT
insert into tx select substring_index(strcol,delimcol,counts) from t1;
select * from tx;

select substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807);
select substring_index(strcol,delimcol,counts) from t1  where counts=9223372036854775807;

select substr(substring_index('www{分隔符}esgyn{分隔符}com','{分隔符}',9223372036854775807),5,20)from t1 where counts=9223372036854775807;

--此条sql结果集不正确，substr问题 
select substr(substring_index(strcol,delimcol,counts),5,20)from t1 where counts=9223372036854775807;

select substr(substring_index(strcol,delimcol,counts),5,20)from t1 where counts=3;

--dml测试
drop table if EXISTS t2;
create table t2 (col1 int,col2 varchar(200));
insert into t2 values(1,substring_index('www 中華瓣 esgyn 中華瓣 com','中華瓣',-2));
insert into t2 values(2,substring_index('中国。天津。南开','。',2));
insert into t2 values(3,substring_index('www 123中華瓣 esgyn 123中華瓣 com','123中華瓣',2));
insert into t2 values(4,substring_index('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com','!@#$%^&*()\/?<>',2));
insert into t2 values(5,substring_index('www null esgyn null com',null,2));
select * from t2;
DELETE from t2 where col2 = substring_index('www !@#$%^&*()\/?<> esgyn !@#$%^&*()\/?<> com','!@#$%^&*()\/?<>',2);
DELETE from t2 where substring_index('www null esgyn null com',null,2) is not NULL;
update t2 set col2 = substring_index('www……esgyn……com','……',2) where col1=3;
select * from t2;


--查看返回类型
drop table if EXISTS t2_type;
create TABLE t2_type AS select substring_index(substring_index('www.esgyn.cn','.',2),'.',1) as substringcol;
show columns from t2_type;

--substring_index 自身嵌套测试
select substring_index(substring_index('www.esgyn.cn','.',2),'.',1);
select substring_index(substring_index('www.esgyn.cn','.',2),'.',-1);
select substring_index(substring_index('www.esgyn.com.cn','.',3),'.',-1);
select substring_index(substring_index('www.esgyn.com.cn','.',3),'.',-2);
select substring_index(substring_index(substring_index('www.esgyn.com.cn','.',3),'.',-2),'.',-1);
select substring_index(substring_index(substring_index('www.esgyn.com.cn','.',3),'.',-2),'.',1);
select substring_index(substring_index(substring_index('www''esgyn''com''cn','''',3),'''',-2),'''',-1);
select substring_index(substring_index(substring_index('www!@#$%^&*()\/?<>esgyn!@#$%^&*()\/?<>com!@#$%^&*()\/?<>cn','!@#$%^&*()\/?<>',3),'!@#$%^&*()\/?<>',-2),'''',1);

--LENGTH MAX
select substring_index(SUBSTR('www.esgyn.cn',2,15),'.',1);
select substring_index(SUBSTR('www.esgyn.cn',2,15),SUBSTR('www.esgyn.cn',4,1),LENGTH('a'));
select substring_index(SUBSTR('www.esgyn.cn',2,15),SUBSTR('www.esgyn.cn',4,1),max(1));

--find_in_set
SELECT find_in_set(substring_index(substring_index('www.esgyn.cn','.',2),'.',2),'abc,ccc,www.esgyn');
SELECT find_in_set(substring_index(substring_index('www.esgyn.cn','.',2),'.',2),substring_index('www.esgyn.cn','.',2));
SELECT find_in_set(substring_index(substring_index(NULL,'.',2),'.',2),'abc,ccc,www.esgyn');
SELECT find_in_set(substring_index(substring_index(NULL,'.',2),'.',2),substring_index(substring_index(substring_index('www!@#$%^&*()\/?<>esgyn!@#$%^&*()\/?<>com!@#$%^&*()\/?<>cn','!@#$%^&*()\/?<>',3),'!@#$%^&*()\/?<>',-2),'''',1));

--sum / MAX
SELECT SUM(find_in_set(substring_index(substring_index('www.esgyn.cn','.',2),'.',2),'abc,ccc,www.esgyn'));
SELECT MAX(find_in_set(substring_index(substring_index('www.esgyn.cn','.',2),'.',2),'abc,ccc,www.esgyn'));
SELECT MAX(substring_index(substring_index('www.esgyn.cn','.',2),'.',1));

--LPAD/ RPAD
select substring_index(lpad('www.esgyn.cn',20,'1'),'.',1);
select substring_index(rpad('www.esgyn.cn',20,'1'),'.',-1);
select lpad(substring_index(rpad('www.esgyn.cn',20,'1'),'.',-1),20,'wgh');

--NVL函数
select nvl(substring_index(substring_index('www.esgyn.cn','.',2),'.',1),'aaa');
select nvl(substring_index(substring_index(null,'.',2),'.',1),'aaa');
select nvl(substring_index(substring_index('www.esgyn.cn','.',2),'.',1),substring_index('aaaaa.bbbbb.cccccc','.',2));
select nvl(substring_index(substring_index(null,'.',2),'.',1),substring_index(substring_index(null,'.',2),'.',1));
SELECT substring_index(NVL('www.esgyn.cn','aaa'),'.',2);
SELECT substring_index(NVL('NULL','www.esgyn.cn'),'.',2);
SELECT substring_index(NVL(NULL,'www.esgyn.cn'),'.',2);

--SUBSTR
select substr(substring_index('www.esgyn.cn','.',2),3,10) ;
select substr(substring_index(NULL,'.',2),3,10) ;
select substr(substring_index('www.esgyn.cn',NULL,2),3,10) ;
select 1 from dual where substr(substring_index('www.esgyn.cn','.',2),11,15) is null;
select 1 from dual where substr(substring_index('www.esgyn.cn','.',2),11,15) is not null;
select 1 from dual where substr(substring_index('www.esgyn.cn','.',2),11,15)='';
select 1 from dual where substr(substring_index('www.esgyn.cn','.',2),11,15)!='';

--LENGTH 
SELECT length(substring_index('www 中華瓣 esgyn 中華瓣 com','中華瓣',-2));
SELECT length(substring_index('www.esgyn.com','.',2));
SELECT length(substring_index(null,'.',2));
SELECT length(substring_index('null','null',2));
SELECT length(substring_index('www 中華瓣 esgyn 中華瓣 com','中華瓣',length('aa')));

--TRIM
select substring_index(TRIM('www esgyn com'),' ',2);
select substring_index(TRIM('www esgyn com'),null,2);
select substring_index(TRIM('   111  www esgyn com  '),' ',2);
select substring_index(TRIM('   111  www esgyn com  '),' ',-3);
select substring_index(TRIM('   111!@#$%^&*()<>?|":www!@#$%^&*()<>?|":esgyn!@#$%^&*()<>?|":com  '),TRIM(' !@#$%^&*()<>?|": '),-3);
select TRIM(substring_index(' www esgyn  cn',' ',2));

--CONCAT
select substring_index(CONCAT('www.','esgyn.cn'),'.',3);
select substring_index(CONCAT('www.','esgyn.cn'),'.',2);
select substring_index(CONCAT('wwwAa','esgynAacn'),CONCAT('A','a'),3);
select substring_index(CONCAT('wwwAa','esgynAacn'),CONCAT('A','a'),2);
select CONCAT(substring_index(CONCAT('wwwAa','esgynAacn'),NULL,2),substring_index(CONCAT('wwwAa','esgynAacn'),CONCAT('A','a'),2));
select CONCAT(substring_index(CONCAT('wwwAa','esgynAacn'),CONCAT('A','a'),2),substring_index(CONCAT('wwwAa','esgynAacn'),CONCAT('A','a'),2));

--子查询
drop TABLE if EXISTS Websites;
CREATE TABLE Websites(id int,name varchar(200),url VARCHAR(200),alexa int,country varchar(200));
insert into Websites values(1,'Google','https://www.google.cm/' ,1,'USA');
insert into Websites values(2,'淘宝',' http://www.runoob.com/' ,13,'CN');
insert into Websites values(3,'菜鸟教程','http://www.runoob.com/' ,5000,'USA');
insert into Websites values(4,'微博','http://weibo.com/' ,20,'CN');
insert into Websites values(5,'Facebook','https://www.facebook.com/' ,3,'USA');
insert into Websites values(7,'stackoverflow','http://stackoverflow.com/' ,0,'IND');
--IN、EXISTS
select * from Websites where name in (substring_index('淘宝.alibaba','.',1),substring_index('Google.alibaba','.',1));
select * from Websites where EXISTS (select substring_index(url,'.',10) from Websites);

drop TABLE if EXISTS Websites2;
CREATE TABLE Websites2(id int,name varchar(200),url VARCHAR(200),alexa int,country varchar(200));
insert into Websites2 values(1,'Google','https://www.google.cm/' ,1,'USA');
insert into Websites2 values(2,'淘宝',' http://www.runoob.com/' ,13,'CN');
insert into Websites2 values(3,'菜鸟教程','http://www.runoob.com/' ,5000,'USA');
insert into Websites2 values(7,'微博','http://weibo.com/' ,20,'CN');
insert into Websites2 values(8,'Facebook','https://www.facebook.com/' ,3,'USA');
insert into Websites2 values(9,'stackoverflow','http://stackoverflow.com/' ,0,'IND');
--join
select substring_index(t1.url,'.','2') from Websites as t1 join Websites2 as t2 on t1.id = t2.id;
select substring_index(t1.url,'.','2') from Websites as t1 left join Websites2 as t2 on t1.id = t2.id;
select substring_index(t1.url,'.','2') from Websites as t1 right join Websites2 as t2 on t1.id = t2.id;
select substring_index(t1.url,'.','2') from Websites as t1 inner join Websites2 as t2 on t1.id = t2.id;
select substring_index(t1.url,'.','2') from Websites as t1 full join Websites2 as t2 on t1.id = t2.id;
select substring_index(t1.url,'.','2') from Websites as t1 , Websites2 as t2 where t1.id = t2.id;

--where 
select substring_index(config,'=','1') as substr,count(*) from system.replication_constraint_stats group by substr;
select 1 from dual where substring_index(NULL,'.',2) is null;
select 1 from dual where substring_index(NULL,'.',2) is not null;
select 1 from dual where substring_index('..','.',1) ='';
select 1 from dual where substring_index(' . . ','.',1) =' ';







