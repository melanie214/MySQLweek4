 current_dept_emp     |
| departments          |
| dept_emp             |
| dept_emp_latest_date |
| dept_manager         |
| employees            |
| salaries             |
| titles         


Which employees have a salary above 150,000 and what are their titles? 

delimiter // 
Drop PROCEDURE IF EXISTS high_salary; 
CREATE PROCEDURE high_salary()  
select e.first_name, e.last_name, t.title, s.salary from employees e
inner join titles t on e.emp_no = t.emp_no
inner join salaries s on t.emp_no = s.emp_no 
where s.salary > 150000;


Which employee was born on February 14, 1990? 

DROP PROCEDURE IF EXISTS birthday; 
CREATE PROCEDURE birthday(IN month int(2), IN day int(2))
select first_name, last_name, birth_date from employees 
where DAYOFMONTH(birth_date) = day and MONTH(birth_date) = month; 


How many employees were hired in 1995? 

DROP PROCEDURE IF EXISTS how_many; 
CREATE PROCEDURE how_many()
SELECT COUNT(*) emp_no from employees 
where hire_date BETWEEN '1995-01-01' and "1995-12-31";  


Which employees had a salary greater that $90,000 in the year 1999? 

DROP PROCEDURE IF EXISTS 90k; 
CREATE PROCEDURE 90k()
SELECT e.first_name, e.last_name, t.title, s.salary from employees e 
inner join titles t on e.emp_no = t.emp_no 
inner join salaries s on t.emp_no = s.emp_no 
where hire_date BETWEEN "1999-01-01" and "1999-12-31" and SALARY > 90000; 




Which employees have a birthday on a paid FEDERAL HOLIDAY such as New Years Day,
Independence Day, Veterans Day, Christmas Day, Memorial Day?
01/01
01/21
05/27
07/04
11/11
12/25
 
DROP PROCEDURE IF EXISTS paid_birthday; 
CREATE PROCEDURE paid_birthday()
SELECT first_name, last_name, birth_date from employees 
WHERE DAYOFMONTH(birth_date) = 01 and MONTH(birth_date) = 01 OR
    DAYOFMONTH(birth_date) = 21 and MONTH(birth_date) = 01 OR
    DAYOFMONTH(birth_date) = 27 and MONTH(birth_date) = 05 OR
    DAYOFMONTH(birth_date) = 04 and MONTH(birth_date)= 07 OR
    DAYOFMONTH(birth_date) = 11 and MONTH(birth_date) = 11 OR
    DAYOFMONTH (birth_date) = 25 and MONTH(birth_date)= 12 LIMIT 25; 


CREATE PROCEDURE find_month_day_match(month, day)
SELECT first_name, last_name, birth_date from employees 
WHERE DAYOFMONTH(birth_date) = month and MONTH(birth_date) = day;

CALL find_month_day_match(01, 01)
CALL find_month_day_match(21, 01)
CALL find_month_day_match(27, 05)

months = [1, 2, 5]
days = [1, 18, 11]

LOOP months and days
    SET d = day
    SET m = month
    CALL find_month_day_match(m, d)
END 



