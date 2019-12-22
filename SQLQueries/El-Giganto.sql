--Produkter i lager
Create or alter View ViewQuantityPerProduct as
select Product, SUM(Quantity) as Quantity
from InventoryLogs
GROUP by Product;
 
select * from viewquantityperproduct
 
