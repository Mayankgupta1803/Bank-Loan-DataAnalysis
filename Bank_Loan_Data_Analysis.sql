use Bank_loan_db;

select * from loan_data;


--- Total Loan Application
select COUNT(id) as Total_Loan_Application_Data from loan_data


--- MTD Total Loan Application
select COUNT(id) as MTD_Total_Loan_Application from loan_data
where MONTH( issue_date) = 12 and YEAR( issue_date) = 2021;

--- Previous month to Date (PMTD) Loan Application
select COUNT(id) as MTD_Total_Loan_Application from loan_data
where MONTH( issue_date) = 11 and YEAR( issue_date) = 2021;

--- Total Funded Amount
select sum(loan_amount) as Total_funded_Amount from loan_data;

--- MTD total funded amount
select sum(loan_amount) as MTD_Total_Funded_Amount from loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021;

--- Previous month to date (PMTD) Funded Amount
select sum(loan_amount) as MTD_Total_Funded_Amount from loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021;




--- Total Amount Received

select sum(total_payment) as Total_Funded_Amount from loan_data;

--- MTD Amount Received
select sum(total_payment) as Total_Funded_Amount from loan_data
where MONTH(last_payment_date)=12 and YEAR(last_payment_date)=2021;

--- PMTD Amount Received
select sum(total_payment) as PMTD_Total_Funded_Amount from loan_data
where MONTH(last_payment_date)=11 and YEAR(last_payment_date)=2021;



--- Average Interest Rate
select round(AVG(int_rate)*100,2) as Avg_Interest_Rate from loan_data;
							--- or
select AVG(int_rate) as Avg_Interest_Rate from loan_data;

--- MTD Average Rate
select round(AVG(int_rate)*100,2) as Avg_Interest_Rate from loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

--- PMTD Average Rate
select round(AVG(int_rate)*100,2) as Avg_Interest_Rate from loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021;



--- Average Debt to Income Ratio
select round(AVG(dti)*100,2) as Avg_DTI from loan_data;

--- MTD Average Debt to Income Ratio
select round(AVG(dti)*100,2) as MTD_Avg_DTI from loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021;

--- PMTD Average Debt to Income Ratio
select round(AVG(dti)*100,2) as PMTD_Avg_DTI from loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021;



select * from loan_data;

select distinct(loan_status) from loan_data;


--- Good Loan Percentage
select
	(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' Then id END)*100)
	/
	COUNT(id) as Good_loan_percentage
from loan_data;

--- Good Loan Applications
select
	(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' Then id END)) as Good_Loan_Application
from loan_data;

									--- OR
select count(id) as Good_Loan_Application from loan_data
where loan_status = 'Fully Paid' or loan_status='Current';

--- Good Loan Funded Amount
select SUM(loan_amount) as Good_Loan_Funded_Amount from loan_data
where loan_status='Fully Paid' or loan_status='Current';
						--- OR
select
	sum(case when loan_status = 'Fully Paid' or loan_status = 'Current' then loan_amount End)
	as Good_Loan_Funded_Amount
from loan_data;


--- Total Good Loan Received Amount
select SUM(total_payment) as Good_Loan_Recieved_Amount from loan_data
where loan_status='Fully Paid' or loan_status='Current';
						--- OR
select
	sum(case when loan_status = 'Fully Paid' or loan_status = 'Current' then total_payment End)
	as Good_Loan_Received_Amount
from loan_data;


select * from loan_data;


--- Bad Loan Percentage
select
	(COUNT(case when loan_status = 'Charged Off' Then id END)*100)
	/
	COUNT(id) as Bad_loan_percentage
from loan_data;

--- Bad Loan Applications
select
	(COUNT(case when loan_status = 'Charged Off' Then id END)) as Bad_Loan_Application
from loan_data;

									--- OR
select count(id) as Bad_Loan_Application from loan_data
where loan_status = 'Charged Off';

--- Bad Loan Funded Amount
select SUM(loan_amount) as Bad_Loan_Funded_Amount from loan_data
where loan_status='Charged Off';
						--- OR
select
	sum(case when loan_status = 'Charged Off' then loan_amount End)
	as Bad_Loan_Funded_Amount
from loan_data;


--- Total Bad Loan Received Amount
select SUM(total_payment) as Bad_Loan_Recieved_Amount from loan_data
where loan_status='Charged Off';
						--- OR
select
	sum(case when loan_status = 'Charged Off' then total_payment End)
	as Bad_Loan_Received_Amount
from loan_data;


-------------------------------
Select
	loan_status,
	count(id) as Loan_Applications,
	SUM(total_payment) as Total_Amount_Received,
	SUM(loan_amount) as Total_Funded_Amount,
	AVG(int_rate)*100 as Interest_Rate,
	AVG(dti)*100 as DTI
from loan_data
group by loan_status;


-------------------------------
select
	loan_status,
	SUM(total_payment) as MTD_Amount_Received,
	SUM(loan_amount) as MTD_Funded_Amount
from loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021
group by loan_status;

--------------------------------
select
	loan_status,
	SUM(total_payment) as PMTD_Amount_Received,
	SUM(loan_amount) as PMTD_Funded_Amount
from loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021
group by loan_status;


---- Dashboard 2
select * from loan_data;


--- Monthly trend by issue date ----------------------------
select
	DATENAME(Month,issue_date) as Months,
	COUNT(id) as Total_Loan_Application,
	SUM(total_payment) as Total_Amount_Received,
	SUM(loan_amount) as Total_Funded_Amount
from loan_data
group by DATENAME(Month,issue_date)
order by DATENAME(Month,issue_date);

				-------------OR--------------------

select
	month(issue_date) as Month_Number,   --- provide months no.
	DATENAME(Month,issue_date) as Months,
	COUNT(id) as Total_Loan_Application,
	SUM(total_payment) as Total_Amount_Received,
	SUM(loan_amount) as Total_Funded_Amount
from loan_data
group by month(issue_date), DATENAME(Month,issue_date)
order by 1;


----- Regional Analysis by State -------------------

select
	address_state,
	COUNT(id) as Total_Loan_Application,
	SUM(total_payment) as Total_Amount_Received,
	SUM(loan_amount) as Total_Funded_Amount
from loan_data
group by address_state
order by 1;

				----------OR---------------

select
	address_state,
	COUNT(id) as Total_Loan_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received
from loan_data
group by address_state
order by 3 Desc;


---- Loan Term Analysis ------------------------

select
	term,
	COUNT(id) as Total_Loan_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received
from loan_data
group by term
order by 1;


---- Employee length Analysis ------------------------

select
	emp_length,
	COUNT(id) as Total_Loan_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received
from loan_data
group by emp_length
order by 1;

select * from loan_data;

---- Loan Purpose Anaalysis --------------------
select
	purpose,
	COUNT(id) as Total_Loan_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received
from loan_data
group by purpose
order by 2;

------             -------------------------
select
	home_ownership,
	COUNT(id) as Total_Loan_Application,
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received
from loan_data
group by home_ownership
order by 2 desc;

