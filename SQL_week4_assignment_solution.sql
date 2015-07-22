--build table
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees(
id 	integer		PRIMARY KEY,
title 	varchar(100),
e_name 	varchar(40) 	NOT NULL,
supervisor_id integer	
);


INSERT INTO Employees
(id, title, e_name, supervisor_id)
VALUES
(1, 'CEO', 'Steve Jobs', NULL),
(2, 'COO', 'Timothy Cook', 1),
(3, 'SVP Operations', 'Jeffrey Williams', 2),
(4, 'SVP Hardware', 'Bob Mansfield', 2),
(5, 'VP Online Stores', 'Jennifer Bailey', 2),
(6, 'VP Architecture', 'Michael Cultbert', 4),
(7, 'VP Iphone design', 'Steve Zadesky', 4),
(8, 'VP operations', 'Rita Lane', 3),
(9, 'VP fullfillment', 'William Frederick',3),
(10, 'Sr.Direct marketing', 'Mimi Mi',8);


-- query with self left join
SELECT o.e_name as employee, c.e_name as supervisor 
FROM Employees o LEFT JOIN Employees c 
ON o.supervisor_id=c.id;

