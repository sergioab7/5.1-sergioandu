DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify;
USE spotify;
CREATE TABLE usuarios(
	usuario_id INT(11) NOT NULL AUTO_INCREMENT,
    email VARCHAR(45) NOT NULL UNIQUE,
    contraseña VARCHAR(45) NOT NULL,
    nombre_usuario VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('masculino', 'femenino') NOT NULL,
    pais VARCHAR(30) NOT NULL,
    codigo_postal INT(11) NOT NULL,
    PRIMARY KEY(usuario_id)
);

CREATE TABLE usuarios_premium(
	usuarios_premium_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    PRIMARY KEY(usuarios_premium_id),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(usuario_id)
);

CREATE TABLE suscripciones_premium(
	suscripcion_premium_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario_premium INT(11),
    fecha_inicio_suscripcion DATE NOT NULL,
    fecha_fin_suscripcion DATE NOT NULL,
    forma_pago ENUM('tarjeta', 'paypal') NOT NULL,
    PRIMARY KEY(suscripcion_premium_id),
    FOREIGN KEY(id_usuario_premium) REFERENCES usuarios_premium(usuarios_premium_id)
);

CREATE TABLE tarjetas(
	tarjeta_id INT(11) NOT NULL AUTO_INCREMENT,
	id_usuario_premium INT(11) NOT NULL,
    numero_tarjeta INT(16) NOT NULL,
    mes_año DATE NOT NULL,
    codigo_seguridad INT(3) NOT NULL,
    PRIMARY KEY(tarjeta_id),
    FOREIGN KEY(id_usuario_premium) REFERENCES usuarios_premium(usuarios_premium_id)
);

CREATE TABLE paypal(
	paypal_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario_premium INT(11) NOT NULL,
    nombre_usuario_paypal VARCHAR(30) NOT NULL,
    PRIMARY KEY(paypal_id),
    FOREIGN KEY(id_usuario_premium) REFERENCES usuarios_premium(usuarios_premium_id)
);

CREATE TABLE registro_pago(
	registro_pago_id INT(11) NOT NULL AUTO_INCREMENT,
    id_tarjeta INT(11) NOT NULL UNIQUE,
    id_paypal INT(11) NOT NULL,
    fecha_pago DATE NOT NULL,
    total_pagos DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(registro_pago_id),
    FOREIGN KEY(id_tarjeta) REFERENCES tarjetas(tarjeta_id),
    FOREIGN KEY(id_paypal) REFERENCES paypal(paypal_id)
);

CREATE TABLE playlist_activas(
	playlist_activa_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    titulo VARCHAR(20) NOT NULL,
    numero_canciones INT(3) NOT NULL,
    fecha_creacion TIMESTAMP,
    PRIMARY KEY(playlist_activa_id),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(usuario_id)
);

CREATE TABLE playlist_borrada(
	playlist_borrada_id INT(11) NOT NULL AUTO_INCREMENT,
    id_playlist INT(11) NOT NULL,
    fecha_eliminacion TIMESTAMP,
    PRIMARY KEY(playlist_borrada_id),
    FOREIGN KEY(id_playlist) REFERENCES playlist_activas(playlist_activa_id)
);

CREATE TABLE artistas(
	artista_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    imagen BLOB NOT NULL,
    PRIMARY KEY(artista_id)
);

CREATE TABLE albums(
	album_id INT(11) NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(25) NOT NULL,
    año_publicacion TINYINT(4) NOT NULL,
    portada BLOB NOT NULL,
    id_artista INT(11) NOT NULL,
    PRIMARY KEY(album_id),
    FOREIGN KEY(id_artista) REFERENCES artistas(artista_id)
);

CREATE TABLE canciones(
	cancion_id INT(11) NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(30) NOT NULL,
    duracion VARCHAR(10) NOT NULL,
    numero_reproducciones INT(11) NOT NULL,
    id_album INT(11) NOT NULL,
    PRIMARY KEY(cancion_id),
    FOREIGN KEY(id_album) REFERENCES albums(album_id)
);

CREATE TABLE cancion_añadida(
	cancion_añadida_id INT(11) NOT NULL AUTO_INCREMENT,
    id_playlist INT(11) NOT NULL,
    id_usuario INT(11) NOT NULL,
    id_cancion INT(11) NOT NULL,
    fecha_añadida TIMESTAMP NOT NULL,
    PRIMARY KEY(cancion_añadida_id),
    FOREIGN KEY(id_playlist) REFERENCES playlist_activas(playlist_activa_id),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(usuario_id),
    FOREIGN KEY(id_cancion) REFERENCES canciones(cancion_id)
);

CREATE TABLE artistas_relacionado(
	artista_relacionado_id INT(11) NOT NULL AUTO_INCREMENT,
    id_artista_1 INT(11) NOT NULL,
    id_artista_2 INT(11) NOT NULL,
    PRIMARY KEY(artista_relacionado_id),
    FOREIGN KEY(id_artista_1) REFERENCES artistas(artista_id),
    FOREIGN KEY(id_artista_2) REFERENCES artistas(artista_id)
);

CREATE TABLE albumes_favoritos(
	album_favorito_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    id_album INT(11) NOT NULL,
    PRIMARY KEY(album_favorito_id),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(usuario_id),
    FOREIGN KEY(id_album) REFERENCES albums(album_id)
);

CREATE TABLE canciones_favoritas(
	cancion_favorita_id INT(11) NOT NULL AUTO_INCREMENT,
    id_usuario INT(11) NOT NULL,
    id_cancion INT(11) NOT NULL,
    PRIMARY KEY(cancion_favorita_id),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(usuario_id),
    FOREIGN KEY(id_cancion) REFERENCES canciones(cancion_id)
);