use Bank;
select distinct s.customername 
from depositer s
where not exists (select branch_name from branch where branch_city="Delhi") 
except (select r.branch_name from depositer t, bankaccount r where t.accno=r.accno and s.customername=t.customername);