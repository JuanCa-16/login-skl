CREATE DATABASE skylink;

CREATE TABLE usuario(
    id VARCHAR(20) PRIMARY KEY,
    rol INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    clave VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL,
    pais VARCHAR(100) NOT NULL,
    millas INT NOT NULL DEFAULT 0
);

CREATE TABLE AEROPUERTO (
    Id_Aeropuerto INT PRIMARY KEY,
    Pais VARCHAR(100),
    Nombre VARCHAR(100),
    Ciudad VARCHAR(100));

CREATE TABLE VUELO (
    id_Vuelo INT PRIMARY KEY,
	id_Avion INT NOT NULL,
    estado VARCHAR(50),
    hora TIME,
    fecha DATE,
    aeropuertoLlegada INT,
    aeropuertoSalida INT,
    FOREIGN KEY (aeropuertoLlegada) REFERENCES AEROPUERTO(id_Aeropuerto),
    FOREIGN KEY (aeropuertoSalida) REFERENCES AEROPUERTO(id_Aeropuerto)
);

CREATE TABLE ADMINISTRAR (
    Id_Usuario VARCHAR(20),
    Id_Vuelo INT,
    PRIMARY KEY (Id_Usuario, Id_Vuelo),
    FOREIGN KEY (Id_Usuario) REFERENCES USUARIO(Id),
    FOREIGN KEY (Id_Vuelo) REFERENCES VUELO(Id_Vuelo)
);

CREATE TABLE ASIENTO (
    Id_Asiento INT PRIMARY KEY NOT NULL,
    Numero_Asiento VARCHAR(10),
    Estado VARCHAR(255),
    Vuelo INT NOT NULL,
    FOREIGN KEY (Vuelo) REFERENCES VUELO(Id_Vuelo)
);

INSERT INTO ASIENTO (Id_Asiento, Numero_Asiento, Estado, Vuelo) VALUES
(1, '0-0', 'Disponible', 1),
(2, '0-1', 'Ocupado', 1),
(3, '0-2', 'Disponible', 1),
(4, '0-3', 'Ocupado', 1),
(5, '0-4', 'Disponible', 1),
(6, '0-5', 'Ocupado', 1),
(7, '1-0', 'Disponible', 1),
(8, '1-1', 'Ocupado', 1),
(9, '1-2', 'Disponible', 1),
(10, '1-3', 'Ocupado', 1),
(11, '1-4', 'Disponible', 1),
(12, '1-5', 'Ocupado', 1),
(13, '2-0', 'Disponible', 1),
(14, '2-1', 'Ocupado', 1),
(15, '2-2', 'Disponible', 1),
(16, '2-3', 'Ocupado', 1),
(17, '2-4', 'Disponible', 1),
(18, '2-5', 'Ocupado', 1),
(19, '3-0', 'Disponible', 1),
(20, '3-1', 'Ocupado', 1),
(21, '3-2', 'Disponible', 1),
(22, '3-3', 'Ocupado', 1),
(23, '3-4', 'Disponible', 1),
(24, '3-5', 'Ocupado', 1),
(25, '4-0', 'Disponible', 1),
(26, '4-1', 'Ocupado', 1),
(27, '4-2', 'Disponible', 1),
(28, '4-3', 'Ocupado', 1),
(29, '4-4', 'Disponible', 1),
(30, '4-5', 'Ocupado', 1),
(31, '5-0', 'Disponible', 1),
(32, '5-1', 'Ocupado', 1),
(33, '5-2', 'Disponible', 1),
(34, '5-3', 'Ocupado', 1),
(35, '5-4', 'Disponible', 1),
(36, '5-5', 'Ocupado', 1),
(37, '6-0', 'Disponible', 1),
(38, '6-1', 'Ocupado', 1),
(39, '6-2', 'Disponible', 1),
(40, '6-3', 'Ocupado', 1),
(41, '6-4', 'Disponible', 1),
(42, '6-5', 'Ocupado', 1),
(43, '7-0', 'Disponible', 1),
(44, '7-1', 'Ocupado', 1),
(45, '7-2', 'Disponible', 1),
(46, '7-3', 'Ocupado', 1),
(47, '7-4', 'Disponible', 1),
(48, '7-5', 'Ocupado', 1),
(49, '8-0', 'Disponible', 1),
(50, '8-1', 'Ocupado', 1),
(51, '8-2', 'Disponible', 1),
(52, '8-3', 'Ocupado', 1),
(53, '8-4', 'Disponible', 1),
(54, '8-5', 'Ocupado', 1),
(55, '9-0', 'Disponible', 1),
(56, '9-1', 'Ocupado', 1),
(57, '9-2', 'Disponible', 1),
(58, '9-3', 'Ocupado', 1),
(59, '9-4', 'Disponible', 1),
(60, '9-5', 'Ocupado', 1);

INSERT INTO ASIENTO (Id_Asiento, Numero_Asiento, Estado, Vuelo) VALUES
(61, '0-0', 'Disponible', 2),
(62, '0-1', 'Disponible', 2),
(63, '0-2', 'Disponible', 2),
(64, '0-3', 'Disponible', 2),
(65, '0-4', 'Ocupado', 2),
(66, '0-5', 'Disponible', 2),
(67, '1-0', 'Disponible', 2),
(68, '1-1', 'Disponible', 2),
(69, '1-2', 'Disponible', 2),
(70, '1-3', 'Disponible', 2),
(71, '1-4', 'Disponible', 2),
(72, '1-5', 'Disponible', 2),
(73, '2-0', 'Disponible', 2),
(74, '2-1', 'Disponible', 2),
(75, '2-2', 'Disponible', 2),
(76, '2-3', 'Disponible', 2),
(77, '2-4', 'Disponible', 2),
(78, '2-5', 'Disponible', 2),
(79, '3-0', 'Disponible', 2),
(80, '3-1', 'Disponible', 2),
(81, '3-2', 'Disponible', 2),
(82, '3-3', 'Disponible', 2),
(83, '3-4', 'Disponible', 2),
(84, '3-5', 'Disponible', 2),
(85, '4-0', 'Disponible', 2),
(86, '4-1', 'Disponible', 2),
(87, '4-2', 'Disponible', 2),
(88, '4-3', 'Disponible', 2),
(89, '4-4', 'Disponible', 2),
(90, '4-5', 'Disponible', 2),
(91, '5-0', 'Disponible', 2),
(92, '5-1', 'Disponible', 2),
(93, '5-2', 'Disponible', 2),
(94, '5-3', 'Disponible', 2),
(95, '5-4', 'Disponible', 2),
(96, '5-5', 'Disponible', 2),
(97, '6-0', 'Disponible', 2),
(98, '6-1', 'Disponible', 2),
(99, '6-2', 'Disponible', 2),
(100, '6-3', 'Disponible', 2),
(101, '6-4', 'Disponible', 2),
(102, '6-5', 'Disponible', 2),
(103, '7-0', 'Disponible', 2),
(104, '7-1', 'Disponible', 2),
(105, '7-2', 'Disponible', 2),
(106, '7-3', 'Disponible', 2),
(107, '7-4', 'Disponible', 2),
(108, '7-5', 'Disponible', 2),
(109, '8-0', 'Disponible', 2),
(110, '8-1', 'Disponible', 2),
(111, '8-2', 'Disponible', 2),
(112, '8-3', 'Disponible', 2),
(113, '8-4', 'Disponible', 2),
(114, '8-5', 'Disponible', 2),
(115, '9-0', 'Disponible', 2),
(116, '9-1', 'Disponible', 2),
(117, '9-2', 'Disponible', 2),
(118, '9-3', 'Disponible', 2),
(119, '9-4', 'Disponible', 2),
(120, '9-5', 'Disponible', 2);


INSERT INTO ADMINISTRAR (Id_Usuario, Id_Vuelo)VALUES 
(33, 1),
(33,5),
(33,2);

INSERT INTO AEROPUERTO (Id_Aeropuerto, Pais, Nombre, Ciudad) VALUES 
(1, 'Colombia', 'Aeropuerto Internacional El Dorado', 'Bogota'),
(2, 'Colombia', 'Aeropuerto Jose Maria Cordova', 'Medellin'),
(3, 'Colombia', 'Aeropuerto Internacional Rafael Nunez', 'Cartagena'),
(4, 'Colombia', 'Aeropuerto Alfonso Bonilla Aragon', 'Cali'),
(5, 'Colombia', 'Aeropuerto Internacional Matecana', 'Pereira'),
(6, 'Colombia', 'Aeropuerto Internacional Ernesto Cortissoz', 'Barranquilla'),
(7, 'Colombia', 'Aeropuerto Internacional Palonegro', 'Bucaramanga'),
(8, 'Colombia', 'Aeropuerto Internacional Camilo Daza', 'Cucuta'),
(9, 'Colombia', 'Aeropuerto Internacional El Eden', 'Armenia'),
(10, 'Colombia', 'Aeropuerto Internacional Simon Bolivar', 'Santa Marta'),
(11, 'Colombia', 'Aeropuerto Gustavo Artunduaga Paredes', 'Flores'),
(12, 'Colombia', 'Aeropuerto Tres de Mayo', 'Puerto Asis'),
(13, 'Colombia', 'Aeropuerto Internacional Antonio Roldan Betancourt', 'Carepa'),
(14, 'Colombia', 'Aeropuerto Internacional El Carano', 'Quibdo'),
(15, 'Colombia', 'Aeropuerto Jorge Enrique Gonzalez Torres', 'San Jose del Guaviare'),
(16, 'Colombia', 'Aeropuerto Almirante Padilla', 'Riohacha'),
(17, 'Colombia', 'Aeropuerto Los Garzones', 'Monteria'),
(18, 'Colombia', 'Aeropuerto El Embrujo', 'Providencia'),
(19, 'Colombia', 'Aeropuerto El Carano', 'Quibdo'),
(20, 'Colombia', 'Aeropuerto El Placer', 'Pasto'),
(21, 'Colombia', 'Aeropuerto Gustavo Rojas Pinilla', 'San Andres'),
(22, 'Colombia', 'Aeropuerto Gerardo Tobar Lopez', 'Puerto Carreno'),
(23, 'Colombia', 'Aeropuerto Jorge Isaac', 'El Banco'),
(24, 'Colombia', 'Aeropuerto Rafael Cabrera Mustafa', 'Saravena'),
(25, 'Colombia', 'Aeropuerto El Yopal', 'Yopal'),
(26, 'Colombia', 'Aeropuerto Benito Salas', 'Neiva'),
(27, 'Colombia', 'Aeropuerto El Guamo', 'Mariquita'),
(28, 'Colombia', 'Aeropuerto Gustavo Vargas', 'Tumaco'),
(29, 'Colombia', 'Aeropuerto de Guapi', 'Guapi'),
(30, 'Colombia', 'Aeropuerto del Valle del Cauca', 'Cartago'),
(31, 'Colombia', 'Aeropuerto de San Luis', 'San Luis'),
(32, 'Colombia', 'Aeropuerto de Mariquita', 'Mariquita'),
(33, 'Colombia', 'Aeropuerto de San Bernardo', 'San Bernardo'),
(34, 'Colombia', 'Aeropuerto de Popayan', 'Popayan'),
(35, 'Colombia', 'Aeropuerto de Malaga', 'Malaga'),
(36, 'Colombia', 'Aeropuerto de Bello', 'Bello'),
(37, 'Colombia', 'Aeropuerto de Tulua', 'Tulua'),
(38, 'Colombia', 'Aeropuerto de Buga', 'Buga'),
(39, 'Colombia', 'Aeropuerto de Puerto Boyaca', 'Puerto Boyaca'),
(40, 'Colombia', 'Aeropuerto de Chiquinquira', 'Chiquinquira'),
(41, 'Colombia', 'Aeropuerto de Montelibano', 'Montelibano'),
(42, 'Colombia', 'Aeropuerto de Filandia', 'Filandia'),
(43, 'Colombia', 'Aeropuerto de Calarca', 'Calarca'),
(44, 'Colombia', 'Aeropuerto de Planadas', 'Planadas'),
(45, 'Colombia', 'Aeropuerto de Cajamarca', 'Cajamarca'),
(46, 'Colombia', 'Aeropuerto de Circasia', 'Circasia'),
(47, 'Colombia', 'Aeropuerto de Manizales', 'Manizales'),
(48, 'Colombia', 'Aeropuerto de Riosucio', 'Riosucio'),
(49, 'Colombia', 'Aeropuerto de Armenia', 'Armenia'),
(50, 'Colombia', 'Aeropuerto de Chinchina', 'Chinchina');

-- Día 1
INSERT INTO VUELO (id_Vuelo, id_Avion, estado, hora, fecha, aeropuertoLlegada, aeropuertoSalida) VALUES
(1, 1, 'Programado', '08:00:00', '2024-05-14', 2, 1),
(2, 2, 'Programado', '10:00:00', '2024-05-14', 3, 1),
(3, 3, 'Programado', '12:00:00', '2024-05-14', 2, 1),
(4, 4, 'Programado', '14:00:00', '2024-05-14', 3, 1),

-- Día 2
(5, 1, 'Programado', '08:00:00', '2024-05-15', 3, 2),
(6, 2, 'Programado', '10:00:00', '2024-05-15', 4, 2),
(7, 3, 'Programado', '12:00:00', '2024-05-15', 3, 2),
(8, 4, 'Programado', '14:00:00', '2024-05-15', 4, 2),

-- Día 3
(9, 1, 'Programado', '08:00:00', '2024-05-16', 4, 3),
(10, 2, 'Programado', '10:00:00', '2024-05-16', 5, 3),
(11, 3, 'Programado', '12:00:00', '2024-05-16', 4, 3),
(12, 4, 'Programado', '14:00:00', '2024-05-16', 5, 3),

-- Día 4
(13, 1, 'Programado', '08:00:00', '2024-05-17', 5, 4),
(14, 2, 'Programado', '10:00:00', '2024-05-17', 6, 4),
(15, 3, 'Programado', '12:00:00', '2024-05-17', 5, 4),
(16, 4, 'Programado', '14:00:00', '2024-05-17', 6, 4),

-- Día 5
(17, 1, 'Programado', '08:00:00', '2024-05-18', 6, 5),
(18, 2, 'Programado', '10:00:00', '2024-05-18', 7, 5),
(19, 3, 'Programado', '12:00:00', '2024-05-18', 6, 5),
(20, 4, 'Programado', '14:00:00', '2024-05-18', 7, 5),

-- Día 6
(21, 1, 'Programado', '08:00:00', '2024-05-19', 7, 6),
(22, 2, 'Programado', '10:00:00', '2024-05-19', 8, 6),
(23, 3, 'Programado', '12:00:00', '2024-05-19', 7, 6),
(24, 4, 'Programado', '14:00:00', '2024-05-19', 8, 6),

-- Día 7
(25, 1, 'Programado', '08:00:00', '2024-05-20', 8, 7),
(26, 2, 'Programado', '10:00:00', '2024-05-20', 9, 7),
(27, 3, 'Programado', '12:00:00', '2024-05-20', 8, 7),
(28, 4, 'Programado', '14:00:00', '2024-05-20', 9, 7),

-- Día 8
(29, 1, 'Programado', '08:00:00', '2024-05-21', 9, 8),
(30, 2, 'Programado', '10:00:00', '2024-05-21', 10, 8),
(31, 3, 'Programado', '12:00:00', '2024-05-21', 9, 8),
(32, 4, 'Programado', '14:00:00', '2024-05-21', 10, 8),

-- Día 9
(33, 1, 'Programado', '08:00:00', '2024-05-22', 10, 9),
(34, 2, 'Programado', '10:00:00', '2024-05-22', 11, 9),
(35, 3, 'Programado', '12:00:00', '2024-05-22', 10, 9),
(36, 4, 'Programado', '14:00:00', '2024-05-22', 11, 9),

-- Día 10
(37, 1, 'Programado', '08:00:00', '2024-05-23', 11, 10),
(38, 2, 'Programado', '10:00:00', '2024-05-23', 12, 10),
(39, 3, 'Programado', '12:00:00', '2024-05-23', 11, 10),
(40, 4, 'Programado', '14:00:00', '2024-05-23', 12, 10),

-- Día 11
(41, 1, 'Programado', '08:00:00', '2024-05-24', 12, 11),
(42, 2, 'Programado', '10:00:00', '2024-05-24', 13, 11),
(43, 3, 'Programado', '12:00:00', '2024-05-24', 12, 11),
(44, 4, 'Programado', '14:00:00', '2024-05-24', 13, 11),

-- Día 12
(45, 1, 'Programado', '08:00:00', '2024-05-25', 13, 12),
(46, 2, 'Programado', '10:00:00', '2024-05-25', 14, 12),
(47, 3, 'Programado', '12:00:00', '2024-05-25', 13, 12),
(48, 4, 'Programado', '14:00:00', '2024-05-25', 14, 12),

-- Día 13
(49, 1, 'Programado', '08:00:00', '2024-05-26', 14, 13),
(50, 2, 'Programado', '10:00:00', '2024-05-26', 15, 13),
(51, 3, 'Programado', '12:00:00', '2024-05-26', 14, 13),
(52, 4, 'Programado', '14:00:00', '2024-05-26', 15, 13),

-- Día 14
(53, 1, 'Programado', '08:00:00', '2024-05-27', 15, 14),
(54, 2, 'Programado', '10:00:00', '2024-05-27', 16, 14),
(55, 3, 'Programado', '12:00:00', '2024-05-27', 15, 14),
(56, 4, 'Programado', '14:00:00', '2024-05-27', 16, 14),

-- Día 15
(57, 1, 'Programado', '08:00:00', '2024-05-28', 16, 15),
(58, 2, 'Programado', '10:00:00', '2024-05-28', 17, 15),
(59, 3, 'Programado', '12:00:00', '2024-05-28', 16, 15),
(60, 4, 'Programado', '14:00:00', '2024-05-28', 17, 15),

-- Día 16
(61, 1, 'Programado', '08:00:00', '2024-05-29', 17, 16),
(62, 2, 'Programado', '10:00:00', '2024-05-29', 18, 16),
(63, 3, 'Programado', '12:00:00', '2024-05-29', 17, 16),
(64, 4, 'Programado', '14:00:00', '2024-05-29', 18, 16),

-- Día 17
(65, 1, 'Programado', '08:00:00', '2024-05-30', 18, 17),
(66, 2, 'Programado', '10:00:00', '2024-05-30', 19, 17),
(67, 3, 'Programado', '12:00:00', '2024-05-30', 18, 17),
(68, 4, 'Programado', '14:00:00', '2024-05-30', 19, 17),

-- Día 18
(69, 1, 'Programado', '08:00:00', '2024-05-31', 19, 18),
(70, 2, 'Programado', '10:00:00', '2024-05-31', 20, 18),
(71, 3, 'Programado', '12:00:00', '2024-05-31', 19, 18),
(72, 4, 'Programado', '14:00:00', '2024-05-31', 20, 18),

-- Día 19
(73, 1, 'Programado', '08:00:00', '2024-06-01', 20, 19),
(74, 2, 'Programado', '10:00:00', '2024-06-01', 21, 19),
(75, 3, 'Programado', '12:00:00', '2024-06-01', 20, 19),
(76, 4, 'Programado', '14:00:00', '2024-06-01', 21, 19),

-- Día 20
(77, 1, 'Programado', '08:00:00', '2024-06-02', 21, 20),
(78, 2, 'Programado', '10:00:00', '2024-06-02', 22, 20),
(79, 3, 'Programado', '12:00:00', '2024-06-02', 21, 20),
(80, 4, 'Programado', '14:00:00', '2024-06-02', 22, 20),

-- Día 21
(81, 1, 'Programado', '08:00:00', '2024-06-03', 22, 21),
(82, 2, 'Programado', '10:00:00', '2024-06-03', 23, 21),
(83, 3, 'Programado', '12:00:00', '2024-06-03', 22, 21),
(84, 4, 'Programado', '14:00:00', '2024-06-03', 23, 21),

-- Día 22
(85, 1, 'Programado', '08:00:00', '2024-06-04', 23, 22),
(86, 2, 'Programado', '10:00:00', '2024-06-04', 24, 22),
(87, 3, 'Programado', '12:00:00', '2024-06-04', 23, 22),
(88, 4, 'Programado', '14:00:00', '2024-06-04', 24, 22),

-- Día 23
(89, 1, 'Programado', '08:00:00', '2024-06-05', 24, 23),
(90, 2, 'Programado', '10:00:00', '2024-06-05', 25, 23),
(91, 3, 'Programado', '12:00:00', '2024-06-05', 24, 23),
(92, 4, 'Programado', '14:00:00', '2024-06-05', 25, 23),

-- Día 24
(93, 1, 'Programado', '08:00:00', '2024-06-06', 25, 24),
(94, 2, 'Programado', '10:00:00', '2024-06-06', 26, 24),
(95, 3, 'Programado', '12:00:00', '2024-06-06', 25, 24),
(96, 4, 'Programado', '14:00:00', '2024-06-06', 26, 24),

-- Día 25
(97, 1, 'Programado', '08:00:00', '2024-06-07', 26, 25),
(98, 2, 'Programado', '10:00:00', '2024-06-07', 27, 25),
(99, 3, 'Programado', '12:00:00', '2024-06-07', 26, 25),
(100, 4, 'Programado', '14:00:00', '2024-06-07', 27, 25),

-- Día 26
(101, 1, 'Programado', '08:00:00', '2024-06-08', 27, 26),
(102, 2, 'Programado', '10:00:00', '2024-06-08', 28, 26),
(103, 3, 'Programado', '12:00:00', '2024-06-08', 27, 26),
(104, 4, 'Programado', '14:00:00', '2024-06-08', 28, 26),

-- Día 27
(105, 1, 'Programado', '08:00:00', '2024-06-09', 28, 27),
(106, 2, 'Programado', '10:00:00', '2024-06-09', 29, 27),
(107, 3, 'Programado', '12:00:00', '2024-06-09', 28, 27),
(108, 4, 'Programado', '14:00:00', '2024-06-09', 29, 27),

-- Día 28
(109, 1, 'Programado', '08:00:00', '2024-06-10', 29, 28),
(110, 2, 'Programado', '10:00:00', '2024-06-10', 30, 28),
(111, 3, 'Programado', '12:00:00', '2024-06-10', 29, 28),
(112, 4, 'Programado', '14:00:00', '2024-06-10', 30, 28),

-- Día 29
(113, 1, 'Programado', '08:00:00', '2024-06-11', 30, 29),
(114, 2, 'Programado', '10:00:00', '2024-06-11', 31, 29),
(115, 3, 'Programado', '12:00:00', '2024-06-11', 30, 29),
(116, 4, 'Programado', '14:00:00', '2024-06-11', 31, 29),

-- Día 30
(117, 1, 'Programado', '08:00:00', '2024-06-12', 31, 30),
(118, 2, 'Programado', '10:00:00', '2024-06-12', 32, 30),
(119, 3, 'Programado', '12:00:00', '2024-06-12', 31, 30),
(120, 4, 'Programado', '14:00:00', '2024-06-12', 32, 30),

-- Día 31
(121, 1, 'Programado', '08:00:00', '2024-06-13', 32, 31),
(122, 2, 'Programado', '10:00:00', '2024-06-13', 33, 31),
(123, 3, 'Programado', '12:00:00', '2024-06-13', 32, 31),
(124, 4, 'Programado', '14:00:00', '2024-06-13', 33, 31),

-- Día 32
(125, 1, 'Programado', '08:00:00', '2024-06-14', 33, 32),
(126, 2, 'Programado', '10:00:00', '2024-06-14', 34, 32),
(127, 3, 'Programado', '12:00:00', '2024-06-14', 33, 32),
(128, 4, 'Programado', '14:00:00', '2024-06-14', 34, 32),

-- Día 33
(129, 1, 'Programado', '08:00:00', '2024-06-15', 34, 33),
(130, 2, 'Programado', '10:00:00', '2024-06-15', 35, 33),
(131, 3, 'Programado', '12:00:00', '2024-06-15', 34, 33),
(132, 4, 'Programado', '14:00:00', '2024-06-15', 35, 33),

-- Día 34
(133, 1, 'Programado', '08:00:00', '2024-06-16', 35, 34),
(134, 2, 'Programado', '10:00:00', '2024-06-16', 36, 34),
(135, 3, 'Programado', '12:00:00', '2024-06-16', 35, 34),
(136, 4, 'Programado', '14:00:00', '2024-06-16', 36, 34),

-- Día 35
(137, 1, 'Programado', '08:00:00', '2024-06-17', 36, 35),
(138, 2, 'Programado', '10:00:00', '2024-06-17', 37, 35),
(139, 3, 'Programado', '12:00:00', '2024-06-17', 36, 35),
(140, 4, 'Programado', '14:00:00', '2024-06-17', 37, 35),

-- Día 36
(141, 1, 'Programado', '08:00:00', '2024-06-18', 37, 36),
(142, 2, 'Programado', '10:00:00', '2024-06-18', 38, 36),
(143, 3, 'Programado', '12:00:00', '2024-06-18', 37, 36),
(144, 4, 'Programado', '14:00:00', '2024-06-18', 38, 36),

-- Día 37
(145, 1, 'Programado', '08:00:00', '2024-06-19', 38, 37),
(146, 2, 'Programado', '10:00:00', '2024-06-19', 39, 37),
(147, 3, 'Programado', '12:00:00', '2024-06-19', 38, 37),
(148, 4, 'Programado', '14:00:00', '2024-06-19', 39, 37),

-- Día 38
(149, 1, 'Programado', '08:00:00', '2024-06-20', 39, 38),
(150, 2, 'Programado', '10:00:00', '2024-06-20', 40, 38),
(151, 3, 'Programado', '12:00:00', '2024-06-20', 39, 38),
(152, 4, 'Programado', '14:00:00', '2024-06-20', 40, 38),

-- Día 39
(153, 1, 'Programado', '08:00:00', '2024-06-21', 40, 39),
(154, 2, 'Programado', '10:00:00', '2024-06-21', 41, 39),
(155, 3, 'Programado', '12:00:00', '2024-06-21', 40, 39),
(156, 4, 'Programado', '14:00:00', '2024-06-21', 41, 39),

-- Día 40
(157, 1, 'Programado', '08:00:00', '2024-06-22', 41, 40),
(158, 2, 'Programado', '10:00:00', '2024-06-22', 42, 40),
(159, 3, 'Programado', '12:00:00', '2024-06-22', 41, 40),
(160, 4, 'Programado', '14:00:00', '2024-06-22', 42, 40),

-- Día 41
(161, 1, 'Programado', '08:00:00', '2024-06-23', 42, 41),
(162, 2, 'Programado', '10:00:00', '2024-06-23', 43, 41),
(163, 3, 'Programado', '12:00:00', '2024-06-23', 42, 41),
(164, 4, 'Programado', '14:00:00', '2024-06-23', 43, 41),

-- Día 42
(165, 1, 'Programado', '08:00:00', '2024-06-24', 43, 42),
(166, 2, 'Programado', '10:00:00', '2024-06-24', 44, 42),
(167, 3, 'Programado', '12:00:00', '2024-06-24', 43, 42),
(168, 4, 'Programado', '14:00:00', '2024-06-24', 44, 42),

-- Día 43
(169, 1, 'Programado', '08:00:00', '2024-06-25', 44, 43),
(170, 2, 'Programado', '10:00:00', '2024-06-25', 45, 43),
(171, 3, 'Programado', '12:00:00', '2024-06-25', 44, 43),
(172, 4, 'Programado', '14:00:00', '2024-06-25', 45, 43),

-- Día 44
(173, 1, 'Programado', '08:00:00', '2024-06-26', 45, 44),
(174, 1, 'Programado', '10:00:00', '2024-06-26', 46, 44),
(175, 1, 'Programado', '12:00:00', '2024-06-26', 45, 44),
(176, 1, 'Programado', '14:00:00', '2024-06-26', 46, 44),

-- Día 45
(177, 1, 'Programado', '08:00:00', '2024-06-27', 46, 45),
(178, 2, 'Programado', '10:00:00', '2024-06-27', 47, 45),
(179, 3, 'Programado', '12:00:00', '2024-06-27', 46, 45),
(180, 4, 'Programado', '14:00:00', '2024-06-27', 47, 45),

-- Día 46
(181, 1, 'Programado', '08:00:00', '2024-06-28', 47, 46),
(182, 2, 'Programado', '10:00:00', '2024-06-28', 48, 46),
(183, 3, 'Programado', '12:00:00', '2024-06-28', 47, 46),
(184, 4, 'Programado', '14:00:00', '2024-06-28', 48, 46),

-- Día 47
(185, 1, 'Programado', '08:00:00', '2024-06-29', 48, 47),
(186, 2, 'Programado', '10:00:00', '2024-06-29', 49, 47),
(187, 3, 'Programado', '12:00:00', '2024-06-29', 48, 47),
(188, 4, 'Programado', '14:00:00', '2024-06-29', 49, 47),

-- Día 48
(189, 1, 'Programado', '08:00:00', '2024-06-30', 49, 48),
(190, 2, 'Programado', '10:00:00', '2024-06-30', 50, 48),
(191, 3, 'Programado', '12:00:00', '2024-06-30', 49, 48),
(192, 3, 'Programado', '14:00:00', '2024-06-30', 50, 48),

-- Día 49
(193, 1, 'Programado', '08:00:00', '2024-07-01', 50, 49),
(194, 2, 'Programado', '10:00:00', '2024-07-01', 1, 49),
(195, 3, 'Programado', '12:00:00', '2024-07-01', 50, 49),
(196, 4, 'Programado', '14:00:00', '2024-07-01', 1, 49),

-- Día 50
(197, 1, 'Programado', '08:00:00', '2024-07-02', 1, 50),
(198, 2, 'Programado', '10:00:00', '2024-07-02', 2, 50),
(199, 3, 'Programado', '12:00:00', '2024-07-02', 1, 50),
(200, 4, 'Programado', '14:00:00', '2024-07-02', 2, 50);