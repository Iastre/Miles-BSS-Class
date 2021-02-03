--All users and their roles:
SELECT u.Name, u.Description, u.Birthday, r.Name AS Role, r.Description AS RoleDesc
FROM Users u LEFT JOIN UserRole ur ON u.UserID = ur.UserID
LEFT JOIN Role r ON ur.RoleID = r.RoleID;

--All classes and a count of guests holding that class:
SELECT c.Name, COUNT(gc.ClassID) AS Count
FROM GuestClass gc LEFT JOIN Class c ON gc.ClassID = c.ClassID
GROUP BY c.Name;

--Guests ordered by name (asc) with classes & levels:
--(include column for beginner(lvl 1-5), intermediate (5-10) and expert (10+)
SELECT g.Name, c.Name AS Class, gc.Level,
(CASE
WHEN gc.Level IS NULL THEN '(no class)'
WHEN gc.Level < 5 THEN 'beginner'
WHEN gc.Level >= 5 AND gc.Level < 10 THEN 'intermediate'
ELSE 'expert'
END) AS Ranking
FROM Guest g LEFT JOIN GuestClass gc ON g.GuestID = gc.GuestID
LEFT JOIN Class c ON gc.ClassID = c.ClassID
ORDER BY g.Name ASC;

--Testing the functions defined in "Homework5_Functions.sql":
SELECT g.Name, c.Name AS Class, gc.Level, dbo.levelGroup(gc.Level) AS Ranking
FROM Guest g LEFT JOIN GuestClass gc ON g.GuestID = gc.GuestID
LEFT JOIN Class c ON gc.ClassID = c.ClassID
ORDER BY g.Name ASC;

SELECT * FROM dbo.listOpenRooms('20081020');

SELECT * FROM dbo.listRoomsByPrice(60,200) ORDER BY Cost ASC;

--Command to undercut the cheapest room by a penny (or 1 gold in my schema):
DECLARE @price int;
DECLARE @tavern int;

SELECT @price = (SELECT TOP(1) Cost FROM dbo.listRoomsByPrice(60,200) ORDER BY Cost ASC);
SET @price = @price - 1;
SELECT @tavern = (SELECT TOP(1) TavernID FROM dbo.listRoomsByPrice(60,200) ORDER BY Cost ASC);

IF @tavern = 1
	INSERT INTO Room(StatusID,TavernID,Cost) VALUES (1,2,@price);
ELSE
	INSERT INTO Room(StatusID,TavernID,Cost) VALUES (1,1,@price);

SELECT * FROM Room;
