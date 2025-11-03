CREATE DATABASE Northwind;
USE Northwind;

CREATE TABLE Categories (
    CategoryID INT IDENTITY PRIMARY KEY,
    CategoryName NVARCHAR(15) NOT NULL,
    Description NVARCHAR(255) NULL
);
GO

CREATE TABLE Customers (
    CustomerID NCHAR(5) PRIMARY KEY,
    CompanyName NVARCHAR(40) NOT NULL,
    ContactName NVARCHAR(30) NULL,
    ContactTitle NVARCHAR(30) NULL,
    Address NVARCHAR(60) NULL,
    City NVARCHAR(15) NULL,
    Region NVARCHAR(15) NULL,
    PostalCode NVARCHAR(10) NULL,
    Country NVARCHAR(15) NULL,
    Phone NVARCHAR(24) NULL,
    Fax NVARCHAR(24) NULL
);

CREATE TABLE Employees (
    EmployeeID INT IDENTITY PRIMARY KEY,
    LastName NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(10) NOT NULL,
    Title NVARCHAR(30) NULL,
    TitleOfCourtesy NVARCHAR(25) NULL,
    BirthDate DATETIME NULL,
    HireDate DATETIME NULL,
    Address NVARCHAR(60) NULL,
    City NVARCHAR(15) NULL,
    Region NVARCHAR(15) NULL,
    PostalCode NVARCHAR(10) NULL,
    Country NVARCHAR(15) NULL,
    HomePhone NVARCHAR(24) NULL,
    Extension NVARCHAR(4) NULL,
    Notes NTEXT NULL,
    ReportsTo INT NULL
);
GO

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(40) NOT NULL,
    ContactName NVARCHAR(30) NULL,
    ContactTitle NVARCHAR(30) NULL,
    Address NVARCHAR(60) NULL,
    City NVARCHAR(15) NULL,
    Region NVARCHAR(15) NULL,
    PostalCode NVARCHAR(10) NULL,
    Country NVARCHAR(15) NULL,
    Phone NVARCHAR(24) NULL,
    Fax NVARCHAR(24) NULL,
    HomePage NTEXT NULL
);

CREATE TABLE Shippers (
    ShipperID INT IDENTITY PRIMARY KEY,
    CompanyName NVARCHAR(40) NOT NULL,
    Phone NVARCHAR(24) NULL
);
CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID NCHAR(5) NULL,
    EmployeeID INT NULL,
    OrderDate DATETIME NULL,
    RequiredDate DATETIME NULL,
    ShippedDate DATETIME NULL,
    ShipVia INT NULL,
    Freight MONEY NULL DEFAULT 0,
    ShipName NVARCHAR(40) NULL,
    ShipAddress NVARCHAR(60) NULL,
    ShipCity NVARCHAR(15) NULL,
    ShipRegion NVARCHAR(15) NULL,
    ShipPostalCode NVARCHAR(10) NULL,
    ShipCountry NVARCHAR(15) NULL
);

CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(40) NOT NULL,
    SupplierID INT NULL,
    CategoryID INT NULL,
    QuantityPerUnit NVARCHAR(20) NULL,
    UnitPrice MONEY NULL DEFAULT 0,
    UnitsInStock SMALLINT NULL DEFAULT 0,
    UnitsOnOrder SMALLINT NULL DEFAULT 0,
    ReorderLevel SMALLINT NULL DEFAULT 0,
    Discontinued BIT NOT NULL DEFAULT 0
);

CREATE TABLE [Order Details] (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice MONEY NOT NULL DEFAULT 0,
    Quantity SMALLINT NOT NULL DEFAULT 1,
    Discount REAL NOT NULL DEFAULT 0,
    PRIMARY KEY (OrderID, ProductID)
);
CREATE TABLE Region (
    RegionID INT PRIMARY KEY,
    RegionDescription NCHAR(50) NOT NULL
);
CREATE TABLE Territories (
    TerritoryID NVARCHAR(20) PRIMARY KEY,
    TerritoryDescription NCHAR(50) NOT NULL,
    RegionID INT NOT NULL
);
CREATE TABLE EmployeeTerritories (
    EmployeeID INT NOT NULL,
    TerritoryID NVARCHAR(20) NOT NULL,
    PRIMARY KEY (EmployeeID, TerritoryID)
);
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Employees
FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID);

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Shippers
FOREIGN KEY (ShipVia)
REFERENCES Shippers(ShipperID);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Suppliers
FOREIGN KEY (SupplierID)
REFERENCES Suppliers(SupplierID);

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);


ALTER TABLE [Order Details]
ADD CONSTRAINT FK_OrderDetails_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE [Order Details]
ADD CONSTRAINT FK_OrderDetails_Products
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID);

ALTER TABLE Territories
ADD CONSTRAINT FK_Territories_Region
FOREIGN KEY (RegionID)
REFERENCES Region(RegionID);

ALTER TABLE EmployeeTerritories
ADD CONSTRAINT FK_EmpTerr_Employees
FOREIGN KEY (EmployeeID)
REFERENCES Employees(EmployeeID);

ALTER TABLE EmployeeTerritories
ADD CONSTRAINT FK_EmpTerr_Territories
FOREIGN KEY (TerritoryID)
REFERENCES Territories(TerritoryID);

SET IDENTITY_INSERT Categories ON;

INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales'),
(2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, N'Confections', N'Desserts, candies, and sweet breads'),
(4, N'Dairy Products', N'Cheeses'),
(5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal'),
(6, N'Meat/Poultry', N'Prepared meats'),
(7, N'Produce', N'Dried fruit and bean curd'),
(8, N'Seafood', N'Seaweed and fish');

SET IDENTITY_INSERT Categories OFF;

SET IDENTITY_INSERT Suppliers ON;

INSERT INTO Suppliers (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage) VALUES
(1, N'Exotic Liquids', N'Charlotte Cooper', N'Purchasing Manager', N'49 Gilbert St.', N'London', NULL, N'EC1 4SD', N'UK', N'(171) 555-2222', NULL, NULL),
(2, N'New Orleans Cajun Delights', N'Shelley Burke', N'Order Administrator', N'P.O. Box 78934', N'New Orleans', N'LA', N'70117', N'USA', N'(100) 555-4822', NULL, NULL),
(3, N'Grandma Kelly''s Homestead', N'Regina Murphy', N'Sales Representative', N'707 Oxford Rd.', N'Ann Arbor', N'MI', N'48104', N'USA', N'(313) 555-5735', N'(313) 555-3349', NULL),
(4, N'Tokyo Traders', N'Yoshi Nagase', N'Marketing Manager', N'9-8 Sekimai Musashino-shi', N'Tokyo', NULL, N'100', N'Japan', N'(03) 3555-5011', NULL, NULL),
(5, N'Cooperativa de Quesos ''Las Cabras''', N'Antonio del Valle Saavedra', N'Export Administrator', N'Calle del Rosal 4', N'Oviedo', NULL, N'33007', N'Spain', N'(98) 598 76 54', NULL, NULL),
(6, N'Mayumi''s', N'Mayumi Ohno', N'Marketing Representative', N'92 Setsuko Chuo-ku', N'Osaka', NULL, N'545', N'Japan', N'(06) 431-7877', NULL, NULL);

SET IDENTITY_INSERT Suppliers OFF;

SET IDENTITY_INSERT Shippers ON;

INSERT INTO Shippers (ShipperID, CompanyName, Phone) VALUES
(1, N'Speedy Express', N'(503) 555-9831'),
(2, N'United Package', N'(503) 555-3199'),
(3, N'Federal Shipping', N'(503) 555-9931');

SET IDENTITY_INSERT Shippers OFF;

SET IDENTITY_INSERT Employees ON;

INSERT INTO Employees 
(EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Notes, ReportsTo) VALUES
(1, N'Davolio', N'Nancy', N'Sales Representative', N'Ms.', '1948-12-08', '1992-05-01', N'507 - 20th Ave. E.\r\nApt. 2A', N'Seattle', N'WA', N'98122', N'USA', N'(206) 555-9857', N'5467', N'Education includes a BA in psychology...', NULL),
(2, N'Fuller', N'Andrew', N'Vice President, Sales', N'Mr.', '1952-02-19', '1992-08-14', N'908 W. Capital Way', N'Tacoma', N'WA', N'98401', N'USA', N'(206) 555-9482', N'3457', N'Andrew received his BTS...', NULL),
(3, N'Leverling', N'Janet', N'Sales Representative', N'Ms.', '1963-08-30', '1992-04-01', N'722 Moss Bay Blvd.', N'Kirkland', N'WA', N'98033', N'USA', N'(206) 555-3412', N'3355', N'Janet has a BS degree...', 2),
(4, N'Peacock', N'Margaret', N'Sales Representative', N'Mrs.', '1937-09-19', '1993-05-03', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'USA', N'(206) 555-8122', N'5176', N'Margaret holds a BA in English...', 2),
(5, N'Buchanan', N'Steven', N'Sales Manager', N'Mr.', '1955-03-04', '1993-10-17', N'14 Garrett Hill', N'London', NULL, N'SW1 8JR', N'UK', N'(71) 555-4848', N'3453', N'Steven Buchanan graduated...', 2),
(6, N'Suyama', N'Michael', N'Sales Representative', N'Mr.', '1963-07-02', '1993-10-17', N'Coventry House\r\nMiner Rd.', N'London', NULL, N'EC2 7JR', N'UK', N'(71) 555-7773', N'428', N'Michael is a graduate...', 5),
(7, N'King', N'Robert', N'Sales Representative', N'Mr.', '1960-05-29', '1994-01-02', N'Edgeham Hollow\r\nWinchester Way', N'London', NULL, N'RG1 9SP', N'UK', N'(71) 555-5598', N'465', N'Robert King served...', 5),
(8, N'Callahan', N'Laura', N'Inside Sales Coordinator', N'Ms.', '1958-01-09', '1994-03-05', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'USA', N'(206) 555-1189', N'2344', N'Laura received a BA...', 2),
(9, N'Dodsworth', N'Anne', N'Sales Representative', N'Ms.', '1966-01-27', '1994-11-15', N'7 Houndstooth Rd.', N'London', NULL, N'WG2 7LT', N'UK', N'(71) 555-4444', N'452', N'Anne has a BA degree...', 5);

SET IDENTITY_INSERT Employees OFF;

INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax) VALUES
(N'ALFKI', N'Alfreds Futterkiste', N'Maria Anders', N'Sales Representative', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', N'030-0074321', N'030-0076545'),
(N'ANATR', N'Ana Trujillo Emparedados y helados', N'Ana Trujillo', N'Owner', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico', N'(5) 555-4729', N'(5) 555-3745'),
(N'ANTON', N'Antonio Moreno Taquería', N'Antonio Moreno', N'Owner', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico', N'(5) 555-3932', NULL),
(N'AROUT', N'Around the Horn', N'Thomas Hardy', N'Sales Representative', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK', N'(171) 555-7788', N'(171) 555-6750'),
(N'BERGS', N'Berglunds snabbköp', N'Christina Berglund', N'Order Administrator', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden', N'0921-12 34 65', N'0921-12 34 67'),
(N'BLAUS', N'Blauer See Delikatessen', N'Hanna Moos', N'Sales Representative', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', N'0621-08460', N'0621-08924'),
(N'BLONP', N'Blondesddsl père et fils', N'Frédérique Citeaux', N'Marketing Manager', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France', N'88.60.15.31', N'88.60.15.32'),
(N'BOLID', N'Bólido Comidas preparadas', N'Martín Sommer', N'Owner', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', N'(91) 555 22 82', N'(91) 555 91 99'),
(N'BONAP', N'Bon app''', N'Laurence Lebihan', N'Owner', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', N'91.24.45.40', N'91.24.45.41'),
(N'BOTTM', N'Bottom-Dollar Markets', N'Elizabeth Lincoln', N'Accounting Manager', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', N'(604) 555-4729', N'(604) 555-3745'),
(N'BSBEV', N'B''s Beverages', N'Victoria Ashworth', N'Sales Representative', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', N'(171) 555-1212', NULL),
(N'CACTU', N'Cactus Comidas para llevar', N'Patricio Simpson', N'Sales Agent', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 135-5555', N'(1) 135-4892'),
(N'CENTC', N'Centro comercial Moctezuma', N'Francisco Chang', N'Marketing Manager', N'Sierras de Granada 9993', N'México D.F.', NULL, N'05022', N'Mexico', N'(5) 555-3392', N'(5) 555-7293'),
(N'CHOPS', N'Chop-suey Chinese', N'Yang Wang', N'Owner', N'Hauptstr. 29', N'Bern', NULL, N'3012', N'Switzerland', N'0452-076545', NULL),
(N'COMMI', N'Comércio Mineiro', N'Pedro Afonso', N'Sales Associate', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', N'(11) 555-7647', NULL);

INSERT INTO Region (RegionID, RegionDescription) VALUES
(1, N'Eastern'),
(2, N'Western'),
(3, N'Northern'),
(4, N'Southern');

INSERT INTO Territories (TerritoryID, TerritoryDescription, RegionID) VALUES
(N'01581', N'Westboro', 1),
(N'01730', N'Bedford', 1),
(N'01833', N'Georgetow', 1),
(N'02116', N'Boston', 1),
(N'02139', N'Cambridge', 1),
(N'02184', N'Braintree', 1),
(N'02903', N'Providence', 1),
(N'03049', N'Hollis', 3),
(N'03801', N'Portsmouth', 3),
(N'06897', N'Wilton', 1),
(N'07960', N'Morristown', 1),
(N'08837', N'Edison', 1),
(N'10019', N'New York', 1),
(N'10038', N'New York', 1),
(N'11747', N'Melville', 1),
(N'15201', N'Pittsburgh', 2),
(N'17810', N'Bloomsburg', 1),
(N'48075', N'Southfield', 2),
(N'48084', N'Troy', 2),
(N'48304', N'Bloomfield Hills', 2),
(N'53404', N'Racine', 2),
(N'55113', N'Roseville', 2),
(N'55439', N'Minneapolis', 2),
(N'60179', N'Hoffman Estates', 2),
(N'60601', N'Chicago', 2),
(N'72716', N'Bentonville', 4),
(N'75201', N'Dallas', 4),
(N'78759', N'Austin', 4),
(N'80202', N'Denver', 2),
(N'80909', N'Colorado Springs', 2),
(N'90405', N'Santa Monica', 2),
(N'94025', N'Menlo Park', 2),
(N'94105', N'San Francisco', 2),
(N'95008', N'Campbell', 2),
(N'95054', N'Santa Clara', 2),
(N'95060', N'Santa Cruz', 2),
(N'98004', N'Bellevue', 2),
(N'98052', N'Redmond', 2),
(N'98101', N'Seattle', 2);


SET IDENTITY_INSERT Products ON;

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued) VALUES
(1, N'Chai', 1, 1, N'10 boxes x 20 bags', 18.00, 39, 0, 10, 0),
(2, N'Chang', 1, 1, N'24 - 12 oz bottles', 19.00, 17, 40, 25, 0),
(3, N'Aniseed Syrup', 1, 2, N'12 - 550 ml bottles', 10.00, 13, 70, 25, 0),
(4, N'Chef Anton''s Cajun Seasoning', 2, 2, N'48 - 6 oz jars', 22.00, 53, 0, 0, 0),
(5, N'Chef Anton''s Gumbo Mix', 2, 2, N'36 boxes', 21.35, 0, 0, 0, 1),
(6, N'Grandma''s Boysenberry Spread', 3, 2, N'12 - 8 oz jars', 25.00, 120, 0, 25, 0),
(7, N'Uncle Bob''s Organic Dried Pears', 3, 7, N'12 - 1 lb pkgs.', 30.00, 15, 0, 10, 0),
(8, N'Northwoods Cranberry Sauce', 3, 2, N'12 - 12 oz jars', 40.00, 6, 0, 0, 0),
(9, N'Mishi Kobe Niku', 4, 6, N'18 - 500 g pkgs.', 97.00, 29, 0, 0, 1),
(10, N'Ikura', 4, 8, N'12 - 200 ml jars', 31.00, 31, 0, 0, 0),
(11, N'Queso Cabrales', 5, 4, N'1 kg pkg.', 21.00, 22, 30, 30, 0),
(12, N'Queso Manchego La Pastora', 5, 4, N'10 - 500 g pkgs.', 38.00, 86, 0, 0, 0),
(13, N'Konbu', 6, 8, N'2 kg box', 6.00, 24, 0, 5, 0),
(14, N'Tofu', 6, 7, N'40 - 100 g pkgs.', 23.25, 35, 0, 0, 0),
(15, N'Genen Shouyu', 6, 2, N'24 - 250 ml bottles', 15.50, 39, 0, 5, 0),
(16, N'Pavlova', 7, 3, N'32 - 500 g boxes', 17.45, 29, 0, 10, 0),
(17, N'Alice Mutton', 7, 6, N'20 - 1 kg tins', 39.00, 0, 0, 0, 1),
(18, N'Carnarvon Tigers', 7, 8, N'16 kg pkg.', 62.50, 42, 0, 0, 0),
(19, N'Teatime Chocolate Biscuits', 8, 3, N'10 boxes x 12 pieces', 9.20, 25, 0, 5, 0),
(20, N'Sir Rodney''s Marmalade', 8, 3, N'30 gift boxes', 81.00, 40, 0, 0, 0),
(21, N'Sir Rodney''s Scones', 8, 3, N'24 pkgs. x 4 pieces', 10.00, 3, 40, 5, 0),
(22, N'Gustaf''s Knäckebröd', 9, 5, N'24 - 500 g pkgs.', 21.00, 104, 0, 25, 0),
(23, N'Tunnbröd', 9, 5, N'12 - 250 g pkgs.', 9.00, 61, 0, 25, 0),
(24, N'Guaraná Fantástica', 10, 1, N'12 - 355 ml cans', 4.50, 20, 0, 0, 1),
(25, N'NuNcHa', 11, 3, N'30 - 100 g pkgs.', 25.00, 0, 0, 0, 1),
(26, N'North Sea', 12, 8, N'200 g pkgs.', 12.00, 100, 0, 30, 0),
(27, N'Barramundi', 12, 8, N'1 kg pkg.', 25.89, 50, 0, 0, 0),
(28, N'Gravad lax', 12, 8, N'12 - 100 g pkgs.', 26.00, 11, 50, 25, 0),
(29, N'Thüringer Rostbratwurst', 13, 6, N'50 bags x 20 pieces', 123.79, 0, 0, 0, 1),
(30, N'Nord-Ost Matjeshering', 14, 8, N'10 - 200 g glasses', 25.89, 10, 0, 15, 0),
(31, N'Gorgonzola Telino', 15, 4, N'12 - 100 g pkgs.', 12.50, 0, 70, 20, 0),
(32, N'Mascarpone Fabioli', 15, 4, N'24 - 200 g pkgs.', 32.00, 9, 40, 25, 0),
(33, N'Geitost', 16, 4, N'500 g', 2.50, 112, 0, 20, 0),
(34, N'Sasquatch Ale', 17, 1, N'24 - 12 oz bottles', 14.00, 111, 0, 15, 0),
(35, N'Steeleye Stout', 17, 1, N'24 - 12 oz bottles', 18.00, 20, 0, 15, 0),
(36, N'Inlagd Sill', 18, 8, N'24 - 250 g jars', 19.00, 112, 0, 20, 0),
(37, N'Gravad lax', 18, 8, N'12 - 500 g pkgs.', 26.00, 11, 50, 25, 0),
(38, N'Côte de Blaye', 19, 1, N'12 - 75 cl bottles', 263.50, 17, 0, 15, 0);

INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued) VALUES
(39, N'Chartreuse verte', 19, 1, N'750 cc per bottle', 18.00, 69, 0, 5, 0),
(40, N'Boston Crab Meat', 20, 8, N'24 - 4 oz tins', 18.40, 123, 0, 30, 0),
(41, N'Jack''s New England Clam Chowder', 20, 8, N'12 - 12 oz cans', 9.65, 85, 0, 10, 0),
(42, N'Singaporean Hokkien Fried Mee', 21, 5, N'32 - 1 kg pkgs.', 14.00, 26, 0, 0, 1),
(43, N'Ipoh Coffee', 22, 1, N'16 - 500 g tins', 46.00, 17, 10, 25, 0),
(44, N'Gula Malacca', 22, 2, N'20 - 2 kg bags', 19.45, 27, 0, 15, 0),
(45, N'Rogede sild', 18, 8, N'1k pkg.', 9.50, 5, 70, 15, 0),
(46, N'Spegesild', 18, 8, N'4 - 500 g pkgs.', 12.00, 95, 0, 10, 0),
(47, N'Zaanse koeken', 23, 3, N'10 - 4 oz boxes', 9.50, 36, 0, 10, 0),
(48, N'Chocolade', 23, 3, N'10 pkgs.', 12.75, 15, 70, 25, 0),
(49, N'Maxilaku', 24, 3, N'24 - 50 g pkgs.', 20.00, 10, 60, 15, 0),
(50, N'Valkoinen suklaa', 24, 3, N'12 - 100 g bars', 16.25, 65, 0, 30, 0),
(51, N'Manjimup Dried Apples', 25, 7, N'50 - 300 g pkgs.', 53.00, 20, 0, 10, 0),
(52, N'Filo Mix', 26, 5, N'16 - 2 kg boxes', 7.00, 38, 0, 15, 0),
(53, N'Perth Pasties', 26, 6, N'48 pieces', 32.80, 0, 0, 0, 1),
(54, N'Tourtière', 27, 6, N'16 pies', 7.45, 21, 0, 10, 0),
(55, N'Pâté chinois', 27, 6, N'24 boxes x 2 pies', 24.00, 115, 0, 20, 0),
(56, N'Gnocchi di nonna Alice', 28, 5, N'24 - 250 g pkgs.', 38.00, 21, 10, 30, 0),
(57, N'Ravioli Angelo', 28, 5, N'24 - 250 g pkgs.', 19.50, 36, 0, 20, 0),
(58, N'Escargots de Bourgogne', 29, 8, N'24 pieces', 13.25, 62, 0, 20, 0),
(59, N'Raclette Courdavault', 30, 4, N'5 kg pkg.', 55.00, 79, 0, 15, 0),
(60, N'Camembert Pierrot', 30, 4, N'15 - 300 g rounds', 34.00, 19, 0, 10, 0),
(61, N'Sirop d''érable', 31, 2, N'24 - 500 ml bottles', 28.50, 113, 0, 25, 0),
(62, N'Tarte au sucre', 31, 3, N'48 pies', 49.30, 17, 0, 15, 0),
(63, N'Vegee-spread', 32, 2, N'15 - 625 g jars', 43.90, 24, 0, 5, 0),
(64, N'Wimmers gute Semmelknödel', 33, 5, N'20 bags x 4 pieces', 33.25, 22, 80, 30, 0),
(65, N'Louisiana Fiery Hot Pepper Sauce', 2, 2, N'32 - 8 oz bottles', 21.05, 76, 0, 0, 0),
(66, N'Louisiana Hot Spiced Okra', 2, 2, N'24 - 8 oz jars', 17.00, 4, 100, 20, 0),
(67, N'Laughing Lumberjack Lager', 17, 1, N'24 - 12 oz bottles', 14.00, 52, 0, 10, 0),
(68, N'Scottish Longbreads', 8, 3, N'10 boxes x 8 pieces', 12.50, 6, 10, 5, 0),
(69, N'Gudbrandsdalsost', 16, 4, N'10 kg pkg.', 36.00, 26, 0, 15, 0),
(70, N'Outback Lager', 7, 1, N'24 - 355 ml bottles', 15.00, 15, 10, 30, 0),
(71, N'Fløtemysost', 16, 4, N'10 - 500 g pkgs.', 21.50, 26, 0, 0, 0),
(72, N'Mozzarella di Giovanni', 14, 4, N'24 - 200 g pkgs.', 34.80, 14, 0, 0, 0),
(73, N'Röd Kaviar', 17, 8, N'24 - 150 g jars', 15.00, 101, 0, 5, 0),
(74, N'Longlife Tofu', 4, 7, N'5 kg pkg.', 10.00, 4, 20, 5, 0),
(75, N'Rhönbräu Klosterbier', 12, 1, N'24 - 0.5 l bottles', 7.75, 125, 0, 25, 0),
(76, N'Lakkalikööri', 11, 1, N'500 ml bottle', 18.00, 57, 0, 20, 0),
(77, N'Original Frankfurter grüne Soße', 12, 2, N'12 boxes', 13.00, 32, 0, 15, 0);

SET IDENTITY_INSERT Products OFF;

SET IDENTITY_INSERT Orders ON;

INSERT INTO Orders
(OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight,
 ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry) VALUES
(1, N'ALFKI', 1, '1996-07-04', '1996-08-01', '1996-07-10', 1, 32.38,
 N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany'),
(2, N'ANATR', 3, '1996-07-05', '1996-08-02', '1996-07-12', 2, 11.61,
 N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico'),
(3, N'ANTON', 4, '1996-07-08', '1996-08-05', '1996-07-15', 3, 65.83,
 N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico'),
(4, N'AROUT', 2, '1996-07-09', '1996-08-06', '1996-07-18', 2, 22.98,
 N'Around the Horn', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK'),
(5, N'BERGS', 5, '1996-07-10', '1996-08-07', '1996-07-19', 1, 45.34,
 N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden'),
(6, N'BLAUS', 6, '1996-07-11', '1996-08-08', '1996-07-20', 3, 8.53,
 N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany'),
(7, N'BLONP', 7, '1996-07-12', '1996-08-09', '1996-07-22', 1, 14.01,
 N'Blondesddsl père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France'),
(8, N'BOLID', 8, '1996-07-15', '1996-08-12', '1996-07-24', 2, 97.52,
 N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain'),
(9, N'BONAP', 9, '1996-07-16', '1996-08-13', '1996-07-25', 3, 16.97,
 N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France'),
(10, N'BOTTM', 2, '1996-07-17', '1996-08-14', '1996-07-26', 1, 74.63,
 N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada'),
(11, N'BSBEV', 3, '1996-07-18', '1996-08-15', '1996-07-27', 2, 4.56,
 N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK'),
(12, N'CACTU', 4, '1996-07-19', '1996-08-16', '1996-07-29', 3, 1.85,
 N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina'),
(13, N'CENTC', 5, '1996-07-22', '1996-08-19', '1996-07-31', 1, 35.67,
 N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'México D.F.', NULL, N'05022', N'Mexico'),
(14, N'CHOPS', 6, '1996-07-23', '1996-08-20', '1996-08-01', 3, 3.04,
 N'Chop-suey Chinese', N'Hauptstr. 29', N'Bern', NULL, N'3012', N'Switzerland'),
(15, N'COMMI', 7, '1996-07-24', '1996-08-21', '1996-08-02', 2, 17.80,
 N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil'),
(16, N'ALFKI', 8, '1996-07-25', '1996-08-22', '1996-08-03', 1, 28.22,
 N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany'),
(17, N'ANATR', 9, '1996-07-26', '1996-08-23', '1996-08-05', 2, 6.90,
 N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico'),
(18, N'AROUT', 1, '1996-07-29', '1996-08-26', '1996-08-06', 3, 43.90,
 N'Around the Horn', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK'),
(19, N'BERGS', 2, '1996-07-30', '1996-08-27', '1996-08-08', 1, 12.31,
 N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden'),
(20, N'BLAUS', 3, '1996-07-31', '1996-08-28', '1996-08-09', 2, 23.19,
 N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');

SET IDENTITY_INSERT Orders OFF;

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
(1, 11, 21.00, 12, 0),
(1, 42, 14.00, 10, 0),
(1, 72, 34.80, 5, 0),

(2, 14, 23.25, 9, 0),
(2, 51, 53.00, 40, 0),
(2, 65, 21.05, 10, 0),

(3, 1, 18.00, 6, 0),
(3, 2, 19.00, 15, 0),
(3, 3, 10.00, 10, 0),
(3, 4, 22.00, 6, 0),

(4, 23, 9.00, 15, 0),
(4, 67, 14.00, 20, 0),

(5, 19, 9.20, 10, 0),
(5, 33, 2.50, 20, 0),

(6, 24, 4.50, 12, 0),
(6, 35, 18.00, 20, 0),
(6, 40, 18.40, 6, 0),

(7, 16, 17.45, 15, 0),
(7, 17, 39.00, 50, 0),
(7, 41, 9.65, 4, 0),

(8, 52, 7.00, 10, 0),

(9, 11, 21.00, 20, 0),
(9, 38, 263.50, 2, 0),

(10, 39, 18.00, 35, 0),
(10, 41, 9.65, 25, 0),
(10, 47, 9.50, 30, 0),
(10, 50, 16.25, 25, 0);

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
-- Order 11 (BSBEV)
(11, 31, 12.50, 12, 0),
(11, 33, 2.50, 25, 0),

-- Order 12 (CACTU)
(12, 21, 10.00, 20, 0),
(12, 44, 19.45, 10, 0),

-- Order 13 (CENTC)
(13, 22, 21.00, 15, 0),
(13, 57, 19.50, 40, 0),
(13, 71, 21.50, 10, 0),

-- Order 14 (CHOPS)
(14, 60, 34.00, 5, 0),
(14, 62, 49.30, 3, 0),

-- Order 15 (COMMI)
(15, 52, 7.00, 25, 0),
(15, 56, 38.00, 8, 0),

-- Order 16 (ALFKI)
(16, 15, 15.50, 10, 0),
(16, 28, 26.00, 6, 0),
(16, 73, 15.00, 12, 0),

-- Order 17 (ANATR)
(17, 5, 21.35, 3, 0),
(17, 6, 25.00, 15, 0),
(17, 7, 30.00, 10, 0),

-- Order 18 (AROUT)
(18, 34, 14.00, 24, 0),
(18, 35, 18.00, 24, 0),
(18, 67, 14.00, 12, 0),

-- Order 19 (BERGS)
(19, 47, 9.50, 20, 0),
(19, 48, 12.75, 15, 0),
(19, 68, 12.50, 10, 0),

-- Order 20 (BLAUS)
(20, 10, 31.00, 8, 0),
(20, 36, 19.00, 12, 0),
(20, 46, 12.00, 10, 0);


INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
-- Order 11 (BSBEV)
(11, 31, 12.50, 12, 0),
(11, 33, 2.50, 25, 0),

-- Order 12 (CACTU)
(12, 21, 10.00, 20, 0),
(12, 44, 19.45, 10, 0),

-- Order 13 (CENTC)
(13, 22, 21.00, 15, 0),
(13, 57, 19.50, 40, 0),
(13, 71, 21.50, 10, 0),

-- Order 14 (CHOPS)
(14, 60, 34.00, 5, 0),
(14, 62, 49.30, 3, 0),

-- Order 15 (COMMI)
(15, 52, 7.00, 25, 0),
(15, 56, 38.00, 8, 0),

-- Order 16 (ALFKI)
(16, 15, 15.50, 10, 0),
(16, 28, 26.00, 6, 0),
(16, 73, 15.00, 12, 0),

-- Order 17 (ANATR)
(17, 5, 21.35, 3, 0),
(17, 6, 25.00, 15, 0),
(17, 7, 30.00, 10, 0),

-- Order 18 (AROUT)
(18, 34, 14.00, 24, 0),
(18, 35, 18.00, 24, 0),
(18, 67, 14.00, 12, 0),

-- Order 19 (BERGS)
(19, 47, 9.50, 20, 0),
(19, 48, 12.75, 15, 0),
(19, 68, 12.50, 10, 0),

-- Order 20 (BLAUS)
(20, 10, 31.00, 8, 0),
(20, 36, 19.00, 12, 0),
(20, 46, 12.00, 10, 0);


/* 31.1 Vista: Lista alfabética de productos con categoría y proveedor */
IF OBJECT_ID('dbo.[Alphabetical list of products]', 'V') IS NOT NULL DROP VIEW dbo.[Alphabetical list of products];
GO
CREATE VIEW dbo.[Alphabetical list of products] AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS SupplierName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    p.Discontinued
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN Suppliers s  ON p.SupplierID  = s.SupplierID
ORDER BY p.ProductName;
GO

/* 31.2 Vista: Productos vigentes (no descontinuados) */
IF OBJECT_ID('dbo.[Current Product List]', 'V') IS NOT NULL DROP VIEW dbo.[Current Product List];
GO
CREATE VIEW dbo.[Current Product List] AS
SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 0;
GO

/* 31.3 Vista: Detalle extendido de órdenes (muestra total por línea) */
IF OBJECT_ID('dbo.[Order Details Extended]', 'V') IS NOT NULL DROP VIEW dbo.[Order Details Extended];
GO
CREATE VIEW dbo.[Order Details Extended] AS
SELECT 
    od.OrderID,
    od.ProductID,
    p.ProductName,
    od.UnitPrice,
    od.Quantity,
    od.Discount,
    CAST(od.UnitPrice * od.Quantity * (1 - od.Discount) AS money) AS ExtendedPrice
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID;
GO

/* 31.4 Vista: Subtotales por Orden */
IF OBJECT_ID('dbo.[Order Subtotals]', 'V') IS NOT NULL DROP VIEW dbo.[Order Subtotals];
GO
CREATE VIEW dbo.[Order Subtotals] AS
SELECT 
    od.OrderID,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS money) AS Subtotal
FROM [Order Details] od
GROUP BY od.OrderID;
GO

/* 31.5 Vista: Ventas por Categoría y Año */
IF OBJECT_ID('dbo.[Sales by Category]', 'V') IS NOT NULL DROP VIEW dbo.[Sales by Category];
GO
CREATE VIEW dbo.[Sales by Category] AS
SELECT 
    c.CategoryName,
    YEAR(o.OrderDate) AS OrderYear,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS money) AS CategorySales
FROM Categories c
JOIN Products p       ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID  = od.ProductID
JOIN Orders o           ON od.OrderID   = o.OrderID
GROUP BY c.CategoryName, YEAR(o.OrderDate);
GO

/* 31.6 Vista: Clientes y proveedores por ciudad (ejemplo de UNION) */
IF OBJECT_ID('dbo.[Customers and Suppliers by City]', 'V') IS NOT NULL DROP VIEW dbo.[Customers and Suppliers by City];
GO
CREATE VIEW dbo.[Customers and Suppliers by City] AS
SELECT 
    City,
    CompanyName,
    ContactName,
    'Customer' AS Relationship
FROM Customers
UNION ALL
SELECT 
    City,
    CompanyName,
    ContactName,
    'Supplier' AS Relationship
FROM Suppliers;

/* 32.1 SP: Detalle de una orden (similar a Northwind clásico) */
IF OBJECT_ID('dbo.CustOrdersDetail', 'P') IS NOT NULL DROP PROCEDURE dbo.CustOrdersDetail;
GO
CREATE PROCEDURE dbo.CustOrdersDetail @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        od.ProductID,
        p.ProductName,
        od.UnitPrice,
        od.Quantity,
        od.Discount,
        CAST(od.UnitPrice * od.Quantity * (1 - od.Discount) AS money) AS ExtendedPrice
    FROM [Order Details] od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = @OrderID
    ORDER BY p.ProductName;
END
GO

/* 32.2 SP: Top 10 productos más caros */
IF OBJECT_ID('dbo.[Ten Most Expensive Products]', 'P') IS NOT NULL DROP PROCEDURE dbo.[Ten Most Expensive Products];
GO
CREATE PROCEDURE dbo.[Ten Most Expensive Products]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP 10 
        ProductName, UnitPrice
    FROM Products
    WHERE Discontinued = 0
    ORDER BY UnitPrice DESC, ProductName ASC;
END
GO

/* 32.3 SP: Ventas por categoría y año */
IF OBJECT_ID('dbo.SalesByCategory', 'P') IS NOT NULL DROP PROCEDURE dbo.SalesByCategory;
GO
CREATE PROCEDURE dbo.SalesByCategory
    @CategoryName NVARCHAR(15),
    @OrdYear INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        p.ProductName,
        CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS money) AS TotalSales
    FROM Categories c
    JOIN Products p ON c.CategoryID = p.CategoryID
    JOIN [Order Details] od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE c.CategoryName = @CategoryName
      AND YEAR(o.OrderDate) = @OrdYear
    GROUP BY p.ProductName
    ORDER BY TotalSales DESC;
END
GO

/* 32.4 SP: Órdenes de un cliente (cabeceras) */
IF OBJECT_ID('dbo.CustOrdersOrders', 'P') IS NOT NULL DROP PROCEDURE dbo.CustOrdersOrders;
GO
CREATE PROCEDURE dbo.CustOrdersOrders @CustomerID NCHAR(5)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        OrderID, OrderDate, RequiredDate, ShippedDate, Freight, ShipCountry
    FROM Orders
    WHERE CustomerID = @CustomerID
    ORDER BY OrderDate DESC, OrderID DESC;
END

/* 33.1 UDF: Subtotal de una orden */
IF OBJECT_ID('dbo.ufn_OrderSubtotal', 'FN') IS NOT NULL DROP FUNCTION dbo.ufn_OrderSubtotal;
GO
CREATE FUNCTION dbo.ufn_OrderSubtotal (@OrderID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @subtotal MONEY;
    SELECT @subtotal = SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
    FROM [Order Details] od
    WHERE od.OrderID = @OrderID;

    RETURN @subtotal;
END
GO

/* 33.2 UDF: Cantidad de órdenes de un cliente */
IF OBJECT_ID('dbo.ufn_CustomerTotalOrders', 'FN') IS NOT NULL DROP FUNCTION dbo.ufn_CustomerTotalOrders;
GO
CREATE FUNCTION dbo.ufn_CustomerTotalOrders (@CustomerID NCHAR(5))
RETURNS INT
AS
BEGIN
    DECLARE @cnt INT;
    SELECT @cnt = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
    RETURN ISNULL(@cnt, 0);
END
GO

/* Limpieza previa si existieran */
IF OBJECT_ID('dbo.tr_OrderDetails_AI', 'TR') IS NOT NULL DROP TRIGGER dbo.tr_OrderDetails_AI;
IF OBJECT_ID('dbo.tr_OrderDetails_AD', 'TR') IS NOT NULL DROP TRIGGER dbo.tr_OrderDetails_AD;
IF OBJECT_ID('dbo.tr_OrderDetails_AU', 'TR') IS NOT NULL DROP TRIGGER dbo.tr_OrderDetails_AU;
GO

/* 34.1 AFTER INSERT: descuenta stock */
CREATE TRIGGER dbo.tr_OrderDetails_AI
ON dbo.[Order Details]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE p
    SET p.UnitsInStock = p.UnitsInStock - i.Quantity
    FROM Products p
    JOIN inserted i ON p.ProductID = i.ProductID;
END
GO

/* 34.2 AFTER DELETE: devuelve stock */
CREATE TRIGGER dbo.tr_OrderDetails_AD
ON dbo.[Order Details]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE p
    SET p.UnitsInStock = p.UnitsInStock + d.Quantity
    FROM Products p
    JOIN deleted d ON p.ProductID = d.ProductID;
END
GO

/* 34.3 AFTER UPDATE: aplica delta de Quantity */
CREATE TRIGGER dbo.tr_OrderDetails_AU
ON dbo.[Order Details]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    /* Solo si cambió Quantity o ProductID */
    IF (UPDATE(Quantity) OR UPDATE(ProductID))
    BEGIN
        -- Reponer cantidades antiguas (deleted)
        UPDATE p
        SET p.UnitsInStock = p.UnitsInStock + d.Quantity
        FROM Products p
        JOIN deleted d ON p.ProductID = d.ProductID;

        -- Descontar cantidades nuevas (inserted)
        UPDATE p
        SET p.UnitsInStock = p.UnitsInStock - i.Quantity
        FROM Products p
        JOIN inserted i ON p.ProductID = i.ProductID;
    END
END


SELECT 
    c.CategoryName,
    YEAR(o.OrderDate) AS OrderYear,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS money) AS TotalSales
FROM Categories c
JOIN Products p       ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID  = od.ProductID
JOIN Orders o           ON od.OrderID   = o.OrderID
GROUP BY c.CategoryName, YEAR(o.OrderDate)
ORDER BY OrderYear, TotalSales DESC;


-- 1?? Productos con su categoría y proveedor
SELECT 
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS Supplier
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- 2?? Total de ventas por categoría
SELECT 
    c.CategoryName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY TotalSales DESC;
SELECT 
    c.CompanyName AS Cliente,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Total_Ventas
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY Total_Ventas DESC;

SELECT 
    c.CategoryName AS Categoria,
    ROUND(AVG(p.UnitPrice), 2) AS Precio_Promedio
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY Precio_Promedio DESC;

SELECT TOP 5 
    p.ProductName AS Producto,
    SUM(od.Quantity) AS Total_Unidades_Vendidas
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total_Unidades_Vendidas DESC;

SELECT 
    e.FirstName + ' ' + e.LastName AS Empleado,
    COUNT(o.OrderID) AS Total_Ordenes
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY Total_Ordenes DESC;

SELECT 
    o.ShipCountry AS Pais,
    CAST(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS MONEY) AS Total_Ventas
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY Total_Ventas DESC;














































