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
    WhenLastUpdated dateTime not null,
    Discount DECIMAL(7,2),
);
Create TABLE CartItems(
    ID int primary key IDENTITY(1,1),
    Product int FOREIGN key REFERENCES Products(ID) not null,
    Cart int FOREIGN key REFERENCES Carts(ID) 
    --¨¨needs to be nullable since we want to remove old carts. 
    --Then remove cartitems where cartitems don't have a cart anymore.
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
 