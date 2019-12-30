---- Returnerat antal per produkt
Create or alter view ViewReturnedPerProduct as
Select ReadableProduct.ID, ReadableProduct.Name, ReadableProduct.Category, Count(Returns.ID) as NrOfReturns
from Returns
inner join OrderDetails
on Returns.OrderItem = OrderDetails.ID
inner join ViewProductReadableInclID as ReadableProduct
on OrderDetails.Product = ReadableProduct.ID
group by ReadableProduct.ID, ReadableProduct.Name, ReadableProduct.Category
 
-- Returnerat antal innevarande månad
Create or alter view ViewReturnedThisMonthPerCategory as
Select Count(Returns.ID) as NrOfReturns, ReadableProduct.Category as Category
from Returns
inner join OrderDetails
on Returns.OrderItem = OrderDetails.ID
inner join ViewProductReadableInclID as ReadableProduct
on OrderDetails.Product = ReadableProduct.ID
where Month(Returns.ReturnDate) = Month(GetDate())
Group by ReadableProduct.Category
 
select * from ViewReturnedThisMonthPerCategory 
 
-- Returnerat antal föregående månad
Create or alter view ViewReturnedLastMonthPerCategory as
Select Count(Returns.ID) as NrOfReturns, ReadableProduct.Category as Category
from Returns
inner join OrderDetails
on Returns.OrderItem = OrderDetails.ID
inner join ViewProductReadableInclID as ReadableProduct
on OrderDetails.Product = ReadableProduct.ID
where Month(Returns.ReturnDate) = Month(DATEADD(MONTH, DATEDIFF(MONTH, -1, GetDate())-1, -1))
Group by ReadableProduct.Category
 
select * from ViewReturnedLastMonthPerCategory
 
-- Returnerat antal X senaste dagar per kategori
CREATE or alter PROCEDURE ReturnedLastXDaysPerCategory @days int
AS
Select Count(Returns.ID) as NrOfReturns, ReadableProduct.Category as Category
from Returns
inner join OrderDetails
on Returns.OrderItem = OrderDetails.ID
inner join ViewProductReadableInclID as ReadableProduct
on OrderDetails.Product = ReadableProduct.ID
where Month(Returns.ReturnDate) >= GetDate() - @days
Group by ReadableProduct.Category
 
returnedlastxdayspercategory 365

-- De 5 mest returnerade produkterna per kategori
Create or alter view MostReturnedProductsPerCategory as
SELECT ViewReturnedPerProduct.*,
Rank() OVER (PARTITION BY Category ORDER by NrOfReturns DESC) AS Ranking
FROM ViewReturnedPerProduct
GROUP BY Category, Name, ID, NrOfReturns

SELECT *
FROM MostReturnedProductsPerCategory
WHERE Ranking <= 5