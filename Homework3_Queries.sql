--Guests with a birthday before 2000:
SELECT * FROM Guest WHERE YEAR(Birthday) < 2000;

--Rooms that cost more than 100 gold a night:
SELECT * FROM Room WHERE Cost > 100;

--Unique guest names:
SELECT DISTINCT Name FROM Guest;

--All guests ordered by name (ascending):
--(use ASC or DESC after your ORDER BY [col]
SELECT * FROM Guest ORDER BY Name ASC;

--Top 10 highest price sales:
SELECT TOP(10) * FROM Sales ORDER BY Price DESC;

--All values stored in Lookup tables:
SELECT * FROM Location
UNION ALL
SELECT * FROM Status
UNION ALL
SELECT * FROM GuestStatus
UNION ALL
SELECT * FROM Class
UNION ALL
SELECT * FROM RoomStatus;


--Guest Classes with Levels:
SELECT *, (CASE
	WHEN Level > 0 AND Level <= 10 THEN 'lvl 1-10'
	WHEN Level > 10 AND Level <= 20 THEN 'lvl 10-20'
	WHEN Level > 20 AND Level <= 30 THEN 'lvl 20-30'
	WHEN Level > 30 AND Level <= 40 THEN 'lvl 30-40'
	WHEN Level > 40 AND Level <= 50 THEN 'lvl 40-50'
	WHEN Level > 50 AND Level <= 60 THEN 'lvl 50-60'
	WHEN Level > 60 AND Level <= 70 THEN 'lvl 60-70'
	WHEN Level > 70 AND Level <= 80 THEN 'lvl 70-80'
	WHEN Level > 80 AND Level <= 90 THEN 'lvl 80-90'
	WHEN Level > 90 AND Level <= 100 THEN 'lvl 90-100'
	ELSE 'l33t'
	END) FROM GuestClass;

--SELECT INSERT statements:
SELECT 'INSERT INTO RoomStatus(Name) VALUES'
UNION ALL
SELECT CONCAT('(''',Name,'''),') FROM Class
UNION ALL
SELECT '(''End Value'');';


SELECT 'INSERT INTO UserRole(UserID, RoleID) VALUES'
UNION ALL
SELECT CONCAT('(',UserID,',',TavernID,')') FROM TavernUser
UNION ALL
SELECT '(1,1);';
