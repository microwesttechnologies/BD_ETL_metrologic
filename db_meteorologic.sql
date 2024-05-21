-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 21-05-2024 a las 01:18:35
-- Versión del servidor: 10.11.7-MariaDB-cll-lve
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u963527317_meteorologic`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinates`
--

CREATE TABLE `coordinates` (
  `id` int(11) NOT NULL,
  `lon` double DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `id_meta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `database`
--

CREATE TABLE `database` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `main_data`
--

CREATE TABLE `main_data` (
  `id` int(11) NOT NULL,
  `temp` double DEFAULT NULL,
  `feels_like` double DEFAULT NULL,
  `temp_min` double DEFAULT NULL,
  `temp_max` double DEFAULT NULL,
  `pressure` int(11) DEFAULT NULL,
  `humidity` int(11) DEFAULT NULL,
  `sea_level` int(11) DEFAULT NULL,
  `grnd_level` int(11) DEFAULT NULL,
  `id_meta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metadata`
--

CREATE TABLE `metadata` (
  `id` int(11) NOT NULL,
  `visibility` int(11) DEFAULT NULL,
  `dt` int(11) DEFAULT NULL,
  `timezone` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `city_name` text DEFAULT NULL,
  `cod` int(11) DEFAULT NULL,
  `timeQuery` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wind`
--

CREATE TABLE `wind` (
  `id` int(11) NOT NULL,
  `speed` double DEFAULT NULL,
  `deg` int(11) DEFAULT NULL,
  `gust` double DEFAULT NULL,
  `id_meta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `coordinates`
--
ALTER TABLE `coordinates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_coordinates_id_meta` (`id_meta`),
  ADD KEY `idx_coordinates_lat_lon` (`lat`,`lon`);

--
-- Indices de la tabla `database`
--
ALTER TABLE `database`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `main_data`
--
ALTER TABLE `main_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_main_data_id_meta` (`id_meta`);

--
-- Indices de la tabla `metadata`
--
ALTER TABLE `metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_metadata_id` (`id`),
  ADD KEY `idx_metadata_timeQuery` (`timeQuery`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `wind`
--
ALTER TABLE `wind`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wind_id_meta` (`id_meta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `coordinates`
--
ALTER TABLE `coordinates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `database`
--
ALTER TABLE `database`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `main_data`
--
ALTER TABLE `main_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metadata`
--
ALTER TABLE `metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wind`
--
ALTER TABLE `wind`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
