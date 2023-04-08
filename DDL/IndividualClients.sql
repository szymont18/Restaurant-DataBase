-- auto-generated definition
create table IndividualClients
(
    ClientID             int         not null
        constraint PK_IndividualClients
            primary key
        constraint FK_IndividualClients_Clients
            references Clients,
    FirstName            varchar(64) not null,
    LastName             varchar(64) not null,
    PhoneNumber          varchar(16),
    Email                varchar(64),
    PermamentDiscountLVL int         not null
)
go

