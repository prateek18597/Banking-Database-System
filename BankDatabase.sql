-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: Bank
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Acc`
--

DROP TABLE IF EXISTS `Acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Acc` (
  `AccountNo` int(15) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(40) NOT NULL,
  `LastName` varchar(40) NOT NULL,
  `DOB` date NOT NULL,
  `Address` varchar(200) NOT NULL,
  `MobNo` varchar(15) NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `Balance` int(11) NOT NULL DEFAULT '0',
  `DoC` date NOT NULL,
  `Branch` varchar(10) NOT NULL,
  `Type` enum('Current','Saving') DEFAULT 'Current',
  PRIMARY KEY (`AccountNo`),
  KEY `Branch` (`Branch`),
  KEY `Type` (`Type`),
  CONSTRAINT `Acc_ibfk_1` FOREIGN KEY (`Branch`) REFERENCES `Bank` (`BranchCode`),
  CONSTRAINT `Acc_ibfk_2` FOREIGN KEY (`Type`) REFERENCES `AccountType` (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Acc`
--

LOCK TABLES `Acc` WRITE;
/*!40000 ALTER TABLE `Acc` DISABLE KEYS */;
/*!40000 ALTER TABLE `Acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `AccountNo` int(15) NOT NULL AUTO_INCREMENT,
  `Balance` int(11) NOT NULL DEFAULT '0',
  `DoC` date NOT NULL,
  `Branch` varchar(10) NOT NULL,
  `Type` enum('Current','Saving') DEFAULT 'Current',
  `CustomerId` int(11) NOT NULL,
  PRIMARY KEY (`AccountNo`),
  KEY `Branch` (`Branch`),
  KEY `Type` (`Type`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `Account_ibfk_1` FOREIGN KEY (`Branch`) REFERENCES `Bank` (`BranchCode`),
  CONSTRAINT `Account_ibfk_2` FOREIGN KEY (`Type`) REFERENCES `AccountType` (`Type`),
  CONSTRAINT `Account_ibfk_3` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1234500004 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES (1234500002,1633,'2019-04-25','12345','Current',3),(1234500003,67,'2019-04-25','12345','Saving',4);
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AccountType`
--

DROP TABLE IF EXISTS `AccountType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountType` (
  `Type` enum('Current','Saving') NOT NULL,
  `Interest` decimal(5,2) NOT NULL,
  PRIMARY KEY (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AccountType`
--

LOCK TABLES `AccountType` WRITE;
/*!40000 ALTER TABLE `AccountType` DISABLE KEYS */;
INSERT INTO `AccountType` VALUES ('Current',1.50),('Saving',2.50);
/*!40000 ALTER TABLE `AccountType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bank`
--

DROP TABLE IF EXISTS `Bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bank` (
  `BranchCode` varchar(10) NOT NULL,
  `Location` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`BranchCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bank`
--

LOCK TABLES `Bank` WRITE;
/*!40000 ALTER TABLE `Bank` DISABLE KEYS */;
INSERT INTO `Bank` VALUES ('12345','IIT Jammu','123456');
/*!40000 ALTER TABLE `Bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Beneficiary`
--

DROP TABLE IF EXISTS `Beneficiary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Beneficiary` (
  `AccountNo` int(15) NOT NULL,
  `BeneAccount` int(15) NOT NULL,
  PRIMARY KEY (`AccountNo`,`BeneAccount`),
  KEY `BeneAccount` (`BeneAccount`),
  CONSTRAINT `Beneficiary_ibfk_1` FOREIGN KEY (`AccountNo`) REFERENCES `Account` (`AccountNo`),
  CONSTRAINT `Beneficiary_ibfk_2` FOREIGN KEY (`BeneAccount`) REFERENCES `Account` (`AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Beneficiary`
--

LOCK TABLES `Beneficiary` WRITE;
/*!40000 ALTER TABLE `Beneficiary` DISABLE KEYS */;
INSERT INTO `Beneficiary` VALUES (1234500003,1234500002);
/*!40000 ALTER TABLE `Beneficiary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(40) NOT NULL,
  `LastName` varchar(40) NOT NULL,
  `DOB` date NOT NULL,
  `Address` varchar(200) NOT NULL,
  `MobNo` varchar(15) NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `MobNo` (`MobNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (3,'Yash','Parmar','2000-07-15','Goa','7000311028','Male'),(4,'Pratik','Parmar','1997-05-18','Jammu','7780813063','Male');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employee` (
  `EmpId` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(40) NOT NULL,
  `LastName` varchar(40) NOT NULL,
  `MobNo` varchar(15) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `DoB` date NOT NULL,
  PRIMARY KEY (`EmpId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (2,'Tabish','Shaikh','7780856496','Pune','1998-07-02');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Loan`
--

DROP TABLE IF EXISTS `Loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Loan` (
  `LoanId` int(11) NOT NULL AUTO_INCREMENT,
  `AccountNo` int(15) NOT NULL,
  `LoanAmount` int(11) NOT NULL,
  `Paid` int(11) NOT NULL,
  `Status` enum('Request','Approve','Complete','Reject') NOT NULL DEFAULT 'Request',
  `Type` enum('Personal','Home','Vehicle','Business','Other') NOT NULL DEFAULT 'Personal',
  PRIMARY KEY (`LoanId`),
  KEY `AccountNo` (`AccountNo`),
  CONSTRAINT `Loan_ibfk_1` FOREIGN KEY (`AccountNo`) REFERENCES `Account` (`AccountNo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Loan`
--

LOCK TABLES `Loan` WRITE;
/*!40000 ALTER TABLE `Loan` DISABLE KEYS */;
INSERT INTO `Loan` VALUES (1,1234500003,50000,11300,'Approve','Personal');
/*!40000 ALTER TABLE `Loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `LoanAccount`
--

DROP TABLE IF EXISTS `LoanAccount`;
/*!50001 DROP VIEW IF EXISTS `LoanAccount`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `LoanAccount` AS SELECT 
 1 AS `AccountNo`,
 1 AS `Balance`,
 1 AS `LoanAmount`,
 1 AS `Paid`,
 1 AS `LoanId`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `LoanLog`
--

DROP TABLE IF EXISTS `LoanLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LoanLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `LoanId` int(11) NOT NULL,
  `Time` datetime NOT NULL,
  `AmountPaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `LoanId` (`LoanId`),
  CONSTRAINT `LoanLog_ibfk_1` FOREIGN KEY (`LoanId`) REFERENCES `Loan` (`LoanId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LoanLog`
--

LOCK TABLES `LoanLog` WRITE;
/*!40000 ALTER TABLE `LoanLog` DISABLE KEYS */;
INSERT INTO `LoanLog` VALUES (1,1,'2019-05-05 03:59:20',1000),(3,1,'2019-05-05 04:15:09',300);
/*!40000 ALTER TABLE `LoanLog` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 Trigger PayLoan
After INSERT on LoanLog
For Each Row
Update Loan
Set Paid=Paid+new.AmountPaid
where LoanId=new.LoanId */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 Trigger DeductBalanceLoan After Insert on LoanLog For Each Row Update LoanAccount Set Balance=Balance-new.AmountPaid where LoanAccount.LoanId=new.LoanId */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Netbanking`
--

DROP TABLE IF EXISTS `Netbanking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Netbanking` (
  `UserId` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `TransactionPassword` varchar(20) NOT NULL,
  `AccountNo` int(15) DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `Role` enum('Customer','Employee') NOT NULL,
  PRIMARY KEY (`UserId`),
  KEY `AccountNo` (`AccountNo`),
  CONSTRAINT `Netbanking_ibfk_1` FOREIGN KEY (`AccountNo`) REFERENCES `Account` (`AccountNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Netbanking`
--

LOCK TABLES `Netbanking` WRITE;
/*!40000 ALTER TABLE `Netbanking` DISABLE KEYS */;
INSERT INTO `Netbanking` VALUES ('pratik18597','1111','1234',1234500003,'2019-05-05 06:17:36','Customer');
/*!40000 ALTER TABLE `Netbanking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transaction` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FromAcc` int(15) NOT NULL,
  `ToAcc` int(15) NOT NULL,
  `Time` datetime NOT NULL,
  `Amount` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `FromAcc` (`FromAcc`),
  KEY `ToAcc` (`ToAcc`),
  CONSTRAINT `Transaction_ibfk_1` FOREIGN KEY (`FromAcc`) REFERENCES `Account` (`AccountNo`),
  CONSTRAINT `Transaction_ibfk_2` FOREIGN KEY (`ToAcc`) REFERENCES `Account` (`AccountNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (1,1234500003,1234500002,'2019-05-04 20:55:46',300),(2,1234500003,1234500002,'2019-05-04 20:58:26',100),(3,1234500003,1234500002,'2019-05-04 20:58:33',100),(4,1234500003,1234500002,'2019-05-04 21:05:26',133);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `LoanAccount`
--

/*!50001 DROP VIEW IF EXISTS `LoanAccount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LoanAccount` AS select `Account`.`AccountNo` AS `AccountNo`,`Account`.`Balance` AS `Balance`,`Loan`.`LoanAmount` AS `LoanAmount`,`Loan`.`Paid` AS `Paid`,`Loan`.`LoanId` AS `LoanId` from (`Loan` join `Account`) where (`Account`.`AccountNo` = `Loan`.`AccountNo`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-05  6:18:25
