--Order process
Create or alter procedure EntireOrderProcess
@customer int, @product int, 
@quantity int, @priceperunit DECIMAL(7,2) as
Begin
	insert into orders(customer, orderdate, ShippingDate, Status)
	values(@customer, GETDATE(), null, 1);

	insert into orderdetails([order], product, quantity, priceperunit)
	values(SCOPE_IDENTITY(), @product, @quantity, @priceperunit);

	insert into InventoryLogs(product, AdjustmentDate, Quantity, Status)
	values(@product, GetDate(), @quantity, 4);

	update Products set Quantity = quantity - @quantity where id = @product;
end

--Order process with cart (should be used with customer, since we want to delete cart when order has been made.)
create or alter procedure EntireOrderProcessWithCart
@customer int, @product int, 
@quantity int, @priceperunit DECIMAL(7,2),
@cart int as
Begin
	insert into orders(customer, orderdate, ShippingDate, Status)
	values(@customer, GETDATE(), null, 1);

	insert into orderdetails([order], product, quantity, priceperunit)
	values(SCOPE_IDENTITY(), @product, @quantity, @priceperunit);

	insert into InventoryLogs(product, AdjustmentDate, Quantity, Status)
	values(@product, GetDate(), @quantity, 4);

	update Products set Quantity = quantity - @quantity where id = @product;

    delete from Carts where Carts.ID = @Cart;

	delete from Cartitems where CartItems.Cart = @Cart
end

declare @cart int = 1;
declare @customer int = 1;
declare @product int = 1;
declare @quantity int = 1;
declare @priceperunit DECIMAL(7,2) = 2290;
exec EntireOrderProcess @customer, @product, @quantity,@priceperunit
exec EntireOrderProcessWithCart @customer, @product, @quantity,@priceperunit, @cart

select * from Orders
select * from OrderDetails
select * from InventoryLogs
select * from products
select * from carts

