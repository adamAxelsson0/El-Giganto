Create or alter view ViewSoldThisMonthPerCategory as
Select SUM(OrderDetails.Quantity) as Sold, Categories.Name as Category
from OrderDetails
inner join Products
on OrderDetails.Product = Products.ID
inner join Categories
on Products.Category = Categories.ID
inner join Orders
on OrderDetails.[Order] = Orders.ID
where Month(Orders.OrderDate) = Month(GetDate())
GROUP by Categories.Name
 
Select * from ViewSoldThisMonthPerCategory 
 
-- Sålt antal föregående månad 
Create or alter view ViewSoldPreviousMonthPerCategory as
Select SUM(OrderDetails.Quantity) as Sold, Categories.Name
from OrderDetails
inner join Products
on OrderDetails.Product = Products.ID
inner join Categories
on Products.Category = Categories.ID
inner join Orders
on OrderDetails.[Order] = Orders.ID
where Month(Orders.OrderDate) = Month(DATEADD(MONTH, DATEDIFF(MONTH, -1, GetDate())-1, -1))
GROUP by Categories.Name
 
select * from viewsoldpreviousmonthpercategory
 
-- Sålt antal X senaste dagar per kategori
CREATE or alter PROCEDURE SoldLastXDaysPerCategory @days int
AS
Select SUM(OrderDetails.Quantity) as Sold, Categories.Name
from OrderDetails
inner join Products
on OrderDetails.Product = Products.ID
inner join Categories
on Products.Category = Categories.ID
inner join Orders
on OrderDetails.[Order] = Orders.ID
where Orders.OrderDate >= GetDate() - @days
GROUP by Categories.Name
 
SoldLastXDaysPerCategory 1