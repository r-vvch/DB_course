USE TEST
-- ������� 1
-- ������� ������� � �������� ��� ���������, ������� ����������� ����������� � ����� '��' (����������).

--��� �������: ������� ��� DISTINCT

SELECT last_name, max(salary) AS 'salary'
FROM EMPLOYEE
	INNER JOIN CUSTOMER ON EMPLOYEE.employee_id = CUSTOMER.salesperson_id
GROUP BY last_name, state
HAVING state = 'CA'
