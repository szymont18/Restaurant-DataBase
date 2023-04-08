-- auto-generated definition
create table Menus
(
    MenuID    int identity
        constraint PK_Menus
            primary key,
    StartTime date not null,
    EndTime   date not null,
    IsLegal   bit,
    constraint CK_Menus
        check (datediff(day, [StartTime], [EndTime]) < 14)
)
go

