create or alter procedure CheckoutCancelProcess
@cart int as
Begin TRANSACTION
begin TRY
--need to check if available products to buy is > cartquantity

delete ReservedCartItems
from ReservedCartItems
inner join CartItems
on ReservedCartItems.Cartitems = CartItems.ID
where CartItems.Cart = @cart

update Products
set Products.QuantityAvailable += CartItems.Quantity
from CartItems
where CartItems.Cart = @cart and
Products.ID = CartItems.Product

commit TRANSACTION
end TRY
begin catch
rollback TRANSACTION
end CATCH

exec CheckoutCancelProcess 1