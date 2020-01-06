--commented out since i dont want customer to "hold" items in cart and not make available
Create or Alter Procedure AdjustCart 
@customer int, @product int, @quantity int as
BEGIN

If Exists(
    select QuantityAvailable 
    from Products
    where QuantityAvailable >= @quantity
)
begin

--Meed to create cart if it does not exist
If not exists(select ID from Carts 
where Customer = @customer)
begin
Insert into Carts(Customer, WhenLastUpdated)
values(@customer, getDate())
END

If exists(
SELECT Customer, Product  
FROM CartItems
inner join Carts
on CartItems.Cart = Carts.ID
WHERE Carts.Customer = @customer and product = @product)--customer and product exists

begin
update CartItems set Quantity += @quantity
end

ELSE IF exists(
SELECT Customer 
FROM Carts
WHERE Carts.Customer = @customer)--product is not already in cart, but customer exists

BEGIN
insert into CartItems(Product, Cart, Quantity)
Select @product, Carts.ID, @quantity
from Carts
where Customer = @customer

--only want to add when product is not already in cart, else product can get very popular by just pressing +quantity in cart
insert into ProductPopularityLogs(Product, Popularity, LogDate)
values(@product, 2, GETDATE());

END

update Carts
set WhenLastUpdated = GetDate()
where Customer = @customer

delete from CartItems where Quantity <= 0

select ID as CartID
from Carts
where Customer = @customer

--
END
Else Select 'Not enough in stock.'
--END--ends our if quantityavailable > 0
--else select 'Not enough in stock'
END--ends entire procedure


exec AdjustCart 1,1,11