--Function to take a level and return a grouping:
IF OBJECT_ID (N'dbo.levelGroup', N'FN') IS NOT NULL
	DROP FUNCTION dbo.levelGroup;
GO
CREATE FUNCTION dbo.levelGroup(@level int)
RETURNS varchar(20)
AS
BEGIN
	DECLARE @result varchar(20);
	SELECT @result = (CASE
		WHEN @level < 5 THEN 'beginner'
		WHEN @level >= 5 AND @level < 10 THEN 'intermediate'
		ELSE 'expert'
	END);
	RETURN @result;
END;

GO

--Function to list all open rooms on a given day & what tavern they belong to:
IF OBJECT_ID (N'dbo.listOpenRooms', N'IF') IS NOT NULL
	DROP FUNCTION dbo.listOpenRooms;
GO
CREATE FUNCTION dbo.listOpenRooms(@date date)
RETURNS TABLE
AS
RETURN
(

SELECT r.RoomID, r.Cost, s.Name AS Status, t.Name AS Tavern, l.Name AS Location
FROM Room r LEFT JOIN RoomStay rs ON r.RoomID = rs.RoomID
LEFT JOIN Tavern t ON r.TavernID = t.TavernID
LEFT JOIN Location l ON t.LocationID = l.LocationID
LEFT JOIN RoomStatus s ON r.StatusID = s.StatusID
WHERE CAST(rs.Date AS DATE) <> @date;

)

GO

--Previous function modified to list room/tavern in a given price range (min-max):
IF OBJECT_ID (N'dbo.listRoomsByPrice', N'IF') IS NOT NULL
	DROP FUNCTION dbo.listRoomsByPrice;
GO
CREATE FUNCTION dbo.listRoomsByPrice(@min int, @max int)
RETURNS TABLE
AS
RETURN
(

SELECT r.RoomID, r.Cost, s.Name AS Status, t.TavernID, t.Name AS Tavern, l.Name AS Location
FROM Room r LEFT JOIN RoomStay rs ON r.RoomID = rs.RoomID
LEFT JOIN Tavern t ON r.TavernID = t.TavernID
LEFT JOIN Location l ON t.LocationID = l.LocationID
LEFT JOIN RoomStatus s ON r.StatusID = s.StatusID
WHERE r.Cost >= @min AND r.Cost <= @max
ORDER BY r.Cost;

)
