-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 13, 2023 at 06:06 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `accounts` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adminusers`
--

CREATE TABLE `adminusers` (
  `ID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hod`
--

CREATE TABLE `hod` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internship`
--

CREATE TABLE `internship` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `library`
--

CREATE TABLE `library` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Roll_Number` int NOT NULL,
  `Branch` varchar(255) NOT NULL,
  `Course` varchar(255) NOT NULL,
  `Semester` varchar(255) NOT NULL,
  `Section` varchar(255) NOT NULL,
  `Session` varchar(255) NOT NULL,
  `Year` int NOT NULL,
  `Mobile_Number` varchar(255) NOT NULL,
  `Accounts_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `Library_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `Training_And_Placement Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `Alumni_Cell_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `Project_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `Internship_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE',
  `HOD_Verified` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentusers`
--

CREATE TABLE `studentusers` (
  `ID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `studentusers`
--

INSERT INTO `studentusers` (`ID`, `username`, `password`) VALUES
(1, 'student', 'student'),
(2, 'student2', 'student2');

-- --------------------------------------------------------

--
-- Table structure for table `trainingandplacement`
--

CREATE TABLE `trainingandplacement` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) NOT NULL,
  `Verification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `upload`
--

CREATE TABLE `upload` (
  `ID` int NOT NULL,
  `Registration_Number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
    INSERT INTO students (Registration_Number,Name, Roll_Number, Branch, Course, Semester, Session, Year,Mobile_Number) VALUES (NEW.Registration_Number, NEW.Name, NEW.Roll_Number, NEW.Branch, NEW.Course, NEW.Semester, NEW.Session, NEW.Year,NEW.Mobile_Number);

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
  `access_rights` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `username`, `password`, `access_rights`) VALUES
(1, 'library', 'library', 'ID	\r\nRegistration_Number	\r\nName	\r\nRoll_Number	\r\nBranch	\r\nCourse	\r\nSemester	\r\nSection\r\nSession	\r\nYear	\r\nMobile_Number	\r\nLibrary_Verified');

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
  ADD KEY `Verification` (`Verification`),
  ADD KEY `Verification_2` (`Verification`);

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
  ADD KEY `hod` (`HOD_Verified`),
  ADD KEY `project` (`Project_Verified`),
  ADD KEY `internship` (`Internship_Verified`),
  ADD KEY `alumni` (`Alumni_Cell_Verified`),
  ADD KEY `accounts` (`Accounts_Verified`),
  ADD KEY `trainingandplacement` (`Training_And_Placement Verified`),
  ADD KEY `library` (`Library_Verified`);

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
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `adminusers`
--
ALTER TABLE `adminusers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `alumni`
--
ALTER TABLE `alumni`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hod`
--
ALTER TABLE `hod`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `internship`
--
ALTER TABLE `internship`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `library`
--
ALTER TABLE `library`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `studentusers`
--
ALTER TABLE `studentusers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trainingandplacement`
--
ALTER TABLE `trainingandplacement`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `upload`
--
ALTER TABLE `upload`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `accounts` FOREIGN KEY (`Accounts_Verified`) REFERENCES `accounts` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `alumni` FOREIGN KEY (`Alumni_Cell_Verified`) REFERENCES `alumni` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `hod` FOREIGN KEY (`HOD_Verified`) REFERENCES `hod` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `internship` FOREIGN KEY (`Internship_Verified`) REFERENCES `internship` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `library` FOREIGN KEY (`Library_Verified`) REFERENCES `library` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `project` FOREIGN KEY (`Project_Verified`) REFERENCES `project` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `trainingandplacement` FOREIGN KEY (`Training_And_Placement Verified`) REFERENCES `trainingandplacement` (`Verification`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
