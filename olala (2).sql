-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Гру 23 2024 р., 22:49
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
(5, 1, 'New Patient', '2024-12-23', '11:00:00'),
(6, 2, 'Laura Scott', '2024-12-25', '09:30:00'),
(7, 3, 'Jacob Lee', '2024-12-25', '10:30:00'),
(8, 4, 'Olivia Kim', '2024-12-26', '11:00:00'),
(9, 1, 'Emma White', '2024-12-26', '12:00:00'),
(10, 2, 'Noah Clark', '2024-12-27', '13:00:00'),
(11, 3, 'Liam Hall', '2024-12-27', '14:00:00'),
(12, 4, 'Isabella Young', '2024-12-28', '09:00:00'),
(13, 1, 'Ethan Allen', '2024-12-28', '10:00:00'),
(14, 2, 'Ava King', '2024-12-29', '11:00:00'),
(15, 3, 'Mason Wright', '2024-12-29', '12:00:00'),
(16, 4, 'Sophia Green', '2024-12-30', '13:00:00'),
(17, 1, 'James Harris', '2024-12-30', '14:00:00'),
(18, 2, 'Benjamin Adams', '2024-12-31', '09:00:00'),
(19, 3, 'Charlotte Nelson', '2024-12-31', '10:00:00'),
(20, 4, 'Alexander Baker', '2024-12-31', '11:00:00');

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
(4, 'Anna', 'Taylor', 'Стоматолог', '444-555-6666', 'anna.taylor@example.com', '104'),
(5, 'David', 'Anderson', 'Педіатр', '111-222-3333', 'david.anderson@example.com', '105'),
(6, 'Ella', 'Walker', 'Невролог', '222-333-4444', 'ella.walker@example.com', '106'),
(7, 'Henry', 'Scott', 'Ортопед', '333-444-5555', 'henry.scott@example.com', '107'),
(8, 'Mia', 'Robinson', 'Психіатр', '444-555-6666', 'mia.robinson@example.com', '108'),
(9, 'Lucas', 'Perez', 'Терапевт', '555-666-7777', 'lucas.perez@example.com', '109'),
(10, 'Charlotte', 'Morris', 'Алерголог', '666-777-8888', 'charlotte.morris@example.com', '110'),
(11, 'Amelia', 'Clark', 'Гастроентеролог', '777-888-9999', 'amelia.clark@example.com', '111'),
(12, 'Oliver', 'Lewis', 'Офтальмолог', '888-999-0000', 'oliver.lewis@example.com', '112'),
(13, 'Sophia', 'Lee', 'Отоларинголог', '999-000-1111', 'sophia.lee@example.com', '113'),
(14, 'William', 'Young', 'Нефролог', '000-111-2222', 'william.young@example.com', '114'),
(15, 'Lucas', 'King', 'Гінеколог', '111-222-3334', 'lucas.king@example.com', '115'),
(16, 'Mason', 'Wright', 'Уролог', '222-333-4445', 'mason.wright@example.com', '116'),
(17, 'Evelyn', 'Hill', 'Хірург', '333-444-5556', 'evelyn.hill@example.com', '117'),
(18, 'Harper', 'Turner', 'Кардіолог', '444-555-6667', 'harper.turner@example.com', '118'),
(19, 'Ella', 'Carter', 'Ревматолог', '555-666-7778', 'ella.carter@example.com', '119'),
(20, 'Liam', 'Mitchell', 'Ендокринолог', '666-777-8889', 'liam.mitchell@example.com', '120');

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
(2, 1, '2024-12-23', '11:00:00', 1),
(3, 1, '2024-12-23', '12:00:00', 0),
(4, 1, '2024-12-23', '13:00:00', 0),
(5, 1, '2024-12-23', '14:00:00', 0),
(6, 2, '2024-12-23', '10:00:00', 1),
(7, 2, '2024-12-23', '11:00:00', 0),
(8, 2, '2024-12-23', '12:00:00', 1),
(9, 2, '2024-12-23', '13:00:00', 1),
(10, 2, '2024-12-23', '14:00:00', 1),
(11, 3, '2024-12-23', '09:00:00', 1),
(12, 3, '2024-12-23', '10:00:00', 1),
(13, 3, '2024-12-23', '11:00:00', 1),
(14, 3, '2024-12-23', '12:00:00', 1),
(15, 3, '2024-12-23', '13:00:00', 1),
(16, 4, '2024-12-23', '09:00:00', 1),
(17, 4, '2024-12-23', '10:00:00', 1),
(18, 4, '2024-12-23', '11:00:00', 1),
(19, 4, '2024-12-23', '12:00:00', 1),
(20, 4, '2024-12-23', '13:00:00', 1),
(21, 5, '2024-12-23', '09:00:00', 0),
(22, 5, '2024-12-23', '10:00:00', 1),
(23, 5, '2024-12-23', '11:00:00', 1),
(24, 5, '2024-12-23', '12:00:00', 0),
(25, 5, '2024-12-23', '13:00:00', 1),
(26, 6, '2024-12-23', '09:00:00', 1),
(27, 6, '2024-12-23', '10:00:00', 0),
(28, 6, '2024-12-23', '11:00:00', 0),
(29, 6, '2024-12-23', '12:00:00', 1),
(30, 6, '2024-12-23', '13:00:00', 1);

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
  MODIFY `appointment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблиці `Doctors`
--
ALTER TABLE `Doctors`
  MODIFY `doctor_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблиці `WorkingHours`
--
ALTER TABLE `WorkingHours`
  MODIFY `working_hour_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

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
