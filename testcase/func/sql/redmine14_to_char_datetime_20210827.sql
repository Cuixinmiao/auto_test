-- to_char(datetime) test for v9.0.0-beta.1.xTP aarch64-redhat-linux, built 2021/08/24 05:32:28, go1.15.13
-- Author: cuixiangling
-- Date: 2021/08/27

-- 第一个参数是string类型
-- 日期不全，需要和to_date一起测试,未测试

-- 日期全，用date或者timestamp转换(-/,.;:"text")
-- 支持的格式 AD(A.D.),AM(A.M.),BC(B.C.),CC(SCC),D,DAY,DD,DDD,DY,FF [1..6],HH(HH12),HH24,MI,MM,MON,MONTH,PM(P.M.),Q,RM,SS,SSSSS,WW,W,X,(Y,YYY),YEAR(SYEAR),YYYY(SYYYY),YYY(YY,Y)
-- dual表中使用

select to_char(DATE'2021-02-01','AD') from dual;
select to_char(DATE'2021-02-01','A.D.') from dual;
select to_char(DATE'2021-02-01','BC') from dual;
select to_char(DATE'2021-02-01','B.C.') from dual;
select to_char(DATE'2021-02-01','CC') from dual;
select to_char(DATE'2021-02-01','SCC') from dual;
select to_char(DATE'2021-02-01','D') from dual;
select to_char(DATE'2021-02-01','DAY') from dual;
select to_char(DATE'2021-02-01','DD') from dual;
select to_char(DATE'2021-02-01','DDD') from dual;
select to_char(DATE'2021-02-01','DY') from dual;
select to_char(DATE'2021-02-01','FF1') from dual;
select to_char(DATE'2021-02-01','FF2') from dual;
select to_char(DATE'2021-02-01','FF3') from dual;
select to_char(DATE'2021-02-01','FF4') from dual;
select to_char(DATE'2021-02-01','FF5') from dual;
select to_char(DATE'2021-02-01','FF6') from dual;
select to_char(DATE'2021-02-01','FF7') from dual;
select to_char(DATE'2021-02-01','FF8') from dual;
select to_char(DATE'2021-02-01','FF9') from dual;
select to_char(DATE'2021-02-01','HH') from dual;
select to_char(DATE'2021-02-01','HH12') from dual;
select to_char(DATE'2021-02-01','HH24') from dual;
select to_char(DATE'2021-02-01','MI') from dual;
select to_char(DATE'2021-02-01','MM') from dual;
select to_char(DATE'2021-02-01','MON') from dual;
select to_char(DATE'2021-02-01','MONTH') from dual;
select to_char(DATE'2021-02-01','PM') from dual;
select to_char(DATE'2021-02-01','P.M.') from dual;
select to_char(DATE'2021-02-01','Q') from dual;
select to_char(DATE'2021-02-01','RM') from dual;
select to_char(DATE'2021-02-01','SS') from dual;
select to_char(DATE'2021-02-01','SSSSS') from dual;
select to_char(DATE'2021-02-01','WW') from dual;
select to_char(DATE'2021-02-01','W') from dual;
select to_char(DATE'2021-02-01','X') from dual;
select to_char(DATE'2021-02-01','Y,YYY') from dual;
select to_char(DATE'2021-02-01','YEAR') from dual;
select to_char(DATE'2021-02-01','SYEAR') from dual;
select to_char(DATE'2021-02-01','YYYY') from dual;
select to_char(DATE'2021-02-01','SYYYY') from dual;
select to_char(DATE'2021-02-01','YYY') from dual;
select to_char(DATE'2021-02-01','YY') from dual;
select to_char(DATE'2021-02-01','Y') from dual;


-- 以下to_date用例只能在oracle中使用，等qianbase支持to_date后再进行测试
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'AD') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'A.D.') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'BC') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'B.C.') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'CC') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'SCC') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'D') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'DAY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'DD') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'DDD') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'DY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF1') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF2') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF3') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF4') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF5') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF6') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF7') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF8') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'FF9') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'HH') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'HH12') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'HH24') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'MI') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'MM') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'MON') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'MONTH') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'PM') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'P.M.') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'Q') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'RM') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'SS') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'SSSSS') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'WW') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'W') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'X') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'Y,YYY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'YEAR') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'SYEAR') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'YYYY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'SYYYY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'YYY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'YY') from dual;
select to_char(to_date('2021-02-01','yyyy-mm-dd'),'Y') from dual;


select to_char(to_date('2021-02-01 00:00:00','yyyy-mm-dd HH12:MI:SS'),'HH12') from dual;
select to_char(to_date('2021-02-01 00:00:00','yyyy-mm-dd HH24:MI:SS'),'HH12') from dual;
select to_char(to_date('2021-02-01 00:00:00','yyyy-mm-dd HH24:MI:SS'),'HH24') from dual;
select to_char(to_date('2021-02-01 24:00:00','yyyy-mm-dd HH24:MI:SS'),'HH12') from dual;

select to_char(timestamp'1987-12-31 12:01:45','AD') from dual;
select to_char(timestamp'1987-12-31 12:01:45','A.D.') from dual;
select to_char(timestamp'1987-12-31 12:01:45','AM') from dual;
select to_char(timestamp'1987-12-31 12:01:45','A.M.') from dual;
select to_char(timestamp'1987-12-31 12:01:45','BC') from dual;
select to_char(timestamp'1987-12-31 12:01:45','B.C.') from dual;
select to_char(timestamp'1987-12-31 12:01:45','CC') from dual;
select to_char(timestamp'1987-12-31 12:01:45','SCC') from dual;
select to_char(timestamp'1987-12-31 12:01:45','D') from dual;
select to_char(timestamp'1987-12-31 12:01:45','DAY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','DD') from dual;
select to_char(timestamp'1987-12-31 12:01:45','DDD') from dual;
select to_char(timestamp'1987-12-31 12:01:45','DY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF1') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF2') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF3') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF4') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF5') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF6') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF7') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF8') from dual;
select to_char(timestamp'1987-12-31 12:01:45','FF9') from dual;
select to_char(timestamp'1987-12-31 12:01:45','HH') from dual;
select to_char(timestamp'1987-12-31 12:01:45','HH12') from dual;
select to_char(timestamp'1987-12-31 12:01:45','HH24') from dual;
select to_char(timestamp'1987-12-31 12:01:45','MI') from dual;
select to_char(timestamp'1987-12-31 12:01:45','MM') from dual;
select to_char(timestamp'1987-12-31 12:01:45','MON') from dual;
select to_char(timestamp'1987-12-31 12:01:45','MONTH') from dual;
select to_char(timestamp'1987-12-31 12:01:45','PM') from dual;
select to_char(timestamp'1987-12-31 12:01:45','P.M.') from dual;
select to_char(timestamp'1987-12-31 12:01:45','Q') from dual;
select to_char(timestamp'1987-12-31 12:01:45','RM') from dual;
select to_char(timestamp'1987-12-31 12:01:45','SS') from dual;
select to_char(timestamp'1987-12-31 12:01:45','SSSSS') from dual;
select to_char(timestamp'1987-12-31 12:01:45','WW') from dual;
select to_char(timestamp'1987-12-31 12:01:45','W') from dual;
select to_char(timestamp'1987-12-31 12:01:45','X') from dual;
select to_char(timestamp'1987-12-31 12:01:45','Y,YYY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','YEAR') from dual;
select to_char(timestamp'1987-12-31 12:01:45','SYEAR') from dual;
select to_char(timestamp'1987-12-31 12:01:45','YYYY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','SYYYY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','YYY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','YY') from dual;
select to_char(timestamp'1987-12-31 12:01:45','Y') from dual;

select to_char(timestamptz'1987-12-31 12:01:45','AD') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','A.D.') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','AM') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','A.M.') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','BC') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','B.C.') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','CC') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','SCC') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','D') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','DAY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','DD') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','DDD') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','DY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF1') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF2') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF3') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF4') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF5') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF6') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF7') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF8') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','FF9') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','HH') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','HH12') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','HH24') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','MI') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','MM') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','MON') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','MONTH') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','PM') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','P.M.') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','Q') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','RM') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','SS') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','SSSSS') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','WW') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','W') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','X') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','Y,YYY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','YEAR') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','SYEAR') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','YYYY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','SYYYY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','YYY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','YY') from dual;
select to_char(timestamptz'1987-12-31 12:01:45','Y') from dual;


select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'AD') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'A.D.') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'AM') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'A.M.') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'BC') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'B.C.') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'CC') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'SCC') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'D') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'DAY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'DD') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'DDD') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'DY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF1') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF2') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF3') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF4') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF5') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF6') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF7') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF8') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'FF9') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'HH') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'HH12') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'HH24') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'MI') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'MM') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'MON') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'MONTH') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'PM') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'P.M.') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'Q') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'RM') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'SS') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'SSSSS') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'WW') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'W') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'X') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'Y,YYY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'YEAR') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'SYEAR') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'YYYY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'SYYYY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'YYY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'YY') from dual;
select to_char(to_date('1987-12-31 12:01:45','yyyy-mm-dd hh:mi:ss'),'Y') from dual;


select to_char(now(),'AD') from dual;
select to_char(now(),'A.D.') from dual;
select to_char(now(),'AM') from dual;
select to_char(now(),'A.M.') from dual;
select to_char(now(),'BC') from dual;
select to_char(now(),'B.C.') from dual;
select to_char(now(),'CC') from dual;
select to_char(now(),'SCC') from dual;
select to_char(now(),'D') from dual;
select to_char(now(),'DAY') from dual;
select to_char(now(),'DD') from dual;
select to_char(now(),'DDD') from dual;
select to_char(now(),'DY') from dual;
select to_char(now(),'FF1') from dual;
select to_char(now(),'FF2') from dual;
select to_char(now(),'FF3') from dual;
select to_char(now(),'FF4') from dual;
select to_char(now(),'FF5') from dual;
select to_char(now(),'FF6') from dual;
select to_char(now(),'FF7') from dual;
select to_char(now(),'FF8') from dual;
select to_char(now(),'FF9') from dual;
select to_char(now(),'HH') from dual;
select to_char(now(),'HH12') from dual;
select to_char(now(),'HH24') from dual;
select to_char(now(),'MI') from dual;
select to_char(now(),'MM') from dual;
select to_char(now(),'MON') from dual;
select to_char(now(),'MONTH') from dual;
select to_char(now(),'PM') from dual;
select to_char(now(),'P.M.') from dual;
select to_char(now(),'Q') from dual;
select to_char(now(),'RM') from dual;
select to_char(now(),'SS') from dual;
select to_char(now(),'SSSSS') from dual;
select to_char(now(),'WW') from dual;
select to_char(now(),'W') from dual;
select to_char(now(),'X') from dual;
select to_char(now(),'Y,YYY') from dual;
select to_char(now(),'YEAR') from dual;
select to_char(now(),'SYEAR') from dual;
select to_char(now(),'YYYY') from dual;
select to_char(now(),'SYYYY') from dual;
select to_char(now(),'YYY') from dual;
select to_char(now(),'YY') from dual;
select to_char(now(),'Y') from dual;

select to_char(current_timestamp,'AD') from dual;
select to_char(current_timestamp,'A.D.') from dual;
select to_char(current_timestamp,'AM') from dual;
select to_char(current_timestamp,'A.M.') from dual;
select to_char(current_timestamp,'BC') from dual;
select to_char(current_timestamp,'B.C.') from dual;
select to_char(current_timestamp,'CC') from dual;
select to_char(current_timestamp,'SCC') from dual;
select to_char(current_timestamp,'D') from dual;
select to_char(current_timestamp,'DAY') from dual;
select to_char(current_timestamp,'DD') from dual;
select to_char(current_timestamp,'DDD') from dual;
select to_char(current_timestamp,'DY') from dual;
select to_char(current_timestamp,'FF1') from dual;
select to_char(current_timestamp,'FF2') from dual;
select to_char(current_timestamp,'FF3') from dual;
select to_char(current_timestamp,'FF4') from dual;
select to_char(current_timestamp,'FF5') from dual;
select to_char(current_timestamp,'FF6') from dual;
select to_char(current_timestamp,'FF7') from dual;
select to_char(current_timestamp,'FF8') from dual;
select to_char(current_timestamp,'FF9') from dual;
select to_char(current_timestamp,'HH') from dual;
select to_char(current_timestamp,'HH12') from dual;
select to_char(current_timestamp,'HH24') from dual;
select to_char(current_timestamp,'MI') from dual;
select to_char(current_timestamp,'MM') from dual;
select to_char(current_timestamp,'MON') from dual;
select to_char(current_timestamp,'MONTH') from dual;
select to_char(current_timestamp,'PM') from dual;
select to_char(current_timestamp,'P.M.') from dual;
select to_char(current_timestamp,'Q') from dual;
select to_char(current_timestamp,'RM') from dual;
select to_char(current_timestamp,'SS') from dual;
select to_char(current_timestamp,'SSSSS') from dual;
select to_char(current_timestamp,'WW') from dual;
select to_char(current_timestamp,'W') from dual;
select to_char(current_timestamp,'X') from dual;
select to_char(current_timestamp,'Y,YYY') from dual;
select to_char(current_timestamp,'YEAR') from dual;
select to_char(current_timestamp,'SYEAR') from dual;
select to_char(current_timestamp,'YYYY') from dual;
select to_char(current_timestamp,'SYYYY') from dual;
select to_char(current_timestamp,'YYY') from dual;
select to_char(current_timestamp,'YY') from dual;
select to_char(current_timestamp,'Y') from dual;

select to_char(current_date,'AD') from dual;
select to_char(current_date,'A.D.') from dual;
select to_char(current_date,'AM') from dual;
select to_char(current_date,'A.M.') from dual;
select to_char(current_date,'BC') from dual;
select to_char(current_date,'B.C.') from dual;
select to_char(current_date,'CC') from dual;
select to_char(current_date,'SCC') from dual;
select to_char(current_date,'D') from dual;
select to_char(current_date,'DAY') from dual;
select to_char(current_date,'DD') from dual;
select to_char(current_date,'DDD') from dual;
select to_char(current_date,'DY') from dual;
select to_char(current_date,'FF1') from dual;
select to_char(current_date,'FF2') from dual;
select to_char(current_date,'FF3') from dual;
select to_char(current_date,'FF4') from dual;
select to_char(current_date,'FF5') from dual;
select to_char(current_date,'FF6') from dual;
select to_char(current_date,'FF7') from dual;
select to_char(current_date,'FF8') from dual;
select to_char(current_date,'FF9') from dual;
select to_char(current_date,'HH') from dual;
select to_char(current_date,'HH12') from dual;
select to_char(current_date,'HH24') from dual;
select to_char(current_date,'MI') from dual;
select to_char(current_date,'MM') from dual;
select to_char(current_date,'MON') from dual;
select to_char(current_date,'MONTH') from dual;
select to_char(current_date,'PM') from dual;
select to_char(current_date,'P.M.') from dual;
select to_char(current_date,'Q') from dual;
select to_char(current_date,'RM') from dual;
select to_char(current_date,'SS') from dual;
select to_char(current_date,'SSSSS') from dual;
select to_char(current_date,'WW') from dual;
select to_char(current_date,'W') from dual;
select to_char(current_date,'X') from dual;
select to_char(current_date,'Y,YYY') from dual;
select to_char(current_date,'YEAR') from dual;
select to_char(current_date,'SYEAR') from dual;
select to_char(current_date,'YYYY') from dual;
select to_char(current_date,'SYYYY') from dual;
select to_char(current_date,'YYY') from dual;
select to_char(current_date,'YY') from dual;
select to_char(current_date,'Y') from dual;

-- 第一个参数用日期格式元素中标志的和用非日期格式元素中标记的
select to_char(DATE'2021/02/01','Y') from dual;
select to_char(DATE'2021;02;01','Y') from dual;
select to_char(DATE'2021.02.01','Y') from dual;
select to_char(DATE'2021#02#01','Y') from dual;

-- 不支持的格式 DL DS E EE FM FX IW IYYY IYY IY I J RR RRRR TS TZD TZH TZM TZR
select to_char(current_timestamp,'DL') from dual;
select to_char(current_timestamp,'DS') from dual;
select to_char(current_timestamp,'E') from dual;
select to_char(current_timestamp,'EE') from dual;
select to_char(current_timestamp,'FM') from dual;
select to_char(current_timestamp,'FX') from dual;
select to_char(current_timestamp,'IW') from dual;
select to_char(current_timestamp,'IYYY') from dual;
select to_char(current_timestamp,'IYY') from dual;
select to_char(current_timestamp,'IY') from dual;
select to_char(current_timestamp,'I') from dual;
select to_char(current_timestamp,'J') from dual;
select to_char(current_timestamp,'RR') from dual;
select to_char(current_timestamp,'RRRR') from dual;
select to_char(current_timestamp,'TS') from dual;
select to_char(current_timestamp,'TZD') from dual;
select to_char(current_timestamp,'TZH') from dual;
select to_char(current_timestamp,'TZM') from dual;
select to_char(current_timestamp,'TZR') from dual;


-- 单独测试D W WW
select to_char(DATE'2021-01-01','D') from dual;
select to_char(DATE'2021-01-01','W') from dual;
select to_char(DATE'2021-01-01','WW') from dual;

select to_char(DATE'2021-01-02','D') from dual;
select to_char(DATE'2021-01-02','W') from dual;
select to_char(DATE'2021-01-02','WW') from dual;

select to_char(DATE'2021-01-03','D') from dual;
select to_char(DATE'2021-01-03','W') from dual;
select to_char(DATE'2021-01-03','WW') from dual;

select to_char(DATE'2021-01-04','D') from dual;
select to_char(DATE'2021-01-04','W') from dual;
select to_char(DATE'2021-01-04','WW') from dual;

select to_char(DATE'2021-01-05','D') from dual;
select to_char(DATE'2021-01-05','W') from dual;
select to_char(DATE'2021-01-05','WW') from dual;

select to_char(DATE'2021-01-06','D') from dual;
select to_char(DATE'2021-01-06','W') from dual;
select to_char(DATE'2021-01-06','WW') from dual;

select to_char(DATE'2021-01-07','D') from dual;
select to_char(DATE'2021-01-07','W') from dual;
select to_char(DATE'2021-01-07','WW') from dual;

select to_char(DATE'2021-01-08','D') from dual;
select to_char(DATE'2021-01-08','W') from dual;
select to_char(DATE'2021-01-08','WW') from dual;

select to_char(DATE'2021-01-09','D') from dual;
select to_char(DATE'2021-01-09','W') from dual;
select to_char(DATE'2021-01-09','WW') from dual;

-- 第二个参数按照日期格式元素表进行测试 分割符为 -/,.;:"text"
-- 除了上面的其他字符
select to_char(current_timestamp,'YYYY-MM-DD HH:MI:SS-ff AD') from dual;
select to_char(current_timestamp,'YYYY-MM-DD HH/MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY-MM-DD HH/MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY:MM"text"DD HH,MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY:MM"day"DD HH,MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY:MM"day1"DD HH,MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY:MM","DD HH,MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 22:09:10.352185','YYYY:MM,DD HH,MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 13:09:10.352185','YYYY:MM,DD HH;MI/SS.ff WW') from dual;
select to_char(timestamp'2021-08-28 02:09:10.352185','YYYY:MM,DD HH*MI%SS.ff WW') from dual;
select to_char(timestamp'2021-01-07 02:09:10.352185','*&%()YYYY:MM,DD HH*MI%SS.ff WW') from dual;
SELECT to_char(timestamp'2021-1-6 1:1:1.123456789', 'YYY*(*YY,Y,YYY-MM(*&()DDDDDDHHHH12HH24') from dual;
-- oracle select to_char(SYSTIMESTAMP,'yyyy-mm-dd hh24:mi:ss.ff') from dual;
select to_char(CURRENT_TIMESTAMP,'yyyy-mm-dd hh24:mi:ss.ff') from dual;
select to_char(CURRENT_TIMESTAMP,'yyyy-mm-dd hh24:mi:ss.ff3') from dual;
-- oracle select to_char(SYSTIMESTAMP,'yyyy-mm-dd hh24:mi:ss.ff9') from dual;
select to_char(CURRENT_TIMESTAMP,'yyyy-mm-dd hh24:mi:ss.ff9') from dual;

-- ff考虑第一个参数的长度超过6位
SELECT to_char(timestamp'-201-1-6 1:1:1.123456189', 'ff') from dual;
SELECT to_char(timestamp'-201-1-6 1:1:1.123456789', 'ff') from dual;

--timetz数据类型不支持
select to_char(current_time,'HH') from dual;
select to_char(current_time,'HH12') from dual;
select to_char(current_time,'HH24') from dual;

drop table if exists tz;
create table tz(a timetz);
insert into tz values('12:14:45');
select to_char(a,'hh') from tz;
drop table tz;

-- 在实体表中测试
drop table if exists t1;
create table t1(a int,b date,c interval,d time,e timetz,f timestamp,g timestamptz);
insert into t1 values(1,'2021-05-07',INTERVAL '1 year 2 months 3 days 4 hours 5 minutes 6 seconds','12:56:07',TIMETZ '24:00:00','2021-06-08 12:01:01.4567',TIMESTAMPTZ'2021-06-08 00:01:01.4567');
insert into t1 values(2,'2021-05-01', INTERVAL '1-2 3 4:5:6','00:56:07',TIMETZ '00:00:00','2021-06-09 12:01:01.4567',TIMESTAMPTZ'2021-06-09 00:01:01.4567');
insert into t1 values(3,'2021-05-02', '1-2 3 4:5:10','12:56:07',TIMETZ '00:00:00','2021-06-08 01:01:00',TIMESTAMPTZ'2021-06-08 12:01:01.4567');
insert into t1 values(3,'2021-05-03', '1-2 3 4:5:10','11:56:07',TIMETZ '00:59:00','2021-06-01 00:00:00',TIMESTAMPTZ'2021-06-09 11:01:01.4567');
insert into t1 values(3,'2021-05-04', '1-2 3 4:5:10','12:56:07',TIMETZ '12:00:00','2021-06-08 03:00:00',TIMESTAMPTZ'2021-06-10 12:01:01.4567');
insert into t1 values(3,'2021-05-05', '1-2 3 4:5:10','11:56:07',TIMETZ '00:59:00','2021-06-02 13:00:00',TIMESTAMPTZ'2021-06-03 11:01:01.4567');
insert into t1 values(3,'2021-05-07', '1-2 3 4:5:10','12:56:07',TIMETZ '20:00:00','2021-06-06 15:00:00',TIMESTAMPTZ'2021-06-11 12:01:01.4567');
insert into t1 values(3,'2021-05-06', '1-2 3 4:5:10','11:56:07',TIMETZ '00:59:00','2021-06-05 16:00:00',TIMESTAMPTZ'2021-06-04 11:01:01.4567');
select * from t1;

-- 出现在投影列中 单独使用
select to_char(b,'D'),to_char(c,'HH'),to_char(d,'HH24'),to_char(e,'HH12'),to_char(f,'HH'),to_char(g,'HH24') from t1;
select to_char(b,'D'),to_char(d,'HH24'),to_char(e,'HH12'),to_char(f,'HH'),to_char(g,'HH24') from t1;
select to_char(b,'D'),to_char(e,'HH12'),to_char(f,'HH'),to_char(g,'HH24') from t1;
select to_char(b,'D'),to_char(f,'HH'),to_char(g,'HH24') from t1;
select to_char(b,'yyyy-mm-dd hh24:mi:ss.ff'),to_char(f,'AD A.D. AM A.M. BC B.C. CC SCC D DAY DD DDD DY FF1 FF2 FF3 FF4 FF5 FF6 HH HH12 HH24 MI MM MON MONTH PM P.M. Q RM SS SSSSS WW W X Y,YYY YEAR SYEAR YYYY SYYYY YYY YY Y') from t1;
select f, to_char(cast(f as timestamp),'AD A.D. AM A.M. BC B.C. CC SCC D DAY DD DDD DY') from t1;
select f, to_char(cast(f as timestamp),'FF1 FF2 FF3 FF4 FF5 FF6 HH HH12 HH24 MI MM MON') from t1;
select f, to_char(cast(f as timestamp),'MONTH PM P.M. Q RM SS SSSSS WW W X Y,YYY YEAR') from t1;
select f, to_char(cast(f as timestamp),'SYEAR YYYY SYYYY YYY YY Y') from t1;

select g, to_char(g,'AD A.D. AM A.M. BC B.C. CC SCC D DAY DD DDD DY') from t1;
select g, to_char(g,'FF1 FF2 FF3 FF4 FF5 FF6 HH HH12 HH24 MI MM MON') from t1;
select g, to_char(g,'MONTH PM P.M. Q RM SS SSSSS WW W X Y,YYY YEAR') from t1;
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1;

-- 出现在where语句中
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(g,'WW') >10;
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(g,'HH') >10;
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(g,'HH24') >10;
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(g,'HH24') >10;
select g, to_char(g,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(g,'MONTH') > to_char(g,'DAY');

-- 出现在投影列中 作为表达式使用
select cast(to_char(g,'YYYY') as int) + cast(to_char(g,'DD') as int) from t1 where to_char(g,'Y') < to_char(g,'DD');

-- 出现在group by，order by
select cast(to_char(g,'YYYY') as int), sum(a) from t1 where to_char(g,'Y') < to_char(g,'DD') group by to_char(g,'Y'),g;
select cast(to_char(g,'YYYY') as int), sum(a) from t1 where to_char(g,'Y') < to_char(g,'DD') group by g;
select sum(cast(to_char(g,'YYYY') as int)) from t1 group by a;
select sum(cast(to_char(g,'YYYY') as int)) from t1 group by g,to_char(g,'YYYY') order by g;
select distinct to_char(g,'YYYY') from t1 group by g,to_char(g,'YYYY') order by g;
select distinct to_char(g,'YYYY') from t1 group by g,to_char(g,'YYYY');
select distinct to_char(g,'YYYY') from t1 group by g;
select sum(cast(to_char(g,'YYYY') as int)) from t1 group by g;
-- 出现在update的set和where语句中
update t1 set a=cast(to_char(g,'YYYY') as int) where a>2;
insert into t1(a,g) values(4,'0021-06-03 03:01:00');
update t1 set a=cast(to_char(g,'YYYY') as int) where a>2;


drop table if exists tv;
create table tv(col1 int,col2 varchar(20),col3 timestamp);
insert into tv values(1,'abcd','2021-06-01 03:00:00');
insert into tv values(2,'geft','2021-06-02 13:00:00');
insert into tv values(3,'dfd','0021-06-03 03:01:00');
insert into tv values(4,'htyt','2021-06-04 13:00:00');

-- 出现在update的set和where语句中
update tv set col2=to_char(col3,'YYYY') where col1>2;
select * from tv;
select * from t1,tv where a=col1 and to_char(g,'YYYY')=to_char(col3,'YYYY');
-- 出现在union/union all/intersect/except
select f, to_char(f,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(f,'WW') >10 union select col3, to_char(col3,'SYEAR YYYY SYYYY YYY YY Y') from tv where to_char(col3,'WW') >10;
select f, to_char(f,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(f,'WW') >10 union all select col3, to_char(col3,'SYEAR YYYY SYYYY YYY YY Y') from tv where to_char(col3,'WW') >10;
select f, to_char(f,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(f,'WW') >10 intersect select col3, to_char(col3,'SYEAR YYYY SYYYY YYY YY Y') from tv where to_char(col3,'WW') >10;
select f, to_char(f,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(f,'WW') >10 except select col3, to_char(col3,'SYEAR YYYY SYYYY YYY YY Y') from tv where to_char(col3,'WW') >10;
select col3, to_char(col3,'SYEAR YYYY SYYYY YYY YY Y') from tv where to_char(col3,'WW') >10 except select f, to_char(f,'SYEAR YYYY SYYYY YYY YY Y') from t1 where to_char(f,'WW') >10 ;

-- create table as select，create的default

drop table if exists tc;
create table tc as select * from t1;
select * from tc;
\d tc;

drop table tc;
create table tc(a int , b varchar(50) not null default to_char(timestamp'2021-01-07 02:09:10.352185','*&%()YYYY:MM,DD HH*MI%SS.ff WW'));
insert into tc(a) values(1);
select * from tc;
drop table tc;

drop table if exists t1;
create table t1(a int,b date,f date,g date);
insert into t1 values(1,'2021-05-07','2021-06-08 12:01:01','2021-06-08 00:01:01');
insert into t1 values(2,'2021-05-01','2021-06-09 12:01:01','2021-06-09 00:01:01');
insert into t1 values(3,'2021-05-02','2021-06-08 01:01:00','2021-06-08 12:01:01');
insert into t1 values(3,'2021-05-03','2021-06-01 00:00:00','2021-06-09 11:01:01');
insert into t1 values(3,'2021-05-04','2021-06-08 03:00:00','2021-06-10 12:01:01');
insert into t1 values(3,'2021-05-05','2021-06-02 13:00:00','2021-06-03 11:01:01');
insert into t1 values(3,'2021-05-07','2021-06-06 15:00:00','2021-06-11 12:01:01');
insert into t1 values(3,'2021-05-06','2021-06-05 16:00:00','2021-06-04 11:01:01');
select to_char(b,'D'),to_char(f,'HH'),to_char(g,'HH24') from t1;
select f, to_char(cast(f as timestamp),'AD A.D. AM A.M. BC B.C. CC SCC D DAY DD DDD DY') from t1;
update t1 set a=to_char(g,'YYYY') where a>2;

drop table t1;
drop table tv;

-- below from oracle doc
drop table if exists empl_temp;
CREATE TABLE empl_temp   (      employee_id NUMBER(6),      first_name  VARCHAR(20),      last_name   VARCHAR(25),      email       VARCHAR(25),      hire_date   DATE,      job_id      VARCHAR(10), clob_column text ); 
INSERT INTO empl_temp VALUES(111,'John','Doe','example.com','10-JAN-2015','1001','Experienced Employee');
INSERT INTO empl_temp VALUES(112,'John','Smith','example.com','12-JAN-2015','1002','Junior Employee');
INSERT INTO empl_temp VALUES(113,'Johnnie','Smith','example.com','12-JAN-2014','1002','Mid-Career Employee');
INSERT INTO empl_temp VALUES(115,'Jane','Doe','example.com','15-JAN-2015','1005','Executive Employee');
INSERT INTO empl_temp VALUES(1,'Jane','Doe','example.com','2015-05-15','1005','Executive Employee');
INSERT INTO empl_temp VALUES(1,'Jane','Doe','example.com','2015-05-15 10:23:45','1005','Executive Employee');

SELECT hire_date "Default", TO_CHAR(hire_date,'DD') "Short", TO_CHAR(hire_date,'DDD') "Long" FROM empl_temp  WHERE employee_id IN (111, 112, 115);

select to_char(DATE'2021-02-01 12:34:23.890','DD');
select to_char(timestamp'2021-02-01 12:34:23.890','DD');
select now(),to_char(now(),'yyyy-mm-dd hh24:mi:ss.ff');
select to_char(timestamp'2021-02-01 12:34:23.890','HH');
SELECT TO_CHAR(current_DATE, 'DD') || ' of ' || TO_CHAR(current_date, 'Month') || ', ' || TO_CHAR(current_date, 'YYYY') "Ides" FROM DUAL;
SELECT TO_CHAR(current_date, 'DDTH') || ' of ' ||  TO_CHAR(current_date, 'Month') || ', ' ||  TO_CHAR(current_date, 'YYYY') "Ides"  FROM DUAL;

SELECT TO_CHAR(current_date, 'DD') || ' of ' ||  TO_CHAR(current_date, 'Month') || ', ' | TO_CHAR(current_date, 'YYYY') "Ides" FROM DUAL;

SELECT TO_CHAR(current_date, 'fmDDTH') || ' of ' || TO_CHAR(current_date, 'fmMonth') || ', ' || TO_CHAR(current_date, 'YYYY') "Ides" FROM DUAL;

SELECT TO_CHAR(current_date, 'fmDD') || ' of ' || TO_CHAR(current_date, 'fmMonth') || ', ' || TO_CHAR(current_date, 'YYYY') "Ides" FROM DUAL;

drop table empl_temp;
