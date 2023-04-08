-- auto-generated definition
create table CompanyClients
(
    ClientID    int not null
        constraint PK_CompanyClients
            primary key
        constraint FK_CompanyClients_Clients
            references Clients,
    CompanyName varchar(64),
    NIP         varchar(16),
    City        varchar(64),
    Street      varchar(64),
    PostalCode  varchar(16),
    PhoneNumber varchar(16),
    Email       varchar(64)
)
go

