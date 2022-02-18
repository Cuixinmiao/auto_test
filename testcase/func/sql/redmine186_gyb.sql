
drop table if exists cim_rtl_inf ;
create table cim_rtl_inf(bankno varchar(3) not null,custno varchar(10) not null primary key, custname varchar(500) not null,stsrcd varchar(2),a varchar(10));
create index idx on cim_rtl_inf(bankno,custname);

insert into cim_rtl_inf select '100', '000'||generate_series(2000001, 3000000)::varchar,'周星驰','1','sadfe';
insert into cim_rtl_inf select '100', '000'||generate_series(4000001, 5000000)::varchar,'周星驰','2','sadfe';
insert into cim_rtl_inf select '100', '000'||generate_series(3000001, 4000000)::varchar,'周星驰','1','sadfe';
insert into cim_rtl_inf select '100', '000'||generate_series(8000001, 9000000)::varchar,'周星驰','1','sadfe';
insert into cim_rtl_inf select '100', '000'||generate_series(6000001, 7000000)::varchar,'周星驰','1','sadfe';

select count(*) from [show ranges from table cim_rtl_inf];

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;


select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;


select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;


drop table if exists cim_rtl_inf1 ;
create table cim_rtl_inf1(
bankno varchar(3) not null,
custno varchar(10) primary key,
mngadsc varchar(8),
custname varchar(500) not null,
custtype varchar(2) not null,
flgfrndgnt varchar(1),
custstg varchar(1),
custlv1 varchar(3),
fstnam varchar(200),
lstname varchar(200),
sltnam varchar(1),
srtnam varchar(200),
formnam varchar(200),
cna varchar(3),
sex varchar(1),
bld varchar(2),
folk varchar(2),
dtbrthday varchar(8),
rsdntat varchar(2),
rsdnflg varchar(1),
lang varchar(5),
edct varchar(2),
major varchar(3),
occup varchar(5),
ocprmk varchar(60),
wrkcom varchar(200),
comnatr varchar(4),
dtonboard varchar(8),
comdpt varchar(30),
pstn varchar(10),
title varchar(3),
monincome dec(20,2),
yeaincom dec(20,2),
comtel varchar(30),
comtelex varchar(30),
compstcod varchar(6),
comaddr varchar(120),
comfax varchar(30),
marristat varchar(2),
childrstat varchar(1),
famincom dec(20,2),
taxno varchar(40),
taxpayaddr varchar(120),
taxdcl varchar(200),
ntaxrsn varchar(200),
socinsuno varchar(40),
taxr dec(10,6),
iscomp varchar(1),
empno varchar(8),
brcno varchar(10),
exctflg varchar(1),
shareflg varchar(1),
ftaflg varchar(1),
flgslp varchar(1),
flgfrz varchar(1),
flgdie varchar(1),
flglock varchar(1),
flgdump varchar(1),
crdtlvl varchar(1),
stscust varchar(1),
chnlopen varchar(6),
brcadsc varchar(10),
imgid varchar(32),
flgccardc varchar(1),
enqpass varchar(32),
remark1 varchar(200),
remark2 varchar(200),
creuid varchar(8),
dtcreate varchar(8),
brccre varchar(10),
modteller varchar(8),
modbrc varchar(10),
moddate varchar(8),
stsrcd varchar(2),
crttime timestamp(6),
updtime timestamp(6),
flghandper varchar(1)
);

insert into cim_rtl_inf1(bankno,custno, custname,custtype,stsrcd) select '100', '000'||generate_series(2000001, 3000000)::varchar,'周星驰','fe','1';
insert into cim_rtl_inf1(bankno,custno, custname,custtype,stsrcd) select '100', '000'||generate_series(4000001, 5000000)::varchar,'周星驰','fe','2';
insert into cim_rtl_inf1(bankno,custno, custname,custtype,stsrcd) select '100', '000'||generate_series(3000001, 4000000)::varchar,'周星驰','sa','1';
insert into cim_rtl_inf1(bankno,custno, custname,custtype,stsrcd) select '100', '000'||generate_series(8000001, 9000000)::varchar,'周星驰','sa','1';
insert into cim_rtl_inf1(bankno,custno, custname,custtype,stsrcd) select '100', '000'||generate_series(6000001, 7000000)::varchar,'周星驰','sa','1';

create index idx on cim_rtl_inf1(bankno,custname);
select count(*) from [show ranges from table cim_rtl_inf1];
select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;

select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1' order by custno desc
)t1 where rownum<=20
)t2 where rn>=10;



select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;


select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;


select t2.* from(
select t1.*,rownum rn from (select * from cim_rtl_inf1 where stsrcd='1'
)t1 where rownum<=20 order by custno desc
)t2 where rn>=10;

drop table cim_rtl_inf1;
drop table cim_rtl_inf;
