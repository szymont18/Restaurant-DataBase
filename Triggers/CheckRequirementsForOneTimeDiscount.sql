CREATE TRIGGER CheckRequirementsForOneTimeDiscount
    ON OrderDetails
    AFTER INSERT, UPDATE
    AS
BEGIN
    DECLARE @ClientID INT
    DECLARE @OrderDate DATE
    DECLARE @OrderID INT
    SELECT @OrderID = OrderID FROM inserted
    SELECT @ClientID = o.ClientID, @OrderDate = o.TakeawayTime FROM Orders o WHERE o.OrderID = @OrderID
    IF (@OrderDate IS NULL)
    BEGIN
        SELECT @OrderDate = StartTime
        FROM Reservations r
        JOIN Orders O2 on r.ReservationID = O2.ReservationID
        WHERE O2.OrderID = @OrderID
    END
    IF EXISTS(SELECT * FROM IndividualClients WHERE ClientID = @ClientID)
    BEGIN
        DECLARE @LastDiscount date
        DECLARE @K2 DECIMAL(18,2)
        DECLARE @D1 INT
        DECLARE @R2 DECIMAL(18,2)
        DECLARE @CurrentSum DECIMAL(18,2)
        SELECT @K2 = K2, @D1 = D1, @R2 = R2 FROM Constants
        SELECT TOP 1 @LastDiscount = ApplyDate FROM OneTimeDiscounts WHERE ClientID = @ClientID ORDER BY ApplyDate DESC
        IF (@LastDiscount IS NOT NULL)
        BEGIN
            SELECT @CurrentSum = SUM(OD.UnitPrice*OD.Quantity)
            FROM Orders o
            JOIN OrderDetails OD on o.OrderID = OD.OrderID
            WHERE o.ClientID = @ClientID AND o.OrderTime > @LastDiscount
        END
        ELSE
        BEGIN
            SELECT @CurrentSum = SUM(OD.UnitPrice*OD.Quantity)
            FROM Orders o
            JOIN OrderDetails OD on o.OrderID = OD.OrderID
            WHERE o.ClientID = @ClientID
        END
        IF (@CurrentSum >= @K2)
        BEGIN
            INSERT INTO OneTimeDiscounts (ClientID, used, ApplyDate, ExpireDate, Value, OrderID)
            VALUES (@ClientID, 0, @OrderDate, DATEADD(day, @D1,@OrderDate), @R2, @OrderID)
        END
    END
END
go

