-- No IDs can or should be inserted because they are auto-generated via the IDENTITY keyword.

-- Seed Locations:
INSERT INTO Location(Name) VALUES('Plymouth Meeting');
INSERT INTO Location(Name) VALUES('New York');
INSERT INTO Location(Name) VALUES('Philadelphia');
INSERT INTO Location(Name) VALUES('Long Island');
INSERT INTO Location(Name) VALUES('Newark');
INSERT INTO Location(Name) VALUES('Scranton');
INSERT INTO Location(Name) VALUES('Trenton');

-- Seed Taverns:
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Salty Reef',1,4);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Bold One',5,3);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Franks Place',2,2);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Aisle Dream',1,2);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Happening Place',3,6);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Deadbeat',2,1);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Fortitude',3,7);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Angels Gate',4,5);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('That One',3,2);
INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('At the End of the Universe',1,3);


-- Seed Users:
INSERT INTO Users(Name,Birthday) VALUES ('Joe','19901020 12:00:00 AM');
INSERT INTO Users(Name,Description,Birthday) VALUES ('Frank','scar on forehead','19780307 12:00:00 AM');


-- Seed Roles:
INSERT INTO Role(Name,Description) VALUES ('Owner','Owns the tavern');
INSERT INTO Role(Name,Description) VALUES ('Barkeep','Tends the bar');
INSERT INTO Role(Name,Description) VALUES ('Patron','A guest at the tavern');


-- Seed UserRoles:
INSERT INTO UserRole(UserID,RoleID) VALUES (1,1);


-- Seed TavernUsers:
INSERT INTO TavernUser(TavernID,UserID) VALUES (1,1);


-- Seed Supply:
INSERT INTO Supply(Name,Unit,Count,Updated,TavernID) VALUES ('Whetstone','Item',50,'20210122 5:28:00 PM',1);
INSERT INTO Supply(Name,Unit,Count,Updated,TavernID) VALUES ('Beer','Bottle',250,'20210120 1:40:00 PM',1);


-- Seed Shipments:
INSERT INTO Shipment(Cost,Amount,Date,SupplyID,TavernID) VALUES (20.25,15,'20210121 12:00:00 PM',1,1);


-- Seed Statuses:
INSERT INTO Status(Name) VALUES ('active');
INSERT INTO Status(Name) VALUES ('inactive');
INSERT INTO Status(Name) VALUES ('out of stock');
INSERT INTO Status(Name) VALUES ('discontinued');


-- Seed Services:
INSERT INTO Service(Name,StatusID,TavernID) VALUES ('Weapon Sharpening',1,1);
INSERT INTO Service(Name,StatusID,TavernID) VALUES ('Pool',2,1);


-- Seed Sales:
INSERT INTO Sales(Price,Date,Amount,ServiceID,UserID,TavernID) VALUES (10.65,'20210115 3:45:50 PM',1,1,1,1);


-- Seed SalesSupply:
INSERT INTO SalesSupply(SaleID,SupplyID) VALUES (1,1);


-- Seed GuestStatus:
INSERT INTO GuestStatus(Name) VALUES ('fine');
INSERT INTO GuestStatus(Name) VALUES ('sick');
INSERT INTO GuestStatus(Name) VALUES ('hangry');
INSERT INTO GuestStatus(Name) VALUES ('raging');
INSERT INTO GuestStatus(Name) VALUES ('placid');


-- Seed Guests:
INSERT INTO Guest(Name,Birthday,Cakeday,Notes,StatusID) VALUES ('Joe','19901020 12:00:00 AM','19901020 12:00:00 AM','Cakeday IS birthday for him',1);
INSERT INTO Guest(Name,Birthday,Notes,StatusID) VALUES ('Frank','19780307 12:00:00 AM','No Cakeday',3);


-- Seed Classes:
INSERT INTO Class(Name) VALUES ('mage');
INSERT INTO Class(Name) VALUES ('fighter');
INSERT INTO Class(Name) VALUES ('rogue');
INSERT INTO Class(Name) VALUES ('monk');
INSERT INTO Class(Name) VALUES ('barbarian');


-- Seed GuestClass:
INSERT INTO GuestClass(ClassID,GuestID,Level) VALUES (1,1,1);
INSERT INTO GuestClass(ClassID,GuestID,Level) VALUES (3,1,2);
INSERT INTO GuestClass(ClassID,GuestID,Level) VALUES (2,2,4);


-- Seed TavernGuest:
INSERT INTO TavernGuest(TavernID,GuestID) VALUES (1,1);
INSERT INTO TavernGuest(TavernID,GuestID) VALUES (1,2);


-- The following statements should fail when run.
-- Since we're recreating tables and using IDENTITY(1, 1),
-- and since this is just a test database, there will likely never be IDs that high.

-- INSERT INTO Tavern(Name,Floors,LocationID) VALUES ('Bogus',1,25000);
-- INSERT INTO TavernGuest(TavernID,GuestID) VALUES (25005,30000);
