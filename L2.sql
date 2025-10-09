create database IF NOT EXISTS INSURANCE;
use INSURANCE;
CREATE TABLE PERSON(
driver_id varchar(10) PRIMARY KEY,
name varchar(50),
address varchar(100));
CREATE TABLE CAR(
reg_num varchar(10) primary KEY,
model varchar (50),
year INT);
CREATE TABLE OWNS(
driver_id varchar(10),
reg_num varchar(10),
PRIMARY KEY(driver_id,reg_num),
foreign key(driver_id) references PERSON(driver_id),
foreign key(reg_num) references CAR(reg_num));
CREATE TABLE ACCIDENT(
report_num int primary key,
accident_date date,
location varchar(100));
create table PARTICIPATED(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
primary key(driver_id, reg_num, report_num ),
foreign key(driver_id) references PERSON(driver_id),
foreign key(reg_num) references CAR(reg_num),
foreign key(report_num) references ACCIDENT(report_num));
insert into PERSON values
('A01','Richard','Srinivas Nagar'),
('A02','Pradeep','Rajaji Nagar'),
('A03','Smith','Ashok Nagar'),
('A04','Venu','NR Colony'),
('A05','John','Hanumanth nagar');
insert into CAR values
('KA001','Indica',1990),
('KA002','Lancer',1957),
('KA003','Toyota',1998),
('KA004','Honda',2008),
('KA005','Audi',2005);
insert into OWNS values
('A01','KA001'),
('A02','KA003'),
('A03','KA005'),
('A04','KA002'),
('A05','KA004');
insert into ACCIDENT values
(11,'2003-01-01','Srinivas Nagar'),
(12,'2004-02-02','Rajaji Nagar'),
(13,'2003-01-21','Ashok Nagar'),
(14,'2008-02-17','NR Colony'),
(15,'2005-03-05','Hanumanth nagar');
ALTER table PARTICIPATED ADD COLUMN damage_amount int;
insert into PARTICIPATED values
('A01','KA001',11,10000),
('A02','KA003',12,50000),
('A03','KA005',13,25000),
('A04','KA002',14,3000),
('A05','KA004',15,5000);
select * from CAR order by year asc;

select count(distinct p.report_num)
from PARTICIPATED P 
JOIN CAR C ON P.reg_num=C.reg_num
where c.model='Lancer';

select count(distinct ow.driver_id)
from owns ow
join participated p on ow.reg_num=p.reg_num
join accident a on p.report_num=a.report_num
where year(a.accident_date)=2008;

select *from participated order by damage_amount desc;

select avg(damage_amount) as avg_damage
from participated;

delete from participated where damage_amount<(select avg(damage_amount) from participated);

select pe.name
from participated p 
join person pe on p.driver_id=pe.driver_id
where damage_amount > (select avg(damage_amount) from participated);

select max(damage_amount) as max_damage
from participated;