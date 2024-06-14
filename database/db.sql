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

CREATE TABLE TIQUETE (
    Id_Tiquete SERIAL PRIMARY KEY,
    Metodo_de_pago VARCHAR(255),
    Asientos VARCHAR(50),
    Clase VARCHAR(50),
    Precio INT,
    Id_Vuelo INT NOT NULL,
    Id_Usuario VARCHAR(20) NOT NULL,
    FOREIGN KEY (Id_Vuelo) REFERENCES VUELO(id_Vuelo),
    FOREIGN KEY (Id_Usuario) REFERENCES USUARIO(id)
);

CREATE TABLE COMIDA (
    Id_Comida SERIAL PRIMARY KEY,
    Nombre VARCHAR(255),
    Id_TiqueteV INT NOT NULL,
    FOREIGN KEY (Id_TiqueteV) REFERENCES TIQUETE(Id_Tiquete)
);

CREATE TABLE EQUIPAJE (
    Id_Equipaje SERIAL PRIMARY KEY,
    Maleta VARCHAR(255),
    Id_TiqueteV INT NOT NULL,
    FOREIGN KEY (Id_TiqueteV) REFERENCES TIQUETE(Id_Tiquete)
);


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
