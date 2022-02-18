drop table if exists t1;
create table t1(a int, b varchar(100), c varchar(100), d varchar(1000));
insert into t1 select generate_series(1,4718590), '2111111111111111111111111', '1111111111111111111111', '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111121';
set session distsql='off';
\| aa=`ps -ef | grep qianbase | head -n1 | awk -F"store=" '{print $2}' |awk '{print $1}'`;rm -rf ${aa}/extern/bug ; mkdir -p ${aa}/extern/bug ;
export into csv "nodelocal://1/bug" WITH delimiter=e'\x01', nullas='',chunk_rows='100000000', chunk_size='10000MB'  FROM TABLE t1;
\| aa=`ps -ef | grep qianbase | head -n1 | awk -F"store=" '{print $2}' |awk '{print $1}'`;mkdir -p ${aa}/extern/bug; \cp ${aa}/extern/bug/`ls -tr ${aa}/extern/bug | grep csv | head -n1`  ${aa}/extern/bug/aa.csv;  sed -i '1i\"' ${aa}/extern/bug/aa.csv ; sed -i '800000a\"' ${aa}/extern/bug/aa.csv ;
drop table if exists t2;
IMPORT TABLE t2 (a int, b varchar(100), c varchar(100), d varchar(1000)) csv data ("nodelocal://1/bug/aa.csv") WITH delimiter=e'\x01';

\| aa=`ps -ef | grep qianbase | head -n1 | awk -F"store=" '{print $2}' |awk '{print $1}'`; mkdir -p ${aa}/extern/bug; \cp ${aa}/extern/bug/`ls -tr ${aa}/extern/bug | grep csv | head -n1`  ${aa}/extern/bug/bb.csv;  sed -i '1i\"' ${aa}/extern/bug/bb.csv ; sed -i '1600000a\"' ${aa}/extern/bug/bb.csv ;
drop table if exists t3;
IMPORT TABLE t3(a int, b varchar(100), c varchar(100), d varchar(1000)) csv data ("nodelocal://1/bug/bb.csv") WITH delimiter=e'\x01';
