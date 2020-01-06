create or alter procedure CheckoutProcess
@cart int as
Begin TRANSACTION
begin TRY
--need to check if available products to buy is > cartquantity

insert into ReservedCartItems(CartItems)
Select CartItems.ID
from CartItems
inner join Products
on CartItems.product = Products.ID
where CartItems.Cart = @cart
and Products.QuantityAvailable >= CartItems.Quantity

if exists(
select CartItems.ID
from CartItems
inner join products
on cartitems.product = products.id
where CartItems.Cart = @cart)
begin

Select CartItems.ID as [Could not be added], CartItems.Product [Too few of]
from CartItems
inner join products
on cartitems.product = products.id
where CartItems.Cart = @cart
and Products.QuantityAvailable < CartItems.Quantity

Select CartItems.ID as [Added], CartItems.Product [Enough in inventory]
from CartItems
inner join products
on cartitems.product = products.id
where CartItems.Cart = @cart
and Products.QuantityAvailable >= CartItems.Quantity
end

update Products--only updates our available quantity for customers
set Products.QuantityAvailable -= CartItems.Quantity
from CartItems
where CartItems.Cart = @cart and CartItems.Product = Products.ID
and Products.QuantityAvailable >= CartItems.Quantity

Update Products
set Status = 4
from CartItems
where CartItems.Cart = @cart
and Products.QuantityAvailable <= 0;

commit TRANSACTION
end TRY
begin catch
rollback TRANSACTION
end CATCH

exec CheckoutProcess 31