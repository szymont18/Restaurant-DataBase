-- auto-generated definition
create table Reservations
(
    ReservationID        int      not null
        constraint PK_Reservations
            primary key,
    ClientID             int      not null
        constraint FK_Reservations_Clients
            references Clients,
    StartTime            datetime not null,
    EndTime              datetime not null,
    IsCompanyReservation bit      not null,
    NumberOfPeople       int      not null,
    Accepted             bit
)
go

create index IX_Reservations
    on Reservations (ClientID)
go

