alter function FindFreeTable(@MinSize as int,
                              @StartTime as datetime,
                              @EndTime as datetime)
returns table
    return (
        select TableID, size from Tables
        where @MinSize <= Tables.Size
        except
        select distinct TableID, size from TableOccupancy
    where @StartTime  between StartTime and EndTime and
          @EndTime  between StartTime and EndTime and
          @MinSize <= Size)
