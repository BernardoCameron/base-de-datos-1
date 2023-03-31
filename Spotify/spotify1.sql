create table `usuarios` (
id int primary key not null auto_increment,
email varchar(100) not null,
contrasenia varchar(256) not null,
fecha_nacimiento date not null,
codigo_postal tinyint not null,
pais varchar(100) not null,
fecha_modificacion_contrasenia date not null,
fecha_expiracion_contrasenia date not null
);

create table playlists(
id int primary key not null auto_increment,
titulo varchar(100) not null,
total_canciones int not null,
fecha_creacion date not null,
id_usuario int not null,
foreign key(id_usuario) references usuarios(id),
id_playlist int not null,
foreign key(id_playlist) references estado_playlists(id)
);

create table canciones(
id int primary key not null auto_increment,
titulo varchar(100) not null,
duracion time not null,
total_reproducciones int not null,
total_likes int not null,
id_album int not null,
foreign key (id_album) references albumes(id)
);

create table estado_playlists(
id int primary key not null auto_increment,
estado varchar(10) not null
);

create table albumes(
id int primary key not null auto_increment,
titulo varchar(100) not null,
anio_publicacion year not null,
id_discografica int not null,
foreign key(id_discografica) references discograficas(id),
imagen_album varchar(500),
id_artista int not null,
foreign key(id_artista) references artistas(id)
);

create table artistas(
id int primary key not null auto_increment,
nombre varchar (100) not null,
imagen varchar(500)
);

create table discograficas(
id int primary key not null auto_increment,
nombre varchar(100) not null,
pais varchar(100) not null
);

create table generos(
id int primary key not null auto_increment,
nombre_genero varchar(100)
);

create table cancion_generos(
id int primary key not null auto_increment,
id_genero int not null,
foreign key (id_genero) references generos(id),
id_cancion int not null,
foreign key (id_cancion) references canciones(id)
);

create table tipo_usuario(
id int primary key not null auto_increment,
estado varchar(10) not null
);

alter table usuarios add id_tipo_usuario int not null;

alter table usuarios add foreign key(id_tipo_usuario) references tipo_usuario(id);

create table canciones_playlists(
id int,
id_cancion int not null,
foreign key (id_cancion) references canciones(id),
id_playlist int not null,
foreign key (id_playlist) references playlists(id)
);



