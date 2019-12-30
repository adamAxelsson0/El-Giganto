--Produkter i lager enligt InventoryLog(exkl reserverade)
Create or alter View ViewQuantityPerProduct as
select Product, SUM(Quantity) as Quantity
from InventoryLogs
GROUP by Product

--se antal produkter reserverade REMOVED
Create or alter View ViewQuantityReservedPerProduct as
select Product, SUM(Quantity) as Quantity
from InventoryLogs
where status in 
GROUP by Product

--see if available products to buy is same in inventory log and products NEEDS FIXING
create or alter view ViewQuantityIsCorrect as
select Products.ID,  Products.QuantityAvailable, viewq.Quantity, 
Products.quantityavailable - viewq.Quantity as Diff
from Products
inner join ViewQuantityPerProduct as viewq
on Products.ID = viewq.Product
group by products.id, products.QuantityAvailable, viewq.Quantity

--för att se alla produkter som är i lager.
select * from ViewProductReadable where status = 1;