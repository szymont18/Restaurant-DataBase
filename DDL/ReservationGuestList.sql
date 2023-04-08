-- auto-generated definition
create table ReservationDetails
(
    ReservationID int not null
        constraint FK_ReservationDetails_Reservations
            references Reservations
            on update cascade on delete cascade,
    TableID       int not null
        constraint FK_ReservationDetails_Tables
            references Tables
            on update cascade,
    constraint PK_ReservationDetails
        primary key (ReservationID, TableID)
)
go

