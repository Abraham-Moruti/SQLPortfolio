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