-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-06-2025 a las 02:09:24
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
-- Base de datos: `biblioteca_ua`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Actualizar_Datos_Usuario` (IN `actualizar_Rut` INT, IN `actualizar_Nombre_completo` VARCHAR(30), IN `actualizar_Email` VARCHAR(40), IN `actualizar_Telefono` INT)   BEGIN
    IF actualizar_Nombre_completo IS NOT NULL AND actualizar_Nombre_completo != '' THEN
        UPDATE Usuario
        SET Nombre_completo = actualizar_Nombre_completo
        WHERE Rut = actualizar_Rut;
    END IF;

    IF actualizar_Email IS NOT NULL AND actualizar_Email != '' THEN
        UPDATE Usuario
        SET Email = actualizar_Email
        WHERE Rut = actualizar_Rut;
    END IF;

    IF actualizar_Telefono IS NOT NULL AND actualizar_Telefono != 0 THEN
        UPDATE Usuario
        SET Telefono = actualizar_Telefono
        WHERE Rut = actualizar_Rut;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_libro` (IN `eliminar_ISBN` INT)   BEGIN DELETE FROM libro WHERE ISBN = eliminar_ISBN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `historial_de_libros_usuario` (IN `nombre_usuario` VARCHAR(30))   BEGIN 
    SELECT
    usuario.Nombre_completo,
    libro.Titulo,
    prestamo_libro.inicio_libro,
    prestamo_libro.fin_libro
    FROM Usuario
    INNER JOIN Prestamo ON usuario.Rut = prestamo.Rut
    INNER JOIN Prestamo_libro ON prestamo.ID_Prestamo = prestamo_libro.ID_Prestamo
    INNER JOIN Libro ON prestamo_libro.ISBN = libro.ISBN
    WHERE u.Nombre_completo LIKE CONCAT('%', nombre_usuario, '%')
    ORDER BY prestamo_libro.inicio_libro DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertar_usuario` (IN `ins_Rut` INT, IN `ins_ID_carrera` INT, IN `ins_nombre_completo` VARCHAR(30), IN `ins_email` VARCHAR(40), IN `ins_telefono` INT)   BEGIN
INSERT INTO usuario(Rut, ID_carrera, Nombre_completo, Email, Telefono) 
VALUES(ins_Rut, ins_ID_carrera, ins_nombre_completo, ins_email, ins_telefono);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `box`
--

CREATE TABLE `box` (
  `ID_box` int(11) NOT NULL,
  `ID_edificio` int(11) DEFAULT NULL,
  `Capacidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `box`
--

INSERT INTO `box` (`ID_box`, `ID_edificio`, `Capacidad`) VALUES
(1, 1, 4),
(2, 1, 6),
(3, 2, 8),
(4, 2, 2),
(5, 3, 10),
(6, 3, 5),
(7, 4, 3),
(8, 4, 7),
(9, 5, 9),
(10, 5, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera`
--

CREATE TABLE `carrera` (
  `ID_carrera` int(11) NOT NULL,
  `nombre_ca` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `carrera`
--

INSERT INTO `carrera` (`ID_carrera`, `nombre_ca`) VALUES
(1, 'Ingeniería Civil Informática'),
(2, 'Medicina'),
(3, 'Arquitectura'),
(4, 'Derecho'),
(5, 'Psicología'),
(6, 'Administración de Empresas'),
(7, 'Ingeniería Civil'),
(8, 'Educación'),
(9, 'Diseño Gráfico'),
(10, 'Ingeniería Comercial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `edificio`
--

CREATE TABLE `edificio` (
  `ID_edificio` int(11) NOT NULL,
  `letra_edificio` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `edificio`
--

INSERT INTO `edificio` (`ID_edificio`, `letra_edificio`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E'),
(6, 'F'),
(7, 'G'),
(8, 'H'),
(9, 'I'),
(10, 'J');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `ISBN` int(11) NOT NULL,
  `Titulo` varchar(30) DEFAULT NULL,
  `Autor` varchar(30) DEFAULT NULL,
  `Genero` varchar(30) DEFAULT NULL,
  `Fecha_publicacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`ISBN`, `Titulo`, `Autor`, `Genero`, `Fecha_publicacion`) VALUES
(11111111, 'Arquitectura Moderna', 'L. Fernández', 'Arte', '2019-05-20'),
(12345678, 'Fundamentos de Programación', 'J. Pérez', 'Educativo', '2018-03-12'),
(22222222, 'Derecho Constitucional', 'C. Martínez', 'Legal', '2020-01-15'),
(33333333, 'Psicología Básica', 'F. Rojas', 'Salud', '2016-11-30'),
(44444444, 'Administración 101', 'G. Morales', 'Negocios', '2015-07-21'),
(55555555, 'Ingeniería Civil Avanzada', 'H. Díaz', 'Educativo', '2021-02-10'),
(66666666, 'Métodos de Enseñanza', 'I. Castro', 'Educativo', '2019-12-12'),
(77777777, 'Diseño Gráfico Digital', 'J. Salazar', 'Arte', '2018-06-18'),
(88888888, 'Economía para Todos', 'K. López', 'Economía', '2017-09-25'),
(98765432, 'Introducción a la Medicina', 'M. Gómez', 'Ciencia', '2017-08-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `ID_Prestamo` int(11) NOT NULL,
  `Rut` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`ID_Prestamo`, `Rut`) VALUES
(3, 193456789),
(5, 195678901),
(8, 198901234),
(1, 201234567),
(2, 202345678),
(4, 204567890),
(7, 207890123),
(9, 209012345),
(10, 211223344),
(6, 216789012);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo_box`
--

CREATE TABLE `prestamo_box` (
  `ID_Prestamo` int(11) NOT NULL,
  `ID_box` int(11) NOT NULL,
  `inicio_box` datetime DEFAULT NULL,
  `fin_box` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `prestamo_box`
--

INSERT INTO `prestamo_box` (`ID_Prestamo`, `ID_box`, `inicio_box`, `fin_box`) VALUES
(1, 1, '2025-06-01 08:00:00', '2025-06-01 12:00:00'),
(2, 2, '2025-06-02 09:00:00', '2025-06-02 11:00:00'),
(3, 3, '2025-06-03 14:00:00', '2025-06-03 18:00:00'),
(4, 4, '2025-06-04 10:00:00', '2025-06-04 13:00:00'),
(5, 5, '2025-06-05 15:00:00', '2025-06-05 17:00:00'),
(6, 6, '2025-06-06 11:30:00', '2025-06-06 14:30:00'),
(7, 7, '2025-06-07 08:00:00', '2025-06-07 12:00:00'),
(8, 8, '2025-06-08 09:00:00', '2025-06-08 13:00:00'),
(9, 9, '2025-06-09 10:00:00', '2025-06-09 15:00:00'),
(10, 10, '2025-06-10 07:00:00', '2025-06-10 12:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo_libro`
--

CREATE TABLE `prestamo_libro` (
  `ID_Prestamo` int(11) NOT NULL,
  `ISBN` int(11) NOT NULL,
  `inicio_libro` datetime DEFAULT NULL,
  `fin_libro` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `prestamo_libro`
--

INSERT INTO `prestamo_libro` (`ID_Prestamo`, `ISBN`, `inicio_libro`, `fin_libro`) VALUES
(1, 12345678, '2025-06-01 10:00:00', '2025-06-15 10:00:00'),
(2, 98765432, '2025-06-03 09:30:00', '2025-06-17 09:30:00'),
(3, 11111111, '2025-06-05 14:00:00', '2025-06-20 14:00:00'),
(4, 22222222, '2025-06-07 13:00:00', '2025-06-21 13:00:00'),
(5, 33333333, '2025-06-09 15:30:00', '2025-06-23 15:30:00'),
(6, 44444444, '2025-06-10 11:00:00', '2025-06-24 11:00:00'),
(7, 55555555, '2025-06-12 16:00:00', '2025-06-26 16:00:00'),
(8, 66666666, '2025-06-14 10:30:00', '2025-06-28 10:30:00'),
(9, 77777777, '2025-06-16 09:00:00', '2025-06-30 09:00:00'),
(10, 88888888, '2025-06-18 08:00:00', '2025-07-02 08:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actualizacion_usuario`
--

CREATE TABLE `registro_actualizacion_usuario` (
  `ID_Registro` int(11) NOT NULL,
  `Rut` int(11) DEFAULT NULL,
  `Fecha` datetime DEFAULT NULL,
  `Campo_Modificado` varchar(30) DEFAULT NULL,
  `Valor_Anterior` varchar(40) DEFAULT NULL,
  `Valor_Nuevo` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Rut` int(11) NOT NULL,
  `ID_carrera` int(11) DEFAULT NULL,
  `Nombre_completo` varchar(30) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Rut`, `ID_carrera`, `Nombre_completo`, `Email`, `telefono`) VALUES
(193456789, 3, 'Juan Gómez', 'juan.gomez@mail.com', 933345678),
(195678901, 5, 'Luis Fernández', 'luis.fernandez@mail.com', 955345678),
(198901234, 8, 'Laura Díaz', 'laura.diaz@mail.com', 988345678),
(201234567, 1, 'Carlos Márquez', 'carlos.marquez@mail.com', 912345678),
(202345678, 2, 'María Pérez', 'maria.perez@mail.com', 922345678),
(204567890, 4, 'Ana Torres', 'ana.torres@mail.com', 944345678),
(207890123, 7, 'Pedro Morales', 'pedro.morales@mail.com', 977345678),
(209012345, 9, 'Diego Castro', 'diego.castro@mail.com', 999345678),
(211223344, 10, 'Elena Salazar', 'elena.salazar@mail.com', 900345678),
(216789012, 6, 'Sofía Rojas', 'sofia.rojas@mail.com', 966345678);

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `registro_actualizacion_usuario` AFTER UPDATE ON `usuario` FOR EACH ROW BEGIN
    IF OLD.Nombre_completo <> NEW.Nombre_completo THEN
        INSERT INTO Log_Actualizacion_Usuario(Rut, Fecha, Campo_Modificado, Valor_Anterior, Valor_Nuevo)
        VALUES (NEW.Rut, NOW(), 'Nombre_completo', OLD.Nombre_completo, NEW.Nombre_completo);
    END IF;

    IF OLD.Email <> NEW.Email THEN
        INSERT INTO Log_Actualizacion_Usuario(Rut, Fecha, Campo_Modificado, Valor_Anterior, Valor_Nuevo)
        VALUES (NEW.Rut, NOW(), 'Email', OLD.Email, NEW.Email);
    END IF;

    IF OLD.Telefono <> NEW.Telefono THEN
        INSERT INTO Log_Actualizacion_Usuario(Rut, Fecha, Campo_Modificado, Valor_Anterior, Valor_Nuevo)
        VALUES (NEW.Rut, NOW(), 'Telefono', OLD.Telefono, NEW.Telefono);
    END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `box`
--
ALTER TABLE `box`
  ADD PRIMARY KEY (`ID_box`),
  ADD KEY `ID_edificio` (`ID_edificio`);

--
-- Indices de la tabla `carrera`
--
ALTER TABLE `carrera`
  ADD PRIMARY KEY (`ID_carrera`);

--
-- Indices de la tabla `edificio`
--
ALTER TABLE `edificio`
  ADD PRIMARY KEY (`ID_edificio`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`ID_Prestamo`),
  ADD KEY `Rut` (`Rut`);

--
-- Indices de la tabla `prestamo_box`
--
ALTER TABLE `prestamo_box`
  ADD PRIMARY KEY (`ID_Prestamo`,`ID_box`),
  ADD KEY `ID_box` (`ID_box`);

--
-- Indices de la tabla `prestamo_libro`
--
ALTER TABLE `prestamo_libro`
  ADD PRIMARY KEY (`ID_Prestamo`,`ISBN`),
  ADD KEY `ISBN` (`ISBN`);

--
-- Indices de la tabla `registro_actualizacion_usuario`
--
ALTER TABLE `registro_actualizacion_usuario`
  ADD PRIMARY KEY (`ID_Registro`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`Rut`),
  ADD KEY `ID_carrera` (`ID_carrera`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `box`
--
ALTER TABLE `box`
  MODIFY `ID_box` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `carrera`
--
ALTER TABLE `carrera`
  MODIFY `ID_carrera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `edificio`
--
ALTER TABLE `edificio`
  MODIFY `ID_edificio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `ID_Prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `registro_actualizacion_usuario`
--
ALTER TABLE `registro_actualizacion_usuario`
  MODIFY `ID_Registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `box`
--
ALTER TABLE `box`
  ADD CONSTRAINT `box_ibfk_1` FOREIGN KEY (`ID_edificio`) REFERENCES `edificio` (`ID_edificio`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`Rut`) REFERENCES `usuario` (`Rut`);

--
-- Filtros para la tabla `prestamo_box`
--
ALTER TABLE `prestamo_box`
  ADD CONSTRAINT `prestamo_box_ibfk_1` FOREIGN KEY (`ID_box`) REFERENCES `box` (`ID_box`),
  ADD CONSTRAINT `prestamo_box_ibfk_2` FOREIGN KEY (`ID_Prestamo`) REFERENCES `prestamo` (`ID_Prestamo`);

--
-- Filtros para la tabla `prestamo_libro`
--
ALTER TABLE `prestamo_libro`
  ADD CONSTRAINT `prestamo_libro_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `libro` (`ISBN`),
  ADD CONSTRAINT `prestamo_libro_ibfk_2` FOREIGN KEY (`ID_Prestamo`) REFERENCES `prestamo` (`ID_Prestamo`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`ID_carrera`) REFERENCES `carrera` (`ID_carrera`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
