--newdb(bankdb),tabname(accounts)

--第一行的注释会用到下面的SQL语句中，python脚本会获取第一行的内容
--from faker import Faker

--fake = Faker("zh-CN")
--for i in range(50):
--    sql = "insert into accounts(id, name, address, job, birthday, ip, email, password) values(%d,'%s','%s','%s','%s','%s','%s','%s')" % \
--          (i + 1, fake.name(), fake.address(), fake.job(), fake.date(pattern="%Y-%m-%d", end_datetime=None),
--           fake.ipv4_private(network=False, address_class=None), \
--           fake.ascii_email(), fake.password(special_chars=False))
--    print(sql)
Drop DATABASE IF EXISTS bankdb cascade;

CREATE DATABASE IF NOT EXISTS bankdb;

USE bankdb;

create table accounts (id int PRIMARY KEY, 
	name VARCHAR, 
	address VARCHAR, 
	job VARCHAR, 
	birthday DATE, 
	ip INET, 
	email varchar, 
	password STRING);


insert into accounts(id, name, address, job, birthday, ip, email, password) values(1,'黄丹丹','宁夏回族自治区呼和浩特县沈北新杨街c座 424963','个人业务客户经理','1993-11-30','192.168.201.35','xiuying11@hotmail.com','9sR9Qhzoa0');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(2,'余婷婷','安徽省颖市闵行六盘水街r座 930886','汽车质量管理','1987-09-01','10.59.38.213','zhaojing@jing.net','BrK8UqoXmT');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(3,'董丽娟','江西省深圳县南长贵阳路j座 712002','项目执行/协调人员','2006-08-23','10.54.237.165','gang05@cui.cn','K8KrWlTZUt');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(4,'陈柳','四川省雪市兴山杨路f座 374810','客服经理','2005-06-12','10.205.126.10','guiying14@chao.cn','DJQMinIq4H');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(5,'许婷','浙江省秀珍县安次辽阳路c座 451920','瘦身顾问','1995-11-29','192.168.220.92','glu@gmail.com','o3r8F2fkPT');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(6,'宋涛','浙江省柳州县平山上海街O座 416252','礼仪/迎宾','1992-08-12','192.168.128.14','junyao@hotmail.com','GJOWNMAb7h');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(7,'俞峰','天津市深圳县平山嘉禾路t座 147500','呼叫中心客服','1970-08-27','192.168.118.123','na72@wei.cn','ta17QtvuiA');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(8,'苏丽华','四川省文县花溪汕尾街T座 495699','晒版员','1996-01-14','192.168.23.14','lixu@yahoo.com','rcV0fPvz3h');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(9,'李艳','北京市荆门县兴山六盘水街E座 264360','电分操作员','2016-11-14','192.168.66.70','isun@97.cn','1IQYDBvjSb');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(10,'赵淑华','海南省太原市沈北新兴城街Z座 361971','演员/群众演员','1986-07-19','172.19.75.125','hanchao@meng.cn','NsRvxe5al2');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(11,'张桂英','宁夏回族自治区台北市吉区孙路j座 966065','后勤','1979-08-23','192.168.4.11','guiyingfang@chaoxiulan.org','eHtcnH886j');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(12,'冯雷','重庆市瑞市丰都胡路T座 401113','压痕工','1983-10-24','172.29.219.119','oyao@gmail.com','5FmcGxwZvl');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(13,'金雪','西藏自治区西安县大兴兴城街M座 575770','手机维修','1985-02-11','10.69.109.198','baijuan@fr.cn','R8SHv9vi2w');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(14,'王秀珍','陕西省桂珍县普陀邓街Y座 521998','产品总监','2016-03-11','10.4.177.58','liaojing@wen.cn','Wv1SvNvs6G');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(15,'张梅','辽宁省亮市清河王街L座 681754','按摩','1997-02-10','172.28.55.250','ijiang@xiong.cn','f3NSU6StNa');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(16,'曹建华','山东省凤兰市淄川大冶街N座 215538','玩具设计','2004-02-25','172.16.65.56','jing38@55.cn','6yLmGx4DYF');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(17,'区淑兰','宁夏回族自治区琴县六枝特牛路H座 541303','造型师','2013-07-09','192.168.182.216','iyu@yahoo.com','7Mhjk9SXxl');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(18,'熊洋','山西省伟市徐汇冯路T座 776560','药品市场推广主管/专员','2004-12-03','10.125.57.158','yanghan@zeng.cn','0OqbBc3T9u');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(19,'王涛','四川省宁德市龙潭周街l座 937877','进出口/信用证结算','2012-06-06','192.168.189.181','nadong@yahoo.com','y5R7RFcblS');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(20,'郭欣','重庆市浩县六枝特马街d座 293862','故障分析工程师','1982-09-03','10.107.54.109','juanhu@gmail.com','9UQ7X0c4W4');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(21,'严刚','河北省宜都市江北孙街N座 856114','物业管理主管','2004-10-12','192.168.231.121','ping52@yao.cn','1Eyp3ma59i');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(22,'董兰英','海南省勇县普陀宜都路p座 709693','厨师助理/学徒','2014-03-19','192.168.213.104','xiuying56@luo.cn','oYidEPyv8S');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(23,'张桂珍','湖南省南京县西峰武汉路y座 838798','产品/品牌主管','2003-11-04','10.44.196.97','myang@yahoo.com','ncWdNNGh7W');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(24,'傅桂荣','台湾省张家港县房山佛山街E座 998208','销售行政经理/主管','2009-01-15','172.26.88.251','longjie@39.cn','93JOedXqKz');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(25,'黄超','上海市六盘水县长寿赵路o座 847957','工程造价师/预结算经理','1980-09-01','192.168.171.107','cuina@han.cn','RBU5Sc66T6');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(26,'齐小红','宁夏回族自治区亮县永川西宁街L座 801093','裁剪工','1970-12-18','192.168.79.137','rdu@gmail.com','7vVNvxi805');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(27,'陈文','安徽省宁德县花溪胡街D座 947479','酒店旅游','2009-10-19','10.248.90.66','oxue@hotmail.com','PIu1UFDsq8');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(28,'赖强','黑龙江省楠市崇文南京街Y座 841203','玩具设计','1990-07-30','172.25.80.250','juan91@hotmail.com','PHsYDztl5t');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(29,'周东','河北省济南市怀柔黄路e座 367902','绩效考核专员/助理','2009-06-13','192.168.230.92','qiang22@hotmail.com','5uxioTra0M');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(30,'乌桂香','山西省永安市金平关岭街e座 502485','销售管理','1984-07-21','192.168.239.174','na67@gmail.com','1MVNxcFpcT');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(31,'郑雷','福建省建华市永川张街U座 314990','高级管理','1989-04-17','192.168.9.72','qiaojun@81.cn','21IkWVlt5T');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(32,'雷雪梅','内蒙古自治区香港县永川昆明街P座 863580','熟食加工','2002-10-18','192.168.170.2','elu@mao.cn','AWdfy4Vt0R');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(33,'刘斌','黑龙江省武汉市滨城惠州街f座 182224','美容助理','2016-05-11','172.31.64.61','jing33@dengpan.cn','k0yQxeBrTz');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(34,'乔琴','贵州省海口市友好吴路p座 510318','经纪人/星探','1992-07-13','192.168.253.114','gongfang@gang.cn','KIaZEduR0L');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(35,'赵璐','新疆维吾尔自治区沈阳市友好大冶街N座 253033','信用卡销售','1981-04-06','192.168.232.174','uli@gmail.com','2QxHhbmgrv');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(36,'林倩','福建省凤英县黄浦六盘水路Y座 906223','其他','2002-07-13','192.168.53.181','aye@tang.cn','4AdQduQ2kU');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(37,'乐红','香港特别行政区宇县大兴潜江街S座 983632','送餐员','2001-09-25','172.22.249.240','li86@hotmail.com','6IdCNhMGx2');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(38,'周红梅','重庆市佛山县友好台北路B座 855652','中学教师','1976-10-01','172.23.135.238','xiulanxu@yahoo.com','pWbzoFpZ4N');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(39,'李霞','澳门特别行政区石家庄市永川哈尔滨街S座 908671','高级硬件工程师','1994-09-21','172.17.184.21','tanwei@jinzhang.cn','fPi8jHYk4a');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(40,'王凤兰','上海市北京市璧山阜新路r座 989253','瓦工','2008-08-07','172.26.36.141','naren@tao.cn','52bHviTam0');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(41,'廖宇','湖北省健市山亭长沙路h座 777106','多媒体/游戏开发工程师','2014-02-21','192.168.192.222','guiyingsun@gmail.com','3GDbCzk3I7');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(42,'杨刚','河南省张家港市崇文许街j座 139324','作家/撰稿人','2006-12-25','192.168.79.93','xia83@gmail.com','Npc15j0l59');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(43,'张华','宁夏回族自治区贵阳市城北辛集路d座 451198','保洁','1976-04-19','172.22.125.207','maogang@gmail.com','slfmQSQR5N');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(44,'韩飞','西藏自治区郑州市长寿刘路J座 781550','生产领班/组长','1989-07-06','10.243.30.168','lyin@nali.cn','6FEm17nFat');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(45,'吴东','重庆市强市浔阳通辽路p座 753983','保险内勤','2013-05-27','172.28.15.91','qiangzhao@28.cn','j7mOUhTv1G');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(46,'严晨','广东省莉市南溪永安街f座 962631','硫化工','1990-09-17','10.246.16.192','xiameng@gmail.com','2EZSuwRLXF');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(47,'刘春梅','四川省淑英县朝阳郭路y座 650397','保安人员','2002-01-28','192.168.174.14','qiangjia@yahoo.com','4rVmmXpvGZ');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(48,'韩秀芳','广西壮族自治区柳县友好穆路r座 555816','其他','2007-06-27','192.168.73.114','yangjing@hotmail.com','8Pkr7dv40U');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(49,'武静','浙江省北京县魏都六安路g座 375748','运输经理/主管','1989-01-06','192.168.228.18','fang01@yahoo.com','WMTbHBwrz2');
insert into accounts(id, name, address, job, birthday, ip, email, password) values(50,'周亮','河北省秀梅县沙湾吴路X座 865137','成本管理员','1972-09-02','192.168.88.255','dengxia@gmail.com','7UiSGaNAEc');
