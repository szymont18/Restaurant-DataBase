-- auto-generated definition
create table Categories
(
    CategoryID          int identity
        constraint PK_Categories
            primary key,
    CategoryName        varchar(64) not null,
    CategoryDescription varchar(255)
)
go

