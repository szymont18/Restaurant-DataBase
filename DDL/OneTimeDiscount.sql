-- auto-generated definition
create table OneTimeDiscounts
(
    OTDiscountID int identity
        constraint PK_OneTimeDiscounts
            primary key,
    ClientID     int      not null
        constraint FK_OneTimeDiscounts_IndividualClients
            references IndividualClients,
    used         bit      not null,
    ApplyDate    datetime not null,
    ExpireDate   datetime not null,
    Value        float
        constraint CK_OneTimeDiscounts
            check ([Value] > 0),
    OrderID      int      not null
)
go

create index IX_OneTimeDiscounts
    on OneTimeDiscounts (ClientID)
go

create index IX_OneTimeDiscounts_1
    on OneTimeDiscounts (OrderID)
go

