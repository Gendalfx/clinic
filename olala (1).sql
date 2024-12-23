-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Гру 23 2024 р., 15:01
-- Версія сервера: 8.0.30
-- Версія PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `olala`
--

-- --------------------------------------------------------

--
-- Структура таблиці `Appointments`
--

CREATE TABLE `Appointments` (
  `appointment_id` int NOT NULL,
  `doctor_id` int DEFAULT NULL,
  `patient_name` varchar(255) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `Appointments`
--

INSERT INTO `Appointments` (`appointment_id`, `doctor_id`, `patient_name`, `appointment_date`, `appointment_time`) VALUES
(1, 1, 'Michael Johnson', '2024-12-23', '10:00:00'),
(2, 2, 'Emily Davis', '2024-12-23', '11:00:00'),
(3, 3, 'Daniel Wilson', '2024-12-24', '09:00:00'),
(4, 4, 'Sophia Martinez', '2024-12-24', '14:00:00'),
(5, 1, 'New Patient', '2024-12-23', '11:00:00');

-- --------------------------------------------------------

--
-- Структура таблиці `Doctors`
--

CREATE TABLE `Doctors` (
  `doctor_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `specialty_id` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `room_number` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `Doctors`
--

INSERT INTO `Doctors` (`doctor_id`, `first_name`, `last_name`, `specialty_id`, `phone_number`, `email`, `room_number`) VALUES
(1, 'John', 'Doe', 'Кардіолог', '123-456-7890', 'john.doe@example.com', '101'),
(2, 'Jane', 'Smith', 'Дерматолог', '987-654-3210', 'jane.smith@example.com', '102'),
(3, 'Sam', 'Brown', 'Хірург', '555-666-7777', 'sam.brown@example.com', '103'),
(4, 'Anna', 'Taylor', 'Стоматолог', '444-555-6666', 'anna.taylor@example.com', '104');

-- --------------------------------------------------------

--
-- Структура таблиці `WorkingHours`
--

CREATE TABLE `WorkingHours` (
  `working_hour_id` int NOT NULL,
  `doctor_id` int DEFAULT NULL,
  `working_day` date DEFAULT NULL,
  `working_hour` time DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `WorkingHours`
--

INSERT INTO `WorkingHours` (`working_hour_id`, `doctor_id`, `working_day`, `working_hour`, `is_available`) VALUES
(1, 1, '2024-12-23', '10:00:00', 1),
(2, 1, '2024-12-23', '11:00:00', 0),
(3, 1, '2024-12-23', '12:00:00', 1),
(4, 1, '2024-12-23', '13:00:00', 1),
(5, 1, '2024-12-23', '14:00:00', 1),
(6, 2, '2024-12-23', '10:00:00', 1),
(7, 2, '2024-12-23', '11:00:00', 1),
(8, 2, '2024-12-23', '12:00:00', 1),
(9, 2, '2024-12-23', '13:00:00', 1),
(10, 2, '2024-12-23', '14:00:00', 1);

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `Appointments`
--
ALTER TABLE `Appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Індекси таблиці `Doctors`
--
ALTER TABLE `Doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Індекси таблиці `WorkingHours`
--
ALTER TABLE `WorkingHours`
  ADD PRIMARY KEY (`working_hour_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `Appointments`
--
ALTER TABLE `Appointments`
  MODIFY `appointment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблиці `Doctors`
--
ALTER TABLE `Doctors`
  MODIFY `doctor_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблиці `WorkingHours`
--
ALTER TABLE `WorkingHours`
  MODIFY `working_hour_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `Appointments`
--
ALTER TABLE `Appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `Doctors` (`doctor_id`);

--
-- Обмеження зовнішнього ключа таблиці `WorkingHours`
--
ALTER TABLE `WorkingHours`
  ADD CONSTRAINT `workinghours_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `Doctors` (`doctor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
