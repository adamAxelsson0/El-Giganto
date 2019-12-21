Tables
CREATE TABLE Categories(
    ID int primary key IDENTITY(1,1),
    Name varchar(50) not null unique,
    Parent int foreign key REFERENCES Categories(ID)
);
CREATE TABLE ProductStatuses(
    ID int primary key IDENTITY(1,1),
    Status varchar(50) UNIQUE
);
CREATE TABLE Brands(
    ID int primary key IDENTITY(1,1),
    Name varchar(50) not null UNIQUE
);
CREATE TABLE Products(
    ID int primary key IDENTITY(1,1),
    ItemNumber varchar(7) Unique,
    Name varchar(50),
    Brand int foreign key REFERENCES Brands(ID),
    Price DECIMAL(7,2),
    Description varchar(50),
    Image image,
    ReleaseDate date,
    Category int foreign key REFERENCES Categories(ID),
    Status int foreign key REFERENCES Brands(ID)
);
CREATE TABLE InventoryStatuses(
    ID int PRIMARY KEY IDENTITY(1,1),
    Status varchar(50)
);
CREATE TABLE InventoryLogs(
    ID int primary key IDENTITY(1,1),
    Product int FOREIGN KEY REFERENCES Products(ID) not null,
    AdjustmentDate DateTime not null,
    Quantity int not null,
    Status int FOREIGN KEY REFERENCES InventoryStatuses(ID) not null,
);
CREATE TABLE PopularityCategories(
    ID int primary key IDENTITY(1,1),
    Name varchar(50) not null unique,
    Points int not null
);
CREATE TABLE ProductPopularityLogs(
    ID int primary key IDENTITY(1,1),
    Product int foreign key REFERENCES Products(ID) not null,
    Popularity int foreign key REFERENCES PopularityCategories(ID) not null,
    LogDate DATETime not null
);
CREATE TABLE Specifications(
    ID int primary key IDENTITY(1,1),
    Name varchar(50) unique
);
CREATE TABLE Specifications_Categories(
    ID int PRIMARY key IDENTITY(1,1),
    Specification int FOREIGN KEY REFERENCES Specifications(ID) not null,
    Category int FOREIGN key REFERENCES Categories(ID) not null
);
CREATE table Specifications_Products(
    ID int PRIMARY key IDENTITY(1,1),
    Product int FOREIGN key REFERENCES Products(ID) not null,
    Specification int FOREIGN key REFERENCES Specifications(ID) not null,
    Value varchar(50) not null
);
CREATE table Customers(
    ID int PRIMARY key IDENTITY(1,1),
    FirstName varchar(50),
    LastName varchar(50),
    Phone varchar(15),
    StreetAdress varchar(50),
    City varchar(50),
    PostalCode varchar(10),
    Country varchar(50)
);
Create Table Carts(
    ID int primary key IDENTITY(1,1),
    Customer int foreign key REFERENCES Customers(ID) not null,
    Comment varchar(100),
    WhenLastUpdated dateTime not null,
    Discount DECIMAL(7,2),
);
Create TABLE CartItems(
    ID int primary key IDENTITY(1,1),
    Product int FOREIGN key REFERENCES Products(ID) not null,
    Cart int FOREIGN key REFERENCES Carts(ID) not null,
    Quantity int not null
);
Create TABLE OrderStatuses(
    ID int primary key IDENTITY(1,1),
    Status varchar(50) not null UNIQUE
);
Create TABLE Orders(
    ID int primary key IDENTITY(1,1),
    Customer int FOREIGN key REFERENCES Customers(ID) not null,
    OrderDate DateTime not null,
    ShippingDate DateTime,
    Status int FOREIGN key REFERENCES OrderStatuses(ID) not null,
);
Create TABLE OrderDetails(
    ID int primary key IDENTITY(1,1),
    [Order] int FOREIGN KEY REFERENCES Orders(ID) not null,
    Product int FOREIGN KEY REFERENCES Products(ID) not null,
    Quantity int not null,
    PricePerUnit DECIMAL(7,2) not null
);
Create Table ReturnStatuses(
    ID int PRIMARY key IDENTITY (1,1),
    Status varchar(50) not null unique
);
CREATE TABLE Returns(
    ID int PRIMARY key IDENTITY (1,1),
    OrderItem int foreign key REFERENCES OrderDetails(ID),
    Reason varchar(255),
	ReturnDate dateTime,
    Status int FOREIGN KEY REFERENCES ReturnStatuses(ID) not NULL
);
CREATE TABLE Payments(
    ID int PRIMARY KEY IDENTITY(1,1),
    [Order] int FOREIGN KEY REFERENCES Orders(ID) not null,
    PaymentDate DateTime not null,
    PaymentDetail varchar(255),
    Amount DECIMAL(7,2) not null
);
 
Insert
Select * from Categories;
Insert into Categories([Name], Parent)
VALUES('CD/DVD & Bluray',40);
 
Select * from ProductStatuses;
Insert into ProductStatuses(Status)
values('Ej lanserad ännu');
 
SELECT * from Brands
Insert into Brands([Name])
values('Onkyo');
 
select * from Products;
Insert into Products(ItemNumber, [Name], Brand, Price, [Description], [Image], ReleaseDate, Category, Quantity, [Status])
values('0000005','AMD Ryzen 7 3800X 3,9GHz Socket AM4 Box', 9, 4390, null, null, '2019-07-07', 43, 20, 1);
 
select * from InventoryStatuses;
insert into InventoryStatuses(Status)
VALUES('Product sold')
 
select * from InventoryLogs;
insert into InventoryLogs(Product, AdjustmentDate, Quantity, Status)
Values(6, GETDATE(), 20, 1);
 
select * from PopularityCategories
insert into PopularityCategories(Name, Points)
Values('Checkout cart', 10);
update PopularityCategories set name = 'Checkout' where id = 3;
 
select * from ProductPopularityLogs
insert into ProductPopularityLogs(Product, Popularity, LogDate)
values(1, 3, GETDATE());
 
Select * from Specifications;
insert into Specifications(Name)
VALUES ('Antal trådar');
 
select * from Specifications_Categories;
insert into Specifications_Categories(Specification, Category)
Values(3,43)
 
Select * from Specifications_Products;
insert into Specifications_Products(product, Specification, [value])
values (4, 2 ,'6 st.')
 
select * from Customers;
insert into Customers(FirstName, LastName, Phone, StreetAdress, City,PostalCode,Country)
values('Adam', 'Axelsson', '0733-333333', 'Södra Sjöbogatan 1', 'Borås',50643, 'Sweden');
 
select * from Carts;
Insert into Carts(Customer, Comment, WhenLastUpdated,Discount)
VALUES(1,'Christmas Cart', GETDATE(), 0)
 
select * from CartItems
insert into CartItems(Product, Cart, Quantity)
VALUES(1,1,2)
 
select * from OrderStatuses
insert into OrderStatuses([Status])
VALUES('Annulerad')
 
Select * from Orders;
insert into Orders(customer, OrderDate, ShippingDate, [Status])
VALUES(1, GETDATE(), null, 1)
 
select * from OrderDetails;
insert into OrderDetails([Order], Product, Quantity,PricePerUnit)
VALUES(1, 1, 2, 2290)
 
select * from Payments;
INSERT into Payments([Order], PaymentDate, PaymentDetail, Amount)
VALUES(1, GETDATE(), 'Nordea 1234-1234-1234-1234', 2290)
--TWO MORE
 
Views
-- Se produkter med namn istället för ID
Create or ALTER View ViewProductReadable AS
Select ItemNumber, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], [Image], ReleaseDate, ProductStatuses.[Status] as Status
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
Select Products.ID as ID, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], [Image], ReleaseDate, ProductStatuses.[Status] as Status
from Products
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID
inner join ProductStatuses
on Products.[Status] = ProductStatuses.ID;
 
Select * from ViewProductReadableInclID
 
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
 
-- Sålt antal innevarande månad 
select * from OrderDetails
 
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
 
select * from ViewReturnedLastMonth
 
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
 
returnedlastxdayspercategory 3

-- De 5 mest populära produkterna per kategori
Create or alter view MostReturnedProductsPerCategory as
SELECT ViewReturnedPerProduct.*,
Rank() OVER (PARTITION BY Category ORDER by NrOfReturns DESC) AS Ranking
FROM ViewReturnedPerProduct
GROUP BY Category, Name, ID, NrOfReturns

SELECT *
FROM MostReturnedProductsPerCategory
WHERE Ranking <= 5
 
--Produkter i lager
Create or alter View ViewQuantityPerProduct as
select Product, SUM(Quantity) as Quantity
from InventoryLogs
GROUP by Product;
 
select * from viewquantityperproduct
 
