-- auto-generated definition
create table Bills
(
    BillID       int identity
        constraint PK_Bills
            primary key,
    IssueDate    datetime not null,
    IsCollective bit      not null
)
go

