-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 04, 2020 at 12:36 PM
-- Server version: 10.1.46-MariaDB-1~bionic
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `call_center`
--

-- --------------------------------------------------------

--
-- Table structure for table `calls`
--

CREATE TABLE `calls` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calls`
--

INSERT INTO `calls` (`id`, `employee_id`, `customer_id`) VALUES
(33, 1, 4),
(34, 2, 3),
(35, 3, 1),
(36, 4, 3),
(37, 5, 2),
(38, 6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `city_name` varchar(100) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`id`, `city_name`, `country_id`) VALUES
(1, 'Zagreb', 1),
(3, 'Belgrade', 2),
(4, 'Sarajevo', 3),
(5, 'Ljubljana', 4),
(6, 'Budapest', 5),
(7, 'Vienna', 6),
(8, 'Prague', 7),
(10, 'Paris', 8),
(11, 'Berlin', 9),
(12, 'Munich', 9),
(13, 'Frankfurt', 9),
(14, 'Rome', 10),
(15, 'Milan', 10);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `country_name` varchar(128) NOT NULL,
  `country_code` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `country_name`, `country_code`) VALUES
(1, 'Croatia', 'HRV'),
(2, 'Serbia', 'SRB'),
(3, 'Bosnia', 'BIH'),
(4, 'Slovenia', 'SLO'),
(5, 'Hungary', 'HUN'),
(6, 'Austria', 'AUT'),
(7, 'Czech Republic', 'CZK'),
(8, 'France', 'FRA'),
(9, 'Germany', 'DEU'),
(10, 'Italy', 'ITA'),
(11, 'Spain', 'ESP');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `city_id` int(11) NOT NULL,
  `ts_inserted` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `customer_name`, `city_id`, `ts_inserted`) VALUES
(1, 'Bakery', 1, '2020-01-09 10:50:15'),
(2, 'Café', 1, '2020-01-10 08:02:40'),
(3, 'City Market', 2, '2020-01-09 14:01:20'),
(5, 'International Airport', 6, '2020-01-11 17:22:15'),
(6, 'Schnitzel Place', 7, '2020-01-11 12:00:00'),
(7, 'Beer place', 8, '2020-01-12 15:10:55'),
(8, 'Bakery', 10, '2020-01-09 09:19:00'),
(9, 'BMW', 13, '2020-01-10 10:30:30'),
(10, 'Fashion Boutique', 15, '2020-01-13 15:20:15');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `age` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `first_name`, `last_name`, `age`) VALUES
(2, 'Brad', 'Pitt', 22),
(3, 'Tom', 'Cruise', 25),
(5, 'Will', 'Smith', 30),
(6, 'Tina', 'Fey', 25),
(7, 'Irena', 'JURASEK', 35);

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `tr_insert_employee` BEFORE INSERT ON `employee` FOR EACH ROW SET NEW.last_name = UPPER(NEW.last_name)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calls`
--
ALTER TABLE `calls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `call_ak_1` (`employee_id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_country` (`country_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `country_ak_1` (`country_name`),
  ADD UNIQUE KEY `country_ak_2` (`country_code`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calls`
--
ALTER TABLE `calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
