alter procedure AddIndividualClient(@Firstname varchar(64),
                                     @Lastname varchar(64),
                                     @PhoneNumber varchar(16),
                                     @Email varchar(64))
as
    begin
        set nocount on
        insert into Clients default values

        DECLARE @ClientId int = SCOPE_IDENTITY();
        insert into IndividualClients(ClientID, FirstName, LastName, PhoneNumber, Email, PermamentDiscountLVL)
        values (@ClientID, @Firstname, @Lastname,@PhoneNumber,@Email, 0)

    end