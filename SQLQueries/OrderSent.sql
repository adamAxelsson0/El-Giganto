Create or Alter procedure OrderSent @order int as
if exists(
SELECT Orders.ShippingDate
FROM Orders
WHERE Orders.ShippingDate = null and Orders.ID = @order)
begin transaction
begin try

if exists(
SELECT Orders.ShippingDate
FROM Orders
WHERE Orders.ShippingDate is null and Orders.ID = @order)
BEGIN

update orders
set shippingdate  = GetDate(), status = 2
where id = @order

insert into InventoryLogs(Product, AdjustmentDate, Quantity, [Status])
SELECT Product, GetDate(), -Quantity, 2
from OrderDetails
where OrderDetails.[Order] = @order

delete ReservedOrdersDetails
from ReservedOrdersDetails
inner join OrderDetails
on ReservedOrdersDetails.OrderItem = OrderDetails.ID
where OrderDetails.[Order] = @order
end
ELSE select 'The Order has been sent or does not exist.'

COMMIT TRANSACTION
end TRY
begin catch
rollback TRANSACTION
end CATCH

exec ordersent 32