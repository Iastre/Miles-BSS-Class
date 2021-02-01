--Query to return users who have admin roles:
SELECT u.Name, u.Description, u.Birthday, r.Name AS Role, r.Description FROM Users u
LEFT JOIN UserRole lt ON u.UserID = lt.UserID
LEFT JOIN Role r ON lt.RoleID = r.RoleID
WHERE r.Name = 'Admin';

--Query to return users with admin roles and information about their taverns:
SELECT u.Name, u.Description, u.Birthday, r.Name AS Role, r.Description,
t.Name AS Tavern, t.Floors, l.Name AS Location
FROM Users u
LEFT JOIN UserRole lta ON u.UserID = lta.UserID
LEFT JOIN Role r ON lta.RoleID = r.RoleID
LEFT JOIN TavernUser ltb ON u.UserID = ltb.UserID
LEFT JOIN Tavern t ON ltb.TavernID = t.TavernID
LEFT JOIN Location l ON t.LocationID = l.LocationID
WHERE r.Name = 'Admin';

--All guests ordered by name (ascending) with classes and levels:
SELECT g.Name, g.Birthday, g.Cakeday, g.Notes, gs.Name AS Status,
gc.Level, c.Name AS Class
FROM GUEST g
LEFT JOIN GuestStatus gs ON g.StatusID = gs.StatusID
LEFT JOIN GuestClass gc ON g.GuestID = gc.GuestID
LEFT JOIN Class c ON gc.ClassID = c.ClassID
ORDER BY g.Name ASC;

--Top 10 sales in terms of sales price and what the services were:
SELECT TOP(10) sl.Price, sl.Date, sl.Amount, sl.UserID, sl.TavernID, sv.Name AS Service FROM Sales sl
LEFT JOIN Service sv ON sl.ServiceID = sv.ServiceID
ORDER BY Price DESC;

--Guests with 2 or more classes:
SELECT * FROM Guest
WHERE GuestID IN (
	SELECT GuestID FROM GuestClass
	GROUP BY GuestID
	HAVING COUNT(GuestID) > 1
);

--Guests with 2 or more classes with levels higher than 5:
SELECT * FROM Guest
WHERE GuestID IN (
	SELECT GuestID FROM GuestClass
	WHERE Level > 5
	GROUP BY GuestID
	HAVING COUNT(GuestID) > 1
);

--Guests with only their highest level class:
SELECT g.Name, MAX(gc.Level), c.Name AS Class FROM Guest g
LEFT JOIN GuestClass gc ON g.GuestID = gc.GuestID
LEFT JOIN Class c ON gc.ClassID = c.ClassID
GROUP BY g.Name;

--Guests who stayed within a certain date range:
SELECT g.Name, g.Notes, rs.Date, rs.Cost FROM Guest g
LEFT JOIN RoomStay rs ON g.GuestID = rs.GuestID
WHERE rs.Date BETWEEN '20080101' AND '20081231';

--(Add IDENTITY and PRIMARY KEY constraints to the SELECT CREATE query)
