-- \\\\\\\\\\     BASIC CONFIG      \\\\\\\\\\

-- ~~~~~ CREACION DE ROLES Y DATABASE ~~~~~
CREATE USER admin_vf CREATEDB CREATEROLE ENCRYPTED PASSWORD 'admin1234';
\c postgres admin_vf CREATE DATABASE feliz_sa;
\c feliz_sa 

-- ~~~~~ CREACION DE TABLAS ~~~~~
CREATE TABLE admin (
    id_admin SERIAL,
    nombre VARCHAR(50) NOT NULL,
    passwd VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_admin)
);

CREATE TABLE usuario (
    id_usr SERIAL,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    nacionalidad VARCHAR(20) NOT NULL,
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
    telefono VARCHAR(10) NOT NULL,
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
    nombre VARCHAR(20) NOT NULL,
    fecha_i DATE NOT NULL,
    fecha_f DATE NOT NULL,
    incremento FLOAT NOT NULL,
    PRIMARY KEY (id_temp)
);

CREATE TABLE region (
    id_region SERIAL,
    depto VARCHAR(20) NOT NULL,
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
    titulo VARCHAR(30) NOT NULL,
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
    ON usuario, pregunta, respuesta, encuesta, propiedad, region TO user_vf;

REVOKE
    SELECT, INSERT, UPDATE, DELETE 
    ON admin, temporada FROM user_vf;

-- ~~~~~!!!!!! INSERCION DE DATOS v.1.1.0 !!!!!!!~~~~~
-- ADMIN
INSERT INTO
    admin (nombre, passwd)
VALUES
    ('Default00', '0011 0010');


SELECT r.* from region r, usuario u WHERE u.id_usr=78;

CREATE FUNCTION default_view()
RETURNS SETOF region 
AS
$$
BEGIN
    SELECT r.id from region r, usuario u WHERE u.id_usr=78;
END
$$
LANGUAGE SQL;

SELECT p.id_prp, p.tipo, p.capacidad, p.nbanios, p.nhab, p.aire_ac, p.calefaccion, p.perm_mascts, p.id_region r.depto FROM propiedad p usuario u region r WHERE u.id_usr=78;