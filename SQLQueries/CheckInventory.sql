--Produkter i lager enligt InventoryLog(om produkt är reserverad, räknas produkten som ej i lager)
Create or alter View ViewQuantityPerProduct as
select Product, SUM(Quantity) as Quantity
from InventoryLogs
GROUP by Product;

--se antal produkter reserverade

--Se ifall saldo stämmer överrens med InventoryLog
create or alter view ViewQuantityIsCorrect as
select Products.ID,  Products.Quantity, ViewQuantityPerProduct.Quantity as InventoryLog, 
Products.Quantity - ViewQuantityPerProduct.Quantity as Diff
from Products
inner join ViewQuantityPerProduct
on Products.ID = ViewQuantityPerProduct.Product

--Se antal reserverade produkter
create or alter View ViewQuantityReserved as
select Product, Sum(Quantity) as Quantity
from InventoryLogs
where Status in(3,4)
group by product

--för att se alla produkter som är i lager.
select * from ViewProductReadable where status = 1;