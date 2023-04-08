-- auto-generated definition
create table OrderDetails
(
    OrderID          int            not null
        constraint FK_OrderDetails_Orders
            references Orders
            on update cascade on delete cascade,
    ProductID        int            not null
        constraint FK_OrderDetails_Products
            references Products
            on update cascade,
    PlannedServeTime datetime       not null,
    Served           bit            not null,
    Quantity         float          not null
        constraint CK_OrderDetails_1
            check ([Quantity] > 0),
    UnitPrice        decimal(18, 2) not null
        constraint CK_OrderDetails
            check ([UnitPrice] >= 0),
    constraint PK_OrderDetails
        primary key (OrderID, ProductID)
)
go

