--LOOK AT THIS
Select Carts.*, CartItems.Product, CartItems.Quantity from CartItems inner join Carts
on CartItems.Cart = Carts.ID where cart = 37;

Select * from CartItems where cart = 1;