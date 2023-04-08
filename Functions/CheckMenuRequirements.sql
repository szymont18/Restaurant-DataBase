create function CheckMenuRequirements(@MenuID as int)
returns bit
as
    begin
        if @MenuID = 0
            begin
                return 1
            end

        Declare @sameProductTable TABLE(ProductID int)
        insert into @sameProductTable
        select ProductID
        from MenuDetails
        where MenuID = @MenuID
        intersect
        select ProductID
        from MenuDetails
        where MenuID = @MenuID - 1

        Declare @sameProductCnt int = (select count(*)
                                        from @sameProductTable)

        Declare @allPreviousCnt int = (select count(*)
                                       from MenuDetails
                                       where MenuID = @MenuID - 1)
        if @sameProductCnt > @allPreviousCnt / 2
            begin
                return 0
            end
        return 1

    end