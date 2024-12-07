-- porovnání hodnot "okem" a vytvoření dočasné tabulky
SELECT 
	base.YEAR,
	round((((base.gdp-a.gdp)/a.gdp)*100 )::NUMERIC,2) AS gdp_growth,
	b.salary_growth,
	b.price_growth
FROM t_miloslava_erika_kaderabkova_project_sql_secondary_final base
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_secondary_final a 
	ON base.country = a.country
	AND base.YEAR = a.YEAR+1
LEFT JOIN v_salary_price_growth b 
	ON base.YEAR = b.year
WHERE base.country ILIKE 'Czech%'
AND base.YEAR >2006;

CREATE TEMP TABLE t_correlation AS ( 
SELECT 
	base.YEAR,
	round((((base.gdp-a.gdp)/a.gdp)*100 )::NUMERIC,2) AS gdp_growth,
	b.salary_growth,
	b.price_growth
FROM t_miloslava_erika_kaderabkova_project_sql_secondary_final base
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_secondary_final a 
	ON base.country = a.country
	AND base.YEAR = a.YEAR+1
LEFT JOIN v_salary_price_growth b 
	ON base.YEAR = b.year
WHERE base.country ILIKE 'Czech%'
AND base.YEAR >2006);

--korelace ve stejném a následujícím roce
SELECT 
	CORR (base.gdp_growth,base.salary_growth) AS salary_same_year,
	CORR (base.gdp_growth, base.price_growth) AS price_same_year,
	CORR (base.gdp_growth, a.salary_growth) AS salary_next_year,
	CORR (base.gdp_growth, a.price_growth) AS price_next_year
FROM t_correlation base
LEFT JOIN t_correlation a
	ON base.YEAR = a.YEAR-1;
  
--pomocný SELECT pro výpočet korelace
SELECT 
	base.YEAR,
	base.gdp_growth,
	base.salary_growth,
	base.price_growth,
	a.salary_growth,
	a.price_growth
FROM t_correlation base
LEFT JOIN t_correlation a
	ON base.YEAR = a.YEAR-1;
