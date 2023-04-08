-- auto-generated definition
create table Payments
(
    PaymentID   int identity
        constraint PK_Payments
            primary key,
    OrderID     int            not null
        constraint FK_Payments_Orders
            references Orders,
    Amount      decimal(18, 2) not null,
    Description varchar(64),
    PayDate     datetime       not null
)
go

create index IX_Payments
    on Payments (OrderID)
go

