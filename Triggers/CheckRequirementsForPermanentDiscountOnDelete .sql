CREATE TRIGGER CheckRequirementsForPermanentDiscountOnDelete
    ON OrderDetails
    AFTER DELETE
    AS
BEGIN
    declare @ClientID int
    SELECT @ClientID = o.ClientID FROM deleted JOIN Orders o ON o.OrderID = deleted.OrderID
    if EXISTS(SELECT * FROM IndividualClients ID WHERE ID.ClientID = @ClientID)
        begin
            declare @CurrentLevel int
            SELECT @CurrentLevel = PermamentDiscountLVL FROM IndividualClients WHERE ClientID = @ClientID
            if (@CurrentLevel = 1)
                begin
                    declare @Z1 int
                    declare @K1 decimal(18, 2)
                    declare @Count int
                    SELECT @Z1 = Z1, @K1 = K1 FROM Constants
                    SELECT @Count = count(distinct o.OrderID)
                    FROM Orders o
                             JOIN OrderDetails OD on o.OrderID = OD.OrderID
                    WHERE ClientID = @ClientID
                    HAVING SUM(OD.UnitPrice * OD.Quantity) >= @K1
                    if (@Count < @Z1)
                        begin
                            UPDATE IndividualClients
                            SET PermamentDiscountLVL = 0
                            WHERE ClientID = @ClientID
                        end
                end
        end
END
go

