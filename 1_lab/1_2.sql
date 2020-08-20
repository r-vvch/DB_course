USE TEST
-- Задание 2
-- Определить штаты, для которых средняя задержка между заключением сделки и поставкой товара превышает месяца.

--Доп задание: через MONTH не работет, исправить


--Пытался написать, чтобы однозначно задать месяц: разнца в датах считается как дробное число
--(к переменной добавляется дробные части от соответсвующих заказу и отгрузке и число месяцев, прошедших целиком)
--и с ним ведётся работа.

--Пытался разобраться в функциях, переменных и ветвлении — не вышло

--Далее — то, что я пробовал:

/*

CREATE FUNCTION diff
RETURNS float
AS
...

DECLARE @sum float
SET @sum = 0.0
SELECT CUSTOMER.state
FROM CUSTOMER INNER JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
WHERE (IF (MONTH(order_date) <> MONTH(ship_date)) AND (YEAR(order_date) = YEAR(ship_date))
		--Прибавляем к sum недостающие дни от даты заказа
			IF (MONTH(order_date) = 1) OR (MONTH(order_date) = 3) OR (MONTH(order_date) = 5) OR (MONTH(order_date) = 7)
				OR (MONTH(order_date) = 8) OR (MONTH(order_date) = 10) OR (MONTH(order_date) = 12)
				{@sum += ((31 - DAY(order_date))/31))}
			IF (MONTH(order_date) = 4) OR (MONTH(order_date) = 6) OR (MONTH(order_date) = 9) OR (MONTH(order_date) = 11)
				(@sum += ((30 - DAY(order_date))/30));
			IF (MONTH(order_date) = 2)
				(@sum += ((28 - DAY(order_date))/28));
		--Прибавляем к sum дни от даты отгрузки
			IF (MONTH(ship_date) = 1) OR (MONTH(ship_date) = 3) OR (MONTH(ship_date) = 5) OR (MONTH(ship_date) = 7)
				OR (MONTH(ship_date) = 8) OR (MONTH(ship_date) = 10) OR (MONTH(ship_date) = 12)
				(@sum += (DAY(ship_date)/31));
			IF (MONTH(ship_date) = 4) OR (MONTH(ship_date) = 6) OR (MONTH(ship_date) = 9) OR (MONTH(ship_date) = 11)
				(@sum += (DAY(ship_date)/30));
			IF (MONTH(order_date) = 2)
				(@sum += (DAY(ship_date)/28));
		--Прибавляем к sum разницу месяцов
			(@sum += DATEDIFF(MONTH, order_date, ship_date)*1.0)
	  ELSE
		--Прибавляем к sum разницу месяцов
			(@sum += DATEDIFF(MONTH, order_date, ship_date)*1.0)

	 --Условие WHERE
	 (@sum > 1.0) 
	 )
GROUP BY CUSTOMER.state

*/

--Рабочий запрос, если однозначно задать значение месяца равным 30 дням
SELECT CUSTOMER.state
FROM CUSTOMER
	INNER JOIN SALES_ORDER on CUSTOMER.customer_id = SALES_ORDER.customer_id
GROUP BY CUSTOMER.state, order_date, ship_date
HAVING (AVG(DATEDIFF (DAY, order_date, ship_date)) > 30)