-- create schema `UniversoLector`;

create table `socios`(
codigo INT Not Null primary Key auto_increment,
dni int not null,
nombre varchar(100) not null,
apellido varchar(100) not null,
direccion varchar(200) not null,
localidad varchar(100) not null
);

create table `editoriales`(
codigo INT Not Null primary Key auto_increment,
razon_social varchar(100) not null,
telefono varchar(100) not null
);

create table `prestamos`(
codigo INT Not Null primary Key auto_increment,
codigo_socio int not null, -- Agregar llave foranea
fechaa datetime not null,
fecha_devolucion date not null,
fecha_tope date not null
);

alter table prestamos modify fechaa date not null;
alter table prestamos modify fecha_devolucion date not null;
alter table prestamos modify fecha_tope date not null;

ALTER TABLE prestamos
ADD FOREIGN KEY (codigo_socio) REFERENCES socios(codigo);

create table `telefonoxSocio`(
codigo INT Not Null primary Key auto_increment,
codigo_socio int not null,
telefono varchar(100) not null,
foreign key (codigo_socio) references socios(codigo)
);

create table `autores`(
codigo INT Not Null primary Key auto_increment,
nombre varchar(100) not null,
apellido varchar(100) not null
);
-- CORRER
create table `libros`(
codigo INT Not Null primary Key auto_increment,
isbn varchar(13) not null,
titulo varchar(200) not null,
anio_escritura date not null,
codigo_autor int not null,
foreign key (codigo_autor) references autores(codigo),
anio_edicion date not null,
codigo_editorial int not null,
foreign key (codigo_editorial) references editoriales(codigo)
);
-- CORRER

create table `volumen`(
codigo int not null primary key auto_increment,
codigo_libro INT not null,
foreign key (codigo_libro) references libros(codigo),
deteriorado tinyint(1)
);

alter table volumen rename volumenes;

create table `prestamosxVolumen`(
codigo int not null primary key auto_increment,
codigo_prestamo INT not null,
foreign key (codigo_prestamo) references prestamos(codigo),
codigo_volumen INT not null,
foreign key (codigo_volumen) references volumenes(codigo)
);


insert into `universolector`. `socios`
(codigo, dni, nombre, apellido, direccion, localidad)
values
-- (1,3000000,"PATRICIA","JOHNSON","28 MySQL Boulevard","QLD"),
(2,2988800,"LINDA","WILLIAMS","23 Workhaven Lane","Alberta"),
(3,2500000,"BARBARA","JONES","1411 Lillydale Drive","QLD"),
(4,32980002,"LOIS","BUTLER","1688 Okara Way	Nothwest","Border Prov"),
(5,2313909,"ROBIN","HAYES","262 A Corua (La Corua) Parkway","Dhaka");

insert into `universolector`. `telefonoxsocio`
(codigo, codigo_socio, telefono)
values
(1, 1, "54911-45636453");

insert into `universolector`. `autores`
(codigo, nombre, apellido)
values
(1, "J.K.", "Rowling");

insert into `universolector`. `editoriales`
(codigo, razon_social, telefono)
values
(1,"Bloomsbury Publishing","54911564874"),
(2,"Scholastic","223483646"),
(3,"Pottermore Limited","5694839582"),
(4,"Editorial Salamandra","011-239-2343");

alter table libros
modify anio_edicion year not null;

alter table libros
modify anio_escritura year not null;

insert into `universolector`. `libros`
(codigo,isbn, titulo, anio_escritura, codigo_autor, anio_edicion, codigo_editorial)
values
(1,9781907545009,"Harry Potter y la piedra filosofal",1997,1,1997,4),
(2,9789878000114,"Harry Potter Y La Camara Secreta",2020,1,2020,4);

insert into `universolector`. `volumenes`
(codigo,codigo_libro, deteriorado)
values
(1,1,0),
(2,1,0),
(3,2,0);

insert into `universolector`. `prestamos`
(codigo,codigo_socio, fechaa, fecha_devolucion, fecha_tope)
values
(1,1,"2020/01/01","2020/07/01","2020/01/07"),
(2,1,"2020/01/07","2020/01/15","2020/01/14"),
(3,2,"2020/03/04","2020/03/08","2020/01/01");

insert into `universolector`. `prestamosxvolumen`
(codigo,codigo_prestamo, codigo_volumen)
values
(1,1,1),
(2,2,2),
(3,3,1),
(4,3,3);

alter table prestamos change `fechaa` `fecha` date not null;
delete from socios where codigo = 5;
update socios set direccion = "Alameda 001" where codigo = 3;