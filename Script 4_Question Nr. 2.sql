/*POMOCNÉ SCRIPTY
Jak vytáhnout cenu mléka ?*/ 
SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  WHERE comodity ILIKE 'mléko%' AND year = 2006;
SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  WHERE comodity ILIKE 'mléko%' AND year = 2018;

--Jak vytáhnout cenu chleba?
SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  WHERE comodity ILIKE 'chléb%' AND year = 2006;
SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  WHERE comodity ILIKE 'chléb%' AND year = 2018;

--jak vytáhnout počet odvětví?
(SELECT count(DISTINCT branch)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2006);

(SELECT count(DISTINCT branch)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2018);

--ODPOVĚDI NA OTÁZKU
--Kolik chleba a mléka je možné koupit za průměrnou mzdu za rok 2006 po odvětvích
SELECT DISTINCT 
branch,
round((salary/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final WHERE comodity ILIKE 'mléko%'AND year = 2006))::numeric) as milk_l,
round((salary/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final WHERE comodity ILIKE 'chléb%'AND year = 2006))::numeric) as bread_kg
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  
WHERE year = 2006
ORDER BY milk_l;

--Kolik chleba a mléka je možné koupit za průměrnou mzdu za rok 2018 po odvětvích
SELECT DISTINCT 
branch,
round((salary/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final WHERE comodity ILIKE 'mléko%'AND year = 2018))::numeric) as milk_l,
round((salary/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final WHERE comodity ILIKE 'chléb%'AND year = 2018))::numeric) as bread_kg
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final  
WHERE year = 2018
ORDER BY milk_l;

-- Jak spočítat celkový průměr z námi dostupných dat? 
	--mléko 2006
SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
					   FROM t_miloslava_erika_kaderabkova_project_sql_primary_final tmekpspf 
					   WHERE year = 2006))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										   WHERE comodity ILIKE 'mlék%'AND year = 2006) AS milk_2006
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2006;

	--chleba 2006
SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
					   FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
					   WHERE year = 2006))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										    WHERE comodity ILIKE 'chlé%'AND year = 2006)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2006;

	--mléko 2018
SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
					   FROM t_miloslava_erika_kaderabkova_project_sql_primary_final 
					   WHERE year = 2018))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										    WHERE comodity ILIKE 'mléko%'AND year = 2018)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2018;

	--chléb 2018
SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
				       FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
					   WHERE year = 2018))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										    WHERE comodity ILIKE 'chléb%'AND year = 2018)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2018;

--Jaké údaje bychom dostali, kdybychom použili průměrnou mzdu z dat ČSÚ? 
  -- mléko 2006
SELECT DISTINCT
	19546/price 
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE comodity ILIKE 'mlék%'
AND year = 2006;
  -- chleba 2006
SELECT DISTINCT
	19546/price 
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE comodity ILIKE 'chléb%'
AND year = 2006;
  -- mléko 2018 
SELECT DISTINCT
	32051/price 
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE comodity ILIKE 'mlék%'
AND year = 2018;
  --chleba 2018
SELECT DISTINCT
	32051/price 
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE comodity ILIKE 'chléb%'
AND year = 2018;

--Porovnání kupní síly u másla?  
SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
					   FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
					   WHERE year = 2006))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										    WHERE comodity ILIKE 'másl%'AND year = 2006)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2006;

SELECT 
(sum(DISTINCT salary)/(SELECT count(DISTINCT branch)
					   FROM t_miloslava_erika_kaderabkova_project_sql_primary_final 
					   WHERE year = 2018))/(SELECT DISTINCT price FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
										    WHERE comodity ILIKE 'másl%'AND year = 2018)
FROM t_miloslava_erika_kaderabkova_project_sql_primary_final
WHERE year = 2018;




