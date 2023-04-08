alter procedure AddMenu(@StartTime as datetime,
                        @EndTime as datetime)
as
    begin try
        if @StartTime > @EndTime
            begin
                ;throw 50001, N'Menu ends before it start', 1
            end

        insert into Menus(starttime, endtime, IsLegal)
        values (@StartTime, @EndTime, 0)

    end try
    begin catch
         Declare @msg NVARCHAR(2048) = N'Procedure AddMenu error: '+ Error_Message();
            ;throw 50001, @msg, 1
    end catch