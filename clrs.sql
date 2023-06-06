-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 06, 2023 at 04:56 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clearance`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `accounts`
--
DELIMITER $$
CREATE TRIGGER `update_verification_trigger` AFTER UPDATE ON `accounts` FOR EACH ROW BEGIN
  UPDATE students
  SET Accounts_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adminusers`
--

CREATE TABLE `adminusers` (
  `ID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `adminusers`
--

INSERT INTO `adminusers` (`ID`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `alumni`
--

CREATE TABLE `alumni` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `alumni`
--

INSERT INTO `alumni` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `alumni`
--
DELIMITER $$
CREATE TRIGGER `alumni_update_verification_trigger` AFTER UPDATE ON `alumni` FOR EACH ROW BEGIN
  UPDATE students
  SET Alumni_Cell_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hod`
--

CREATE TABLE `hod` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hod`
--

INSERT INTO `hod` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `hod`
--
DELIMITER $$
CREATE TRIGGER `hod_update_verification_trigger` AFTER UPDATE ON `hod` FOR EACH ROW BEGIN
  UPDATE students
  SET HOD_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `internship`
--

CREATE TABLE `internship` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `internship`
--

INSERT INTO `internship` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `internship`
--
DELIMITER $$
CREATE TRIGGER `alumni_update` AFTER UPDATE ON `internship` FOR EACH ROW BEGIN
  UPDATE students
  SET Alumni_Cell_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE `library` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `library`
--

INSERT INTO `library` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `library`
--
DELIMITER $$
CREATE TRIGGER `library_update` AFTER UPDATE ON `library` FOR EACH ROW BEGIN
  UPDATE students
  SET Library_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 0),
(4, '4', 0);

--
-- Triggers `project`
--
DELIMITER $$
CREATE TRIGGER `update_project` AFTER UPDATE ON `project` FOR EACH ROW BEGIN
  UPDATE students
  SET Project_Verified = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `ID` int NOT NULL,
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
  `HOD_Verified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`ID`, `Registration_Number`, `Name`, `Roll_Number`, `Branch`, `Course`, `Semester`, `Section`, `Session`, `Year`, `Mobile_Number`, `Email`, `Accounts_Verified`, `Library_Verified`, `Training_And_Placement Verified`, `Alumni_Cell_Verified`, `Project_Verified`, `Internship_Verified`, `HOD_Verified`) VALUES
(1, '1', 'John Smith', 123456789, 'Computer Science', 'B.Tech', '2', 'A', '2022', 2023, '555-1234', '1@lol.com', 0, 0, 0, 0, 0, 0, 0),
(2, '2', 'Jane Doe', 234567890, 'Electrical Engineering', 'B.Tech', '4', 'B', '2021', 2022, '555-5678', '2@lol.com', 1, 1, 1, 1, 1, 1, 1),
(3, '3', 'Robert Johnson', 345678901, 'Civil Engineering', 'M.Tech', '6', 'C', '2020', 2021, '555-9876', '3@lol.com', 0, 0, 1, 0, 0, 0, 0),
(4, '4', 'Sarah Lee', 456789012, 'Finance', 'MBA', '8', 'D', '2019', 2020, '555-4321', '4lol@lol.com', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `studentusers`
--

CREATE TABLE `studentusers` (
  `ID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `studentusers`
--

INSERT INTO `studentusers` (`ID`, `username`, `password`) VALUES
(1, '1@lol.com', '1'),
(2, '2@lol.com', '2'),
(3, '3@lol.com', '3'),
(4, '4lol@lol.com', '4');

-- --------------------------------------------------------

--
-- Table structure for table `trainingandplacement`
--

CREATE TABLE `trainingandplacement` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `trainingandplacement`
--

INSERT INTO `trainingandplacement` (`ID`, `Registration_Number`, `Verification`) VALUES
(1, '1', 0),
(2, '2', 1),
(3, '3', 1),
(4, '4', 0);

--
-- Triggers `trainingandplacement`
--
DELIMITER $$
CREATE TRIGGER `tnp_update` AFTER UPDATE ON `trainingandplacement` FOR EACH ROW BEGIN
  UPDATE students
  SET `Training_And_Placement Verified` = NEW.Verification
  WHERE Registration_Number = NEW.Registration_Number ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `upload`
--

CREATE TABLE `upload` (
  `ID` int NOT NULL,
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
  `Email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `upload`
--

INSERT INTO `upload` (`ID`, `Registration_Number`, `Name`, `Roll_Number`, `Branch`, `Course`, `Semester`, `Section`, `Session`, `Year`, `Mobile_Number`, `Email`) VALUES
(1, '1', 'John Smith', 123456789, 'Computer Science', 'B.Tech', '2', 'A', '2022', 2023, '555-1234', '1@lol.com'),
(2, '2', 'Jane Doe', 234567890, 'Electrical Engineering', 'B.Tech', '4', 'B', '2021', 2022, '555-5678', '2@lol.com'),
(3, '3', 'Robert Johnson', 345678901, 'Civil Engineering', 'M.Tech', '6', 'C', '2020', 2021, '555-9876', '3@lol.com'),
(4, '4', 'Sarah Lee', 456789012, 'Finance', 'MBA', '8', 'D', '2019', 2020, '555-4321', '4lol@lol.com');

--
-- Triggers `upload`
--
DELIMITER $$
CREATE TRIGGER `insert_trigger` AFTER INSERT ON `upload` FOR EACH ROW BEGIN
    INSERT INTO hod (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO library (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO project (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO trainingandplacement (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO internship (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO accounts (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO alumni (Registration_Number) VALUES (NEW.Registration_Number);
    INSERT INTO studentusers (username , password) VALUES (NEW.Email, NEW.Registration_Number);
    INSERT INTO students (Registration_Number,Name, Roll_Number, Branch, Course, Semester, Section, Session, Year, Mobile_Number, Email) VALUES (NEW.Registration_Number, NEW.Name, NEW.Roll_Number, NEW.Branch, NEW.Course, NEW.Semester, NEW.Section,  NEW.Session, NEW.Year,NEW.Mobile_Number, NEW.Email);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `access_rights` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_tablename` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `username`, `password`, `access_rights`, `user_tablename`) VALUES
(1, 'librarylol', 'library441', 'ID, Registration_Number, Name, Roll_Number,Branch,Course,Semester,Section,Session,Year,Mobile_Number,Library_Verified', 'library'),
(2, 'ac1', 'ac1', 'ID,Registration_Number,Name,Roll_Number,Branch,Course,Semester,Section,Session,Year,Mobile_Number,Accounts_Verified', 'accounts');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `adminusers`
--
ALTER TABLE `adminusers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `alumni`
--
ALTER TABLE `alumni`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `hod`
--
ALTER TABLE `hod`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `internship`
--
ALTER TABLE `internship`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `library`
--
ALTER TABLE `library`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `accounts` (`Accounts_Verified`),
  ADD KEY `alumni` (`Alumni_Cell_Verified`),
  ADD KEY `hod` (`HOD_Verified`),
  ADD KEY `internship` (`Internship_Verified`),
  ADD KEY `library` (`Library_Verified`),
  ADD KEY `project` (`Project_Verified`),
  ADD KEY `trainingandplacement` (`Training_And_Placement Verified`);

--
-- Indexes for table `studentusers`
--
ALTER TABLE `studentusers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `trainingandplacement`
--
ALTER TABLE `trainingandplacement`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Verification` (`Verification`);

--
-- Indexes for table `upload`
--
ALTER TABLE `upload`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `adminusers`
--
ALTER TABLE `adminusers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `alumni`
--
ALTER TABLE `alumni`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hod`
--
ALTER TABLE `hod`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `internship`
--
ALTER TABLE `internship`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `library`
--
ALTER TABLE `library`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `studentusers`
--
ALTER TABLE `studentusers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trainingandplacement`
--
ALTER TABLE `trainingandplacement`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `upload`
--
ALTER TABLE `upload`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
