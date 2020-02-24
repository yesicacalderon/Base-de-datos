CREATE DATABASE UnlaAutomotriz;
USE UnlaAutomotriz;
-- ***************************************DDL****************************************************
CREATE TABLE Linea_montaje(
	id_linea INT primary key
);
CREATE TABLE Estacion_trabajo(
	id_estacion INT primary key,
    nombre VARCHAR(50),
    cod_linea int,
    foreign key(cod_linea) references Linea_montaje(id_linea)
);
CREATE TABLE Insumo(
	id_insumo INT primary key,
    descripcion VARCHAR(50)
);
CREATE TABLE Proveedor(
	id_proveedor INT primary key,
    nombre VARCHAR(50)
);
CREATE TABLE Auto_proveedor(
	cod_proveedor INT,
    cod_insumo INT,
    primary key(cod_proveedor, cod_insumo),
    foreign key(cod_proveedor) references Proveedor(id_proveedor),
    foreign key(cod_insumo) references Insumo(id_insumo)
);
CREATE TABLE Detalle_insumo(
	codigo_estacion INT,
    codigo_insumo INT,
    cantidad INT,
    precio float,
    primary key(codigo_estacion, codigo_insumo),
    foreign key(codigo_estacion) references Estacion_trabajo(id_estacion),
    foreign key(codigo_insumo) references Insumo(id_insumo)
);
CREATE TABLE Modelo(
	id_modelo INT primary key,
    nombre VARCHAR(45),
    codigo_linea INT,
    foreign key(codigo_linea)references Linea_montaje(id_linea)
);
CREATE TABLE Concesionaria(
	id_concesionaria INT primary key,
    nombre VARCHAR(40)
);
CREATE TABLE Pedido(
	id_pedido VARCHAR(25) primary key,
    fecha_pedido DATE,
    cod_concesionaria int,
    foreign key(cod_concesionaria) references Concesionaria(id_concesionaria)
);
CREATE TABLE Detalle_pedido(
	cod_pedido VARCHAR(25),
    cod_modelo INT,
    cantidad INT,
    primary key(cod_pedido, cod_modelo),
    foreign key(cod_pedido) references Pedido(id_pedido),
    foreign key(cod_modelo) references Modelo(id_modelo)
);
CREATE TABLE Auto(
	chasis INT primary key,
    codigo_pedido VARCHAR(25),
    codigo_modelo INT,
    foreign key(codigo_pedido) references Pedido(id_pedido),
    foreign key(codigo_modelo) references Modelo(id_modelo)
);
CREATE TABLE Auto_en_produccion(
	cod_chasis INT,
    cod_estacion INT,
    fecha_hora_ingreso datetime,
    fecha_hora_egreso datetime,
    primary key(cod_chasis, cod_estacion),
    foreign key(cod_chasis) references Auto(chasis),
    foreign key(cod_estacion) references Estacion_trabajo(id_estacion)
);
-- DROP DATABASE UnlaAutomotriz;