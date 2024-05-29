-- \\\\\\\\\\     BASIC CONFIG      \\\\\\\\\\

-- ~~~~~ CREACION DE ROLES Y DATABASE ~~~~~
CREATE USER admin_vf CREATEDB CREATEROLE ENCRYPTED PASSWORD 'admin1234';


-- ~~~~~ CREACION DE TABLAS ~~~~~
CREATE TABLE admin (
    id_admin SERIAL,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    passwd VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_admin)
);

CREATE TABLE usuario (
    id_usr SERIAL,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    nacionalidad VARCHAR(20),
    direccion VARCHAR(50),
    id_admin SERIAL,
    PRIMARY KEY (id_usr),
    FOREIGN KEY (id_admin) REFERENCES admin (id_admin)
);

CREATE TABLE mascota (
    id_usr SERIAL,
    tipo VARCHAR(15) NOT NULL,
    raza VARCHAR(15) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_usr),
    FOREIGN KEY (id_usr) REFERENCES usuario (id_usr)
);

CREATE TABLE telofono_usuario (
    id_usr SERIAL,
    telefono VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY (id_usr),
    FOREIGN KEY (id_usr) REFERENCES usuario (id_usr)
);

CREATE TABLE frm_pago (
    id_formap INT,
    metodo_pago VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_formap)
);

CREATE TABLE temporada (
    id_temp SERIAL,
    nombre VARCHAR(20) NOT NULL UNIQUE,
    fecha_i DATE NOT NULL,
    fecha_f DATE NOT NULL,
    incremento FLOAT NOT NULL,
    PRIMARY KEY (id_temp)
);

CREATE TABLE region (
    id_region SERIAL,
    depto VARCHAR(20) NOT NULL UNIQUE,
    ciudad VARCHAR(20) NOT NULL,
    barrio VARCHAR(20) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_region)
);

CREATE TABLE propiedad (
    id_prp INT,
    tipo VARCHAR(10) NOT NULL,
    capacidad INT NOT NULL,
    nbanios INT NOT NULL,
    nhab INT NOT NULL,
    aire_ac BOOLEAN NOT NULL,
    calefaccion BOOLEAN NOT NULL,
    perm_mascts BOOLEAN NOT NULL,
    id_usr SERIAL,
    id_region SERIAL,
    PRIMARY KEY (id_prp),
    FOREIGN KEY (id_usr) REFERENCES usuario (id_usr),
    FOREIGN KEY (id_region) REFERENCES region (id_region)
);

CREATE TABLE fotografia (
    id_foto SERIAL,
    id_prp INT,
    fotografia BYTEA,
    titulo VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (id_foto),
    FOREIGN KEY (id_prp) REFERENCES propiedad (id_prp)
);

CREATE TABLE encuesta (
    id_encuesta SERIAL,
    id_usr SERIAL,
    id_prp INT,
    PRIMARY KEY (id_encuesta),
    FOREIGN KEY (id_usr) REFERENCES usuario (id_usr),
    FOREIGN KEY (id_prp) REFERENCES propiedad (id_prp)
);

CREATE TABLE pregunta (
    id_pregunta SERIAL,
    pregunta VARCHAR(50) NOT NULL,
    id_encuesta SERIAL,
    PRIMARY KEY (id_pregunta),
    FOREIGN KEY (id_encuesta) REFERENCES encuesta (id_encuesta)
);

CREATE TABLE respuesta (
    id_respuesta SERIAL,
    respuesta VARCHAR(50) NOT NULL,
    id_encuesta INT,
    PRIMARY KEY (id_respuesta),
    FOREIGN KEY (id_encuesta) REFERENCES encuesta (id_encuesta)
);

CREATE TABLE reserva (
    id_resv INT,
    fecha_resv DATE NOT NULL,
    fecha_inicio_alq DATE NOT NULL,
    fecha_fin_alq DATE NOT NULL,
    estado_pago BOOLEAN NOT NULL,
    precio FLOAT NOT NULL,
    Id_prp INT,
    Id_usr SERIAL,
    id_temp SERIAL,
    PRIMARY KEY (id_resv),
    FOREIGN KEY (id_usr) REFERENCES usuario (id_usr),
    FOREIGN KEY (id_prp) REFERENCES propiedad (id_prp),
    FOREIGN KEY (id_temp) REFERENCES temporada (id_temp)
);

CREATE TABLE pago (
    id_pago INT,
    fecha_pago DATE NOT NULL,
    id_resv INT,
    id_formap INT,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_resv) REFERENCES reserva (id_resv),
    FOREIGN KEY (id_formap) REFERENCES frm_pago (id_formap)
);

-- ~~~~~!!!!!! ROLES AND PRIVILIGIES !!!!!!!~~~~~
CREATE USER owner_vf ENCRYPTED PASSWORD 'owner1234';
CREATE USER user_vf ENCRYPTED PASSWORD 'user1234';

GRANT 
    SELECT, DELETE, INSERT ON
    propiedad, region, temporada, pregunta TO owner_vf;

GRANT 
    SELECT ON
    usuario, mascota, telofono_usuario, respuesta, reserva, encuesta, frm_pago TO owner_vf;

GRANT
    UPDATE, SELECT, INSERT 
    ON usuario, mascota, telofono_usuario, frm_pago TO user_vf;

GRANT
    DELETE, INSERT 
    ON reserva TO user_vf;

GRANT
    SELECT
    ON usuario, pregunta, respuesta, encuesta, propiedad TO user_vf;

GRANT
    DELETE
    ON usuario TO user_vf;

GRANT USAGE, SELECT ON SEQUENCE usuario_id_usr_seq TO user_vf;

REVOKE
    SELECT, INSERT, UPDATE, DELETE 
    ON admin, temporada FROM user_vf;

-- ~~~~~!!!!!! INSERCION DE DATOS v.1.1.0 !!!!!!!~~~~~
-- ADMIN
INSERT INTO
    admin (nombre, passwd)
VALUES
    ('Default00', '0011 0010');

INSERT INTO usuario(nombres, apellidos, nacionalidad, id_admin)
VALUES ('System','Default', 'BASES DEFINED','NN');

-- ~~~~~!!!!!! INSERCION DE DATOS TEST !!!!!!!~~~~~
-- ADMIN
INSERT INTO
    admin (nombre, passwd)
VALUES
    ('System', '0101');

-- TESTER USER'S

INSERT INTO usuario(nombres, apellidos, nacionalidad, id_admin)
VALUES ('System','R4kun', 'BASES DEFINED','3');

INSERT INTO usuario (nombres, apellidos, nacionalidad, id_admin)
VALUES ('Carlos Eduardo', 'Martínez Gómez', 'Argentina','1'),
    ('María Fernanda', 'López Ruiz', 'México','1'),
    ('Juan Pablo', 'Hernández Torres', 'España','1'),
    ('Ana Sofía', 'Rodríguez Sánchez', 'Chile','1'),
    ('Luis Miguel', 'García Castro', 'Perú','1'),
    ('Gabriela Alejandra', 'Ramírez Pérez', 'Venezuela','1'),
    ('José Antonio', 'Fernández Morales', 'Uruguay','1'),
    ('Daniela Isabel', 'Suárez Ortiz', 'Bolivia','1'),
    ('Miguel Ángel', 'Flores Rivera', 'Ecuador','1'),
    ('Laura Valentina', 'Pérez Jiménez', 'Paraguay','1'),
    ('Andrés Felipe', 'Mendoza Ríos', 'Guatemala','1'),
    ('Camila Victoria', 'Ortiz Vega', 'Honduras','1'),
    ('Ricardo Alejandro', 'Díaz Soto', 'El Salvador','1'),
    ('Isabella Lucía', 'Cruz García', 'Costa Rica','1'),
    ('Mateo Sebastián', 'Mejía Muñoz', 'Panamá','1'),
    ('Luciana Emilia', 'Gómez Castillo', 'Nicaragua','1'),
    ('Santiago Tomás', 'González Morales', 'Cuba','1'),
    ('Sofía Daniela', 'Reyes Sánchez', 'Puerto Rico','1'),
    ('Alejandro David', 'Vargas Herrera', 'República Dominicana','1'),
    ('Valeria Camila', 'Torres López', 'Portugal','1'),
    ('Diego Armando', 'Rojas Martínez', 'Italia','1'),
    ('Martina Elena', 'Navarro Fernández', 'Francia','1'),
    ('Emilio Javier', 'Luna Ramírez', 'Brasil','1'),
    ('Antonia Teresa', 'Silva Romero', 'Chile','1'),
    ('Francisco Javier', 'Blanco Vázquez', 'Uruguay','1');

-- TEST REGION

INSERT INTO region (depto, ciudad, barrio, descripcion)
VALUES ('Antioquia', 'Medellín', 'El Poblado', 'Barrio residencial y comercial con gran afluencia de turistas'),
    ('Cundinamarca', 'Bogotá', 'Chapinero', 'Zona central con una mezcla de áreas residenciales y comerciales'),
    ('Atlántico', 'Barranquilla', 'El Prado', 'Área histórica y cultural con arquitectura republicana'),
    ('Valle del Cauca', 'Cali', 'San Fernando', 'Barrio conocido por su vida nocturna y restaurantes'),
    ('Santander', 'Bucaramanga', 'Cabecera del Llano', 'Zona residencial y comercial con parques y centros comerciales'),
    ('Bolívar', 'Cartagena', 'Bocagrande', 'Área turística con playas y hoteles de lujo'),
    ('Risaralda', 'Pereira', 'Circunvalar', 'Barrio residencial de alta estratificación'),
    ('Magdalena', 'Santa Marta', 'Rodadero', 'Área turística con playas populares'),
    ('Caldas', 'Manizales', 'Chipre', 'Barrio con vistas panorámicas y ambiente tranquilo'),
    ('Nariño', 'Pasto', 'Centro', 'Zona central con comercio y servicios administrativos'),
    ('Boyacá', 'Tunja', 'San Antonio', 'Barrio histórico con arquitectura colonial'),
    ('Huila', 'Neiva', 'Las Granjas', 'Barrio residencial y comercial con zonas verdes'),
    ('Tolima', 'Ibagué', 'Ambalá', 'Área residencial con comercio local'),
    ('Córdoba', 'Montería', 'La Castellana', 'Barrio conocido por sus eventos culturales y vida nocturna'),
    ('Meta', 'Villavicencio', 'La Esperanza', 'Barrio residencial en expansión con nuevos desarrollos');

-- TEST PROPIEDAD
INSERT INTO propiedad (id_prp, tipo, capacidad, nbanios, nhab, aire_ac, calefaccion, perm_mascts, id_usr, id_region)
VALUES
    (0001, 'Casa', 6, 2, 3, TRUE, TRUE, FALSE, 78, 1),
    (0002, 'Cabaña', 4, 1, 2, TRUE, TRUE, TRUE, 78, 2),
    (0003, 'Casa', 8, 3, 4, TRUE, TRUE, FALSE, 78, 3),
    (0004, 'Cabaña', 2, 1, 1, TRUE, FALSE, TRUE, 78, 4),
    (0005, 'Casa', 10, 4, 5, TRUE, TRUE, TRUE, 78, 5),
    (0006, 'Cabaña', 3, 1, 1, TRUE, TRUE, TRUE, 78, 6),
    (0007, 'Casa', 12, 5, 6, TRUE, TRUE, FALSE, 78, 7),
    (0008, 'Cabaña', 2, 1, 1, TRUE, TRUE, FALSE, 78, 8),
    (0009, 'Casa', 8, 3, 4, TRUE, TRUE, TRUE, 78, 9),
    (00010, 'Cabaña', 6, 2, 3, TRUE, TRUE, TRUE, 78, 10),
    (00011, 'Casa', 4, 1, 2, TRUE, TRUE, FALSE, 78, 11),
    (00012, 'Cabaña', 5, 2, 2, TRUE, TRUE, FALSE, 78, 12),
    (00013, 'Casa', 6, 2, 3, TRUE, TRUE, FALSE, 78, 13),
    (00014, 'Cabaña', 3, 1, 1, TRUE, FALSE, TRUE, 78, 14),
    (00015, 'Casa', 10, 4, 5, TRUE, TRUE, TRUE, 78, 15),
    (00016, 'Cabaña', 2, 1, 1, TRUE, TRUE, TRUE, 78, 1),
    (00017, 'Casa', 8, 3, 4, TRUE, TRUE, FALSE, 78, 2),
    (00018, 'Cabaña', 2, 1, 1, TRUE, TRUE, FALSE, 78, 3),
    (00019, 'Casa', 12, 5, 6, TRUE, TRUE, TRUE, 78, 4),
    (00020, 'Cabaña', 6, 2, 3, TRUE, TRUE, TRUE, 78, 5);







