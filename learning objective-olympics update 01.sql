Q0
Select * from public.athlete_events

Q1 find the total no of Olympic Games held as per the dataset.
select count(distinct games) as no_olympics from athlete_events

Q2 list down all the Olympic Games held so far.
select distinct year, season, city from athlete_events
order by 1

Q3 Mention the total no of nations who participated in each olympics game?
select count(distinct noc), games
from athlete_events
group by games

Q4 Which year saw the highest and lowest no of countries participating in olympics
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

Q4_alternative querry
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
					
Q5 Which year saw the highest and lowest no of countries participating in olympics
	 with tot_games as
              (select count(distinct games) as total_games
              from athlete_events),
          countries2 as
              (select games, nr.country as countries
              from athlete_events oh
              join noc_regions nr ON nr.noc=oh.noc
              group by games, nr.country),
          countries_participated as
              (select countries, count(1) as total_participated_games
              from countries2
              group by countries)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1

Q6 Identify the sport which was played in all summer olympics.
select distinct sport, season, games
from athlete_events
where season= 'Summer'
order by 1

Q7 Which Sports were just played only once in the olympics.
with x1 as (select distinct Games, Sport
from athlete_events ),
x2 as (select sport, count(1) as no_of_games from x1 group by sport )
select x2.*,x1.Games
from x2 join x1 on x1.Sport = x2.Sport
where x2.no_of_games = 1
order by x1.Sport

Q8 Fetch the total no of sports played in each olympic games.
select distinct games, count(distinct sport) from athlete_events
group by games

Q9 fetch the details of the oldest athletes to win a gold medal at the olympics.
select *
from athlete_events
where medal= 'Gold' and age = '64'

Q10  Find the Ratio of male and female athletes participated in all olympic games.
with t1 as
        	(select sex, count(1) as cnt
        	from athlete_events
        	group by sex),
        t2 as
        	(select *, row_number() over(order by cnt) as rn
        	 from t1),
        min_cnt as
        	(select cnt from t2	where rn = 1),
        max_cnt as
        	(select cnt from t2	where rn = 2)
    select concat('1 : ', round(max_cnt.cnt::decimal/min_cnt.cnt, 2)) as ratio
    from min_cnt, max_cnt


