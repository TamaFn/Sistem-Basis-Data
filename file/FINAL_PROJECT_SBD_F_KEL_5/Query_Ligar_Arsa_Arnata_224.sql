-- 1
select ac.ACC_KTP_NUM, ac.acc_name, at.at_limit
from account ac, account_type at
where ac.acc_at_id = at.at_id
AND at.AT_LIMIT < "5000000";

-- 2
select a.acc_name  
from transaction t
inner join employee e on t.t_e_ktp_num = e.e_ktp_num
inner join account a on t.t_acc_ktp_num = a.acc_ktp_num
where e.e_name = "Sinaga Bakianto";

-- 3
select ROUND (SUM(t.t_loan) / (COUNT(distinct a.acc_ktp_num)), 2) as "Nilai rata rata"
from account a, transaction t
where t.t_acc_ktp_num = a.acc_ktp_num
and a.acc_gender = "P";

-- 4
select e.e_name, COUNT(t.t_id) as "Jumlah Transaksi"
from employee e 
inner join transaction t
on e.e_ktp_num = t.t_e_ktp_num
group by e.e_name
order by COUNT(t.t_id) DESC
limit 1;

-- 5
SELECT ACC_KTP_NUM, ACC_NAME
FROM account
WHERE ACC_KTP_NUM NOT IN(
    SELECT DISTINCT T_ACC_KTP_NUM
    FROM transaction
    WHERE T_LT_ID IN (
        SELECT LT_ID
        FROM loan_type
        WHERE LT_NAME = '12 BULAN')
    )
ORDER BY ACC_REG_DATE ASC;