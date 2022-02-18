--newdb(bankdb),tabname(accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
--from faker import Faker

--fake = Faker("zh-CN")
--for i in range(20):
--    tmp = fake.ipv4_private(network=False, address_class=None)
--    sql0 = "insert into fk values('%s');" % tmp
--    sql = "insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(%d,'%s','%s','%s','%s','%s','%s','%s',%d);" % \
--          (i + 1, fake.name(), fake.address(), fake.job(), fake.date(pattern="%Y-%m-%d", end_datetime=None),
--           tmp, \
--           fake.ascii_email(), fake.password(special_chars=False),fake.pyint(min_value=5000, max_value=20000, step=100))
--    print(sql0)
--    print(sql)


Drop DATABASE IF EXISTS bankdb cascade;

CREATE DATABASE IF NOT EXISTS bankdb;

USE bankdb;

COMMENT ON DATABASE bankdb IS 'This database name is bankdb，这个数据库名称是bankdb';

CREATE table fk(ip INET PRIMARY KEY);

create table accounts (id int PRIMARY KEY,
        name VARCHAR,
        address VARCHAR,
        job VARCHAR NOT NULL,
        birthday DATE,
        ip INET NOT NULL REFERENCES fk(ip),
        email varchar UNIQUE,
        password STRING DEFAULT 'abcdedg',
	salary int not NULL CHECK (salary >= 5000));

COMMENT ON TABLE accounts IS '此表包含用户信息';
	
CREATE INDEX ON accounts(name);
COMMENT ON INDEX accounts_name_idx IS 'This index filter by name.';

COMMENT ON COLUMN accounts.birthday IS '此列包含帐户生日。';



insert into fk values('192.168.114.196');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(1,'刘丽丽','青海省岩县海陵甘路q座 458300','供应链经理','1980-10-25','192.168.114.196','hujie@hotmail.com','20AvvoaFV2',10100);
insert into fk values('172.21.23.243');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(2,'胡志强','湖北省海燕县萧山深圳街T座 748895','化验员','2009-10-11','172.21.23.243','jzhang@14.cn','0dF8XkSmza',6800);
insert into fk values('172.29.61.185');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(3,'罗桂荣','安徽省沈阳市和平王街W座 729736','医疗器械注册','2006-12-10','172.29.61.185','rkang@luohe.cn','13OCndED2n',6900);
insert into fk values('10.188.89.93');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(4,'卢彬','河南省雪梅县花溪韩街J座 823735','IT-管理','1983-05-10','10.188.89.93','bhan@hotmail.com','lu7dEcKq7O',6400);
insert into fk values('192.168.132.234');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(5,'赵鹏','澳门特别行政区瑞市长寿黄街I座 658037','法务助理','2001-09-05','192.168.132.234','ccui@hotmail.com','sV1HR0Hu9L',6800);
insert into fk values('172.29.91.81');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(6,'李华','西藏自治区杨县翔安方路Z座 213563','美容顾问','1984-10-04','172.29.91.81','xiulan01@wenmeng.org','A8TSekqh88',14600);
insert into fk values('192.168.172.65');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(7,'褚琳','福建省萍县孝南江街g座 700207','销售主管','1981-05-31','192.168.172.65','fenggang@hotmail.com','IhuqWVocA9',17200);
insert into fk values('10.44.17.141');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(8,'邓鑫','香港特别行政区伟市梁平褚街W座 212896','保险业务经理/主管','2020-03-15','10.44.17.141','yong22@junxia.cn','W0ElEWzBrw',17900);
insert into fk values('172.23.93.81');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(9,'张淑兰','上海市齐齐哈尔市华龙南昌路P座 463899','渠道/分销专员','1970-05-31','172.23.93.81','gaoping@xf.cn','G1QX2dEwow',5800);
insert into fk values('192.168.170.55');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(10,'杜刚','北京市丽丽市南长谭街m座 929588','专科医生','1978-01-29','192.168.170.55','hhan@hotmail.com','u8e4OcOxY0',6600);
insert into fk values('192.168.201.204');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(11,'孙桂香','江西省玉英市长寿汤街x座 670705','焊接工程师/技师','1991-03-02','192.168.201.204','lei20@lili.cn','7aLPPhlh3G',7000);
insert into fk values('10.208.98.250');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(12,'朱宁','天津市明县崇文张街Y座 338443','电声/音响工程师/技术员','2001-05-13','10.208.98.250','jiexia@gmail.com','FYym1wRI0Z',17000);
insert into fk values('172.30.45.124');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(13,'韦杨','辽宁省莉市上街黄街Z座 327213','销售管理','1992-12-04','172.30.45.124','cmeng@hotmail.com','b9ZWXFoTbP',8300);
insert into fk values('172.19.139.255');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(14,'董丹丹','贵州省六盘水市西夏乌鲁木齐街y座 347593','法务助理','2019-01-21','172.19.139.255','axue@hotmail.com','PJojZSlO3d',5500);
insert into fk values('172.22.156.167');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(15,'邹桂兰','湖北省东莞市上街呼和浩特街e座 947782','装订工','2012-04-17','172.22.156.167','xxiong@gmail.com','Mp3OoToMkx',5300);
insert into fk values('10.24.193.218');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(16,'刘建军','青海省雪县沙市宜都街J座 642500','策略发展总监','1989-01-09','10.24.193.218','bpan@fang.cn','2t99U9v2or',9500);
insert into fk values('172.29.177.5');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(17,'胡涛','福建省呼和浩特县徐汇张路h座 910122','产品/品牌专员','1979-11-13','172.29.177.5','maming@hotmail.com','RCRFuxWk8G',6300);
insert into fk values('10.51.96.159');
insert into accounts(id, name, address, job, birthday, ip, email, password,salary) values(18,'张淑华','湖南省石家庄市清河薛路Y座 273509','生产文员','2011-08-12','10.51.96.159','yeyong@jieli.cn','tA7NiktENN',16500);
insert into fk values('10.101.114.10');
insert into accounts(id, name, address, job, birthday, ip, email,salary) values(19,'鞠淑英','河北省楠县朝阳巢湖路k座 381493','其他','1971-12-16','10.101.114.10','xiexia@gmail.com',14900);
insert into fk values('10.12.138.206');
insert into accounts(id, name, address, job, birthday, ip, email,salary) values(20,'叶静','广西壮族自治区宁德市西峰永安路v座 205526','公关/媒介','1996-07-19','10.12.138.206','zcai@yahoo.com',15900);


