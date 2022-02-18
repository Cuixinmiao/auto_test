select nvl(null,now());
select nvl(null,0.999);
select nvl(null,1);
select nvl(null,array[1,2,3]);
select nvl(now(),null);
select nvl(0.9999,null);
select nvl(1,null);
select nvl(array[1,2,3],null);
drop table if exists cs_nvl;
create table cs_nvl(id int,soc decimal(3,1),name varchar,replicas int8[],today timestamp);
insert into cs_nvl values (1,1.3,'nihao',array[1,2,3],now());
insert into cs_nvl values (1,null,'nihao',array[1,2,3],now());
insert into cs_nvl values (1,0.99,null,array[1,2,3],now());
insert into cs_nvl values (1,0.99,'shishi',null,now());
insert into cs_nvl values (1,0.99,'shijiushi',array[5,2,0],null);
insert into cs_nvl values(null,10.2,'zazadi',array[8,5,7],now());
drop table if exists cs_nvl_id;
create table cs_nvl_id (fid int,name varchar);
insert into cs_nvl_id values(1,'lili');
insert into cs_nvl_id values(1,'xiao');
insert into cs_nvl_id values(3,'qi');
insert into cs_nvl_id values(4,'bu');
insert into cs_nvl_id values(5,'ting');
insert into cs_nvl_id values(null,'hua');
select nvl(id,null) from cs_nvl;
select nvl(soc,null) from cs_nvl;
select nvl(name,null) from cs_nvl;
select nvl(replicas,null) from cs_nvl;
select nvl(today,null) from cs_nvl;
select nvl(null,id) from cs_nvl;
select nvl(null,soc) from cs_nvl;
select nvl(null,name) from cs_nvl;
select nvl(null,replicas) from cs_nvl;
select nvl(null,today) from cs_nvl;
select nvl(id,10) from cs_nvl;
select nvl(soc,1.23) from cs_nvl;
select nvl (name,'xiaozi') from cs_nvl;
select nvl(replicas,array[1,6,5]) from cs_nvl;
select nvl(today,now()) from cs_nvl;
select nvl(id,1.3) from cs_nvl;
-- ERROR: incompatible NVL expressions: expected 1.3 to be of type int, found type decimal
-- SQLSTATE: 22023
-- 符合预期  int 和 flot 不可以转换 
select nvl(id,'1.5') from cs_nvl;
-- ERROR: incompatible NVL expressions: could not parse "1.5" as type int: strconv.ParseInt: parsing "1.5": invalid syntax
-- SQLSTATE: 22P02
-- 符合预期  int 和 flot 不可以转换
select nvl(id,'1') from cs_nvl;
select nvl(soc,1)  from cs_nvl;
select nvl(soc,'1.5') from cs_nvl;
select nvl(name,1) from cs_nvl;
select nvl(name ,1.5) from cs_nvl;
-- ERROR: incompatible NVL expressions: expected 1.5 to be of type varchar, found type decimal
-- SQLSTATE: 22023
-- 不符合预期nvl函数中 decimal 与varchar 类型应该可以支持隐式转换
select nvl(name,now()) from cs_nvl;
-- ERROR: incompatible NVL expressions: unknown signature: now() (desired <varchar>)
-- SQLSTATE: 42883
-- 不符合预期 date 类型应该可以转换为varchar 类型 最终显示出结果
select nvl(today ,'1993-05-10') from cs_nvl;
select nvl(replicas,1) from cs_nvl;
-- ERROR: incompatible NVL expressions: expected 1 to be of type int[], found type int
-- SQLSTATE: 22023
-- 符合预期oracle 表中目前没发现支持数组类型，oracle 在存储过程中支持数组类型，表中存数组为本数据库特性
select nvl(replicas,1.5) from cs_nvl;
-- ERROR: incompatible NVL expressions: expected 1 to be of type int[], found type decimal
-- SQLSTATE: 22023
-- 符合预期oracle 表中目前没发现支持数组类型，oracle 在存储过程中支持数组类型，表中存数组为本数据库特性
select nvl(replicas,'{1,2,3}') from cs_nvl;
select nvl(replicas,now())  from cs_nvl;
-- ERROR: incompatible NVL expressions: unknown signature: now() (desired <int[]>)
-- SQLSTATE: 42883
-- 符合预期oracle 表中目前没发现支持数组类型，oracle 在存储过程中支持数组类型，表中存数组为本数据库特性
select nvl('',1);
select nvl(null,1);
--  NVL('','1')
-----------------
--
-- (1 row)
-- 如果与oracle %100 兼容oracle 中的空串插入会被当做null值处理，这与本数据库表现不同，本数据库空串就是空串，后续需考虑 此类需要兼容否
select nvl(null,1);
select * from cs_nvl order by nvl(soc,10) desc;
select * from cs_nvl order by nvl(soc,10);
select id,soc,nvl(id,10) from cs_nvl group by nvl(id,10),id,soc;
select sum(nvl(id,10)) from cs_nvl;
select count(nvl(id,10)) from cs_nvl;
select max(nvl(id,10)) from cs_nvl;
select nvl(nvl(id,10),null) from cs_nvl;
select substr(nvl(name,'10'),1) from cs_nvl;
select length(nvl(name,'10')) from cs_nvl;
select lpad(nvl(name,'10'),10,' ') from cs_nvl;
select trim(lpad(nvl(name,'10'),10,' ')) from cs_nvl;
select id  from cs_nvl where id=nvl(id,1);
select * from cs_nvl where id in (select nvl(id,2) from cs_nvl);
select b.fid,b.name,a.replicas from cs_nvl a, cs_nvl_id b where nvl(id,3)=b.fid;
select b.fid,b.name,a.replicas from cs_nvl a full outer join cs_nvl_id b on  nvl(id,3)=b.fid; 
drop table cs_nvl_id;
drop table cs_nvl;
