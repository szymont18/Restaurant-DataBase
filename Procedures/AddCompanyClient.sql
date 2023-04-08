create procedure AddCompanyClient(@CompanyName varchar(64),
                                  @NIP varchar(16),
                                  @City varchar(64),
                                  @Street varchar(64),
                                  @PostalCode varchar(16),
                                  @PhoneNumber varchar(16),
                                  @Email varchar(64))
as
    begin
        set nocount on

        insert into Clients default values
        Declare @ClientID int = SCOPE_IDENTITY()

        insert into CompanyClients(ClientID, CompanyName, NIP, City, Street, PostalCode, PhoneNumber, Email)
        values (@ClientID, @CompanyName, @NIP, @City, @Street, @PostalCode, @PhoneNumber, @Email)

    end