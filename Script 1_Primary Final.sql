--TVORBA TABULKY t_payroll_light
CREATE TABLE t_payroll_light AS
SELECT 
	payroll_year,
	round(avg(value)::numeric) as salary,
	cpib.name
FROM czechia_payroll cp 
LEFT JOIN	czechia_payroll_industry_branch cpib 
			ON cp.industry_branch_code = cpib.code 
WHERE value_type_code = '5958'
AND industry_branch_code IS NOT NULL 
AND value IS NOT NULL
GROUP by payroll_year, cpib.name;

--Data o počtu zaměstnanců nejsou použitelná
SELECT count(payroll_year)
FROM czechia_payroll cp
WHERE value_type_code = '316';

SELECT count(payroll_year)
FROM czechia_payroll cp
WHERE value_type_code = '316'
AND value IS NULL;

--TVORBA TABULKY t_price_light

CREATE TABLE t_price_light AS
SELECT 
	date_part('year',date_from) as year,
	round(avg(cp.value)::numeric,1) as price,
	cpc.name,
	cpc.price_value,
	cpc.price_unit
FROM czechia_price cp 
LEFT JOIN czechia_price_category cpc 
		ON cp.category_code = cpc.code 
WHERE region_code IS NULL
AND cpc.name IS NOT NULL 
GROUP BY YEAR,cpc.name,cpc.price_value,cpc.price_unit;

--Sjednocení tabulek t_price_light a t_payroll_light do Primary_Final

CREATE TABLE t_Miloslava_Erika_Kaderabkova_project_SQL_primary_final AS
SELECT
	base.year,
	base.price as price,
	base.name as comodity,
	base.price_value,
	base.price_unit,
	a.salary as salary,
	a.name as branch
FROM t_price_light base 
LEFT JOIN t_payroll_light a 
	ON base."year" = a.payroll_year
ORDER BY base.year,base.name;


