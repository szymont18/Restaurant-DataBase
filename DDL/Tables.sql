-- auto-generated definition
create table Tables
(
    TableID int identity
        constraint PK_Tables
            primary key,
    Size    int not null
        constraint CK_Tables
            check ([Size] >= 2),
    Active  bit
)
go

