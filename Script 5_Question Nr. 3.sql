-- Která kategorie potravin zdražuje nejpomaleji? 
SELECT DISTINCT 
	base.price as price_2006,
	base.comodity,
	a.price as price_2018,
	round((((a.price/base.price)*100)-100)::numeric,1) as growth
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final base 
LEFT JOIN t_miloslava_erika_kaderabkova_project_sql_primary_final a 
	ON base.comodity = a.comodity
	AND a.year = 2018
WHERE base.year = '2006'
ORDER BY growth;

-- Kontrola cukru
SELECT DISTINCT 
	year,
	price,
	comodity 
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  
WHERE comodity ILIKE 'cukr%'
ORDER BY year;
