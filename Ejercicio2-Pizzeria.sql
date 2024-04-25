CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(255),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    provincia VARCHAR(100),
    telefono VARCHAR(15)
);

CREATE TABLE Comandas (
    id_comanda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_hora DATETIME,
    tipo_entrega ENUM('domicilio', 'recogida_en_tienda'),
    precio_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    imagen VARCHAR(255),
    precio DECIMAL(10, 2)
);

CREATE TABLE Categorias_Pizzas (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
);

CREATE TABLE Pizzas (
    id_pizza INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Pizzas(id_categoria)
);

CREATE TABLE Comandas_Productos (
    id_comanda INT,
    id_producto INT,
    cantidad INT,
    FOREIGN KEY (id_comanda) REFERENCES Comandas(id_comanda),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    PRIMARY KEY (id_comanda, id_producto)
);

CREATE TABLE Tiendas (
    id_tienda INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255),
    codigo_postal VARCHAR(10),
    localidad VARCHAR(100),
    provincia VARCHAR(100)
);

CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    NIF VARCHAR(20),
    telefono VARCHAR(15),
    tipo_trabajo ENUM('cocinero', 'repartidor'),
    id_tienda INT,
    FOREIGN KEY (id_tienda) REFERENCES Tiendas(id_tienda)
);

CREATE TABLE Entregas (
    id_comanda INT PRIMARY KEY,
    id_repartidor INT,
    fecha_hora_entrega DATETIME,
    FOREIGN KEY (id_comanda) REFERENCES Comandas(id_comanda),
    FOREIGN KEY (id_repartidor) REFERENCES Empleados(id_empleado)
);
