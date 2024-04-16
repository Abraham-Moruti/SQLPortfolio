#1. Show their name and net worth
Select personName,finalworth from billionaires;

#2. Calculate the number of unique countries
SELECT COUNT(DISTINCT country) AS Number_Of_Countries FROM billionaires;

#3. What is the average for there Net Worth?
SELECT AVG(finalWorth) AS Number_Of_NetWorth FROM billionaires;

#4. Who is the richest person in france?
SELECT finalWorth, personName from billionaires
where country= 'france'
Order by finalWorth desc
limit 1;

#5. Count how many are self made
SELECT count(personName) as Count_of_Selfmade FROM billionaires
where selfmade = 'true';

#6. Find the number of billionaires by industry
SELECT industries, count(personName) as number_of_billionaires FROM billionaires
group by industries
Order by number_of_billionaires desc;

#7. List the number of the top 5 billionaires by country
SELECT country, count(personName) as number_of_billionaires FROM billionaires
group by country
Order by number_of_billionaires desc
limit 5;

#8. List the number of billionaires by the birth month
SELECT birthMonth, count(personName) FROM billionaires
group by birthMonth
order by birthMonth

#9. List countries that start with the letters F or A
select distinct (country) from billionaires
where country like 'f%' or country like 'a%';

#10. List Countries that start with 'C' but has an 'H/O' afterwards
select distinct (country) from billionaires
where country like 'CH%' or country like 'CO%';

#11. Categorize the billionaires by high or low
select personName, finalworth, if (finalworth <10000, 'low', 'high') AS Category
from billionaires;

#12. Categorize the billionaires by low, mwdium and high
Select personName, finalWorth, case
When finalWorth < 25000 then 'low'
When finalworth between 25000 and 75000 then 'medium'
else 'high'
end as category
from billionaires;

#13. Compare the average net worth vs each person
select personName, Finalworth,
(Select round((avg(FinalWorth)),2)from billionaires) as AverageNetWorth
from billionaires;

#14. What are the top 3 languages spoken by billionaires
select language , count(personName) AS languageCount from billionaires
right JOIN geography
ON billionaires.country= geography.Country_Name
group by Language
order by LanguageCount desc
limit 3;
