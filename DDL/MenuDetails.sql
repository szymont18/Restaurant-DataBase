-- auto-generated definition
create table MenuDetails
(
    MenuID    int            not null
        constraint FK_MenuDetails_Menus
            references Menus
            on update cascade on delete cascade,
    ProductID int            not null
        constraint FK_MenuDetails_Products
            references Products
            on update cascade,
    UnitPrice decimal(18, 2) not null
        constraint CK_MenuDetails
            check ([UnitPrice] >= 0),
    constraint PK_MenuDetails
        primary key (MenuID, ProductID)
)
go

