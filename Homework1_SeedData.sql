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


-- Populate other tables:
-- Classes should include things like mage, fighter, etc.
-- GuestStatus should include things like sick, fine, hangry, raging, placid
-- Services include things like Pool and Weapon Sharpening
-- Status includes thingslike active, inactive, out of stock, discontinued, etc.
-- (Didn't have time to seed the other tables)

-- TODO: Do some scripts that fail to show foreign key constraints
