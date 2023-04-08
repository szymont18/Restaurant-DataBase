alter procedure AddReservationGuest(@Reservation_ID as int,
                                     @First_Name as varchar(20),
                                     @Last_Name as varchar(20)
)
as
    begin
--  Checking if the guest is not already registered
        if EXISTS(select * from ReservationGuestList
                     where  ReservationID = @Reservation_ID
                        and @First_Name like FirstName
                        and @Last_Name like LastName)
            begin;
                throw 50001, N'Miejsce dla tej osoby jest juz zarezerwowane',1
            end

-- Inserting Guest

        insert into ReservationGuestList (ReservationID, FirstName, LastName)
                values (@Reservation_ID, @First_Name , @Last_Name);
    end
go;





