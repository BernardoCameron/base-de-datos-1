create schema DHespegar;

create table clientes(
id int primary key not null auto_increment,
nombre varchar(50) not null,
apellidos varchar(100) not null,
numero_pasaporte varchar(100),
direccion varchar(100) not null,
id_ciudad int not null,
foreign key (id_ciudad) references ciudades(id),
id_telefono int not null,
foreign key (id_telefono) references telefonos(id)

);

create table reservas (
id int primary key not null auto_increment,
codigo_reserva varchar(6) not null,
fecha_y_hora_reserva datetime not null,
id_tipo_reservas int not null,
foreign key (id_tipo_reservas) references tipo_reservas(id),
id_clientes int not null,
foreign key (id_clientes) references clientes(id),
factura_servicios int not null 
);


create table tipo_reservas(
id int primary key not null auto_increment,
id_vuelos int not null,
foreign key (id_vuelos) references vuelos(id),
id_hotel int not null,
foreign key (id_hotel) references hoteles(id)
);

create table vuelos(
id int primary key not null auto_increment,
tipo_vuelo varchar(40) not null,
categoria varchar(40) not null,
numero_vuelo varchar(6) not null,
fecha_partida datetime not null,
fecha_llegada_estimada datetime not null,
id_ciudad_destino int not null,
foreign key (id_ciudad_destino) references ciudades(id),
id_ciudad_origen int not null,
foreign key (id_ciudad_origen) references ciudades(id),
cantidad_turista tinyint not null,
cantidad_primera tinyint not null
);

create table hoteles(
id int primary key not null auto_increment,
nombre varchar(100) not null,
direccion varchar(100) not null,
id_ciudad int not null,
foreign key (id_ciudad) references ciudades(id),
id_telefono int not null,
foreign key (id_telefono) references telefonos(id),
cantidad_habitaciones tinyint not null,
tipo_hospedaje varchar(50)
);

create table tipo_de_pagos(
id int primary key not null auto_increment,
metodos_pago varchar(100) not null
);

create table pago_tarjetas(
id int primary key not null auto_increment,
nombre_titular varchar(100) not null,
numero_tarjeta tinyint(16) not null,
cvc tinyint(4) not null,
fecha_vencimiento date not null,
cuotas tinyint not null,
id_entidad_tarjeta int not null,
foreign key (id_entidad_tarjeta) references entidad_financieras(id),
total int not null
);

alter table pago_tarjetas add id_tipo_pago int not null;
ALTER TABLE pago_tarjetas
   ADD FOREIGN KEY (id_tipo_pago) references tipo_de_pagos(id);

create table entidad_financieras(
id int primary key not null auto_increment,
nombre varchar(100) not null,
id_telefono int not null,
foreign key (id_telefono) references telefonos(id)
);

create table paises(
id int primary key not null auto_increment,
nombre varchar(50) not null,
id_ciudad int not null,
foreign key (id_ciudad) references ciudades(id)
);

create table ciudades(
id int primary key not null auto_increment,
nombre varchar(100) not null
);

create table telefonos (
id int primary key not null auto_increment,
numero_telefono varchar(100) not null
);

create table sucursales (
id int primary key not null auto_increment,
nombre varchar(50) not null,
direccion varchar(50) not null,
id_ciudad int not null,
foreign key (id_ciudad) references ciudades(id),
id_telefono int not null,
foreign key (id_telefono) references telefonos(id)
);







