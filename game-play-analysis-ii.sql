"""
  
Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the device that is first logged in for each player.

Return the result table in any order.

The result format is in the following example.


Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+

"""

-- method 1: using first_value
select 
    distinct player_id, 
    first_value(device_id) over(partition by player_id order by event_date) as device_id
from 
    Activity

  
-- method 2: using rank
with cte as
(
    select 
        distinct player_id, device_id,
        rank() over(partition by player_id order by event_date) as rnk
    from 
        Activity
)

select player_id, device_id from cte where rnk = 1

  
-- method 3: using subquery
select 
    a.player_id, a.device_id
from 
    Activity a
where 
    a.event_date in 
    (
        select
            min(b.event_date)
        from 
            Activity b 
        where 
            a.player_id = b.player_id
    )

  
-- method 4: using cte 
with cte as
(
    select 
        a.player_id, min(a.event_date) as 'min_date'
    from 
        Activity a
    group by 
        a.player_id
)

select 
    a.player_id, a.device_id 
from 
    Activity a 
where 
    a.event_date in (select c.min_date from cte c where c.player_id = a.player_id )


-- method 5: using last_value
select 
    distinct player_id, 
    last_value(device_id) over(partition by player_id order by event_date desc range between unbounded preceding and unbounded following ) as 'device_id'
from 
    Activity
