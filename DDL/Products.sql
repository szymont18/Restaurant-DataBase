-- auto-generated definition
create table Products
(
    ProductID          int identity
        constraint PK_Products
            primary key,
    CategoryID         int
        constraint Category
            references Categories
            on update cascade on delete set null,
    ProductName        varchar(64) not null,
    IsImportedFlag     bit,
    UnitPrice          decimal(18, 2)
        constraint CK_Products
            check ([UnitPrice] >= 0),
    ProductDescription varchar(255),
    Active             bit
)
go

create index IX_Products
    on Products (CategoryID)
go

