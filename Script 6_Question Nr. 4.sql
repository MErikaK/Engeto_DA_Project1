/* vypočet pro mezirocni procentualni zmenu 
 * ((salary-lag)/lag)*100
   ((price - lag) /lag) * 100*/

-- Výpočet meziročního růstu platů
	--pomocný SELECT
SELECT DISTINCT 
	base.YEAR,
	base.salary,
	base.branch,
	a.salary AS lag
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a 
	ON base.branch = a.branch 
	AND base.YEAR = a.YEAR+1
WHERE base.YEAR >2006
ORDER BY base.year;

	--samotný výpočet
SELECT DISTINCT 
	base.YEAR,
	round((((SUM(base.salary)-SUM(a.salary))/SUM(a.salary))*100)::NUMERIC,2) AS salary_growth
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a 
	ON base.branch = a.branch 
	AND base.YEAR = a.YEAR+1
WHERE base.YEAR >2006
GROUP BY base.year
ORDER BY base.year;

--Výpočet meziročního růstu cen
	--pomocný SELECT
SELECT DISTINCT 
	base.YEAR,
	base.price,
	base.comodity,
	b.price AS lag
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base 
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final b 
	ON base.comodity = b.comodity 
	AND base.YEAR = b.YEAR+1
WHERE base.YEAR >2006
ORDER BY base.year;

	--samotný výpočet
SELECT DISTINCT 
	base.YEAR,
	round((((sum (base.price)-sum(a.price))/sum(a.price))*100)::NUMERIC,2) AS price_growth
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base 
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a 
	ON base.comodity = a.comodity 
	AND base.YEAR = a.YEAR+1
WHERE base.YEAR >2006
GROUP BY base.year
ORDER BY base.year;

-- Spojení obou tabulek v jednu a vytvoření view
CREATE VIEW v_salary_price_growth AS
SELECT DISTINCT 
	base.YEAR,
	round((((SUM(base.salary)-SUM(a.salary))/SUM(a.salary))*100)::NUMERIC,2) AS salary_growth,
	round((((sum (base.price)-sum(a.price))/sum(a.price))*100)::NUMERIC,2) AS price_growth
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a 
	ON base.branch = a.branch 
	AND base.comodity = a.comodity
	AND base.YEAR = a.YEAR+1
WHERE base.YEAR >2006
GROUP BY base.year
ORDER BY base.year;

-- porovnání růstu cen a platů
SELECT 
	*,
	price_growth - salary_growth AS difference,
	CASE WHEN price_growth - salary_growth > 10 THEN 1
	ELSE 0
	END AS higher_than_10
FROM v_salary_price_growth vspg ;

