# Bussines Model Project SQL DAW 2024 
## Sergi Martinez y Enrrique Ferrer
### Introduction
Our work consists of a relational model that will encompass all work information. Later we will make the "inserts" corresponding to the tables of the previously made model and later we will make the transactions, the users and their respective permissions as the work script requests. For our part, we will put some queries to consult certain information in addition to some functions that allow us, for example; add an extra “QuoteLineItems”.


### Relational Model

To start, here we have the relational model. We believe that the first thing of all has to be done to be clear about the approach to the work.

When the tables are many-to-many, we add an auxiliary table to solve this problem, since it is provided by the relational model.
In this case; ContractLineItems, QuoteLineItems and ReservationLineItems are examples of that.



## Creation of tables in the database

-- Clients table
CREATE TABLE Clients (
ID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(150) NOT NULL,
IBAN VARCHAR(50)
);

-- Products table
CREATE TABLE Products (
ID INT PRIMARY KEY AUTO_INCREMENT,
ProductType VARCHAR(50) NOT NULL,
ProductName VARCHAR(255) NOT NULL,
Price DECIMAL(10, 2) NOT NULL
);


-- Quotes table
CREATE TABLE Quotes (
ID INT PRIMARY KEY AUTO_INCREMENT,
ClientID INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
FOREIGN KEY (ClientID) REFERENCES Clients(ID)
);

-- QuoteLineItems table
CREATE TABLE QuoteLineItems (
ID INT PRIMARY KEY AUTO_INCREMENT,
QuoteID INT NOT NULL,
ProductID INT NOT NULL,
ProductPrice DECIMAL(10, 2),
FinalPrice DECIMAL(10, 2),
FOREIGN KEY (QuoteID) REFERENCES Quotes(ID),
FOREIGN KEY (ProductID) REFERENCES Products(ID)
);

-- Contracts table
CREATE TABLE Contracts (
ID INT PRIMARY KEY AUTO_INCREMENT,
QuoteID INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalPrice DECIMAL(10, 2),
TotalMonthlyPrice DECIMAL(10, 2),
FOREIGN KEY (QuoteID) REFERENCES Quotes(ID)
);

-- ContractLineItems table
CREATE TABLE ContractLineItems (
ID INT PRIMARY KEY AUTO_INCREMENT,
ContractID INT NOT NULL,
ProductID INT NOT NULL,
QuoteLineID INT NOT NULL,
ProductPrice DECIMAL(10, 2),
FOREIGN KEY (ContractID) REFERENCES Contracts(ID),
FOREIGN KEY (ProductID) REFERENCES Products(ID),
FOREIGN KEY (QuoteLineID) REFERENCES QuoteLineItems(ID)
);


-- Reservation table
CREATE TABLE Reservations (
ID INT PRIMARY KEY AUTO_INCREMENT,
ClientID INT NOT NULL,
StartTime TIME NOT NULL,
EndTime TIME NOT NULL,
FOREIGN KEY (ClientID) REFERENCES Clients(ID)
);


-- ReservationLineItems Table
CREATE TABLE ReservationLineItems (
ID INT PRIMARY KEY AUTO_INCREMENT,
ReservationID INT NOT NULL,
ProductID INT NOT NULL,
ClientID INT NOT NULL,
ProductPrice DECIMAL(10, 2),
FinalPrice DECIMAL(10, 2),
FOREIGN KEY (ReservationID) REFERENCES Reservations(ID),
FOREIGN KEY (ProductID) REFERENCES Products(ID),
FOREIGN KEY (ClientID) REFERENCES Clients(ID)
);



### Inserts of the information to tables in the database

-- Clients Inserts
INSERT INTO Clients (Name, IBAN) VALUES
('John Doe', 'ES6621000418401234567891'),
('Jane Smith', 'GB29NWBK60161331926819'),
('Alice Johnson', 'FR1420041010050500013');

-- Products Inserts
INSERT INTO Products (ProductType, ProductName, Price) VALUES
('Electronics', 'Laptop', 999.99),
('Clothing', 'T-shirt', 19.99),
('Books', 'Novel', 12.50);

-- Quote Inserts
INSERT INTO Quotes (ClientID, StartDate, EndDate) VALUES
(1, '2024-04-01', '2024-04-15'),
(2, '2024-04-05', '2024-04-20'),
(3, '2024-04-10', '2024-04-25');

-- QuoteLineItems Inserts
INSERT INTO QuoteLineItems (QuoteID, ProductID, ProductPrice, FinalPrice) VALUES
(1, 1, 999.99, 999.99),
(2, 2, 19.99, 19.99),
(3, 3, 12.50, 12.50);

-- Contracts Inserts
INSERT INTO Contracts (QuoteID, StartDate, EndDate, TotalPrice, TotalMonthlyPrice) VALUES
(1, '2024-04-01', '2024-04-15', 999.99, 499.99),
(2, '2024-04-05', '2024-04-20', 19.99, 19.99),
(3, '2024-04-10', '2024-04-25', 12.50, 12.50);

-- ContractLineItems Inserts
INSERT INTO ContractLineItems (ContractID, ProductID, QuoteLineID, ProductPrice) VALUES
(1, 1, 1, 999.99),
(2, 2, 2, 19.99),
(3, 3, 3, 12.50);

-- Reservations Inserts
INSERT INTO Reservations (ClientID, StartTime, EndTime) VALUES
(1, '10:00:00', '12:00:00'),
(2, '14:00:00', '16:00:00'),
(3, '09:00:00', '11:00:00');

-- ReservationLineItems Inserts
INSERT INTO ReservationLineItems (ReservationID, ProductID, ClientID, ProductPrice, FinalPrice) VALUES
(1, 1, 1, 999.99, 999.99),
(2, 2, 2, 19.99, 19.99),
(3, 3, 3, 12.50, 12.50);


## Use Cases

### Use Case 1: Get all reservations for a specific customer

SELECT Reservations.*, Clients.Name AS ClientName
FROM Reservations
JOIN Clients ON Reservations.ClientID = Clients.ID
WHERE Clients.ID = [client ID];

### Use Case 2: Calculate the total price of a contract
SELECT SUM(ContractLineItems.ProductPrice) AS TotalPrice
FROM ContractLineItems
JOIN Products ON ContractLineItems.ProductID = Products.ID
WHERE ContractLineItems.ContractID = [contract ID];

### Use Case 3: Get all contract lines associated with a specific product
SELECT ContractLineItems.*, Products.ProductName
FROM ContractLineItems
JOIN Products ON ContractLineItems.ProductID = Products.ID
WHERE ContractLineItems.ProductID = [product ID];

### Use Case 4: Get all contract lines associated with a specific customer, including product details

SELECT ContractLineItems.*, Products.ProductName
FROM ContractLineItems
JOIN Products ON ContractLineItems.ProductID = Products.ID
JOIN Contracts ON ContractLineItems.ContractID = Contracts.ID
WHERE Contracts.ClientID = [Client ID];
Procedure

This stored procedure called calculateFinalPrice aims to calculate the final price and the total monthly price for each quote in the Quotes table based on the final prices of the products in the QuoteLineItems table.

I wanted to add a procedure to give a little more complicity to the database, instead of making a trigger, which has a slightly more controversial use, I wanted to put a procedure for the case.

## Transactions

### 1.Add new clients

START TRANSACTION;
INSERT INTO Clients (Name, IBAN) VALUES ('Nombre del Cliente', 'IBAN del Cliente');
COMMIT;

### 2.Create quote for a Client

START TRANSACTION;
INSERT INTO Quotes (ClientID, StartDate, EndDate) VALUES (Client_ID, 'StartDate', 'EndDate');
COMMIT;

### 3.Add items to a quote:

START TRANSACTION;
INSERT INTO QuoteLineItems (QuoteID, ProductID, ProductPrice, FinalPrice) VALUES (Quote_ID, Product_ID, ProductPrice, FinalPrice);
COMMIT;

### 4.Create a contract based on a quote:

START TRANSACTION;
INSERT INTO Contracts (QuoteID, StartDate, EndDate, TotalPrice, TotalMonthlyPrice) VALUES (Quote_ID, 'StartDate', 'EndDate', TotalPrice, TotalMonthlyPrice);
COMMIT;

### 5.Add items to a contract:

START TRANSACTION;
INSERT INTO ContractLineItems (ContractID, ProductID, QuoteLineID, ProductPrice) VALUES (Contract_ID, Product_ID, QuoteLine_ID, ProductPrice);
COMMIT;

### 6.Create a reservation for a client:

START TRANSACTION;
INSERT INTO Reservations (ClientID, StartTime, EndTime) VALUES (Client_ID, 'StartTime', 'EndTime');
COMMIT;

### 7.Add Items to a reservation.

START TRANSACTION;
INSERT INTO ReservationLineItems (ReservationID, ProductID, ClientID, ProductPrice, FinalPrice) VALUES (Reservation_ID, Product_ID, Client_ID, ProductPrice, FinalPrice);
COMMIT;

## Users and permissions

After defining these transactions, we can proceed to create users and assign them permissions. Here's an example of how you could do it:

-- Create user
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.* TO 'username'@'localhost';


















