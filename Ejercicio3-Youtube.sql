CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    nombre_usuario VARCHAR(100),
    fecha_nacimiento DATE,
    sexo VARCHAR(10),
    pais VARCHAR(100),
    codigo_postal VARCHAR(10)
);

CREATE TABLE Videos (
    id_video INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    descripcion TEXT,
    tamano INT,
    nombre_archivo VARCHAR(255),
    duracion TIME,
    thumbnail VARCHAR(255),
    reproducciones INT DEFAULT 0,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    estado ENUM('publico', 'oculto', 'privado'),
    fecha_publicacion DATETIME,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Etiquetas (
    id_etiqueta INT PRIMARY KEY AUTO_INCREMENT,
    nombre_etiqueta VARCHAR(100)
);

CREATE TABLE Videos_Etiquetas (
    id_video INT,
    id_etiqueta INT,
    FOREIGN KEY (id_video) REFERENCES Videos(id_video),
    FOREIGN KEY (id_etiqueta) REFERENCES Etiquetas(id_etiqueta),
    PRIMARY KEY (id_video, id_etiqueta)
);

CREATE TABLE Canales (
    id_canal INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    fecha_creacion DATE,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Suscripciones (
    id_usuario_suscriptor INT,
    id_canal_suscrito INT,
    fecha_suscripcion DATETIME,
    FOREIGN KEY (id_usuario_suscriptor) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_canal_suscrito) REFERENCES Canales(id_canal),
    PRIMARY KEY (id_usuario_suscriptor, id_canal_suscrito)
);

CREATE TABLE Playlists (
    id_playlist INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    fecha_creacion DATE,
    estado ENUM('publica', 'privada'),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Playlist_Videos (
    id_playlist INT,
    id_video INT,
    FOREIGN KEY (id_playlist) REFERENCES Playlists(id_playlist),
    FOREIGN KEY (id_video) REFERENCES Videos(id_video),
    PRIMARY KEY (id_playlist, id_video)
);

CREATE TABLE Comentarios (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    texto_comentario TEXT,
    fecha_hora_comentario DATETIME,
    id_usuario INT,
    id_video INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_video) REFERENCES Videos(id_video)
);

CREATE TABLE Likes_Dislikes_Comentarios (
    id_usuario INT,
    id_comentario INT,
    tipo ENUM('like', 'dislike'),
    fecha_hora_like_dislike DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_comentario) REFERENCES Comentarios(id_comentario),
    PRIMARY KEY (id_usuario, id_comentario)
);
