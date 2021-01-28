-- Drop tables:
DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS RoomStatus;
DROP TABLE IF EXISTS TavernGuest;
DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS SalesSupply;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Status;
DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS Supply;
DROP TABLE IF EXISTS TavernUser;
DROP TABLE IF EXISTS UserRole;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Rats; -- Leave in to remove legacy tables.
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Location;

-- Location table:

CREATE TABLE Location (
	LocationID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL
);

-- Tavern table:

CREATE TABLE Tavern (
	Name VARCHAR(255) NOT NULL,
	Floors INT NOT NULL,
	LocationID INT NOT NULL FOREIGN KEY REFERENCES Location(LocationID)
);

-- Modified to demonstrate an ALTER statement
ALTER TABLE Tavern ADD TavernID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY;

-- Rats table: (no longer tracked)
/* -- Obsoleted 1/14/21
CREATE TABLE Rats (
	RatID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID)
);*/

-- User table:

CREATE TABLE Users (
	Name VARCHAR(255) NOT NULL,
	Description VARCHAR(255),
	Birthday DATETIME
);

-- Modified to demonstrate an ALTER statement
ALTER TABLE Users ADD UserID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY;

-- Role table:

CREATE TABLE Role (
	RoleID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Description VARCHAR(255)
);

-- Link Role and User:

CREATE TABLE UserRole (
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	RoleID INT NOT NULL FOREIGN KEY REFERENCES Role(RoleID)
);

-- Link Tavern and User:

CREATE TABLE TavernUser (
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID)
);

-- Supply table:

CREATE TABLE Supply (
	SupplyID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Unit VARCHAR(255) NOT NULL,
	Count INT NOT NULL,
	Updated DATETIME NOT NULL,
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID)
);

-- Shipment table:

CREATE TABLE Shipment (
	ShipmentID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Cost DECIMAL NOT NULL,
	Amount INT NOT NULL,
	Date DATETIME NOT NULL,
	SupplyID INT NOT NULL FOREIGN KEY REFERENCES Supply(SupplyID),
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID)
);

-- Status table:

CREATE TABLE Status (
	StatusID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL
);

-- Service table:

CREATE TABLE Service (
	ServiceID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	StatusID INT NOT NULL FOREIGN KEY REFERENCES Status(StatusID),
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID)
);

-- Sales table:

CREATE TABLE Sales (
	SaleID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Price DECIMAL NOT NULL,
	Date DATETIME NOT NULL,
	Amount INT NOT NULL,
	ServiceID INT NOT NULL FOREIGN KEY REFERENCES Service(ServiceID),
	UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID)
);



-- SalesSupply table:

CREATE TABLE SalesSupply (
	SaleID INT NOT NULL FOREIGN KEY REFERENCES Sales(SaleID),
	SupplyID INT NOT NULL FOREIGN KEY REFERENCES Supply(SupplyID)
);



-- GuestStatus table:

CREATE TABLE GuestStatus (
	GuestStatusID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255)
);

-- Guest table:

CREATE TABLE Guest (
	GuestID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL,
	Birthday DATETIME NOT NULL,
	Cakeday DATETIME,
	Notes VARCHAR(255),
	StatusID INT NOT NULL FOREIGN KEY REFERENCES GuestStatus(GuestStatusID)
);

-- Class table:

CREATE TABLE Class (
	ClassID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL
);

-- Link Guest and Class, include level of that class:

CREATE TABLE GuestClass (
	ClassID INT NOT NULL FOREIGN KEY REFERENCES Class(ClassID),
	GuestID INT NOT NULL FOREIGN KEY REFERENCES Guest(GuestID),
	Level INT NOT NULL
);

-- Link Guest and Tavern:

CREATE TABLE TavernGuest (
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID),
	GuestID INT NOT NULL FOREIGN KEY REFERENCES Guest(GuestID)
);

-- RoomStatus table:

CREATE TABLE RoomStatus (
	StatusID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	Name VARCHAR(255) NOT NULL
);

-- Room table:

CREATE TABLE Room (
	RoomID INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	StatusID INT NOT NULL FOREIGN KEY REFERENCES RoomStatus(StatusID),
	TavernID INT NOT NULL FOREIGN KEY REFERENCES Tavern(TavernID),
	Cost INT NOT NULL
);

-- RoomStay stable:

CREATE TABLE RoomStay (
	SaleID INT NOT NULL FOREIGN KEY REFERENCES Sales(SaleID),
	RoomID INT NOT NULL FOREIGN KEY REFERENCES Room(RoomID),
	GuestID INT NOT NULL FOREIGN KEY REFERENCES Guest(GuestID),
	Date DATETIME NOT NULL,
	Cost INT NOT NULL
);
