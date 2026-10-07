select * from [dbo].[customer_churn]
select count(*) from [dbo].[customer_churn]

select COUNT(*) from [dbo].[customer_churn]
where Churn = 'Yes'

-- Churn Rate 
select ROUND(
	SUM(case when churn = 'Yes' then 1.0 else 0.0 end) * 100 / 
	COUNT(*),2)
 [Churn Rate]
from [dbo].[customer_churn]

-- Avg Monthly Charges
select AVG(Monthly_Charges) from [dbo].[customer_churn]

--avg tenure 
select AVG(Tenure_Months) from [dbo].[customer_churn]

-- Churn by contract type 
select Contract_Type,COUNT(*) [customers] from [dbo].customer_churn
group by Contract_Type

-- Churn by internt service
select Internet_Service,COUNT(*) [customers] from [dbo].customer_churn
group by Internet_Service
-- Churn by State 
select state , count(*) from customer_churn
where Churn = 'Yes'
group by State
order by 2 desc  -- 2 means 2 coloumn 

-- Payment method wise customers 
select payment_Method , count(*) from customer_churn
group by Payment_Method

-- Subcription type wise customers 
select Subscription_Type , count(*) from customer_churn
group by Subscription_Type

-- highest revenue state 
select State, SUM(Total_Charges) [State_charges] from customer_churn
group by State 
order by 2 desc 
-- Avg Charges by Contract
select Contract_Type,avg(Monthly_Charges) from customer_churn
group by Contract_Type

-- senior citizens churn
select Senior_Citizen,COUNT(*) from customer_churn
where Churn='Yes'
group by Senior_Citizen

-- top 10 high value customers 
select top 10 Total_Charges, Customer_Name, Customer_Value from customer_churn
order by Total_Charges desc

-- customer w/o tecg support 
select  * from customer_churn where Tech_Support = 'No'




