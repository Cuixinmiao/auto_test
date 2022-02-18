--newdb(bankdb),tabname(accounts),--viewname(view_accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容

Drop DATABASE IF EXISTS bankdb cascade;

CREATE DATABASE IF NOT EXISTS bankdb;

USE bankdb;

create table accounts (id int PRIMARY KEY,
        name VARCHAR,
        address VARCHAR,
        job VARCHAR NOT NULL,
        birthday DATE,
        email varchar UNIQUE,
        password STRING DEFAULT 'abcdedg',
	salary int not NULL CHECK (salary >= 5000));


create or replace view view_accounts as select id,name,address,job,birthday,email,password,salary from bankdb.accounts;

	
insert into accounts(id, name, address, job, birthday, email, password,salary) values(1,'张海燕','湖南省辉市丰都齐街c座 542592','测绘/测量','1999-07-30','xiulanlei@yahoo.com','4DMRmEjibk',16500);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(2,'沈秀芳','四川省梧州县吉区沈阳街X座 680374','采购经理','2005-06-22','hsu@min.cn','9u6GGzkfmR',13200);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(3,'王文','贵州省合肥县闵行赵街Q座 887669','裁床','1974-12-13','yang01@ap.cn','rWMb0rik21',15500);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(4,'张畅','天津市成市平山杨路o座 435737','监察人员','2018-12-10','fangpeng@yahoo.com','SdB0IVdcvP',15900);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(5,'林华','福建省瑜县金平武汉街k座 967982','专科医生','1983-10-06','syuan@hz.cn','7HJwvE2BJT',10200);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(6,'张桂芳','河南省秀梅市沙湾廖路C座 931298','促销员','2021-04-04','ixiang@hotmail.com','1MduyRdwdH',17800);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(7,'商想','贵州省桂芝县南溪广州街U座 739895','审计经理/主管','2017-01-26','lshi@hotmail.com','XBGfnQ8H3Q',11300);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(8,'刘杰','河北省兴安盟县丰都兴城路n座 281923','医疗器械销售经理/主管','1992-06-06','pengtao@hotmail.com','Ptd3RnzYtU',8800);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(9,'邱丹','广西壮族自治区长沙市和平靳街e座 623838','药品市场推广主管/专员','1976-10-07','cshi@gu.cn','Ls2Ig13p21',19200);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(10,'高丽华','四川省晨市沙湾马鞍山路J座 785746','数据库工程师/管理员','2000-02-26','vwen@jielei.cn','wOAVeb0gu0',14300);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(11,'邓欢','山东省荆门县龙潭陈路T座 573716','工长','1983-01-31','gangliu@lin.com','i7W28ikLZG',10600);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(12,'刘桂兰','安徽省昆明市南长姚街G座 789386','兽医','1985-03-09','utang@hotmail.com','Qki2XLnc4C',7700);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(13,'程宇','甘肃省倩县沈北新通辽街H座 731615','审核员','2004-01-18','mingsong@madeng.net','CP5TCCuaRH',10300);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(14,'武英','湖南省平县怀柔寇街S座 268241','咖啡师','2010-09-29','uzhao@panhao.cn','7b1VzswicT',16600);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(15,'曾浩','广西壮族自治区红梅县蓟州呼和浩特路c座 510471','采购材料、设备质量管理','2020-06-15','chaosong@31.cn','tNDSDqr49c',11700);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(16,'杨涛','河北省济南县清河陆街T座 732579','签证专员','1985-09-18','yan76@yahoo.com','f1iTPETf3D',11700);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(17,'马莉','四川省楠县锡山姚街W座 380292','医疗器械生产/质量管理','2005-11-02','tianjuan@gmail.com','1qgr1WPm3q',15700);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(18,'杜冬梅','四川省杨县南湖李路m座 536182','质量管理/测试经理(QA/QC经理)','1986-01-22','tao42@hotmail.com','NZqtmMnt0A',11200);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(19,'左成','山西省金凤县双滦韩街r座 482454','信用卡销售','2012-11-10','mingfeng@guhu.cn','oBq7zKat0l',6000);
insert into accounts(id, name, address, job, birthday, email, password,salary) values(20,'郑娟','湖南省武汉市平山淮安路e座 657241','系统分析员','1970-08-20','jie23@yan.cn','IFCayOicB3',7100);


