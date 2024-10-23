DROP DATABASE IF EXISTS primerparcialbbdd;
CREATE DATABASE primerparcialbbdd;
USE primerparcialbbdd;

CREATE TABLE localidad (
cod_localidad INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
CONSTRAINT PK_localidad PRIMARY KEY(cod_localidad));

CREATE TABLE pub (
cod_pub INT AUTO_INCREMENT NOT NULL,
nombre VARCHAR(60) NOT NULL,
licencia_fiscal VARCHAR(60) NOT NULL,
domicilio VARCHAR(50),
cod_localidad INT NOT NULL,
CONSTRAINT PK_pub PRIMARY KEY(cod_pub),
CONSTRAINT PK_localidad FOREIGN KEY(cod_localidad) REFERENCES pub(cod_pub));