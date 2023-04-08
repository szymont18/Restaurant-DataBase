-- auto-generated definition
create table Orders
(
    OrderID         int not null
        constraint PK_Orders
            primary key,
    ClientID        int
        constraint FK_Orders_Clients
            references Clients,
    ReservationID   int
        constraint FK_Orders_Reservations
            references Reservations,
    BillID          int
        constraint FK_Orders_Bills
            references Bills
            on update cascade,
    OrderTime       datetime,
    TakeawayTime    datetime,
    AppliedDiscount float,
    OTDiscountID    int
        constraint FK_Orders_OneTimeDiscounts
            references OneTimeDiscounts
)
go

create index IX_Orders
    on Orders (ClientID)
go

create index IX_Orders_1
    on Orders (ReservationID)
go

create index IX_Orders_2
    on Orders (BillID)
go

