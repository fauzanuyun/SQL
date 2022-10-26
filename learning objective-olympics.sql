Q0
Select * from public.athlete_events
Q1
select count(distinct games) as no_olympics from athlete_events
Q2
select distinct year, season, city from athlete_events
order by 1
Q3
with all_countries AS
(select games, nr.country
from athlete_events oh
join noc_regions nr ON nr.noc=oh.noc
group by games, nr.country),
tot_countries as (select games, count(1) as total_countries
				 from all_countries
				 group by games)
select distinct 
CONCAT(first_value(games) over(order by total_countries),'-',
first_value(total_countries) over(order by total_countries)) as lowest_countries,
concat(first_value(games) over(order by total_countries desc),'-', 
first_value(total_countries) over(order by total_countries desc)) as Highest_countries
from tot_countries
order by 1

Q4_1
with ab as(SELECT count(distinct NOC)as tot_countries,Games  
FROM athlete_events
group by 2
order by 1)
select distinct concat(first_value(Games) over(order by ab.tot_countries),'-',
first_value(ab.tot_countries) over(order by ab.tot_countries)) as lowest ,
concat(first_value(Games) over(order by ab.tot_countries desc),'-',
first_value(ab.tot_countries) over(order by ab.tot_countries desc)) as highest
from ab
					order by 1
					
Q5
	with ab as (select count(distinct games) as total_participated, a.country as negara
	from athlete_events b
	join noc_regions a 
	on a.noc= b.noc 
	group by a.country)
	select max(ab.total_participated), ab.negara
	from ab
	group by 2
order by 1 desc
limit 4

Q6
select distinct sport, season, games
from athlete_events
where season= 'Summer'
order by 1

Q7
