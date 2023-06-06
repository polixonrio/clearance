CREATE DATABASE  IF NOT EXISTS `clearance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clearance`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: clearance
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminusers`
--

DROP TABLE IF EXISTS `adminusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminusers` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminusers`
--

LOCK TABLES `adminusers` WRITE;
/*!40000 ALTER TABLE `adminusers` DISABLE KEYS */;
INSERT INTO `adminusers` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `adminusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
INSERT INTO `alumni` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hod`
--

DROP TABLE IF EXISTS `hod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hod` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hod`
--

LOCK TABLES `hod` WRITE;
/*!40000 ALTER TABLE `hod` DISABLE KEYS */;
INSERT INTO `hod` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `hod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internship`
--

DROP TABLE IF EXISTS `internship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internship` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internship`
--

LOCK TABLES `internship` WRITE;
/*!40000 ALTER TABLE `internship` DISABLE KEYS */;
INSERT INTO `internship` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `internship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library`
--

LOCK TABLES `library` WRITE;
/*!40000 ALTER TABLE `library` DISABLE KEYS */;
INSERT INTO `library` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (1,'1',0),(2,'2',1),(3,'3',0),(4,'4',0);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Roll_Number` int NOT NULL,
  `Branch` varchar(255) NOT NULL,
  `Course` varchar(255) NOT NULL,
  `Semester` varchar(255) NOT NULL,
  `Section` varchar(255) NOT NULL,
  `Session` varchar(255) NOT NULL,
  `Year` int NOT NULL,
  `Mobile_Number` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Accounts_Verified` tinyint(1) NOT NULL DEFAULT '0',
  `Library_Verified` tinyint(1) NOT NULL DEFAULT '0',
  `Training_And_Placement Verified` tinyint(1) NOT NULL DEFAULT '0',
  `Alumni_Cell_Verified` tinyint(1) NOT NULL DEFAULT '0',
  `Project_Verified` tinyint(1) NOT NULL DEFAULT '0',
  `Internship_Verified` tinyint(1) NOT NULL DEFAULT '0',
  `HOD_Verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `accounts` (`Accounts_Verified`),
  KEY `alumni` (`Alumni_Cell_Verified`),
  KEY `hod` (`HOD_Verified`),
  KEY `internship` (`Internship_Verified`),
  KEY `library` (`Library_Verified`),
  KEY `project` (`Project_Verified`),
  KEY `trainingandplacement` (`Training_And_Placement Verified`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'1','John Smith',123456789,'Computer Science','B.Tech','2','A','2022',2023,'555-1234','1@lol.com',0,0,0,0,0,0,0),(2,'2','Jane Doe',234567890,'Electrical Engineering','B.Tech','4','B','2021',2022,'555-5678','2@lol.com',1,1,1,1,1,1,1),(3,'3','Robert Johnson',345678901,'Civil Engineering','M.Tech','6','C','2020',2021,'555-9876','3@lol.com',0,0,1,0,0,0,0),(4,'4','Sarah Lee',456789012,'Finance','MBA','8','D','2019',2020,'555-4321','4lol@lol.com',0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentusers`
--

DROP TABLE IF EXISTS `studentusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentusers` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentusers`
--

LOCK TABLES `studentusers` WRITE;
/*!40000 ALTER TABLE `studentusers` DISABLE KEYS */;
INSERT INTO `studentusers` VALUES (1,'1@lol.com','1'),(2,'2@lol.com','2'),(3,'3@lol.com','3'),(4,'4lol@lol.com','4');
/*!40000 ALTER TABLE `studentusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainingandplacement`
--

DROP TABLE IF EXISTS `trainingandplacement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainingandplacement` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `Verification` (`Verification`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainingandplacement`
--

LOCK TABLES `trainingandplacement` WRITE;
/*!40000 ALTER TABLE `trainingandplacement` DISABLE KEYS */;
INSERT INTO `trainingandplacement` VALUES (1,'1',0),(2,'2',1),(3,'3',1),(4,'4',0);
/*!40000 ALTER TABLE `trainingandplacement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload`
--

DROP TABLE IF EXISTS `upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upload` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Registration_Number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Roll_Number` int NOT NULL,
  `Branch` varchar(255) NOT NULL,
  `Course` varchar(255) NOT NULL,
  `Semester` varchar(255) NOT NULL,
  `Section` varchar(255) NOT NULL,
  `Session` varchar(255) NOT NULL,
  `Year` int NOT NULL,
  `Mobile_Number` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload`
--

LOCK TABLES `upload` WRITE;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
INSERT INTO `upload` VALUES (1,'1','John Smith',123456789,'Computer Science','B.Tech','2','A','2022',2023,'555-1234','1@lol.com'),(2,'2','Jane Doe',234567890,'Electrical Engineering','B.Tech','4','B','2021',2022,'555-5678','2@lol.com'),(3,'3','Robert Johnson',345678901,'Civil Engineering','M.Tech','6','C','2020',2021,'555-9876','3@lol.com'),(4,'4','Sarah Lee',456789012,'Finance','MBA','8','D','2019',2020,'555-4321','4lol@lol.com');
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `access_rights` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_tablename` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'librarylol','library441','ID, Registration_Number, Name, Roll_Number,Branch,Course,Semester,Section,Session,Year,Mobile_Number,Library_Verified','library'),(2,'ac1','ac1','ID,Registration_Number,Name,Roll_Number,Branch,Course,Semester,Section,Session,Year,Mobile_Number,Accounts_Verified','accounts');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-06 10:22:53
