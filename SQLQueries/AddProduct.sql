create or alter procedure AddProduct @ItemNumber varchar(7), @Name varchar(50), 
@Brand int, @Price decimal(7,2), @Description text, @ReleaseDate datetime, 
@Category int, @Status int, @ImageURL varchar(255) as

Insert into Products(ItemNumber, [Name], Brand, Price, [Description], 
ReleaseDate, Category,  [Status], ImageURL)

values(@ItemNumber, @Name, @Brand, @Price, @Description, @ReleaseDate,
@Category, @Status, @ImageURL)

select SCOPE_IDENTITY() as ProductID

exec AddProduct ......