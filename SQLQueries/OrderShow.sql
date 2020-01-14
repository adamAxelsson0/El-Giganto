--see all orderdetails for specific order
create or alter procedure SeeOrderDetails @order int AS
Select p.Name, d.Quantity, d.PricePerUnit
from OrderDetails as d
inner join Products as p
on d.Product = p.ID
where d.[Order] = @order
group by p.Name, d.Quantity, d.PricePerUnit

exec SeeOrderDetails 36

create or alter view ViewOrders AS
Select o.ID as OrderID, o.Customer, o.OrderDate, o.ShippingDate, os.[Status], Sum(d.Quantity) as NrOfProducts,
Sum(d.PricePerUnit*d.Quantity) as TotalSum, pa.Amount as AmountPaid, Sum(d.PricePerUnit*d.Quantity)-pa.Amount as LeftToPay
from OrderDetails as d
inner join Products as p
on d.Product = p.ID
inner join Orders as o
on d.[Order] = o.ID
inner join OrderStatuses as os
on o.[Status] = os.ID
left join Payments as pa
on o.ID = pa.[Order]
group by o.ID, o.Customer, o.OrderDate,o.ShippingDate, os.[Status], pa.Amount

select * from ViewOrders

