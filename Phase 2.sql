#Which department's employee is the most likely to have the shortest commute between home and work?
use EmployeeAttritionDB_Group3;
select department.DepartmentID, department.DepartmentName, avg(employee.DistanceFromHome) as AverageDistance 
from employee inner join workexperience on employee.EmployeeNumber=workexperience.EmployeeNumber
inner join department on department.DepartmentID=employee.DepartmentID group by department.DepartmentID order by AverageDistance limit 1;









#A new employee from a Medical-related education field wants to work in Sales.
# Do you believe the company might be able to give her a chance to work in Sales? Why or Why not?
use EmployeeAttritionDB_Group3;
select department.DepartmentID, department.DepartmentName, educationfield.EducationField, 
avg(feedback.PerformanceRating) as Average_performance_rating 
from department inner join employee on department.DepartmentID=employee.DepartmentID
inner join feedback on feedback.EmployeeNumber=employee.EmployeeNumber
inner join educationdetails on educationdetails.EmployeeNumber=feedback.EmployeeNumber
inner join educationfield on educationfield.EducationFieldID=educationdetails.EducationFieldID 
WHERE department.DepartmentName="Sales" and employee.Gender="Female"
group by department.DepartmentID,department.DepartmentName,educationfield.EducationField
order by Average_performance_rating desc;





#The HR department feels they have the highest job satisfaction 
#while Research & Development department feels their department has the highest environment satisfaction. Who is right?
use EmployeeAttritionDB_Group3;
select department.DepartmentID, department.DepartmentName,avg(feedback.JobSatisfaction) as average_job_satisfaction,
avg(feedback.EnvironmentSatisfaction) as average_environment_satisfaction 
from department inner join employee on department.DepartmentID=employee.DepartmentID 
inner join feedback on employee.EmployeeNumber=feedback.EmployeeNumber
group by department.DepartmentID;









#An employee in Sales department has complained to HR saying that females are paid less than males in the company, in all departments. 
#What insight can you provide to prove or disprove that statement?
select * from 
(select department.DepartmentID, department.DepartmentName,employee.Gender, avg(salary.MonthlyIncome) as Average_Monthly_Salary,
(Rank() over(partition by DepartmentName order by (avg(salary.MonthlyIncome)) desc)) as Maximum_Salary_Rank
from department inner join employee on department.DepartmentID=employee.DepartmentID
inner join salary on employee.EmployeeNumber=salary.EmployeeNumber
group by department.DepartmentID,department.DepartmentName,employee.Gender
) Grp
Having  Grp.Maximum_Salary_Rank=1;





#HR feels that their environment satisfaction score is higher than Sales 
#but HR job satisfaction score is lower than Research & Development. Are they right?
use EmployeeAttritionDB_Group3;
select department.DepartmentID, department.DepartmentName,
avg(feedback.EnvironmentSatisfaction) as average_environment_satisfaction,
RANK() OVER (ORDER BY AVG(feedback.EnvironmentSatisfaction) DESC) AS environment_satisfaction_rank,
avg(feedback.JobSatisfaction) as average_job_satisfaction,
RANK() OVER (ORDER BY AVG(feedback.JobSatisfaction) DESC) AS job_satisfaction_rank
from department inner join employee on department.DepartmentID=employee.DepartmentID 
inner join feedback on employee.EmployeeNumber=feedback.EmployeeNumber
group by department.DepartmentID;




#A press article in a business magazine has said that at this company, married men have higher performance ratings than divorced or single men. 
#What initial finding can you obtain from the data to help articulate the company's response in this regard?
select employee.Gender,employee.MaritalStatus,avg(feedback.PerformanceRating) as Average_PerformanceRating
from employee inner join feedback on employee.EmployeeNumber=feedback.EmployeeNumber
where employee.Gender="Male"
group by employee.MaritalStatus
order by Average_PerformanceRating desc;










