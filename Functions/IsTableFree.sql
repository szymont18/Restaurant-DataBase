alter function IsTableFree(@TableID as int,
                            @StarDate as datetime,
                            @EndDate as datetime)
returns bit
as
begin
    if exists(select * from TableOccupancy where TableID = @TableID and ((@StarDate  between StartTime and EndTime) or
                                                 (@EndDate  between StartTime and EndTime))) return 0
    return 1
end