-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.11.6-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for sqlproyectenrser
CREATE DATABASE IF NOT EXISTS `sqlproyectenrser` /*!40100 DEFAULT CHARACTER SET utf16 COLLATE utf16_spanish_ci */;
USE `sqlproyectenrser`;

-- Dumping structure for table sqlproyectenrser.clients
CREATE TABLE IF NOT EXISTS `clients` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `IBAN` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.clients: ~3 rows (approximately)
INSERT INTO `clients` (`ID`, `Name`, `IBAN`) VALUES
	(1, 'John Doe', 'ES6621000418401234567891'),
	(2, 'Jane Smith', 'GB29NWBK60161331926819'),
	(3, 'Alice Johnson', 'FR1420041010050500013');

-- Dumping structure for table sqlproyectenrser.contractlineitems
CREATE TABLE IF NOT EXISTS `contractlineitems` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ContractID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `QuoteLineID` int(11) NOT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ContractID` (`ContractID`),
  KEY `ProductID` (`ProductID`),
  KEY `QuoteLineID` (`QuoteLineID`),
  CONSTRAINT `contractlineitems_ibfk_1` FOREIGN KEY (`ContractID`) REFERENCES `contracts` (`ID`),
  CONSTRAINT `contractlineitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ID`),
  CONSTRAINT `contractlineitems_ibfk_3` FOREIGN KEY (`QuoteLineID`) REFERENCES `quotelineitems` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.contractlineitems: ~3 rows (approximately)
INSERT INTO `contractlineitems` (`ID`, `ContractID`, `ProductID`, `QuoteLineID`, `ProductPrice`) VALUES
	(1, 1, 1, 1, 999.99),
	(2, 2, 2, 2, 19.99),
	(3, 3, 3, 3, 12.50);

-- Dumping structure for table sqlproyectenrser.contracts
CREATE TABLE IF NOT EXISTS `contracts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `QuoteID` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `TotalMonthlyPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `QuoteID` (`QuoteID`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`QuoteID`) REFERENCES `quotes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.contracts: ~3 rows (approximately)
INSERT INTO `contracts` (`ID`, `QuoteID`, `StartDate`, `EndDate`, `TotalPrice`, `TotalMonthlyPrice`) VALUES
	(1, 1, '2024-04-01', '2024-04-15', 999.99, 499.99),
	(2, 2, '2024-04-05', '2024-04-20', 19.99, 19.99),
	(3, 3, '2024-04-10', '2024-04-25', 12.50, 12.50);

-- Dumping structure for table sqlproyectenrser.invoicelineitems
CREATE TABLE IF NOT EXISTS `invoicelineitems` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `ReservationLineID` int(11) DEFAULT NULL,
  `ContractLineID` int(11) DEFAULT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  `FinalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ProductID` (`ProductID`),
  KEY `ReservationLineID` (`ReservationLineID`),
  KEY `ContractLineID` (`ContractLineID`),
  CONSTRAINT `invoicelineitems_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ID`),
  CONSTRAINT `invoicelineitems_ibfk_2` FOREIGN KEY (`ReservationLineID`) REFERENCES `reservationlineitems` (`ID`),
  CONSTRAINT `invoicelineitems_ibfk_3` FOREIGN KEY (`ContractLineID`) REFERENCES `contractlineitems` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.invoicelineitems: ~0 rows (approximately)

-- Dumping structure for table sqlproyectenrser.products
CREATE TABLE IF NOT EXISTS `products` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductType` varchar(50) NOT NULL,
  `ProductName` varchar(255) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.products: ~3 rows (approximately)
INSERT INTO `products` (`ID`, `ProductType`, `ProductName`, `Price`) VALUES
	(1, 'Electronics', 'Laptop', 999.99),
	(2, 'Clothing', 'T-shirt', 19.99),
	(3, 'Books', 'Novel', 12.50);

-- Dumping structure for table sqlproyectenrser.quotelineitems
CREATE TABLE IF NOT EXISTS `quotelineitems` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `QuoteID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  `FinalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `QuoteID` (`QuoteID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `quotelineitems_ibfk_1` FOREIGN KEY (`QuoteID`) REFERENCES `quotes` (`ID`),
  CONSTRAINT `quotelineitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.quotelineitems: ~3 rows (approximately)
INSERT INTO `quotelineitems` (`ID`, `QuoteID`, `ProductID`, `ProductPrice`, `FinalPrice`) VALUES
	(1, 1, 1, 999.99, 999.99),
	(2, 2, 2, 19.99, 19.99),
	(3, 3, 3, 12.50, 12.50);

-- Dumping structure for table sqlproyectenrser.quotes
CREATE TABLE IF NOT EXISTS `quotes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientID` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ClientID` (`ClientID`),
  CONSTRAINT `quotes_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.quotes: ~3 rows (approximately)
INSERT INTO `quotes` (`ID`, `ClientID`, `StartDate`, `EndDate`) VALUES
	(1, 1, '2024-04-01', '2024-04-15'),
	(2, 2, '2024-04-05', '2024-04-20'),
	(3, 3, '2024-04-10', '2024-04-25');

-- Dumping structure for table sqlproyectenrser.reservationlineitems
CREATE TABLE IF NOT EXISTS `reservationlineitems` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ReservationID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `ProductPrice` decimal(10,2) DEFAULT NULL,
  `FinalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ReservationID` (`ReservationID`),
  KEY `ProductID` (`ProductID`),
  KEY `ClientID` (`ClientID`),
  CONSTRAINT `reservationlineitems_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`ID`),
  CONSTRAINT `reservationlineitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ID`),
  CONSTRAINT `reservationlineitems_ibfk_3` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.reservationlineitems: ~3 rows (approximately)
INSERT INTO `reservationlineitems` (`ID`, `ReservationID`, `ProductID`, `ClientID`, `ProductPrice`, `FinalPrice`) VALUES
	(1, 1, 1, 1, 999.99, 999.99),
	(2, 2, 2, 2, 19.99, 19.99),
	(3, 3, 3, 3, 12.50, 12.50);

-- Dumping structure for table sqlproyectenrser.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClientID` int(11) NOT NULL,
  `StartTime` time NOT NULL,
  `EndTime` time NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ClientID` (`ClientID`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `clients` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table sqlproyectenrser.reservations: ~3 rows (approximately)
INSERT INTO `reservations` (`ID`, `ClientID`, `StartTime`, `EndTime`) VALUES
	(1, 1, '10:00:00', '12:00:00'),
	(2, 2, '14:00:00', '16:00:00'),
	(3, 3, '09:00:00', '11:00:00');

-- Dumping structure for procedure sqlproyectenrser.calculateFinalPrice
DELIMITER //
CREATE PROCEDURE `calculateFinalPrice`()
BEGIN
	DECLARE QuoteID INT;
	DECLARE errores INT DEFAULT FALSE; 
	DECLARE finalProductPrice DECIMAL(10,2);
	
	DECLARE cur_quoteID CURSOR FOR 
		SELECT QuoteID, SUM(IF (FinalPrice IS NULL,ProductPrice,FinalPrice)) AS Total  
		GROUP BY QuoteID;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET errores = TRUE; 
	
	OPEN cur_quoteID;
	
	loop_quotes : LOOP
		FETCH cur_quoteID INTO QuoteID, finalProductPrice; 
		IF errores THEN
			LEAVE loop_quotes;
		END IF;	
		UPDATE quotes 
		SET FinalPrice = finalProductPrice, TotalMonthlyPrice = finalProductPrice / 12
		WHERE ID = QuoteID;
	END LOOP;
	CLOSE cur_quoteID;
END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
