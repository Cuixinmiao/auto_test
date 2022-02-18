drop table if exists cs_sub;
drop table if exists cs_subf;
create table cs_sub (id int,name varchar,soc decimal(10,2));
insert into cs_sub values(1,'xiaowang',100.2);
insert into cs_sub values(2,'xiaoli',100.2);
insert into cs_sub values(2,'xiaoli',100.3);
insert into cs_sub values(2,'xiaoli',101.3);
insert into cs_sub values(3,null,1000.3);
CREATE TABLE cs_subf (fid INT ,name varchar);
insert into cs_subf values(3,'bavi');
insert into cs_subf values(1,'badv');
insert into cs_subf values(1,'alava');
insert into cs_subf values(2,'xiaom');
select substr('nihao',1,2) from dual;
select substr('niaho',0,2) from dual;
select substr('niaho',3) from dual;
select substr('niaho',-1) from dual;
select substr('niaho',-10) from dual;
select substr('niaho',3,-1) from dual;
select substr('nihao',1.5) from dual;
select substr('nihao',-6,5) from dual;
select substr('nihao',-1,9) from dual;
-- ERROR: unknown signature: substr(string, decimal)
-- SQLSTATE: 42883
select substr('nihao',-1.5) from dual;
-- ERROR: unknown signature: substr(string, decimal)
-- SQLSTATE: 42883
select substr('nihao','1','2') from dual;
-- ERROR: unknown signature: substr(string, string, string)
-- SQLSTATE: 42883
select substr('nihao'::varchar,'1','2') from dual;
 -- substr
----------
 -- ni
-- (1 row)
select substr('nihao','1','1.6') from dual;
-- ERROR: unknown signature: substr(string, string, string)
-- SQLSTATE: 42883
select substr('nihao'::varchar,'1','1.6') from dual;
-- ERROR: unknown signature: substr(varchar, string, string)
select substr(1.5555,1,22) from dual;
-- ERROR: unknown signature: substr(decimal, int, int)
-- SQLSTATE: 42883
select substr(111111,1,3) from dual;
select substr(name,1,2) from cs_sub;
select substr (name,2) from cs_sub;
select substr(name,1,2,3) from cs_sub;
-- ERROR: unknown signature: substr(varchar, int, int, int)
-- SQLSTATE: 42883
select substr(name,'1','2') from cs_sub;
select substr(name,1.3,2.7) from cs_sub;
-- ERROR: unknown signature: substr(varchar, decimal, decimal)
-- SQLSTATE: 42883
select substr(name ,-1.3,2) from cs_sub;
-- ERROR: unknown signature: substr(varchar, decimal, int)
-- SQLSTATE: 42883
insert into cs_sub values(1,substr('zhangliang',1,3),109.4);
delete  from cs_sub where name=substr('zhangliang',1,3);
update cs_sub  set soc=130.5 where name=substr('xiaoliy',1,6);
select max(substr(name,1)) from cs_sub;
select min(substr(name,1)) from cs_sub;
select length(substr(name,1)) from cs_sub;
select  avg(length(substr(name,1))) from cs_sub;
select sum(length(substr(name,1))) from cs_sub;
select nvl(name,substr('null',1,3)) from cs_sub;
select * from cs_sub a,cs_subf b  where substr(a.name,1,4)='xiao';
select * from cs_sub order by substr(name,1,4);
select id,substr(name,1,4) from cs_sub group by id, substr(name,1,4);
select * from cs_sub where substr(name,1,4) in (select substr(name,1,4) from cs_subf);
select * from cs_sub a full outer join cs_subf b  on substr(b.name,1,4)='xiao';
select id,name from cs_sub a
union
select fid,name from cs_subf b where substr(name,1,4)='xiao' order by id,name;

select id,name from cs_sub a
union all
select fid,name from cs_subf b where substr(name,1,4)='xiao' order by id,name;

select id,name from cs_sub a
INTERSECT
select fid,name from cs_subf b  where substr(name,1,4)='xiao';

select id,name from cs_sub a
EXCEPT
select fid,name from cs_subf b where substr(name,1,4)='xiao';
drop table if exists cs_sub;
drop table if exists cs_subf;
