USE TEST
-- Задание 1
-- Выбрать фамилии и зарплаты тех продавцов, которые обслуживают покупателей в штате 'СА' (Калифорния).

--Доп задание: сделать без DISTINCT

SELECT last_name, max(salary) AS 'salary'
FROM EMPLOYEE
	INNER JOIN CUSTOMER ON EMPLOYEE.employee_id = CUSTOMER.salesperson_id
GROUP BY last_name, state
HAVING state = 'CA'
