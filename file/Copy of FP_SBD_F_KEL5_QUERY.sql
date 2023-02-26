---------------------------------------------------- KELOMPOK 5 ----------------------------------------------------
------------------------------------------------------ SBD F -------------------------------------------------------

-- Aurelio Killian Lexi Verrill --------- (5025211126)
-- Jawahirul Wildan --------------------- (5025211150)
-- Sandyatama Fransisna Nugraha --------- (5025211196)
-- Ligar Arsa Arnata -------------------- (5025211224)

-------------------------------------------------------------------------------------------------LIGAR--------------
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
-------------------------------------------------------------------------------------------------LIGAR--------------

-------------------------------------------------------------------------------------------------WILDAN-------------
-- 6
SELECT ACC_KTP_NUM, ACC_NAME
FROM account
WHERE ACC_KTP_SCAN IS NULL 
OR ACC_NPWP_SCAN IS NULL 
OR ACC_SELFIE IS NULL 
OR ACC_BANK_NUM_SCAN IS NULL;

-- 7
SELECT ACC_KTP_NUM, ACC_NAME
FROM loan_type lt
INNER JOIN transaction tr ON tr.T_LT_ID = lt.LT_ID
INNER JOIN account ac ON ac.ACC_KTP_NUM = tr.T_ACC_KTP_NUM
WHERE LT_NAME = '12 BULAN';

-- 8
SELECT ACC_KTP_NUM,ACC_NAME, COUNT(T_ID) AS TOTAL
FROM account ac
LEFT JOIN transaction tr ON ac.ACC_KTP_NUM = tr.T_ACC_KTP_NUM
GROUP BY ACC_KTP_NUM  
ORDER BY TOTAL ASC;

-- 9
SELECT ACC_KTP_NUM, ACC_NAME, SUM(T_PENALTY_COUNT) AS PENALTI, SUM(T_PENALTY_COUNT*LT_PENALTY) AS TOTAL_UANG_PENALTI
FROM account ac
INNER JOIN transaction tr ON tr.T_ACC_KTP_NUM =  ac.ACC_KTP_NUM
INNER JOIN loan_type lt ON lt.LT_ID = tr.T_LT_ID
WHERE T_PENALTY_COUNT <> 0
GROUP BY ACC_KTP_NUM
ORDER BY TOTAL_PENALTI

-- 10
SELECT ACC_NAME
FROM account
WHERE ACC_KTP_NUM NOT IN (
SELECT DISTINCT T_ACC_KTP_NUM
FROM transaction)
-------------------------------------------------------------------------------------------------WILDAN-------------

-------------------------------------------------------------------------------------------------TAMA---------------
-- 11
SELECT T_ID, T_DATE
FROM Transaction
WHERE MONTH(t_date) <= 6 AND YEAR(t_date) = 2021;

-- 12
SELECT ACC_NAME, T_DUE_DATE
FROM account
INNER JOIN transaction
ON T_ACC_KTP_NUM = ACC_KTP_NUM
WHERE T_STATUS = 'BELUM LUNAS'
AND T_DUE_DATE < '2022-12-29';

-- 13
SELECT LT_NAME_ID,COUNT(T_LT_ID) AS Banyak_Transaksi
FROM transaction,loan_type
WHERE LT_ID = T_LT_ID
GROUP BY LT_ID;

-- 14
SELECT T_ID, T_LOAN, SUM(T_MONTHLY_PAYMENT) AS TOTAL_PAYMENT
FROM transaction INNER JOIN loan_payment
ON T_ID = LP_T_ID
GROUP BY T_ID
ORDER BY TOTAL_PAYMENT DESC;

-- 15
SELECT ROUND(AVG((TIMESTAMPDIFF(YEAR,ACC_DATE_OF_BIRTH,NOW()))),2) AS "UMUR RATA RATA"
FROM account
WHERE ACC_KTP_NUM IN (
    SELECT DISTINCT T_ACC_KTP_NUM
    FROM transaction );
-------------------------------------------------------------------------------------------------TAMA---------------

-------------------------------------------------------------------------------------------------AURELIO------------
-- 16
SELECT ACC_NAME, ACC_RATING
FROM ACCOUNT
WHERE ACC_RATING < 5
ORDER BY ACC_RATING;

-- 17
SELECT T_DATE, E_NAME
FROM TRANSACTION
INNER JOIN EMPLOYEE
ON T_E_KTP_NUM = E_KTP_NUM
WHERE MONTH(T_DATE) = 8 AND YEAR(T_DATE) = 2020;

-- 18
SELECT MONTHNAME(T_DATE), YEAR(T_DATE), COUNT(*)
FROM TRANSACTION
GROUP BY YEAR(T_DATE), MONTH(T_DATE)
ORDER BY COUNT(*) DESC;

-- 19
SELECT ACC_NAME, SUM(T_LOAN) AS 'TOTAL PEMINJAMAN'
FROM ACCOUNT
LEFT JOIN TRANSACTION
ON ACC_KTP_NUM = T_ACC_KTP_NUM
GROUP BY ACC_KTP_NUM
ORDER BY SUM(T_LOAN) DESC;

-- 20
SELECT ACC_NAME, T_ID, SUM(SISA)
FROM ACCOUNT, 
(
    SELECT *, COUNT(LP_ID), (LT_PERIOD - COUNT(LP_ID)) AS SISA
    FROM TRANSACTION
    INNER JOIN LOAN_TYPE
    ON T_LT_ID = LT_ID
	LEFT JOIN LOAN_PAYMENT
    ON LP_T_ID = T_ID
    WHERE T_STATUS = 'BELUM LUNAS'
    GROUP BY T_ID
    ORDER BY SISA
) AS SC
WHERE T_ACC_KTP_NUM = ACC_KTP_NUM
GROUP BY ACC_KTP_NUM
ORDER BY SUM(SISA) DESC;
-------------------------------------------------------------------------------------------------AURELIO------------

-------------------------------------------------------------------------------------------------VALIDASI-----------
-- VALIDASI DATA PEMINJAMAN
SELECT ACC_KTP_NUM, ACC_NAME, AT_LIMIT, T_LOAN, T_DATE, T_DUE_DATE, T_STATUS
FROM ACCOUNT
INNER JOIN TRANSACTION
ON T_ACC_KTP_NUM = ACC_KTP_NUM
INNER JOIN ACCOUNT_TYPE
ON ACC_AT_ID = AT_ID
WHERE ACC_KTP_NUM IN (
    SELECT ACC_KTP_NUM
    FROM ACCOUNT 
    INNER JOIN
    ACCOUNT_TYPE
    ON ACC_AT_ID = AT_ID
    INNER JOIN TRANSACTION
    ON ACC_KTP_NUM = T_ACC_KTP_NUM
    GROUP BY ACC_KTP_NUM
    HAVING SUM(T_LOAN) > AT_LIMIT
)


