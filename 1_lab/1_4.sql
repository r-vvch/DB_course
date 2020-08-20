USE TEST
--������� 4
--���������� ���������, � �������� � ���������������� ���������� ��������� ���������� ����� ��������.

--��� �������: ������� ��� ���������� SELECT

SELECT TOP(1) WITH ties CONCAT (ManTab.first_name, ' ', ManTab.last_name) AS 'manager name'
FROM (Employee ManTab inner join Employee EmpTab
	ON EmpTab.manager_id = ManTab.employee_id) INNER JOIN Job JobTable 
	ON (ManTab.job_id = JobTable.job_id AND JobTable.[function] LIKE 'manager')
GROUP BY ManTab.employee_id, EmpTab.manager_id, ManTab.last_name, ManTab.first_name
ORDER BY count (ManTab.manager_id) DESC;
