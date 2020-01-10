--when customer registers a return
create or alter PROCEDURE RegisterReturn 
@orderitem int, @reason varchar(255) as

insert into returns(orderitem,reason,returndate,status)
values(@orderitem,@reason,null,1);

--orderitem, reason
exec RegisterReturn 1,''


--
create or alter PROCEDURE Returnchanges
@return int, @status int as
begin

if exists(
SELECT id
from returns
where @status = 2)

update returns 
set returndate = getdate(), status = 2
where id = @return;


else if exists(
select id
from Returns
where @status = 5)
begin

--might need fixing!!!!
update products 
set QuantityAvailable += 1
from [Returns]
inner join OrderDetails
on [Returns].OrderItem = OrderDetails.ID
where [Returns].ID = @return;

update returns
set status = 5
where id = @return;

insert into InventoryLogs(Product, AdjustmentDate, Quantity, Status)
Select Products.ID, GETDATE(), 1, 5
from [Products]
inner join OrderDetails
on  Products.ID = OrderDetails.Product
inner join [Returns]
on OrderDetails.ID = [Returns].OrderItem
where [Returns].ID = @return;

end
ELSE
update Returns
set [Status] = @status
where id = @return
END 

exec Returnchanges 2,