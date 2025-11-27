use L5;

select m.ename as Manager_Name, count(e.empno) as Emp_Count
from employee e
join employee m on e.mgr_no=m.empno
group by m.ename
having count(e.empno)=(
     select max(cnt) from (
            select count(e1.empno) as cnt
            from employee e1
            where e1.mgr_no is not NULL
            group by e1.mgr_no
	 ) as Temp
);

select distinct m.ename as Manager_Name
from employee m
join employee e on e.mgr_no=m.empno
group by m.empno, m.ename, m.sal
having m.sal>AVG(e.sal);

select distinct e.ename as Second_Top_Manager, d.dname
from employee e
join employee m on e.mgr_no=m.empno
join dept d on e.deptno=d.deptno
where m.mgr_no is Null;

select * from incentives i
join employee e on i.empno=e.empno
where i.incentive_date between '2019-01-01' and '2019-01-31'
and i.incentive_amount=(select distinct incentive_amount from incentives where incentive_date between '2019-01-01' and '2019-01-31' order by incentive_amount desc limit 1 offset 1);

select e.ename as Employee_Name, m.ename as Manager_Name, d.dname
from employee e
join employee m on e.mgr_no=m.empno
join dept d on e.deptno=d.deptno
where e.deptno=m.deptno;