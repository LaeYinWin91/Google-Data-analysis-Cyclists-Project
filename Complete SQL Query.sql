Drop table if exists #2023combined_data
CREATE TABLE #2023combined_data 
(ride_id nvarchar(255),
rideable_type nvarchar(255),
started_at datetime,
ended_at datetime,
ride_length datetime,
day_of_week float,
member_casual nvarchar(255)
)
Insert into #2023combined_data (ride_id,rideable_type,started_at,ended_at,ride_length, day_of_week,member_casual)
Select *
From [Portfolio project]..Cyclists0123
UNION All
Select *
From [Portfolio project]..Cyclists0223
UNION ALL
Select *
From [Portfolio project]..Cyclists0323
UNION ALL
Select *
From [Portfolio project]..Cyclists0423
UNION ALL
Select *
From [Portfolio project]..Cyclists0523
UNION ALL
Select *
From [Portfolio project]..Cyclists0623
UNION ALL
Select *
From [Portfolio project]..Cyclists0723
UNION ALL
Select *
From [Portfolio project]..Cyclists0822
UNION ALL
Select *
From [Portfolio project]..Cyclists0922
UNION ALL
Select *
From [Portfolio project]..Cyclists1022
UNION ALL
Select *
From [Portfolio project]..Cyclists1122
UNION ALL
Select *
From [Portfolio project]..Cyclists1222

SELECT *
FROM #2023combined_data


With combinedCTE As (
Select*,
ROW_NUMBER () Over(
Partition by ride_id,
             started_at,
             ended_at,
			 ride_length
Order by ride_id)
row_num
From #2023combined_data
)
Select *
From combinedCTE
where row_num >1

With combinedCTE As (
Select*,
ROW_NUMBER () Over(
Partition by ride_id,
             started_at,
             ended_at,
			 ride_length
Order by ride_id)
row_num
From #2023combined_data
)
Delete
From combinedCTE
where row_num >1


Select Month(started_at) as Month_name, count(*) as monthly_riders, member_casual
From #2023combined_data
Group by Month(started_at), member_casual


Select count (*) as daily_riders, member_casual, day_of_week
From #2023combined_data
Group by day_of_week, member_casual



Select count (member_casual) as type_of_users, member_casual
From #2023combined_data
Group by member_casual

 
Select member_casual, Avg (Cast(DATEDIFF (second, started_at, ended_at)as bigint)) as Trip_duration
From #2023combined_data
Group by member_casual 



Select member_casual, Avg (Cast(DATEDIFF (second, started_at, ended_at)as bigint)) as Trip_duration, month(started_at) as Monthly
From #2023combined_data
Group by member_casual, month (started_at) 


Select member_casual, Avg (Cast(DATEDIFF (second, started_at, ended_at)as bigint)) as Trip_duration, day_of_week
From #2023combined_data
Group by member_casual, day_of_week 


Select rideable_type, count (member_casual), member_casual
From #2023combined_data
Group by rideable_type, member_casual
