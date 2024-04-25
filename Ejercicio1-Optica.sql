CREATE TABLE Proveedores (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    fax VARCHAR(15),
    NIF VARCHAR(20)
);

CREATE TABLE MarcasUlleres (
    id_marca INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE Ulleres (
    id_ullera INT PRIMARY KEY AUTO_INCREMENT,
    id_marca INT,
    graduacion_vidre VARCHAR(20),
    tipus_muntura VARCHAR(20),
    color_muntura VARCHAR(50),
    color_vidre VARCHAR(50),
    preu DECIMAL(10, 2),
    id_proveedor INT,
    FOREIGN KEY (id_marca) REFERENCES MarcasUlleres(id_marca),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor)
);

CREATE TABLE Clients (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    adreca_postal VARCHAR(255),
    telefon VARCHAR(15),
    correu_electronic VARCHAR(100),
    data_registre DATE
);

CREATE TABLE Recomendacions (
    id_recomendacio INT PRIMARY KEY AUTO_INCREMENT,
    id_client_recomanador INT,
    id_client_recomanat INT,
    data_recomanacio DATE,
    FOREIGN KEY (id_client_recomanador) REFERENCES Clients(id_client),
    FOREIGN KEY (id_client_recomanat) REFERENCES Clients(id_client)
);

CREATE TABLE Vendes (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_ullera INT,
    id_client INT,
    id_empleat INT,
    data_venda DATE,
    FOREIGN KEY (id_ullera) REFERENCES Ulleres(id_ullera),
    FOREIGN KEY (id_client) REFERENCES Clients(id_client)
);

CREATE TABLE Empleats (
    id_empleat INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100)
);
