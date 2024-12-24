"""
  
Table: Point2D
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
+-------------+------+
(x, y) is the primary key column (combination of columns with unique values) for this table.
Each row of this table indicates the position of a point on the X-Y plane.
 

The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write a solution to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

The result format is in the following example.

Input: 
Point2D table:
+----+----+
| x  | y  |
+----+----+
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
+----+----+
Output: 
+----------+
| shortest |
+----------+
| 1.00     |
+----------+
  
"""

select 
    min(round(sqrt(pow(p2.x - p1.x, 2) + pow(p2.y-p1.y, 2)), 2)) as shortest
from 
    Point2D p1 join Point2D p2 
on 
    p1.x <= p2.x and p1.y < p2.y
    or 
    p1.x <= p2.x and p1.y > p2.y
    or 
    p1.x < p2.x and p1.y = p2.y
