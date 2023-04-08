alter function GetAllFreeTables(@StartDate datetime,
                                @EndDate datetime)
returns TABLE
AS
  return select distinct TableID, size from TableOccupancy where @StartDate not between StartTime and EndTime and
                                                        @EndDate not between StartTime and EndTime



