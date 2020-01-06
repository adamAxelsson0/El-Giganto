-- Se produkter med namn istället för ID
Create or ALTER View ViewProductReadable AS
Select ItemNumber, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], ImageURL, ReleaseDate, ProductStatuses.[Status] as Status, QuantityAvailable
from Products
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID
inner join ProductStatuses
on Products.[Status] = ProductStatuses.ID;
 
Select * from ViewProductReadable
 
-- Se produkter(inkl Produkt.ID) med namn istället för ID
Create or ALTER View ViewProductReadableInclID AS
Select Products.ID as ID, ItemNumber, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], ImageURL, ReleaseDate, ProductStatuses.[Status] as Status, QuantityAvailable
from Products
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID
inner join ProductStatuses
on Products.[Status] = ProductStatuses.ID;
 
Select * from ViewProductReadableInclID

--Se produkter som endast är i lager
select * from products where status = 1;

