create or alter procedure EntireOrderProcess
@cart int as
Begin TRANSACTION
begin TRY

	insert into orders(customer, orderdate, ShippingDate, Status)
    select Carts.Customer, GETDATE(), null, 1
    from Carts
    where ID = @cart
   
	insert into orderdetails([order], product, quantity, priceperunit)
    SELECT SCOPE_IDENTITY(), Product, CartItems.Quantity as Quantity, Products.Price as PricePerUnit
    from CartItems
    inner join Products
    on CartItems.Product = Products.ID
	where CartItems.Cart = @cart

	insert into ReservedOrdersDetails(OrderItem)
    Select OrderDetails.ID
    from OrderDetails
    inner join Orders
    on OrderDetails.[Order] = Orders.ID
    where Orders.ID = IDENT_CURRENT( 'orders' )

    insert into ProductPopularityLogs(Product, Popularity, LogDate)
    select Product, 3, GetDate()
    from CartItems
    where cart = @cart
    
    delete r
    from ReservedCartItems as r
    inner join CartItems
    on r.Cartitems = CartItems.ID
    where CartItems.Cart = @cart

    delete from Cartitems where CartItems.Cart = @Cart

    delete from Carts where Carts.ID = @Cart;

    commit TRANSACTION
end TRY
begin catch
rollback TRANSACTION
end CATCH

exec EntireOrderProcess 1