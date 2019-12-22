--Se Popularitet per produkt
CREATE OR ALTER VIEW ViewMostPopularProducts as
Select Products.ID, Products.Name, SUM(PopularityCategories.Points) as PopularityPoints, Categories.Name as Category
from Products
inner join ProductPopularityLogs
on Products.ID = ProductPopularityLogs.Product
inner join PopularityCategories
on ProductPopularityLogs.Popularity = PopularityCategories.ID
inner join Categories
on Products.Category = Categories.ID
group by Products.ID, Products.Name, Categories.Name
 
select * from ViewMostPopularProducts
order by PopularityPoints desc
 
-- De X mest populära produkterna
Create or alter procedure XMostPopularProducts @number int as
select top (@number) *
from ViewMostPopularProducts as Pop
order by pop.PopularityPoints desc
 
XMostPopularProducts 3

-- De 5 mest populära produkterna per kategori
CREATE OR ALTER VIEW MostPopularProductsPerCategory as
SELECT ViewMostPopularProducts.*,
Rank() OVER (PARTITION BY Category ORDER by PopularityPoints DESC) AS Ranking
FROM ViewMostPopularProducts --är en view som jag skapat för att se pop på alla produkter
GROUP BY Category, Name, PopularityPoints, ID

SELECT *
FROM MostPopularProductsPerCategory
WHERE Ranking <= 5