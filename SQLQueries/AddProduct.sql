create or alter procedure AddProduct @ItemNumber varchar(7), @Name varchar(50), 
@Brand int, @Price decimal(7,2), @Description text, @ReleaseDate datetime, 
@Category int, @Status int, @ImageURL varchar(255) as

Insert into Products(ItemNumber, [Name], Brand, Price, [Description], 
ReleaseDate, Category,  [Status], ImageURL)

values(@ItemNumber, @Name, @Brand, @Price, @Description, @ReleaseDate,
@Category, @Status, @ImageURL)

select SCOPE_IDENTITY() as ProductID

exec AddProduct '0000014', 'Asus ROG Strix X570-F Gaming', 27, 2890, 'Placeholder', '2019-07-07', 44, 3, 'https://pricespy-75b8.kxcdn.com/product/standard/800/5102534.jpg'