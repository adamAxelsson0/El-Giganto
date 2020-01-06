--Add to Cart, @Customer, @Product, @Quantity
exec AdjustCart 1,1,5

--Checkout, @Cart
exec CheckoutProcess 31

--Cancel Checkout, @cart
exec CheckoutCancelProcess 31

--Order, @cart
exec EntireOrderProcess 31

--Send Order, @order
exec ordersent 31