CREATE database if not exists Bank;
use Bank;
create table branch(
branch_name varchar(50) primary key,
branch_city varchar(15),
assests real);
create table account(
accno int primary key, 
branch_name varchar(50), 
balance real,
foreign key(branch_name) references branch(branch_name));
create table customer(
customer_name varchar(50) primary key, 
customer_street varchar(50), 
customer_city varchar(15));
create table depositer(
customer_name varchar(50),
accno int,
primary key(customer_name, accno),
foreign key(customer_name) references customer(customer_name),
foreign key(accno) references account(accno));
create table loan(
loan_num int primary key,
branch_name varchar(50),
amount real,
foreign key(branch_name) references branch(branch_name));
insert into branch values
("SBI_Chamrajpet","Banglore", 50000),
("SBI_ResidencyRoad","Banglore", 10000),
("SBI_ShivajiRoad","Mumbai", 20000),
("SBI_ParliamentRoad","Delhi", 10000),
("SBI_Jantarmantar","Delhi", 20000);
insert into account values
(1,"SBI_Chamrajpet", 2000),
(2,"SBI_ResidencyRoad", 5000),
(3,"SBI_ShivajiRoad", 6000),
(4,"SBI_ParliamentRoad", 9000),
(5,"SBI_Jantarmantar", 8000),
(6,"SBI_ShivajiRoad", 4000),
(7,"SBI_ResidencyRoad", 4000),
(8,"SBI_ParliamentRoad", 3000),
(9,"SBI_ResidencyRoad", 5000),
(10,"SBI_Jantarmantar", 2000);
insert into customer values
("Avinash","Bull_Temple_Road","Banglore"),
("Dinesh","Bannerghatta_Road","Banglore"),
("Mohan","NationalCollege_Road","Banglore"),
("Nikhil","Akbar_Road","Delhi"),
("Ravi","Prithviraj_Road","Delhi");
insert into depositer values
("Avinash",1),
("Dinesh",2),
("Nikhil",4),
("Ravi",5),
("Avinash",8),
("Nikhil",9),
("Dinesh",10),
("Nikhil",7);
insert into loan values
(1,"SBI_Chamrajpet", 1000),
(2,"SBI_ResidencyRoad", 2000),
(3,"SBI_ShivajiRoad", 3000),
(4,"SBI_ParliamentRoad", 4000),
(5,"SBI_Jantarmantar", 5000);
select branch_name, (assests/100000) as assets_lakhs
from branch;
select d.customer_name
from depositer d
join account a on d.accno= a.accno
where a.branch_name="SBI_ResidencyRoad"
group by d.customer_name
having count(a.accno)>=2;
create view loan_amount
as select branch_name , amount
from loan;
select * from loan_amount;
CREATE TABLE borrower (
 loan_num INT,
 customer_name VARCHAR(20),
 PRIMARY KEY (loan_num),
 FOREIGN KEY (loan_num)
 REFERENCES loan (loan_num),
 FOREIGN KEY (customer_name)
 REFERENCES customer (customer_name)
);
insert into borrower values(1,"Mohan");
insert into borrower values(2,"Avinash");
insert into borrower values(3,"Dinesh");
insert into borrower values(4,"Mohan");
insert into borrower values(5,"Nikhil");
select distinct s.customer_name
from depositer s
where not exists(
select b.branch_name
from branch b 
where b.branch_city="Delhi"
and b.branch_name not in(select r.branch_name
from depositer t join account r on t.accno=r.accno
where s.customer_name=t.customer_name));
select distinct customer_name from borrower
where customer_name not in (select customer_name from depositer);
SELECT DISTINCT b.customer_name FROM borrower b join loan l join depositer d join branch br
WHERE b.loan_num = l.loan_num
AND l.branch_name = br.branch_name
AND br.branch_city = 'Bangalore'
AND b.customer_name IN (SELECT customer_name FROM depositer);
SELECT branch_name FROM branch
WHERE assests > max(SELECT assests FROM branch
WHERE branch_city = 'Bangalore');
DELETE FROM account
WHERE branch_name IN (SELECT branch_name FROM branch
WHERE branch_city = "Mumbai");
select * from account;
UPDATE account
SET balance = balance * 1.05;
select * from account;