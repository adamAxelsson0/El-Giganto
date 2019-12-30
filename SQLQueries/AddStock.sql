create or alter procedure AddStock @product int, @quantity int as
Update Products 
set quantityavailable += @quantity 
where ID = @product

insert into InventoryLogs(Product, AdjustmentDate, Quantity, Status)
Values(@product, GETDATE(), @quantity, 1);

select Scope_Identity() as InventoryLogsID;

addstock 1,10
