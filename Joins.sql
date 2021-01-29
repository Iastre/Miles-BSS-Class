--Original:
SELECT * FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID;
--Filtered Columns:
SELECT Guest.Name, Birthday, Cakeday, Notes, Level, Class.Name FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID;
--Filtered & Organized Columns:
SELECT Guest.Name, Level, Class.Name, Birthday, Cakeday, Notes FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID;
--Just the name, level and class:
SELECT Guest.Name, Level, Class.Name FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID;
--CONCAT version:
SELECT CONCAT(Guest.Name, ' - level ', CAST(Level AS VARCHAR(100)), ' ', Class.Name) FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID;
--Restrict to levels above 5
SELECT Guest.Name, Level, Class.Name FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID WHERE Level > 5;
--Then restrict to mages only
SELECT Guest.Name, Level, Class.Name FROM Guest JOIN GuestClass ON Guest.GuestID = GuestClass.GuestID JOIN Class ON GuestClass.ClassID = Class.ClassID WHERE Level > 5 AND Class.Name = 'mage';
