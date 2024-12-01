-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-10-2024 a las 17:11:17
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `techtec`
--
CREATE DATABASE IF NOT EXISTS `techtec` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `techtec`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agregados`
--

DROP TABLE IF EXISTS `agregados`;
CREATE TABLE `agregados` (
  `id_agregados` int(11) NOT NULL,
  `tipo_agregado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `agregados`
--

INSERT INTO `agregados` (`id_agregados`, `tipo_agregado`) VALUES
(1, 'Cargador'),
(2, 'Funda'),
(3, 'Mochila'),
(5, 'estuche'),
(6, 'eeeeeeeeeeeeee');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `celulares`
--

DROP TABLE IF EXISTS `celulares`;
CREATE TABLE `celulares` (
  `id_celular` int(11) NOT NULL,
  `celular` bigint(10) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `lada` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `celulares`
--

INSERT INTO `celulares` (`id_celular`, `celular`, `id_cliente`, `lada`) VALUES
(1, 1234567890, 1, 52),
(2, 2345678901, 2, 52),
(3, 3456789012, 3, 52),
(4, 4567890123, 4, 52),
(5, 5678901234, 5, 52),
(9, 5987856585, 35, 52),
(10, 2658595458, 35, 52),
(11, 5551234567, 36, 52),
(12, 5557654321, 36, 52),
(13, 9516577535, 37, 52),
(14, 9516577535, 38, 52),
(15, 9516577535, 39, 52),
(16, 9516577535, 40, 52),
(18, 9516577535, 42, 52),
(19, 9514577858, 43, 52),
(20, 4585585695, 43, 52),
(21, 9514577858, 44, 52),
(22, 123456789, 45, 52),
(23, 987654321, 45, 52),
(24, 123456789, 46, 52),
(25, 987654321, 46, 52),
(26, 123456789, 47, 52),
(27, 987654321, 47, 52),
(28, 4565258568, 48, 52),
(29, 4565258568, 49, 52),
(30, 9514577858, 50, 52),
(31, 9514577858, 51, 52),
(33, 9514577858, 53, 52),
(34, 123456789, 54, 52),
(35, 987654321, 54, 52),
(36, 123456789, 57, 52),
(37, 987654321, 57, 52),
(39, 9514577858, 59, 52),
(40, 9514577858, 60, 52);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido_paterno` varchar(20) DEFAULT NULL,
  `apellido_materno` varchar(20) DEFAULT NULL,
  `domicilio` varchar(200) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `apellido_paterno`, `apellido_materno`, `domicilio`, `email`) VALUES
(1, 'Juan', 'Pérez', 'García', 'Av. Siempre Viva 123', 'juan.perez@example.c'),
(2, 'Ana', 'López', 'Martínez', 'Calle Falsa 456', 'ana.lopez@example.co'),
(3, 'Luis', 'Ramírez', 'Hernández', 'Boulevard 789', 'luis.ramirez@example'),
(4, 'Marta', 'Gómez', 'Castro', 'Plaza Mayor 101', 'marta.gomez@example.'),
(5, 'Pedro', 'Sánchez', 'Morales', 'Calle Principal 202', 'pedro.sanchez@exampl'),
(35, 'prueba', 'para', 'pdf', 'ejemplo', 'ejemplo@pdf'),
(36, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(37, 'jose', 'maslow', 'maslow', 'eee', 'e@jemplo.com'),
(38, 'jose', 'maslow', 'maslow', 'eee', 'e@jemplo.com'),
(39, 'jose', 'maslow', 'maslow', 'eee', 'e@jemplo.com'),
(40, 'jose', 'maslow', 'maslow', 'eee', 'e@jemplo.com'),
(42, 'jose', 'maslow', 'maslow', 'eee', 'e@jemplo.com'),
(43, 'prueba', 'delk', 'pdf', 'qweretewe', 'a@a'),
(44, 'prueba', 'delk', 'pdf', 'qweretewe', 'a@a'),
(45, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(46, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(47, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(48, 'qqq', 'www', 'eee', 'rrr', 't@t'),
(49, 'qqq', 'www', 'eee', 'rrr', 't@t'),
(50, 'prueba', 'delk', 'pdf', 'qweretewe', 'a@a'),
(51, 'prueba', 'delk', 'pdf', 'qweretewe', 'a@a'),
(53, 'antonio', 's', 'garcia', 'eee', 'antonio_garcia@anahu'),
(54, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(57, 'Juan', 'Pérez', 'García', 'Calle Falsa 123', 'juan.perez@example.c'),
(59, 'antonio', 's', 'garcia', 'domicilio de prueba', 'antonio_garcia@anahu'),
(60, 'antonio', 's', 'garcia', 'domicilio de prueba', 'antonio_garcia@anahu');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `equipo`
--

DROP TABLE IF EXISTS `equipo`;
CREATE TABLE `equipo` (
  `id_equipo` int(11) NOT NULL,
  `marca` varchar(20) DEFAULT NULL,
  `serie` varchar(20) DEFAULT NULL,
  `modelo` varchar(20) DEFAULT NULL,
  `descripcion` varchar(140) DEFAULT NULL,
  `estado` enum('BUENO','REGULAR','MALO') DEFAULT NULL,
  `descripcion_agregado` varchar(200) NOT NULL,
  `id_tipo_equipo` int(11) DEFAULT NULL,
  `id_agregados` int(11) DEFAULT NULL,
  `id_ubicacion` int(11) DEFAULT 4
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `equipo`
--

INSERT INTO `equipo` (`id_equipo`, `marca`, `serie`, `modelo`, `descripcion`, `estado`, `descripcion_agregado`, `id_tipo_equipo`, `id_agregados`, `id_ubicacion`) VALUES
(1, 'HP', '1234', 'EliteBook', 'Computadora portátil', 'BUENO', 'cargador negro', 1, 1, 4),
(2, 'Samsung', '5678', 'Galaxy S21', 'Teléfono inteligente', 'REGULAR', 'funda negra', 2, 2, 4),
(3, 'Epson', '9101', 'L210', 'Impresora multifuncional', 'BUENO', 'mochila rota', 3, 3, 4),
(4, 'Apple', '1122', 'iPad Pro', 'Tableta con pantalla Retina', 'MALO', 'cargador roto', 4, 1, 4),
(5, 'Dell', '3344', 'UltraSharp', 'Monitor 24 pulgadas', 'BUENO', 'funda sin cierre', 5, 2, 4),
(6, 'hp', '3600', 'a2w3', 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las', 'REGULAR', 'mochila roja', 3, 3, 4),
(7, 'Apple', 'ABC12345XYZ', 'iPhone 13', 'Pantalla dañada', '', 'Con protector de pantalla', 1, 2, 4),
(8, '3qr3qr', '33qrr3q', '3r3rqq3', '3qr3qr3qr', 'BUENO', 'eeer3r3', 2, 1, 4),
(9, '3qr3qr', '33qrr3q', '3r3rqq3', '3qr3qr3qr', '', 'eeer3r3', 3, 2, 4),
(10, '3qr3qr', '33qrr3q', '3r3rqq3', '3qr3qr3qr', '', 'eeer3r3', 4, 3, 4),
(11, '3qr3qr', '33qrr3q', '3r3rqq3', '3qr3qr3qr', 'REGULAR', 'eeer3r3', 3, 5, 4),
(13, '3qr3qr', '33qrr3q', '3r3rqq3', 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las', 'BUENO', 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las', 3, 2, 4),
(14, 'ddd', 'ddd', 'www', 'fewbnewowe', 'REGULAR', 'cargador marca samsung', 2, 1, 4),
(15, 'ddd', 'ddd', 'www', 'fewbnewowe', '', 'cargador marca samsung', 4, 3, 4),
(16, 'Samsung', 'S21', 'Galaxy S21', 'Teléfono inteligente', '', 'Sin accesorios', 1, 1, 4),
(17, 'Samsung', 'S21', 'Galaxy S21', 'Teléfono inteligente', 'BUENO', 'Sin accesorios', 1, 1, 4),
(18, 'Samsung', 'S21', 'Galaxy S21', 'Teléfono inteligente', 'BUENO', 'Sin accesorios', 1, 1, 4),
(19, 'uuu', 'iii', 'ooo', 'aaa', 'REGULAR', 'yyy', 1, 3, 4),
(20, 'uuu', 'iii', 'ooo', 'aaa', '', 'yyy', 6, 3, 4),
(21, 'ddd', 'ddd', 'www', 'fewbnewowe', '', 'cargador marca samsung', 4, 2, 4),
(22, 'ddd', 'ddd', 'www', 'fewbnewowe', 'REGULAR', 'cargador marca samsung', 4, 5, 4),
(24, 'ddd', 'ddd', 'www', 'fewbnewowe', 'REGULAR', 'cargador marca samsung', 1, 1, 4),
(25, 'Samsung', 'S21', 'Galaxy S21', 'Teléfono inteligente', 'BUENO', 'Sin accesorios', 1, 1, 4),
(26, 'Samsung', 'S21', 'Galaxy S21', 'Teléfono inteligente', 'BUENO', 'Sin accesorios', 1, 1, 4),
(28, 'ddd', '33qrr3q', 'ooo', 'ds con pantalla rota', 'BUENO', 'yyy', 6, 3, 4),
(29, 'ddd', '33qrr3q', 'ooo', 'ds con pantalla rota', '', 'yyy', 2, 5, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

DROP TABLE IF EXISTS `etiquetas`;
CREATE TABLE `etiquetas` (
  `id_etiqueta` int(11) NOT NULL,
  `etiqueta` varchar(50) NOT NULL,
  `id_servicio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `etiquetas`
--

INSERT INTO `etiquetas` (`id_etiqueta`, `etiqueta`, `id_servicio`) VALUES
(1, 'Nueva Etiqueta', 1),
(2, 'prueba de etiqueta', 1),
(3, 'ID6', 6),
(4, 'aaa', 1),
(5, 'ddddd', 3),
(6, 'wwqeew', 6),
(7, 'prueba', 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

DROP TABLE IF EXISTS `servicio`;
CREATE TABLE `servicio` (
  `id_servicio` int(11) NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `tiempo_entrega` int(2) DEFAULT NULL,
  `medida_tiempo` enum('DIAS','HORAS') DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_equipo` int(11) DEFAULT NULL,
  `id_tipo_servicio` int(11) DEFAULT NULL,
  `id_trabajador` int(11) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `costo` int(6) DEFAULT NULL,
  `prioridad` enum('Urgente','Medianamente urgente','No urgente') NOT NULL DEFAULT 'No urgente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`id_servicio`, `observaciones`, `tiempo_entrega`, `medida_tiempo`, `id_cliente`, `id_equipo`, `id_tipo_servicio`, `id_trabajador`, `fecha`, `costo`, `prioridad`) VALUES
(1, 'Servicio de revisión general', 2, 'DIAS', 1, 1, 1, 1, '2024-10-27 01:16:39', 100, 'No urgente'),
(2, 'Formateo completo', 1, 'DIAS', 2, 2, 2, 1, '2024-10-27 01:16:39', 100, 'No urgente'),
(3, 'Instalación de software', 3, 'HORAS', 3, 3, 3, 1, '2024-10-27 01:16:39', 100, 'No urgente'),
(4, 'Limpieza interna', 1, 'DIAS', 4, 4, 4, 1, '2024-10-27 01:16:39', 100, 'No urgente'),
(5, 'Reparación de pantalla', 5, 'DIAS', 5, 5, 5, 1, '2024-10-27 01:16:39', 100, 'No urgente'),
(6, 'ejemplo', 3, 'DIAS', 35, 6, 4, 1, '2024-10-27 01:33:20', 100, 'No urgente'),
(7, 'Se requiere cambio de pantalla y revisión de batería', 2, 'DIAS', 36, 7, 3, 1, '2024-10-27 04:54:38', 100, 'No urgente'),
(8, '3qr3qr3qr', 4, 'HORAS', 37, 8, 2, 1, '2024-10-27 04:57:57', 100, 'No urgente'),
(9, 'wertge4wy4wt34wt', 4, 'DIAS', 38, 9, 2, 1, '2024-10-27 05:05:05', 100, 'No urgente'),
(10, 'wetgwrgwergwrg', 4, 'HORAS', 39, 10, 2, 1, '2024-10-27 05:10:20', 100, 'No urgente'),
(11, 'eeeeee', 4, 'HORAS', 40, 11, 4, 1, '2024-10-27 05:16:36', 100, 'No urgente'),
(12, 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las', 4, '', 42, 13, 3, 1, '2024-10-27 05:24:12', 100, 'No urgente'),
(13, 'ewewewewew', 3, 'DIAS', 43, 14, 4, 1, '2024-10-27 06:00:56', 100, 'No urgente'),
(14, 'ewti7ou6ur64ue64', 3, 'HORAS', 44, 15, 3, 1, '2024-10-27 06:11:42', 100, 'No urgente'),
(15, 'Reparación de pantalla', 3, 'DIAS', 45, 16, 2, 1, '2024-10-28 07:17:48', 100, 'No urgente'),
(16, 'Reparación de pantalla', 3, 'DIAS', 46, 17, 2, 1, '2024-10-28 07:20:49', NULL, 'No urgente'),
(17, 'Reparación de pantalla', 3, 'DIAS', 47, 18, 2, 1, '2024-10-28 07:23:18', 150, 'No urgente'),
(18, '5646554', 22, '', 48, 19, 3, 1, '2024-10-28 07:30:53', NULL, 'No urgente'),
(19, '5545454', 22, 'DIAS', 49, 20, 3, 1, '2024-10-28 07:31:20', NULL, 'No urgente'),
(20, 'www', 3, 'DIAS', 50, 21, 2, 1, '2024-10-28 07:35:58', 400, 'No urgente'),
(21, 'rwgrrewgreg', 3, 'DIAS', 51, 22, 4, 1, '2024-10-28 07:40:18', 400, 'No urgente'),
(23, 'wswwwww', 3, 'DIAS', 53, 24, 7, 11, '2024-10-28 07:45:18', 400, 'No urgente'),
(24, 'Reparación de pantalla', 3, 'DIAS', 54, 25, 2, 1, '2024-10-28 07:56:47', 150, 'Urgente'),
(25, 'Reparación de pantalla', 3, 'DIAS', 57, 26, 2, 1, '2024-10-28 08:14:44', 150, 'Urgente'),
(26, 'wwwwwwwwww', 2, 'DIAS', 59, 28, 4, 1, '2024-10-28 08:36:04', 32, 'No urgente'),
(27, '222222222222', 2, 'HORAS', 60, 29, 4, 1, '2024-10-28 08:36:29', 32, 'Medianamente urgente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_equipo`
--

DROP TABLE IF EXISTS `tipos_equipo`;
CREATE TABLE `tipos_equipo` (
  `id_tipo_equipo` int(11) NOT NULL,
  `equipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_equipo`
--

INSERT INTO `tipos_equipo` (`id_tipo_equipo`, `equipo`) VALUES
(1, 'Computadora'),
(2, 'Celular'),
(3, 'Impresora'),
(4, 'Tableta'),
(5, 'Monitor'),
(6, 'servidor'),
(8, 'router'),
(9, 'wwwwwww');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_servicio`
--

DROP TABLE IF EXISTS `tipos_servicio`;
CREATE TABLE `tipos_servicio` (
  `id_tipo_servicio` int(11) NOT NULL,
  `servicio` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipos_servicio`
--

INSERT INTO `tipos_servicio` (`id_tipo_servicio`, `servicio`) VALUES
(1, 'Revisión'),
(2, 'Formateo'),
(3, 'Inst software'),
(4, 'Limpieza'),
(5, 'Refacción'),
(6, 'testeos'),
(7, 'cambios'),
(8, 'rrrrrrrrrrrrrrrrr'),
(9, 'ññññññññ'),
(10, 'rerere');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadores`
--

DROP TABLE IF EXISTS `trabajadores`;
CREATE TABLE `trabajadores` (
  `id_trabajador` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido_paterno` varchar(20) DEFAULT NULL,
  `apellido_materno` varchar(20) DEFAULT NULL,
  `id_jefe` int(11) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajadores`
--

INSERT INTO `trabajadores` (`id_trabajador`, `nombre`, `apellido_paterno`, `apellido_materno`, `id_jefe`, `user`, `password`) VALUES
(1, 'Enrique', 'Castellanos', 'Rodriguez', NULL, 'enriqueCR', '$2b$10$YKC5RV0g7KlZDJcqM/Sv/uZV3xH5L48kTCKc2.GK/pgVRBh7kWcz.'),
(11, 'Carlos', 'López', 'García', 1, 'carlosLG', '$2b$10$cG8ENjvGTA0USIyoL5tmVO3mGtWeHH6T5hyK2g4ywFUS.k8HfuFC6');

--
-- Disparadores `trabajadores`
--
DROP TRIGGER IF EXISTS `after_insert_trabajadores`;
DELIMITER $$
CREATE TRIGGER `after_insert_trabajadores` BEFORE INSERT ON `trabajadores` FOR EACH ROW BEGIN
    SET NEW.user = CONCAT(
        LOWER(NEW.nombre), 
        UPPER(LEFT(NEW.apellido_paterno, 1)), 
        UPPER(LEFT(NEW.apellido_materno, 1))
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_equipo`
--

DROP TABLE IF EXISTS `ubicacion_equipo`;
CREATE TABLE `ubicacion_equipo` (
  `id_ubicacion` int(11) NOT NULL,
  `ubicacion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicacion_equipo`
--

INSERT INTO `ubicacion_equipo` (`id_ubicacion`, `ubicacion`) VALUES
(1, 'stand-by'),
(2, 'en bodega'),
(3, 'listo para entrega'),
(4, 'en reparación');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agregados`
--
ALTER TABLE `agregados`
  ADD PRIMARY KEY (`id_agregados`);

--
-- Indices de la tabla `celulares`
--
ALTER TABLE `celulares`
  ADD PRIMARY KEY (`id_celular`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD PRIMARY KEY (`id_equipo`),
  ADD KEY `id_tipo_equipo` (`id_tipo_equipo`),
  ADD KEY `id_agregados` (`id_agregados`),
  ADD KEY `fk_ubicacion` (`id_ubicacion`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id_etiqueta`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_equipo` (`id_equipo`),
  ADD KEY `id_tipo_servicio` (`id_tipo_servicio`),
  ADD KEY `id_trabajador` (`id_trabajador`);

--
-- Indices de la tabla `tipos_equipo`
--
ALTER TABLE `tipos_equipo`
  ADD PRIMARY KEY (`id_tipo_equipo`);

--
-- Indices de la tabla `tipos_servicio`
--
ALTER TABLE `tipos_servicio`
  ADD PRIMARY KEY (`id_tipo_servicio`);

--
-- Indices de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  ADD PRIMARY KEY (`id_trabajador`),
  ADD KEY `id_jefe` (`id_jefe`);

--
-- Indices de la tabla `ubicacion_equipo`
--
ALTER TABLE `ubicacion_equipo`
  ADD PRIMARY KEY (`id_ubicacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agregados`
--
ALTER TABLE `agregados`
  MODIFY `id_agregados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `celulares`
--
ALTER TABLE `celulares`
  MODIFY `id_celular` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `equipo`
--
ALTER TABLE `equipo`
  MODIFY `id_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id_etiqueta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `tipos_equipo`
--
ALTER TABLE `tipos_equipo`
  MODIFY `id_tipo_equipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipos_servicio`
--
ALTER TABLE `tipos_servicio`
  MODIFY `id_tipo_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  MODIFY `id_trabajador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `ubicacion_equipo`
--
ALTER TABLE `ubicacion_equipo`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `celulares`
--
ALTER TABLE `celulares`
  ADD CONSTRAINT `celulares_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `equipo`
--
ALTER TABLE `equipo`
  ADD CONSTRAINT `equipo_ibfk_1` FOREIGN KEY (`id_tipo_equipo`) REFERENCES `tipos_equipo` (`id_tipo_equipo`),
  ADD CONSTRAINT `equipo_ibfk_2` FOREIGN KEY (`id_agregados`) REFERENCES `agregados` (`id_agregados`),
  ADD CONSTRAINT `fk_ubicacion` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion_equipo` (`id_ubicacion`);

--
-- Filtros para la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD CONSTRAINT `etiquetas_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`);

--
-- Filtros para la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD CONSTRAINT `servicio_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `servicio_ibfk_2` FOREIGN KEY (`id_equipo`) REFERENCES `equipo` (`id_equipo`),
  ADD CONSTRAINT `servicio_ibfk_3` FOREIGN KEY (`id_tipo_servicio`) REFERENCES `tipos_servicio` (`id_tipo_servicio`),
  ADD CONSTRAINT `servicio_ibfk_4` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajadores` (`id_trabajador`);

--
-- Filtros para la tabla `trabajadores`
--
ALTER TABLE `trabajadores`
  ADD CONSTRAINT `trabajadores_ibfk_1` FOREIGN KEY (`id_jefe`) REFERENCES `trabajadores` (`id_trabajador`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
