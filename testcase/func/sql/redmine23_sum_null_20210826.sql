-- sum(null) test for v9.0.0-beta.1.xTP aarch64-redhat-linux, built 2021/08/24 05:32:28, go1.15.13
-- Author: cuixiangling
-- Date: 2021/08/26

-- generate data
drop table if exists t1;
create table t1(a int,b varchar(10));
insert into t1 values(1,'abc');
insert into t1 values(5,'dfc');
insert into t1 values(8,'ghtr');
insert into t1 values(2,'daes');
insert into t1 values(null,null);
insert into t1 values(null,'aaa');
insert into t1 values(null,'abc');
insert into t1 values(5,'dfc');
insert into t1 values(8,'ghtr');
insert into t1 values(2,'daes');
insert into t1 values(null,null);
insert into t1 values(null,'aaa');


drop table if exists t2;
create table t2(c int,d varchar(10));
insert into t2 values(1,'abc');
insert into t2 values(15,'dfc');
insert into t2 values(8,'dfhtr');
insert into t2 values(2,'ddes');
insert into t2 values(1,'abc');
insert into t2 values(15,'dfc');
insert into t2 values(8,'dfhtr');

-- 无from子句中使用
-- 仅有null
select sum(null);
select sum(null) over(partition by 1 order by 1);
select sum(null) over(partition by null order by null);
select sum(null) over();
select sum(null)+1;
select sum(null)*10;
select sum(null)/5;
select sum(null)||3;


-- 表达式 +,-,*,/等表达式，1+null,1*null
select sum(1+null);
select sum(1+null) over(partition by 1 order by 1);
select sum(1+null) over(partition by null order by null);
select sum(1+null) over();
select sum(null*0.5);
select sum(null*0.5) over(partition by 1 order by 1);
select sum(null*0.5) over(partition by null order by null);
select sum(null*0.5) over();

select sum(null/5);
select sum(null/5) over(partition by 1 order by 1);
select sum(null/5) over(partition by null order by null);
select sum(null/5) over();

select sum(null||'abc');
select sum(null||'abc') over(partition by 1 order by 1);
select sum(null||'abc') over(partition by null order by null);
select sum(null||'abc') over();
select sum(3*null) over(partition by c,d order by c,d);
-- 嵌套函数
select sum(nvl(null,null));
select sum(ifnull(null,null));
select sum(case 1 when 1 then null else null end);

-- 在dual中使用
-- 仅有null
select sum(null) from dual;
select sum(null) over(partition by 1 order by 1) from dual;
select sum(null) over(partition by null order by null) from dual;
select sum(null) over() from dual;
select sum(null)+1 from dual;
select sum(null)*10 from dual;
select sum(null)/5 from dual;
select sum(null)||3 from dual;


-- 表达式 +,-,*,/等表达式，1+null,1*null
select sum(1+null) from dual;
select sum(1+null) over(partition by 1 order by 1) from dual;
select sum(1+null) over(partition by null order by null) from dual;
select sum(1+null) over() from dual;
select sum(null*0.5) from dual;
select sum(null*0.5) over(partition by 1 order by 1) from dual;
select sum(null*0.5) over(partition by null order by null) from dual;
select sum(null*0.5) over() from dual;
select sum(null),sum(null);
select sum(null)+null;
select sum(null)+sum(null);
select sum(null)+max(null)+count(null);
select sum(null*0.5) over(),sum(null) over()  from dual;

select sum(null/5) from dual;
select sum(null/5) over(partition by 1 order by 1) from dual;
select sum(null/5) over(partition by null order by null) from dual;
select sum(null/5) over() from dual;

select sum(null||'abc') from dual;
select sum(null||'abc') over(partition by 1 order by 1) from dual;
select sum(null||'abc') over(partition by null order by null) from dual;
select sum(null||'abc') over() from dual; 
-- 嵌套函数
select sum(nvl(null,null)) from dual;
select sum(ifnull(null,null)) from dual;
select sum(case 1 when 1 then null else null end) from dual;
select sum(sum(null)) from dual;
select sum(count(null)) from dual;

-- 实体表中使用
-- sum内部表达式
-- 仅有null
select sum(null) from t1;
select sum(null) over(partition by a,b order by a,b) from t1;
select sum(null) over() from t1;
select sum(null) from t2;
select sum(null) over(partition by a,b order by a,b) from t2;
select sum(null) over() from t2;
-- 常量表达式,例如1+null等
select sum(null+1) from t1;
select sum(null+1) over(partition by a,b order by a,b) from t1;
select sum(null+1) over() from t1;
select sum(3*null) from t2;
-- partition by 和 order by的字段不存在
select sum(3*null) over(partition by a,b order by a,b) from t2;
select sum(3*null) over() from t2;
select sum(3*null) over(partition by c,d order by c,d) from t2;
select sum(null/5) over(partition by null order by null) from t2;
select sum(null/5) over(partition by null order by null) from t1;
-- 字段参与的表达式
select sum(a) from t1 group by b;
select sum(a) from t1;
select sum(a+null) from t1; -- bug99
select sum(a+null) from t1 group by b;
select sum(a) over () from t1;
select sum(a) over () from t1 group by a,b;
select sum(a) over (partition by null order by null) from t1;
select sum(a) over (partition by null order by null) from t1 group by a,b;
select sum(a) over (partition by a,b order by a,b) from t1;
select sum(a) over (partition by a,b order by a,b) from t1 group by a,b;
select sum(a) over (partition by c,d order by c,d) from t1;
select sum(a) over (partition by c,d order by c,d) from t1 group by a,b;

select sum(c) from t2 group by d;
select sum(c) from t2;
select sum(c+null) from t2;
select sum(c+null) from t2 group by d;
select sum(c) over () from t2;
select sum(c) over () from t2 group by d;
select sum(c) over (partition by null order by null) from t2 group by d;
select sum(c) over (partition by c,d order by c,d) from t2 group by c,d;

select sum(a) from t1;
select sum(a+null) from t1;
select sum(a+null) from t1 group by b;
select sum(a)+sum(a) from t1 group by b;
select sum(a)+sum(a) from t1;
select sum(a)+sum(null) from t1 group by b;
-- order by not same as group by
select sum(a+null) from t1 group by b order by a;
select sum(a)+sum(a) from t1 group by b order by b;
select sum(a)+sum(null) from t1 group by b order by b;



-- 嵌套函数
select sum(nvl(null,null)) from t1;
select sum(nvl(a,null)) from t1;
select sum(nvl(a,null)) from t1 group by a;
select sum(nvl(a,null)) from t1 group by c;

select sum(ifnull(c,null)) from t2;
select sum(nullif(c,null)) from t2;
select sum(case c when 1 then null else null end) from t2;

-- substr
select 1 from dual where substr('ab',3,5) is null;
select 1 from dual where substr('ab',3,5) is not null;
select 1 from dual where substr('ab',3,5)='';
select 1 from dual where substr('ab',3,5)!='';
select sum(substr('ab',3,5)) from dual;

-- union/union all/intersect/except中使用
select sum(null) from dual union all select sum(null+1) from dual order by sum;
select sum(null) from dual union select sum(null+1) from dual order by sum;
select sum(null) from dual intersect select sum(null+1) from dual;
select sum(null) from dual except select sum(null+1) from dual;
select sum(a) from t1 where b is null union all select sum(c) from t2 order by sum;
select sum(a) from t1 where b is null union select sum(c) from t2 order by sum;
select sum(a) from t1 where b is null intersect select sum(c) from t2;
select sum(a) from t1 where b is null except select sum(c) from t2;

select sum(null) over() from dual union all select sum(null+1) from dual order by sum;
select sum(null) over() from dual union select sum(null+1) from dual order by sum;
select sum(null) over() from dual intersect select sum(null+1) from dual;
select sum(null) over() from dual except select sum(null+1) from dual;

select sum(null) over(partition by null order by null) from dual union all select sum(null+1) from dual order by sum;
select sum(null) over(partition by null order by null) from dual union select sum(null+1) from dual order by sum;
select sum(null) over(partition by null order by null) from dual intersect select sum(null+1) from dual;
select sum(null) over(partition by null order by null) from dual except select sum(null+1) from dual;

select sum(a) from t1 where b is null union all select sum(c) over() from t2 order by sum;
select sum(a) from t1 where b is null union select sum(c) over() from t2 order by sum;
select sum(a) from t1 where b is null intersect select sum(c) over() from t2;
select sum(a) from t1 where b is null except select sum(c) over() from t2;



select sum(a) over(partition by a order by a) from t1 where b is not null group by a union all select sum(c) from t2 order by sum;
select sum(a) over(partition by a order by a) from t1 where b is not null group by a union select sum(c) from t2 order by sum;
select sum(a) over(partition by a order by a) from t1 where b is not null group by a intersect select sum(c) from t2;
select sum(a) over(partition by a order by a) from t1 where b is not null group by a except select sum(c) from t2;
select sum(a) over(partition by a order by a) from t1 where b is not null group by a minus select sum(c) from t2;

drop table if exists ts;
create table ts as select * from t1;
select sum(ts.a)+sum(t1.a) from ts,t1 where ts.b>t1.b group by t1.b;
select sum(ts.a)+sum(t1.a) aa from ts,t1 
where ts.b>t1.b group by t1.b 
union 
select sum(a) from t1 where b is not null group by b order by aa;
select sum(ts.a)+sum(t1.a) aa from ts,t1 where ts.b>t1.b group by t1.b union all select sum(null) from t1 group by a order by aa;
select sum(ts.a)+sum(t1.a) aa from ts,t1 where ts.b>t1.b group by t1.b union select sum(null) from t1 group by a order by aa;
select sum(ts.a)+sum(t1.a) from ts,t1 where ts.b>t1.b group by t1.b intersect select sum(null) from t1 group by a;
select sum(ts.a)+sum(t1.a) from ts,t1 where ts.b>t1.b group by t1.b except select sum(null) from t1 group by a;

-- 多表join
select sum(a)+sum(c) from t1 left join t2 on b=d where a is null group by b;
select sum(a)+sum(c) from t1 left join t2 on b=d where a is not null group by b;

select sum(a)+sum(c) from t1 right join t2 on b=d where a is null group by b;
select sum(a)+sum(c) from t1 right join t2 on b=d where a is not null group by b;

select sum(a)+sum(c) from t1 full join t2 on b=d where a is null group by b;
select sum(a)+sum(c) from t1 full join t2 on b=d where a is not null group by b;

drop table t1;


-- 不同的数据类型做如上操作 int，dec，number，float、interval等
create table t1(a interval,b varchar(20));
insert into t1 values(INTERVAL '1 year 2 months 3 days 4 hours 5 minutes 6 seconds','abc');
insert into t1 values(INTERVAL '1-2 3 4:5:6','cde');
insert into t1 values(null,'ryh');
insert into t1 select * from t1;

select sum(a)+null from t1 group by b;
select sum(a) from t1;
select sum(a) from t1 group by b;
delete from t1 where a is not null;
select sum(a) from t1;
select sum(null) from t1;

drop table t1;
drop table t2;
drop table ts;
