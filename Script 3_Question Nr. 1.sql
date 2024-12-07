--Výpočet meziročního růstu
SELECT DISTINCT 
	base.year,
	base.salary,
	a.salary,
	((base.salary-a.salary)/a.salary)*100 AS growth,
	base.branch
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base 
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a
ON base.branch = a.branch
AND base.YEAR = a.YEAR+1
WHERE base.year >2006
ORDER BY growth;

--vytvoření pomocného view 
CREATE VIEW v_salary_growth AS
SELECT DISTINCT 
	base.year,
	((base.salary-a.salary)/a.salary)*100 AS growth,
	base.branch
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base 
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a
ON base.branch = a.branch
AND base.YEAR = a.YEAR+1
WHERE base.year >2006
ORDER BY growth;

--ve kterých odvětvích došlo k poklesu ? 
SELECT DISTINCT branch
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final tmekpspf 
WHERE branch IN 
		(SELECT branch 
		FROM v_salary_growth 
		WHERE growth <0);

--ve kterých odvětvích nedošlo k podklesu ? 
SELECT DISTINCT branch
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final tmekpspf
WHERE branch NOT IN (SELECT branch 
					FROM v_salary_growth vsg  
					WHERE growth <0);
	
--odvětví, ve kterých došlo k poklesu (data s lety a mírou poklesu)
SELECT * 
FROM v_salary_growth vsg 
WHERE growth <0
ORDER BY branch;
