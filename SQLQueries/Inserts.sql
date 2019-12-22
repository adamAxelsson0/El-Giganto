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