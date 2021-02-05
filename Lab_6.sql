--Procedure to add a Supply Sale and deduct from the Inventory:
CREATE PROCEDURE addSale
@SupplyID int,
@UserID int,
@Price Decimal,
@Amount int,
@TavernID int
AS BEGIN
INSERT INTO Sales(ServiceID, UserID, Price, Date, Amount, TavernID) VALUES
	(1, @UserID, @Price, GETDATE(), @Amount, @TavernID);
INSERT INTO SalesSupply(SaleID, SupplyID) VALUES (SCOPE_IDENTITY(), @SupplyID);
UPDATE Supply SET Count = Count - @Amount WHERE SupplyID = @SupplyID;
END;

GO

--Updated version that does not update Supply (so that can be done with a trigger):
CREATE PROCEDURE addSale2
@SupplyID int,
@UserID int,
@Price Decimal,
@Amount int,
@TavernID int
AS BEGIN
INSERT INTO Sales(ServiceID, UserID, Price, Date, Amount, TavernID) VALUES
	(1, @UserID, @Price, GETDATE(), @Amount, @TavernID);
INSERT INTO SalesSupply(SaleID, SupplyID) VALUES (SCOPE_IDENTITY(), @SupplyID);
END;

GO

--Trigger to deduct from the Inventory:
CREATE TRIGGER decreaseStock
ON dbo.SalesSupply
AFTER INSERT
AS BEGIN
DECLARE @amount int;
SELECT @amount = s.Amount FROM INSERTED i JOIN Sales s ON i.SaleID = s.SaleID;
UPDATE Supply SET Count = Count - @amount WHERE SupplyID IN (SELECT SupplyID FROM INSERTED);
END;

GO

--Trigger to order more (add a Shipment record) when it hits a certain threshold:
CREATE TRIGGER autoOrder
ON dbo.Supply
AFTER UPDATE
AS BEGIN
DECLARE @stock int;
DECLARE @sid int;
DECLARE @tid int;
SELECT @stock = Count, @sid = SupplyID, @tid = TavernID FROM INSERTED;
IF (@stock < 10)
	INSERT INTO Shipment(SupplyID,TavernID,Cost,Amount,Date) VALUES (@sid,@tid,100,100,GETDATE());
END;

GO

--Tests:
BEGIN TRANSACTION T1;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
SELECT * FROM Shipment;
EXEC addSale
	@SupplyID = 1,
	@UserID = 1,
	@Price = 40.05,
	@Amount = 5,
	@TavernID = 1;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
SELECT * FROM Shipment;
ROLLBACK TRANSACTION T1;

BEGIN TRANSACTION T2;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
EXEC addSale2
	@SupplyID = 1,
	@UserID = 1,
	@Price = 40.05,
	@Amount = 5,
	@TavernID = 1;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
ROLLBACK TRANSACTION T2;

BEGIN TRANSACTION T3;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
SELECT * FROM Shipment;
EXEC addSale2
	@SupplyID = 1,
	@UserID = 1,
	@Price = 40.05,
	@Amount = 45,
	@TavernID = 1;
SELECT * FROM Sales sl JOIN SalesSupply ss ON sl.SaleID = ss.SaleID
JOIN Supply sp ON ss.SupplyID = sp.SupplyID;
SELECT * FROM Shipment;
ROLLBACK TRANSACTION T3;
