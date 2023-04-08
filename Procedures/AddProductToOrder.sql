alter procedure [dbo].[AddProductToOrder](@Order_ID int,
                                  @Product_ID int,
                                  @Quantity float)
as
    begin
        set nocount on
        begin try

            Declare @MenuDate datetime;
            if not exists(select * from Orders where OrderID = @Order_ID)
                begin
                    ;throw 50001, N'There is no order with this ID in the database', 1
                end

            if not exists(select * from Products where ProductID = @Product_ID)
                begin
                    ;throw 50001, N'There is no product with this ID in the database', 1
                end
			declare @OrderWeekDay int;
			declare @OrderDate datetime;

			if((select IsImportedFlag from Products where ProductID = @Product_ID) = 1)
				begin
					if((select TakeawayTime from Orders where OrderID = @Order_ID) IS NULL)
						begin
							set @OrderDate = (select R.StartTime from Orders O join Reservations R on O.ReservationID = R.ReservationID where OrderID = @Order_ID);
							set @OrderWeekDay = datepart(weekday, @OrderDate);
						end
					else
						begin
							set @OrderDate = (select O.TakeawayTime from Orders O where OrderID = @Order_ID);
							set @OrderWeekDay = datepart(weekday, @OrderDate);
						end
					if(@OrderWeekDay != 3 and @OrderWeekDay != 4 and @OrderWeekDay != 5)
						begin
							;throw 50001, N'Invalid delivery day for an imported product. Such a product can be served on thursday, friday and saturday.', 1;
						end
					if(DATEFROMPARTS(YEAR(DATEADD(DAY,-@OrderWeekDay, @OrderDate)),
									MONTH(DATEADD(DAY,-@OrderWeekDay, @OrderDate)),
									DAY(DATEADD(DAY,-@OrderWeekDay, @OrderDate))
									) < getdate())
						begin
							;throw 50001, N'The order for an imported product has been placed too late.', 1
						end
				end


            Declare @TakeAwayTime datetime = (select TakeawayTime from Orders where OrderID = @Order_ID)
            if (@TakeAwayTime is not null) set @MenuDate = @TakeAwayTime;


            else
                set @MenuDate = (select max(R2.StartTime) from Orders join Reservations R2 on R2.ReservationID = Orders.ReservationID where OrderID = @Order_ID)

            if  (dbo.CheckProductInMenu(@Product_ID, @MenuDate)) = 0
                begin
                    ;throw 50001, N'There is no selected item in the current menu (for this day)',1
                end

            if (select IsLegal from Menus where @MenuDate between StartTime and EndTime) = 0
                begin
                    ;throw 50001, N'Menu is invalid', 1
                end

            Declare @Price decimal(18,2) = (select UnitPrice from Products where ProductID = @Product_ID)
            if exists(select * from OrderDetails where OrderID = @Order_ID and ProductID = @Product_ID)
                begin
                    update OrderDetails
                    set Quantity = (select max(Quantity) from OrderDetails where OrderID = @Order_ID and ProductID = @Product_ID) +
                                   @Quantity
                    where OrderID = @Order_ID and ProductID = @Product_ID
                end
            else
                begin
                    insert into OrderDetails(OrderID, ProductID, PlannedServeTime, Served, Quantity, UnitPrice)
                    values(@Order_ID, @Product_ID, @MenuDate, 0, @Quantity, @Price)
                end
        end try

        begin catch
             Declare @msg NVARCHAR(2048) = N'Procedure AddProductToOrder error: '+ Error_Message();
            ;throw 50001, @msg, 1
        end catch



    end
go

