create database if not exists supplier;
use supplier;
create table supplier(
sid int primary key,
sname varchar(30),
city varchar(30));
create table parts(
pid int primary key,
pname varchar (30),
color varchar(20));
create table catalog(
sid int ,
pid int,
cost decimal,
primary key(sid,pid),
foreign key (sid) references supplier(sid),
foreign key (pid) references parts(pid));
insert into supplier values
(1,'Acme Widget Suppliers','Pune'),
(2,'Ramesh','Mumbai'),
(3,'Suresh','Delhi'),
(4,'Rakesh','Bengaluru'),
(5,'Vignesh','Manipal');
insert into parts values
(101,'Table','Brown'),
(102,'Chair','Black'),
(103,'Desk','White'),
(104,'Stand','Yellow'),
(105,'Stool','Red');
insert into catalog values
(1,101,1000),
(1,102,2000),
(1,103,3000),
(1,104,4000),
(1,105,5000),
(2,101,1000),
(4,102,1000),
(5,103,1000),
(3,104,1000),
(4,105,1000);

select distinct p.pname
from parts p
join catalog c on p.pid=c.pid
where p.pid in (select distinct c.pid from catalog c);

select distinct s.sname
from supplier s
join catalog c on c.sid=s.sid
group by s.sid,s.sname
having count(c.pid)=(select count(*) from parts);

select distinct s.sname
from supplier s
join catalog c on c.sid=s.sid
join parts p on c.pid=p.pid
where p.color="Red"
group by s.sid,s.sname
having count(c.pid)=(select count(*) from parts where parts.color="Red");

select p.pname 
from parts p
join catalog c on p.pid=c.pid
join supplier s on c.sid=s.sid
where sname='Acme Widget Supplier'
group by p.pid,p.pname
having count(distinct s.sid)=1;

SELECT DISTINCT c.sid
FROM Catalog c
WHERE c.cost > (
    SELECT AVG(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = c.pid
);

SELECT p.pname, s.sname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
JOIN Supplier s ON s.sid = c.sid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM Catalog c2
    WHERE c2.pid = p.pid
);
