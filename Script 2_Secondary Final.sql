--Tvorba Secondary_Final
CREATE TABLE t_Miloslava_Erika_Kaderabkova_project_SQL_secondary_final AS
SELECT 
	country,
	year,
	population,
	gdp,
	gini 
FROM economies e 
WHERE 	year BETWEEN 2006 AND 2018
AND 	country IN (SELECT country FROM countries c)
ORDER BY year, country;

--prověření počtu zemí, které se propsaly do finální tabulky
SELECT count (DISTINCT country)
FROM countries;

SELECT count (DISTINCT country)
FROM t_miloslava_erika_kaderabkova_project_sql_secondary_final tmekpssf; 

--které země se nepropsaly? 
SELECT country
FROM countries c 
EXCEPT 
SELECT country 
FROM t_miloslava_erika_kaderabkova_project_sql_secondary_final tmekpssf 
ORDER BY country;

SELECT DISTINCT country
FROM economies e 
WHERE country ILIKE '%Baha%';

SELECT DISTINCT country
FROM economies e 
WHERE country ILIKE '%Timor%';

SELECT DISTINCT country 
FROM economies e 
WHERE COUNTRY ILIKE '%Sahara%';

SELECT DISTINCT country 
FROM economies e 
WHERE COUNTRY ILIKE '%Korea, D%';

SELECT DISTINCT country
FROM economies e 
WHERE country ILIKE '%Bru%';

--Úprava Secondary_Final tak, aby obsahovala i Severní Koreu a Brunej
DROP TABLE t_Miloslava_Erika_Kaderabkova_project_SQL_secondary_final;

CREATE TABLE t_Miloslava_Erika_Kaderabkova_project_SQL_secondary_final AS
SELECT 
	country,
	year,
	population,
	gdp,
	gini 
FROM economies e 
WHERE year BETWEEN 2006 AND 2018
AND country IN (SELECT country FROM countries c )
UNION
SELECT
	country,
	year,
	population,
	gdp,
	gini
FROM economies e2 
WHERE country ILIKE '%Brun%'
AND "year" BETWEEN 2006 AND 2018
OR country ILIKE 'Korea, Dem.%'
AND "year" BETWEEN 2006 AND 2018
ORDER BY year, country;
