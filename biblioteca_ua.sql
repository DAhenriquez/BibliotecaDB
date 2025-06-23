CREATE TABLE `Carrera` (
  `ID_carrera` INT AUTO_INCREMENT,
  `nombre_ca` Varchar(30),
  PRIMARY KEY (`ID_carrera`)
);

CREATE TABLE `Libro` (
  `ISBN` INT,
  `Titulo` Varchar(30),
  `Autor` Varchar(30),
  `Genero` Varchar(30),
  `Fecha_publicacion` DATE,
  PRIMARY KEY (`ISBN`)
);

CREATE TABLE `Usuario` (
  `Rut` INT,
  `ID_carrera` INT,
  `Nombre_completo` Varchar(30),
  `Email` Varchar(40),
  `telefono` INT,
  PRIMARY KEY (`Rut`),
  FOREIGN KEY (`ID_carrera`) REFERENCES `Carrera`(`ID_carrera`)
);

CREATE TABLE `Prestamo` (
  `ID_Prestamo` INT AUTO_INCREMENT,
  `Rut` INT,
  PRIMARY KEY (`ID_Prestamo`),
  FOREIGN KEY (`Rut`) REFERENCES `Usuario`(`Rut`)
);

CREATE TABLE `Prestamo_libro` (
  `ID_Prestamo` INT,
  `ISBN` INT,
  `inicio_libro` DATETIME,
  `fin_libro` DATETIME,
  PRIMARY KEY (`ID_Prestamo`, `ISBN`),
  FOREIGN KEY (`ISBN`) REFERENCES `Libro`(`ISBN`),
  FOREIGN KEY (`ID_Prestamo`) REFERENCES `Prestamo`(`ID_Prestamo`)
);

CREATE TABLE `Edificio` (
  `ID_edificio` INT AUTO_INCREMENT,
  `letra_edificio` varchar(1),
  PRIMARY KEY (`ID_edificio`)
);

CREATE TABLE `Box` (
  `ID_box` INT AUTO_INCREMENT,
  `ID_edificio` INT,
  `Capacidad` INT,
  PRIMARY KEY (`ID_box`),
  FOREIGN KEY (`ID_edificio`) REFERENCES `Edificio`(`ID_edificio`)
);

CREATE TABLE `Prestamo_Box` (
  `ID_Prestamo` INT,
  `ID_box` INT,
  `inicio_box` DATETIME,
  `fin_box` DATETIME,
  PRIMARY KEY (`ID_Prestamo`, `ID_box`),
  FOREIGN KEY (`ID_box`) REFERENCES `Box`(`ID_box`),
  FOREIGN KEY (`ID_Prestamo`) REFERENCES `Prestamo`(`ID_Prestamo`)
);
