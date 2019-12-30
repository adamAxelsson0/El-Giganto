Create or Alter procedure OrderSent @order int as
begin transaction
begin try
update orders
set shippingdate  = GetDate(), status = 2
where id = @order

insert into InventoryLogs(Product, AdjustmentDate, Quantity, [Status])
SELECT Product, GetDate(), -Quantity, 2
from OrderDetails
where OrderDetails.[Order] = @order

delete r
from ReservedLogs as r
inner join OrderDetails
on r.OrderItem = OrderDetails.ID
where OrderDetails.[Order] = @order

end TRY
begin catch
rollback TRANSACTION
end CATCH

exec ordersent 32