--TABLES --FIRST 4 needs changing not null
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
    Quantity int,
    Status int foreign key REFERENCES Brands(ID)
);
CREATE TABLE InventoryStatuses(
    ID int PRIMARY KEY IDENTITY(1,1),
    Status varchar(50)
);
CREATE TABLE InventoryLogs(
    ID int primary key IDENTITY(1,1),
    Product int FOREIGN KEY REFERENCES Products(ID) not null,
    AdjustmentDate Date not null,
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
    LogDate DATE not null
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
    WhenLastUpdated date not null,
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
    OrderDate Date not null,
    ShippingDate Date,
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
    Status int FOREIGN KEY REFERENCES ReturnStatuses(ID) not NULL
);
CREATE TABLE Payments(
    ID int PRIMARY KEY IDENTITY(1,1),
    [Order] int FOREIGN KEY REFERENCES Orders(ID) not null,
    PaymentDate Date not null,
    PaymentDetail varchar(255),
    Amount DECIMAL(7,2) not null
);
--INSERTEXAMPLES
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
Values(6, Convert(Date, GETDATE()), 20, 1);

select * from PopularityCategories
insert into PopularityCategories(Name, Points)
Values('Checkout cart', 10);
update PopularityCategories set name = 'Checkout' where id = 3;

select * from ProductPopularityLogs
insert into ProductPopularityLogs(Product, Popularity, LogDate)
values(1, 3, Convert(Date, GETDATE()));

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
VALUES(1,'Christmas Cart', Convert(Date, GETDATE()), 0)

select * from CartItems
insert into CartItems(Product, Cart, Quantity)
VALUES(1,1,2)

select * from OrderStatuses
insert into OrderStatuses([Status])
VALUES('Annulerad')

Select * from Orders;
insert into Orders(customer, OrderDate, ShippingDate, [Status])
VALUES(1, Convert(Date, GETDATE()), null, 1)

select * from OrderDetails;
insert into OrderDetails([Order], Product, Quantity,PricePerUnit)
VALUES(1, 1, 2, 2290)

select * from Payments;
INSERT into Payments([Order], PaymentDate, PaymentDetail, Amount)
VALUES(1, Convert(Date, GETDATE()), 'Nordea 1234-1234-1234-1234', 2290)
--TWO MORE

--VIEWS
-- Se produkter med namn istället för ID
Create or ALTER View ViewProductReadable AS
Select ItemNumber, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], [Image], ReleaseDate, Quantity, ProductStatuses.[Status] as Status
from Products
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID
inner join ProductStatuses
on Products.[Status] = ProductStatuses.ID;

Select * from ViewProductReadable

-- Se produkter(inkl Produkt.ID) med namn istället för ID
Create or ALTER View ViewProductReadableInclID AS
Select Products.ID as ID, Categories.Name as Category, Products.Name as Name, Brands.Name as Brand, Price, 
[Description], [Image], ReleaseDate, Quantity, ProductStatuses.[Status] as Status
from Products
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID
inner join ProductStatuses
on Products.[Status] = ProductStatuses.ID;

Select * from ViewProductReadableInclID

-- De 5 mest populära produkterna per kategori
Select TOP 5 Products.Name, Products.Category, ProductPopularityLogs.Popularity
from ProductPopularityLogs
inner JOIN Products
on ProductPopularityLogs.Product = Products.ID
group by Products.Name;

--Se Popularitet per produkt
CREATE OR ALTER VIEW ViewMostPopularProducts as
Select SUM(PopularityCategories.Points) as PopularityPoints,  Products.ID
from Products
inner join ProductPopularityLogs
on Products.ID = ProductPopularityLogs.Product
inner join PopularityCategories
on ProductPopularityLogs.Popularity = PopularityCategories.ID
group by Products.ID
HAVING Products.Category = 43;

select * from ViewMostPopularProducts

Create or alter view ViewMostPopularProductsReadable as
select Products.ID, Products.ItemNumber, Products.Name as Product, 
Brands.Name as Brand, Categories.Name as Category, Pop.PopularityPoints
from ViewMostPopularProducts as Pop
inner join Products
on Pop.ID = Products.ID
inner join Brands
on Products.Brand = Brands.ID
inner join Categories
on Products.Category = Categories.ID;

Select top 5 * from ViewMostPopularProductsReadable 
where Category = 'Processor'
order by PopularityPoints desc;

--Kategorirapport (en rad per kategori)
-- Sålt antal innevarande månad 
select * from OrderDetails

Create or alter view ViewSoldThisMonth
Select SUM(OrderDetails.Quantity) as Sold
from OrderDetails
inner join Products
on OrderDetails.Product = Products.ID
inner join Categories
on Products.Category = Categories.ID
inner join Orders
on OrderDetails.[Order] = Orders.ID
where Month(Orders.OrderDate) = Month(GetDate())

select SUM(OrderDetails.Quantity) as Sold, Categories.ID as Category
from OrderDetails
inner join Products
on OrderDetails.Product = Products.ID
inner join Categories
on Products.Category = Categories.ID
GROUP BY Categories.ID


Select