-- ============================================================
--  BASE DE DATOS: Álbum Panini Mundial 2026
--  Asignatura : Desarrollo Web - Universidad de la Costa
--  Profesor   : Ing. José Manuel Santos Sánchez
--  Descripción: Script completo con TODAS las láminas del álbum
--  CORRECCIÓN : USA13 tenía 'Poco Comúnn' (doble n) → corregido a 'Poco Común'
-- ============================================================

-- 1. Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS bdalbum2026
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE bdalbum2026;

-- ============================================================
-- TABLA 1: usuarios
-- ============================================================
CREATE TABLE IF NOT EXISTS usuarios (
    username    VARCHAR(30)  NOT NULL,
    password    VARCHAR(255) NOT NULL,
    nombre      VARCHAR(120) NOT NULL,
    correo      VARCHAR(100) NOT NULL,
    fecha_reg   DATETIME     DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_usuarios PRIMARY KEY (username),
    CONSTRAINT uq_correo   UNIQUE (correo)
);

-- ============================================================
-- TABLA 2: laminas  (catálogo completo del álbum)
-- ============================================================
CREATE TABLE IF NOT EXISTS laminas (
    numero         VARCHAR(10)  NOT NULL,
    nombre_jugador VARCHAR(100) NOT NULL,
    equipo         VARCHAR(60)  NOT NULL,
    rareza         ENUM(
                       'Irremplazable',
                       'Especial',
                       'Ultra Valiosa',
                       'Super Valiosa',
                       'Muy Valiosa',
                       'Valiosa',
                       'Poco Común',
                       'Común'
                   ) DEFAULT 'Común',
    CONSTRAINT pk_laminas PRIMARY KEY (numero)
);

-- ============================================================
-- TABLA 3: inventario  (relación usuario <-> lámina)
-- ============================================================
CREATE TABLE IF NOT EXISTS inventario (
    id_inventario  INT         NOT NULL AUTO_INCREMENT,
    username       VARCHAR(30) NOT NULL,
    numero_lamina  VARCHAR(10) NOT NULL,
    cantidad       INT         NOT NULL DEFAULT 1,
    pegada         BOOLEAN     NOT NULL DEFAULT FALSE,
    fecha_obtenida DATETIME             DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_inventario     PRIMARY KEY (id_inventario),
    CONSTRAINT fk_inv_usuario    FOREIGN KEY (username)
        REFERENCES usuarios(username) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_inv_lamina     FOREIGN KEY (numero_lamina)
        REFERENCES laminas(numero)    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_usuario_lamina UNIQUE (username, numero_lamina)
);

-- ============================================================
-- DATOS INICIALES: usuario administrador
-- ============================================================
INSERT IGNORE INTO usuarios (username, password, nombre, correo) VALUES
('admin', '12345', 'Administrador', 'admin@album2026.com');

-- ============================================================
-- DATOS INICIALES: catálogo completo de láminas
-- ============================================================

-- ---------- Copa Mundial e Historia (FWC) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('00', 'Lámina 00', 'Copa Mundial e Historia', 'Irremplazable'),
    ('FWC1', 'Lámina FWC1', 'Copa Mundial e Historia', 'Especial'),
    ('FWC2', 'Lámina FWC2', 'Copa Mundial e Historia', 'Especial'),
    ('FWC3', 'Lámina FWC3', 'Copa Mundial e Historia', 'Especial'),
    ('FWC4', 'Lámina FWC4', 'Copa Mundial e Historia', 'Especial'),
    ('FWC5', 'Lámina FWC5', 'Copa Mundial e Historia', 'Especial'),
    ('FWC6', 'Lámina FWC6', 'Copa Mundial e Historia', 'Especial'),
    ('FWC7', 'Lámina FWC7', 'Copa Mundial e Historia', 'Especial'),
    ('FWC8', 'Lámina FWC8', 'Copa Mundial e Historia', 'Especial'),
    ('FWC9', 'Lámina FWC9', 'Copa Mundial e Historia', 'Especial'),
    ('FWC10', 'Lámina FWC10', 'Copa Mundial e Historia', 'Especial'),
    ('FWC11', 'Lámina FWC11', 'Copa Mundial e Historia', 'Especial'),
    ('FWC12', 'Lámina FWC12', 'Copa Mundial e Historia', 'Especial'),
    ('FWC13', 'Lámina FWC13', 'Copa Mundial e Historia', 'Especial'),
    ('FWC14', 'Lámina FWC14', 'Copa Mundial e Historia', 'Especial'),
    ('FWC15', 'Lámina FWC15', 'Copa Mundial e Historia', 'Especial'),
    ('FWC16', 'Lámina FWC16', 'Copa Mundial e Historia', 'Especial'),
    ('FWC17', 'Lámina FWC17', 'Copa Mundial e Historia', 'Especial'),
    ('FWC18', 'Lámina FWC18', 'Copa Mundial e Historia', 'Especial'),
    ('FWC19', 'Lámina FWC19', 'Copa Mundial e Historia', 'Especial');

-- ---------- México (MEX) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('MEX1', 'Lámina MEX1', 'México', 'Muy Valiosa'),
    ('MEX2', 'Lámina MEX2', 'México', 'Común'),
    ('MEX3', 'Lámina MEX3', 'México', 'Común'),
    ('MEX4', 'Lámina MEX4', 'México', 'Común'),
    ('MEX5', 'Lámina MEX5', 'México', 'Común'),
    ('MEX6', 'Lámina MEX6', 'México', 'Común'),
    ('MEX7', 'Lámina MEX7', 'México', 'Común'),
    ('MEX8', 'Lámina MEX8', 'México', 'Común'),
    ('MEX9', 'Lámina MEX9', 'México', 'Común'),
    ('MEX10', 'Lámina MEX10', 'México', 'Común'),
    ('MEX11', 'Lámina MEX11', 'México', 'Común'),
    ('MEX12', 'Lámina MEX12', 'México', 'Común'),
    ('MEX13', 'Lámina MEX13', 'México', 'Poco Común'),
    ('MEX14', 'Lámina MEX14', 'México', 'Común'),
    ('MEX15', 'Lámina MEX15', 'México', 'Común'),
    ('MEX16', 'Lámina MEX16', 'México', 'Común'),
    ('MEX17', 'Lámina MEX17', 'México', 'Común'),
    ('MEX18', 'Lámina MEX18', 'México', 'Común'),
    ('MEX19', 'Lámina MEX19', 'México', 'Común'),
    ('MEX20', 'Lámina MEX20', 'México', 'Común');

-- ---------- Sudáfrica (RSA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('RSA2', 'Lámina RSA2', 'Sudáfrica', 'Valiosa'),
    ('RSA3', 'Lámina RSA3', 'Sudáfrica', 'Común'),
    ('RSA4', 'Lámina RSA4', 'Sudáfrica', 'Común'),
    ('RSA5', 'Lámina RSA5', 'Sudáfrica', 'Común'),
    ('RSA6', 'Lámina RSA6', 'Sudáfrica', 'Común'),
    ('RSA7', 'Lámina RSA7', 'Sudáfrica', 'Común'),
    ('RSA8', 'Lámina RSA8', 'Sudáfrica', 'Común'),
    ('RSA9', 'Lámina RSA9', 'Sudáfrica', 'Común'),
    ('RSA10', 'Lámina RSA10', 'Sudáfrica', 'Común'),
    ('RSA11', 'Lámina RSA11', 'Sudáfrica', 'Común'),
    ('RSA12', 'Lámina RSA12', 'Sudáfrica', 'Común'),
    ('RSA13', 'Lámina RSA13', 'Sudáfrica', 'Poco Común'),
    ('RSA14', 'Lámina RSA14', 'Sudáfrica', 'Común'),
    ('RSA15', 'Lámina RSA15', 'Sudáfrica', 'Común'),
    ('RSA16', 'Lámina RSA16', 'Sudáfrica', 'Común'),
    ('RSA17', 'Lámina RSA17', 'Sudáfrica', 'Común'),
    ('RSA18', 'Lámina RSA18', 'Sudáfrica', 'Común'),
    ('RSA19', 'Lámina RSA19', 'Sudáfrica', 'Común'),
    ('RSA20', 'Lámina RSA20', 'Sudáfrica', 'Común');

-- ---------- Corea del Sur (KOR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('KOR1', 'Lámina KOR1', 'Corea del Sur', 'Valiosa'),
    ('KOR2', 'Lámina KOR2', 'Corea del Sur', 'Común'),
    ('KOR3', 'Lámina KOR3', 'Corea del Sur', 'Común'),
    ('KOR4', 'Lámina KOR4', 'Corea del Sur', 'Común'),
    ('KOR5', 'Lámina KOR5', 'Corea del Sur', 'Común'),
    ('KOR6', 'Lámina KOR6', 'Corea del Sur', 'Común'),
    ('KOR7', 'Lámina KOR7', 'Corea del Sur', 'Común'),
    ('KOR8', 'Lámina KOR8', 'Corea del Sur', 'Común'),
    ('KOR9', 'Lámina KOR9', 'Corea del Sur', 'Común'),
    ('KOR10', 'Lámina KOR10', 'Corea del Sur', 'Común'),
    ('KOR11', 'Lámina KOR11', 'Corea del Sur', 'Común'),
    ('KOR12', 'Lámina KOR12', 'Corea del Sur', 'Común'),
    ('KOR13', 'Lámina KOR13', 'Corea del Sur', 'Poco Común'),
    ('KOR14', 'Lámina KOR14', 'Corea del Sur', 'Común'),
    ('KOR15', 'Lámina KOR15', 'Corea del Sur', 'Común'),
    ('KOR16', 'Lámina KOR16', 'Corea del Sur', 'Común'),
    ('KOR17', 'Lámina KOR17', 'Corea del Sur', 'Común'),
    ('KOR18', 'Lámina KOR18', 'Corea del Sur', 'Común'),
    ('KOR19', 'Lámina KOR19', 'Corea del Sur', 'Común'),
    ('KOR20', 'Lámina KOR20', 'Corea del Sur', 'Común');

-- ---------- República Checa (CZE) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CZE1', 'Lámina CZE1', 'República Checa', 'Valiosa'),
    ('CZE2', 'Lámina CZE2', 'República Checa', 'Común'),
    ('CZE3', 'Lámina CZE3', 'República Checa', 'Común'),
    ('CZE4', 'Lámina CZE4', 'República Checa', 'Común'),
    ('CZE5', 'Lámina CZE5', 'República Checa', 'Común'),
    ('CZE6', 'Lámina CZE6', 'República Checa', 'Común'),
    ('CZE7', 'Lámina CZE7', 'República Checa', 'Común'),
    ('CZE8', 'Lámina CZE8', 'República Checa', 'Común'),
    ('CZE9', 'Lámina CZE9', 'República Checa', 'Común'),
    ('CZE10', 'Lámina CZE10', 'República Checa', 'Común'),
    ('CZE11', 'Lámina CZE11', 'República Checa', 'Común'),
    ('CZE12', 'Lámina CZE12', 'República Checa', 'Común'),
    ('CZE13', 'Lámina CZE13', 'República Checa', 'Poco Común'),
    ('CZE14', 'Lámina CZE14', 'República Checa', 'Común'),
    ('CZE15', 'Lámina CZE15', 'República Checa', 'Común'),
    ('CZE16', 'Lámina CZE16', 'República Checa', 'Común'),
    ('CZE17', 'Lámina CZE17', 'República Checa', 'Común'),
    ('CZE18', 'Lámina CZE18', 'República Checa', 'Común'),
    ('CZE19', 'Lámina CZE19', 'República Checa', 'Común'),
    ('CZE20', 'Lámina CZE20', 'República Checa', 'Común');

-- ---------- Canadá (CAN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CAN1', 'Lámina CAN1', 'Canadá', 'Valiosa'),
    ('CAN2', 'Lámina CAN2', 'Canadá', 'Común'),
    ('CAN3', 'Lámina CAN3', 'Canadá', 'Común'),
    ('CAN4', 'Lámina CAN4', 'Canadá', 'Común'),
    ('CAN5', 'Lámina CAN5', 'Canadá', 'Común'),
    ('CAN6', 'Lámina CAN6', 'Canadá', 'Común'),
    ('CAN7', 'Lámina CAN7', 'Canadá', 'Común'),
    ('CAN8', 'Lámina CAN8', 'Canadá', 'Común'),
    ('CAN9', 'Lámina CAN9', 'Canadá', 'Común'),
    ('CAN10', 'Lámina CAN10', 'Canadá', 'Común'),
    ('CAN11', 'Lámina CAN11', 'Canadá', 'Común'),
    ('CAN12', 'Lámina CAN12', 'Canadá', 'Común'),
    ('CAN13', 'Lámina CAN13', 'Canadá', 'Poco Común'),
    ('CAN14', 'Lámina CAN14', 'Canadá', 'Común'),
    ('CAN15', 'Lámina CAN15', 'Canadá', 'Común'),
    ('CAN16', 'Lámina CAN16', 'Canadá', 'Común'),
    ('CAN17', 'Lámina CAN17', 'Canadá', 'Común'),
    ('CAN18', 'Lámina CAN18', 'Canadá', 'Común'),
    ('CAN19', 'Lámina CAN19', 'Canadá', 'Común'),
    ('CAN20', 'Lámina CAN20', 'Canadá', 'Común');

-- ---------- Bosnia y Herzegovina (BIH) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('BIH1', 'Lámina BIH1', 'Bosnia y Herzegovina', 'Valiosa'),
    ('BIH2', 'Lámina BIH2', 'Bosnia y Herzegovina', 'Común'),
    ('BIH3', 'Lámina BIH3', 'Bosnia y Herzegovina', 'Común'),
    ('BIH4', 'Lámina BIH4', 'Bosnia y Herzegovina', 'Común'),
    ('BIH5', 'Lámina BIH5', 'Bosnia y Herzegovina', 'Común'),
    ('BIH6', 'Lámina BIH6', 'Bosnia y Herzegovina', 'Común'),
    ('BIH7', 'Lámina BIH7', 'Bosnia y Herzegovina', 'Común'),
    ('BIH8', 'Lámina BIH8', 'Bosnia y Herzegovina', 'Común'),
    ('BIH9', 'Lámina BIH9', 'Bosnia y Herzegovina', 'Común'),
    ('BIH10', 'Lámina BIH10', 'Bosnia y Herzegovina', 'Común'),
    ('BIH11', 'Lámina BIH11', 'Bosnia y Herzegovina', 'Común'),
    ('BIH12', 'Lámina BIH12', 'Bosnia y Herzegovina', 'Común'),
    ('BIH13', 'Lámina BIH13', 'Bosnia y Herzegovina', 'Poco Común'),
    ('BIH14', 'Lámina BIH14', 'Bosnia y Herzegovina', 'Común'),
    ('BIH15', 'Lámina BIH15', 'Bosnia y Herzegovina', 'Común'),
    ('BIH16', 'Lámina BIH16', 'Bosnia y Herzegovina', 'Común'),
    ('BIH17', 'Lámina BIH17', 'Bosnia y Herzegovina', 'Común'),
    ('BIH18', 'Lámina BIH18', 'Bosnia y Herzegovina', 'Común'),
    ('BIH19', 'Lámina BIH19', 'Bosnia y Herzegovina', 'Común'),
    ('BIH20', 'Lámina BIH20', 'Bosnia y Herzegovina', 'Común');

-- ---------- Catar (QAT) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('QAT1', 'Lámina QAT1', 'Catar', 'Valiosa'),
    ('QAT2', 'Lámina QAT2', 'Catar', 'Común'),
    ('QAT3', 'Lámina QAT3', 'Catar', 'Común'),
    ('QAT4', 'Lámina QAT4', 'Catar', 'Común'),
    ('QAT5', 'Lámina QAT5', 'Catar', 'Común'),
    ('QAT6', 'Lámina QAT6', 'Catar', 'Común'),
    ('QAT7', 'Lámina QAT7', 'Catar', 'Común'),
    ('QAT8', 'Lámina QAT8', 'Catar', 'Común'),
    ('QAT9', 'Lámina QAT9', 'Catar', 'Común'),
    ('QAT10', 'Lámina QAT10', 'Catar', 'Común'),
    ('QAT11', 'Lámina QAT11', 'Catar', 'Común'),
    ('QAT12', 'Lámina QAT12', 'Catar', 'Común'),
    ('QAT13', 'Lámina QAT13', 'Catar', 'Poco Común'),
    ('QAT14', 'Lámina QAT14', 'Catar', 'Común'),
    ('QAT15', 'Lámina QAT15', 'Catar', 'Común'),
    ('QAT16', 'Lámina QAT16', 'Catar', 'Común'),
    ('QAT17', 'Lámina QAT17', 'Catar', 'Común'),
    ('QAT18', 'Lámina QAT18', 'Catar', 'Común'),
    ('QAT19', 'Lámina QAT19', 'Catar', 'Común'),
    ('QAT20', 'Lámina QAT20', 'Catar', 'Común');

-- ---------- Suiza (SUI) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('SUI1', 'Lámina SUI1', 'Suiza', 'Valiosa'),
    ('SUI2', 'Lámina SUI2', 'Suiza', 'Común'),
    ('SUI3', 'Lámina SUI3', 'Suiza', 'Común'),
    ('SUI4', 'Lámina SUI4', 'Suiza', 'Común'),
    ('SUI5', 'Lámina SUI5', 'Suiza', 'Común'),
    ('SUI6', 'Lámina SUI6', 'Suiza', 'Común'),
    ('SUI7', 'Lámina SUI7', 'Suiza', 'Común'),
    ('SUI8', 'Lámina SUI8', 'Suiza', 'Común'),
    ('SUI9', 'Lámina SUI9', 'Suiza', 'Común'),
    ('SUI10', 'Lámina SUI10', 'Suiza', 'Común'),
    ('SUI11', 'Lámina SUI11', 'Suiza', 'Común'),
    ('SUI12', 'Lámina SUI12', 'Suiza', 'Común'),
    ('SUI13', 'Lámina SUI13', 'Suiza', 'Poco Común'),
    ('SUI14', 'Lámina SUI14', 'Suiza', 'Común'),
    ('SUI15', 'Lámina SUI15', 'Suiza', 'Común'),
    ('SUI16', 'Lámina SUI16', 'Suiza', 'Común'),
    ('SUI17', 'Lámina SUI17', 'Suiza', 'Común'),
    ('SUI18', 'Lámina SUI18', 'Suiza', 'Común'),
    ('SUI19', 'Lámina SUI19', 'Suiza', 'Común'),
    ('SUI20', 'Lámina SUI20', 'Suiza', 'Común');

-- ---------- Brasil (BRA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('BRA1', 'Lámina BRA1', 'Brasil', 'Ultra Valiosa'),
    ('BRA2', 'Lámina BRA2', 'Brasil', 'Común'),
    ('BRA3', 'Lámina BRA3', 'Brasil', 'Común'),
    ('BRA4', 'Lámina BRA4', 'Brasil', 'Común'),
    ('BRA5', 'Lámina BRA5', 'Brasil', 'Común'),
    ('BRA6', 'Lámina BRA6', 'Brasil', 'Común'),
    ('BRA7', 'Lámina BRA7', 'Brasil', 'Común'),
    ('BRA8', 'Lámina BRA8', 'Brasil', 'Común'),
    ('BRA9', 'Lámina BRA9', 'Brasil', 'Común'),
    ('BRA10', 'Lámina BRA10', 'Brasil', 'Común'),
    ('BRA11', 'Lámina BRA11', 'Brasil', 'Común'),
    ('BRA12', 'Lámina BRA12', 'Brasil', 'Común'),
    ('BRA13', 'Lámina BRA13', 'Brasil', 'Valiosa'),
    ('BRA14', 'Lámina BRA14', 'Brasil', 'Muy Valiosa'),
    ('BRA15', 'Lámina BRA15', 'Brasil', 'Común'),
    ('BRA16', 'Lámina BRA16', 'Brasil', 'Común'),
    ('BRA17', 'Lámina BRA17', 'Brasil', 'Común'),
    ('BRA18', 'Lámina BRA18', 'Brasil', 'Común'),
    ('BRA19', 'Lámina BRA19', 'Brasil', 'Valiosa'),
    ('BRA20', 'Lámina BRA20', 'Brasil', 'Común');

-- ---------- Marruecos (MAR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('MAR1', 'Lámina MAR1', 'Marruecos', 'Valiosa'),
    ('MAR2', 'Lámina MAR2', 'Marruecos', 'Común'),
    ('MAR3', 'Lámina MAR3', 'Marruecos', 'Común'),
    ('MAR4', 'Lámina MAR4', 'Marruecos', 'Común'),
    ('MAR5', 'Lámina MAR5', 'Marruecos', 'Común'),
    ('MAR6', 'Lámina MAR6', 'Marruecos', 'Común'),
    ('MAR7', 'Lámina MAR7', 'Marruecos', 'Común'),
    ('MAR8', 'Lámina MAR8', 'Marruecos', 'Común'),
    ('MAR9', 'Lámina MAR9', 'Marruecos', 'Común'),
    ('MAR10', 'Lámina MAR10', 'Marruecos', 'Común'),
    ('MAR11', 'Lámina MAR11', 'Marruecos', 'Común'),
    ('MAR12', 'Lámina MAR12', 'Marruecos', 'Común'),
    ('MAR13', 'Lámina MAR13', 'Marruecos', 'Poco Común'),
    ('MAR14', 'Lámina MAR14', 'Marruecos', 'Común'),
    ('MAR15', 'Lámina MAR15', 'Marruecos', 'Común'),
    ('MAR16', 'Lámina MAR16', 'Marruecos', 'Común'),
    ('MAR17', 'Lámina MAR17', 'Marruecos', 'Común'),
    ('MAR18', 'Lámina MAR18', 'Marruecos', 'Común'),
    ('MAR19', 'Lámina MAR19', 'Marruecos', 'Común'),
    ('MAR20', 'Lámina MAR20', 'Marruecos', 'Común');

-- ---------- Haití (HAI) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('HAI1', 'Lámina HAI1', 'Haití', 'Valiosa'),
    ('HAI2', 'Lámina HAI2', 'Haití', 'Común'),
    ('HAI3', 'Lámina HAI3', 'Haití', 'Común'),
    ('HAI4', 'Lámina HAI4', 'Haití', 'Común'),
    ('HAI5', 'Lámina HAI5', 'Haití', 'Común'),
    ('HAI6', 'Lámina HAI6', 'Haití', 'Común'),
    ('HAI7', 'Lámina HAI7', 'Haití', 'Común'),
    ('HAI8', 'Lámina HAI8', 'Haití', 'Común'),
    ('HAI9', 'Lámina HAI9', 'Haití', 'Común'),
    ('HAI10', 'Lámina HAI10', 'Haití', 'Común'),
    ('HAI11', 'Lámina HAI11', 'Haití', 'Común'),
    ('HAI12', 'Lámina HAI12', 'Haití', 'Común'),
    ('HAI13', 'Lámina HAI13', 'Haití', 'Poco Común'),
    ('HAI14', 'Lámina HAI14', 'Haití', 'Común'),
    ('HAI15', 'Lámina HAI15', 'Haití', 'Común'),
    ('HAI16', 'Lámina HAI16', 'Haití', 'Común'),
    ('HAI17', 'Lámina HAI17', 'Haití', 'Común'),
    ('HAI18', 'Lámina HAI18', 'Haití', 'Común'),
    ('HAI19', 'Lámina HAI19', 'Haití', 'Común'),
    ('HAI20', 'Lámina HAI20', 'Haití', 'Común');

-- ---------- Escocia (SCO) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('SCO1', 'Lámina SCO1', 'Escocia', 'Valiosa'),
    ('SCO2', 'Lámina SCO2', 'Escocia', 'Común'),
    ('SCO3', 'Lámina SCO3', 'Escocia', 'Común'),
    ('SCO4', 'Lámina SCO4', 'Escocia', 'Común'),
    ('SCO5', 'Lámina SCO5', 'Escocia', 'Común'),
    ('SCO6', 'Lámina SCO6', 'Escocia', 'Común'),
    ('SCO7', 'Lámina SCO7', 'Escocia', 'Común'),
    ('SCO8', 'Lámina SCO8', 'Escocia', 'Común'),
    ('SCO9', 'Lámina SCO9', 'Escocia', 'Común'),
    ('SCO10', 'Lámina SCO10', 'Escocia', 'Común'),
    ('SCO11', 'Lámina SCO11', 'Escocia', 'Común'),
    ('SCO12', 'Lámina SCO12', 'Escocia', 'Común'),
    ('SCO13', 'Lámina SCO13', 'Escocia', 'Poco Común'),
    ('SCO14', 'Lámina SCO14', 'Escocia', 'Común'),
    ('SCO15', 'Lámina SCO15', 'Escocia', 'Común'),
    ('SCO16', 'Lámina SCO16', 'Escocia', 'Común'),
    ('SCO17', 'Lámina SCO17', 'Escocia', 'Común'),
    ('SCO18', 'Lámina SCO18', 'Escocia', 'Común'),
    ('SCO19', 'Lámina SCO19', 'Escocia', 'Común'),
    ('SCO20', 'Lámina SCO20', 'Escocia', 'Común');

-- ---------- Estados Unidos (USA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('USA1', 'Lámina USA1', 'Estados Unidos', 'Valiosa'),
    ('USA2', 'Lámina USA2', 'Estados Unidos', 'Común'),
    ('USA3', 'Lámina USA3', 'Estados Unidos', 'Común'),
    ('USA4', 'Lámina USA4', 'Estados Unidos', 'Común'),
    ('USA5', 'Lámina USA5', 'Estados Unidos', 'Común'),
    ('USA6', 'Lámina USA6', 'Estados Unidos', 'Común'),
    ('USA7', 'Lámina USA7', 'Estados Unidos', 'Común'),
    ('USA8', 'Lámina USA8', 'Estados Unidos', 'Común'),
    ('USA9', 'Lámina USA9', 'Estados Unidos', 'Común'),
    ('USA10', 'Lámina USA10', 'Estados Unidos', 'Común'),
    ('USA11', 'Lámina USA11', 'Estados Unidos', 'Común'),
    ('USA12', 'Lámina USA12', 'Estados Unidos', 'Común'),
    ('USA13', 'Lámina USA13', 'Estados Unidos', 'Poco Común'),
    ('USA14', 'Lámina USA14', 'Estados Unidos', 'Común'),
    ('USA15', 'Lámina USA15', 'Estados Unidos', 'Común'),
    ('USA16', 'Lámina USA16', 'Estados Unidos', 'Común'),
    ('USA17', 'Lámina USA17', 'Estados Unidos', 'Común'),
    ('USA18', 'Lámina USA18', 'Estados Unidos', 'Común'),
    ('USA19', 'Lámina USA19', 'Estados Unidos', 'Común'),
    ('USA20', 'Lámina USA20', 'Estados Unidos', 'Común');

-- ---------- Paraguay (PAR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('PAR1', 'Lámina PAR1', 'Paraguay', 'Valiosa'),
    ('PAR2', 'Lámina PAR2', 'Paraguay', 'Común'),
    ('PAR3', 'Lámina PAR3', 'Paraguay', 'Común'),
    ('PAR4', 'Lámina PAR4', 'Paraguay', 'Común'),
    ('PAR5', 'Lámina PAR5', 'Paraguay', 'Común'),
    ('PAR6', 'Lámina PAR6', 'Paraguay', 'Común'),
    ('PAR7', 'Lámina PAR7', 'Paraguay', 'Común'),
    ('PAR8', 'Lámina PAR8', 'Paraguay', 'Común'),
    ('PAR10', 'Lámina PAR10', 'Paraguay', 'Común'),
    ('PAR11', 'Lámina PAR11', 'Paraguay', 'Común'),
    ('PAR12', 'Lámina PAR12', 'Paraguay', 'Común'),
    ('PAR13', 'Lámina PAR13', 'Paraguay', 'Poco Común'),
    ('PAR14', 'Lámina PAR14', 'Paraguay', 'Común'),
    ('PAR16', 'Lámina PAR16', 'Paraguay', 'Común'),
    ('PAR17', 'Lámina PAR17', 'Paraguay', 'Común'),
    ('PAR18', 'Lámina PAR18', 'Paraguay', 'Común'),
    ('PAR20', 'Lámina PAR20', 'Paraguay', 'Común');

-- ---------- Australia (AUS) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('AUS1', 'Lámina AUS1', 'Australia', 'Valiosa'),
    ('AUS2', 'Lámina AUS2', 'Australia', 'Común'),
    ('AUS3', 'Lámina AUS3', 'Australia', 'Común'),
    ('AUS4', 'Lámina AUS4', 'Australia', 'Común'),
    ('AUS5', 'Lámina AUS5', 'Australia', 'Común'),
    ('AUS6', 'Lámina AUS6', 'Australia', 'Común'),
    ('AUS7', 'Lámina AUS7', 'Australia', 'Común'),
    ('AUS8', 'Lámina AUS8', 'Australia', 'Común'),
    ('AUS9', 'Lámina AUS9', 'Australia', 'Común'),
    ('AUS10', 'Lámina AUS10', 'Australia', 'Común'),
    ('AUS11', 'Lámina AUS11', 'Australia', 'Común'),
    ('AUS12', 'Lámina AUS12', 'Australia', 'Común'),
    ('AUS13', 'Lámina AUS13', 'Australia', 'Poco Común'),
    ('AUS14', 'Lámina AUS14', 'Australia', 'Común'),
    ('AUS15', 'Lámina AUS15', 'Australia', 'Común'),
    ('AUS16', 'Lámina AUS16', 'Australia', 'Común'),
    ('AUS17', 'Lámina AUS17', 'Australia', 'Común'),
    ('AUS18', 'Lámina AUS18', 'Australia', 'Común'),
    ('AUS19', 'Lámina AUS19', 'Australia', 'Común'),
    ('AUS20', 'Lámina AUS20', 'Australia', 'Común');

-- ---------- Turquía (TUR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('TUR1', 'Lámina TUR1', 'Turquía', 'Valiosa'),
    ('TUR2', 'Lámina TUR2', 'Turquía', 'Común'),
    ('TUR3', 'Lámina TUR3', 'Turquía', 'Común'),
    ('TUR4', 'Lámina TUR4', 'Turquía', 'Común'),
    ('TUR5', 'Lámina TUR5', 'Turquía', 'Común'),
    ('TUR6', 'Lámina TUR6', 'Turquía', 'Común'),
    ('TUR7', 'Lámina TUR7', 'Turquía', 'Común'),
    ('TUR8', 'Lámina TUR8', 'Turquía', 'Común'),
    ('TUR9', 'Lámina TUR9', 'Turquía', 'Común'),
    ('TUR10', 'Lámina TUR10', 'Turquía', 'Común'),
    ('TUR11', 'Lámina TUR11', 'Turquía', 'Común'),
    ('TUR12', 'Lámina TUR12', 'Turquía', 'Común'),
    ('TUR13', 'Lámina TUR13', 'Turquía', 'Poco Común'),
    ('TUR14', 'Lámina TUR14', 'Turquía', 'Común'),
    ('TUR15', 'Lámina TUR15', 'Turquía', 'Común'),
    ('TUR16', 'Lámina TUR16', 'Turquía', 'Común'),
    ('TUR17', 'Lámina TUR17', 'Turquía', 'Común'),
    ('TUR18', 'Lámina TUR18', 'Turquía', 'Común'),
    ('TUR19', 'Lámina TUR19', 'Turquía', 'Común'),
    ('TUR20', 'Lámina TUR20', 'Turquía', 'Común');

-- ---------- Alemania (GER) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('GER1', 'Lámina GER1', 'Alemania', 'Super Valiosa'),
    ('GER3', 'Lámina GER3', 'Alemania', 'Común'),
    ('GER4', 'Lámina GER4', 'Alemania', 'Común'),
    ('GER5', 'Lámina GER5', 'Alemania', 'Común'),
    ('GER6', 'Lámina GER6', 'Alemania', 'Común'),
    ('GER7', 'Lámina GER7', 'Alemania', 'Común'),
    ('GER8', 'Lámina GER8', 'Alemania', 'Común'),
    ('GER9', 'Lámina GER9', 'Alemania', 'Común'),
    ('GER10', 'Lámina GER10', 'Alemania', 'Común'),
    ('GER11', 'Lámina GER11', 'Alemania', 'Muy Valiosa'),
    ('GER12', 'Lámina GER12', 'Alemania', 'Común'),
    ('GER13', 'Lámina GER13', 'Alemania', 'Valiosa'),
    ('GER14', 'Lámina GER14', 'Alemania', 'Común'),
    ('GER15', 'Lámina GER15', 'Alemania', 'Común'),
    ('GER16', 'Lámina GER16', 'Alemania', 'Común'),
    ('GER17', 'Lámina GER17', 'Alemania', 'Común'),
    ('GER18', 'Lámina GER18', 'Alemania', 'Común'),
    ('GER19', 'Lámina GER19', 'Alemania', 'Común'),
    ('GER20', 'Lámina GER20', 'Alemania', 'Común');

-- ---------- Curazao (CUW) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CUW1', 'Lámina CUW1', 'Curazao', 'Valiosa'),
    ('CUW2', 'Lámina CUW2', 'Curazao', 'Común'),
    ('CUW3', 'Lámina CUW3', 'Curazao', 'Común'),
    ('CUW4', 'Lámina CUW4', 'Curazao', 'Común'),
    ('CUW5', 'Lámina CUW5', 'Curazao', 'Común'),
    ('CUW7', 'Lámina CUW7', 'Curazao', 'Común'),
    ('CUW8', 'Lámina CUW8', 'Curazao', 'Común'),
    ('CUW9', 'Lámina CUW9', 'Curazao', 'Común'),
    ('CUW10', 'Lámina CUW10', 'Curazao', 'Común'),
    ('CUW11', 'Lámina CUW11', 'Curazao', 'Común'),
    ('CUW12', 'Lámina CUW12', 'Curazao', 'Común'),
    ('CUW13', 'Lámina CUW13', 'Curazao', 'Poco Común'),
    ('CUW15', 'Lámina CUW15', 'Curazao', 'Común'),
    ('CUW16', 'Lámina CUW16', 'Curazao', 'Común'),
    ('CUW18', 'Lámina CUW18', 'Curazao', 'Común'),
    ('CUW20', 'Lámina CUW20', 'Curazao', 'Común');

-- ---------- Costa de Marfil (CIV) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CIV1', 'Lámina CIV1', 'Costa de Marfil', 'Valiosa'),
    ('CIV2', 'Lámina CIV2', 'Costa de Marfil', 'Común'),
    ('CIV3', 'Lámina CIV3', 'Costa de Marfil', 'Común'),
    ('CIV4', 'Lámina CIV4', 'Costa de Marfil', 'Común'),
    ('CIV5', 'Lámina CIV5', 'Costa de Marfil', 'Común'),
    ('CIV6', 'Lámina CIV6', 'Costa de Marfil', 'Común'),
    ('CIV7', 'Lámina CIV7', 'Costa de Marfil', 'Común'),
    ('CIV8', 'Lámina CIV8', 'Costa de Marfil', 'Común'),
    ('CIV9', 'Lámina CIV9', 'Costa de Marfil', 'Común'),
    ('CIV10', 'Lámina CIV10', 'Costa de Marfil', 'Común'),
    ('CIV11', 'Lámina CIV11', 'Costa de Marfil', 'Común'),
    ('CIV12', 'Lámina CIV12', 'Costa de Marfil', 'Común'),
    ('CIV13', 'Lámina CIV13', 'Costa de Marfil', 'Poco Común'),
    ('CIV14', 'Lámina CIV14', 'Costa de Marfil', 'Común'),
    ('CIV15', 'Lámina CIV15', 'Costa de Marfil', 'Común'),
    ('CIV16', 'Lámina CIV16', 'Costa de Marfil', 'Común'),
    ('CIV17', 'Lámina CIV17', 'Costa de Marfil', 'Común'),
    ('CIV18', 'Lámina CIV18', 'Costa de Marfil', 'Común'),
    ('CIV19', 'Lámina CIV19', 'Costa de Marfil', 'Común'),
    ('CIV20', 'Lámina CIV20', 'Costa de Marfil', 'Común');

-- ---------- Ecuador (ECU) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('ECU1', 'Lámina ECU1', 'Ecuador', 'Valiosa'),
    ('ECU2', 'Lámina ECU2', 'Ecuador', 'Común'),
    ('ECU3', 'Lámina ECU3', 'Ecuador', 'Común'),
    ('ECU4', 'Lámina ECU4', 'Ecuador', 'Común'),
    ('ECU5', 'Lámina ECU5', 'Ecuador', 'Común'),
    ('ECU6', 'Lámina ECU6', 'Ecuador', 'Común'),
    ('ECU7', 'Lámina ECU7', 'Ecuador', 'Común'),
    ('ECU8', 'Lámina ECU8', 'Ecuador', 'Común'),
    ('ECU9', 'Lámina ECU9', 'Ecuador', 'Común'),
    ('ECU10', 'Lámina ECU10', 'Ecuador', 'Común'),
    ('ECU11', 'Lámina ECU11', 'Ecuador', 'Común'),
    ('ECU13', 'Lámina ECU13', 'Ecuador', 'Poco Común'),
    ('ECU14', 'Lámina ECU14', 'Ecuador', 'Común'),
    ('ECU15', 'Lámina ECU15', 'Ecuador', 'Común'),
    ('ECU16', 'Lámina ECU16', 'Ecuador', 'Común'),
    ('ECU18', 'Lámina ECU18', 'Ecuador', 'Común'),
    ('ECU19', 'Lámina ECU19', 'Ecuador', 'Común'),
    ('ECU20', 'Lámina ECU20', 'Ecuador', 'Común');

-- ---------- Países Bajos (NED) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('NED1', 'Lámina NED1', 'Países Bajos', 'Muy Valiosa'),
    ('NED2', 'Lámina NED2', 'Países Bajos', 'Común'),
    ('NED3', 'Lámina NED3', 'Países Bajos', 'Común'),
    ('NED4', 'Lámina NED4', 'Países Bajos', 'Común'),
    ('NED5', 'Lámina NED5', 'Países Bajos', 'Común'),
    ('NED6', 'Lámina NED6', 'Países Bajos', 'Común'),
    ('NED7', 'Lámina NED7', 'Países Bajos', 'Común'),
    ('NED8', 'Lámina NED8', 'Países Bajos', 'Común'),
    ('NED9', 'Lámina NED9', 'Países Bajos', 'Común'),
    ('NED10', 'Lámina NED10', 'Países Bajos', 'Común'),
    ('NED11', 'Lámina NED11', 'Países Bajos', 'Común'),
    ('NED12', 'Lámina NED12', 'Países Bajos', 'Común'),
    ('NED13', 'Lámina NED13', 'Países Bajos', 'Poco Común'),
    ('NED14', 'Lámina NED14', 'Países Bajos', 'Común'),
    ('NED15', 'Lámina NED15', 'Países Bajos', 'Común'),
    ('NED16', 'Lámina NED16', 'Países Bajos', 'Común'),
    ('NED17', 'Lámina NED17', 'Países Bajos', 'Común'),
    ('NED18', 'Lámina NED18', 'Países Bajos', 'Común'),
    ('NED19', 'Lámina NED19', 'Países Bajos', 'Común'),
    ('NED20', 'Lámina NED20', 'Países Bajos', 'Común');

-- ---------- Japón (JPN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('JPN1', 'Lámina JPN1', 'Japón', 'Muy Valiosa'),
    ('JPN2', 'Lámina JPN2', 'Japón', 'Común'),
    ('JPN3', 'Lámina JPN3', 'Japón', 'Común'),
    ('JPN5', 'Lámina JPN5', 'Japón', 'Común'),
    ('JPN6', 'Lámina JPN6', 'Japón', 'Común'),
    ('JPN7', 'Lámina JPN7', 'Japón', 'Común'),
    ('JPN8', 'Lámina JPN8', 'Japón', 'Común'),
    ('JPN9', 'Lámina JPN9', 'Japón', 'Común'),
    ('JPN10', 'Lámina JPN10', 'Japón', 'Común'),
    ('JPN11', 'Lámina JPN11', 'Japón', 'Común'),
    ('JPN12', 'Lámina JPN12', 'Japón', 'Común'),
    ('JPN13', 'Lámina JPN13', 'Japón', 'Poco Común'),
    ('JPN14', 'Lámina JPN14', 'Japón', 'Común'),
    ('JPN15', 'Lámina JPN15', 'Japón', 'Común'),
    ('JPN16', 'Lámina JPN16', 'Japón', 'Común'),
    ('JPN17', 'Lámina JPN17', 'Japón', 'Común'),
    ('JPN18', 'Lámina JPN18', 'Japón', 'Común'),
    ('JPN19', 'Lámina JPN19', 'Japón', 'Común'),
    ('JPN20', 'Lámina JPN20', 'Japón', 'Común');

-- ---------- Suecia (SWE) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('SWE1', 'Lámina SWE1', 'Suecia', 'Valiosa'),
    ('SWE2', 'Lámina SWE2', 'Suecia', 'Común'),
    ('SWE3', 'Lámina SWE3', 'Suecia', 'Común'),
    ('SWE4', 'Lámina SWE4', 'Suecia', 'Común'),
    ('SWE5', 'Lámina SWE5', 'Suecia', 'Común'),
    ('SWE6', 'Lámina SWE6', 'Suecia', 'Común'),
    ('SWE7', 'Lámina SWE7', 'Suecia', 'Común'),
    ('SWE8', 'Lámina SWE8', 'Suecia', 'Común'),
    ('SWE9', 'Lámina SWE9', 'Suecia', 'Común'),
    ('SWE10', 'Lámina SWE10', 'Suecia', 'Común'),
    ('SWE11', 'Lámina SWE11', 'Suecia', 'Común'),
    ('SWE12', 'Lámina SWE12', 'Suecia', 'Común'),
    ('SWE13', 'Lámina SWE13', 'Suecia', 'Poco Común'),
    ('SWE14', 'Lámina SWE14', 'Suecia', 'Común'),
    ('SWE15', 'Lámina SWE15', 'Suecia', 'Común'),
    ('SWE16', 'Lámina SWE16', 'Suecia', 'Común'),
    ('SWE17', 'Lámina SWE17', 'Suecia', 'Común'),
    ('SWE18', 'Lámina SWE18', 'Suecia', 'Común'),
    ('SWE19', 'Lámina SWE19', 'Suecia', 'Común'),
    ('SWE20', 'Lámina SWE20', 'Suecia', 'Común');

-- ---------- Túnez (TUN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('TUN1', 'Lámina TUN1', 'Túnez', 'Valiosa'),
    ('TUN2', 'Lámina TUN2', 'Túnez', 'Común'),
    ('TUN3', 'Lámina TUN3', 'Túnez', 'Común'),
    ('TUN4', 'Lámina TUN4', 'Túnez', 'Común'),
    ('TUN5', 'Lámina TUN5', 'Túnez', 'Común'),
    ('TUN6', 'Lámina TUN6', 'Túnez', 'Común'),
    ('TUN7', 'Lámina TUN7', 'Túnez', 'Común'),
    ('TUN8', 'Lámina TUN8', 'Túnez', 'Común'),
    ('TUN9', 'Lámina TUN9', 'Túnez', 'Común'),
    ('TUN10', 'Lámina TUN10', 'Túnez', 'Común'),
    ('TUN11', 'Lámina TUN11', 'Túnez', 'Común'),
    ('TUN12', 'Lámina TUN12', 'Túnez', 'Común'),
    ('TUN13', 'Lámina TUN13', 'Túnez', 'Poco Común'),
    ('TUN14', 'Lámina TUN14', 'Túnez', 'Común'),
    ('TUN15', 'Lámina TUN15', 'Túnez', 'Común'),
    ('TUN16', 'Lámina TUN16', 'Túnez', 'Común'),
    ('TUN17', 'Lámina TUN17', 'Túnez', 'Común'),
    ('TUN18', 'Lámina TUN18', 'Túnez', 'Común'),
    ('TUN19', 'Lámina TUN19', 'Túnez', 'Común'),
    ('TUN20', 'Lámina TUN20', 'Túnez', 'Común');

-- ---------- Bélgica (BEL) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('BEL1', 'Lámina BEL1', 'Bélgica', 'Valiosa'),
    ('BEL2', 'Lámina BEL2', 'Bélgica', 'Común'),
    ('BEL4', 'Lámina BEL4', 'Bélgica', 'Común'),
    ('BEL5', 'Lámina BEL5', 'Bélgica', 'Común'),
    ('BEL6', 'Lámina BEL6', 'Bélgica', 'Común'),
    ('BEL7', 'Lámina BEL7', 'Bélgica', 'Común'),
    ('BEL8', 'Lámina BEL8', 'Bélgica', 'Común'),
    ('BEL9', 'Lámina BEL9', 'Bélgica', 'Común'),
    ('BEL10', 'Lámina BEL10', 'Bélgica', 'Común'),
    ('BEL11', 'Lámina BEL11', 'Bélgica', 'Común'),
    ('BEL12', 'Lámina BEL12', 'Bélgica', 'Común'),
    ('BEL13', 'Lámina BEL13', 'Bélgica', 'Poco Común'),
    ('BEL14', 'Lámina BEL14', 'Bélgica', 'Común'),
    ('BEL15', 'Lámina BEL15', 'Bélgica', 'Común'),
    ('BEL16', 'Lámina BEL16', 'Bélgica', 'Común'),
    ('BEL17', 'Lámina BEL17', 'Bélgica', 'Común'),
    ('BEL18', 'Lámina BEL18', 'Bélgica', 'Común'),
    ('BEL19', 'Lámina BEL19', 'Bélgica', 'Común'),
    ('BEL20', 'Lámina BEL20', 'Bélgica', 'Común');

-- ---------- Egipto (EGY) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('EGY1', 'Lámina EGY1', 'Egipto', 'Valiosa'),
    ('EGY3', 'Lámina EGY3', 'Egipto', 'Común'),
    ('EGY4', 'Lámina EGY4', 'Egipto', 'Común'),
    ('EGY5', 'Lámina EGY5', 'Egipto', 'Común'),
    ('EGY7', 'Lámina EGY7', 'Egipto', 'Común'),
    ('EGY8', 'Lámina EGY8', 'Egipto', 'Común'),
    ('EGY9', 'Lámina EGY9', 'Egipto', 'Común'),
    ('EGY10', 'Lámina EGY10', 'Egipto', 'Común'),
    ('EGY11', 'Lámina EGY11', 'Egipto', 'Común'),
    ('EGY12', 'Lámina EGY12', 'Egipto', 'Común'),
    ('EGY13', 'Lámina EGY13', 'Egipto', 'Poco Común'),
    ('EGY14', 'Lámina EGY14', 'Egipto', 'Común'),
    ('EGY15', 'Lámina EGY15', 'Egipto', 'Común'),
    ('EGY16', 'Lámina EGY16', 'Egipto', 'Común'),
    ('EGY17', 'Lámina EGY17', 'Egipto', 'Común'),
    ('EGY18', 'Lámina EGY18', 'Egipto', 'Común'),
    ('EGY19', 'Lámina EGY19', 'Egipto', 'Común'),
    ('EGY20', 'Lámina EGY20', 'Egipto', 'Común');

-- ---------- Irán (IRN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('IRN2', 'Lámina IRN2', 'Irán', 'Valiosa'),
    ('IRN3', 'Lámina IRN3', 'Irán', 'Común'),
    ('IRN4', 'Lámina IRN4', 'Irán', 'Común'),
    ('IRN5', 'Lámina IRN5', 'Irán', 'Común'),
    ('IRN6', 'Lámina IRN6', 'Irán', 'Común'),
    ('IRN7', 'Lámina IRN7', 'Irán', 'Común'),
    ('IRN8', 'Lámina IRN8', 'Irán', 'Común'),
    ('IRN9', 'Lámina IRN9', 'Irán', 'Común'),
    ('IRN10', 'Lámina IRN10', 'Irán', 'Común'),
    ('IRN11', 'Lámina IRN11', 'Irán', 'Común'),
    ('IRN12', 'Lámina IRN12', 'Irán', 'Común'),
    ('IRN13', 'Lámina IRN13', 'Irán', 'Poco Común'),
    ('IRN14', 'Lámina IRN14', 'Irán', 'Común'),
    ('IRN15', 'Lámina IRN15', 'Irán', 'Común'),
    ('IRN16', 'Lámina IRN16', 'Irán', 'Común'),
    ('IRN17', 'Lámina IRN17', 'Irán', 'Común'),
    ('IRN18', 'Lámina IRN18', 'Irán', 'Común'),
    ('IRN19', 'Lámina IRN19', 'Irán', 'Común'),
    ('IRN20', 'Lámina IRN20', 'Irán', 'Común');

-- ---------- Nueva Zelanda (NZL) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('NZL1', 'Lámina NZL1', 'Nueva Zelanda', 'Valiosa'),
    ('NZL2', 'Lámina NZL2', 'Nueva Zelanda', 'Común'),
    ('NZL3', 'Lámina NZL3', 'Nueva Zelanda', 'Común'),
    ('NZL4', 'Lámina NZL4', 'Nueva Zelanda', 'Común'),
    ('NZL5', 'Lámina NZL5', 'Nueva Zelanda', 'Común'),
    ('NZL6', 'Lámina NZL6', 'Nueva Zelanda', 'Común'),
    ('NZL7', 'Lámina NZL7', 'Nueva Zelanda', 'Común'),
    ('NZL8', 'Lámina NZL8', 'Nueva Zelanda', 'Común'),
    ('NZL9', 'Lámina NZL9', 'Nueva Zelanda', 'Común'),
    ('NZL10', 'Lámina NZL10', 'Nueva Zelanda', 'Común'),
    ('NZL11', 'Lámina NZL11', 'Nueva Zelanda', 'Común'),
    ('NZL12', 'Lámina NZL12', 'Nueva Zelanda', 'Común'),
    ('NZL13', 'Lámina NZL13', 'Nueva Zelanda', 'Poco Común'),
    ('NZL14', 'Lámina NZL14', 'Nueva Zelanda', 'Común'),
    ('NZL15', 'Lámina NZL15', 'Nueva Zelanda', 'Común'),
    ('NZL16', 'Lámina NZL16', 'Nueva Zelanda', 'Común'),
    ('NZL17', 'Lámina NZL17', 'Nueva Zelanda', 'Común'),
    ('NZL18', 'Lámina NZL18', 'Nueva Zelanda', 'Común'),
    ('NZL19', 'Lámina NZL19', 'Nueva Zelanda', 'Común'),
    ('NZL20', 'Lámina NZL20', 'Nueva Zelanda', 'Común');

-- ---------- España (ESP) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('ESP1', 'Lámina ESP1', 'España', 'Super Valiosa'),
    ('ESP2', 'Lámina ESP2', 'España', 'Común'),
    ('ESP3', 'Lámina ESP3', 'España', 'Común'),
    ('ESP4', 'Lámina ESP4', 'España', 'Común'),
    ('ESP5', 'Lámina ESP5', 'España', 'Común'),
    ('ESP6', 'Lámina ESP6', 'España', 'Común'),
    ('ESP7', 'Lámina ESP7', 'España', 'Común'),
    ('ESP8', 'Lámina ESP8', 'España', 'Común'),
    ('ESP9', 'Lámina ESP9', 'España', 'Común'),
    ('ESP10', 'Lámina ESP10', 'España', 'Común'),
    ('ESP11', 'Lámina ESP11', 'España', 'Común'),
    ('ESP12', 'Lámina ESP12', 'España', 'Común'),
    ('ESP13', 'Lámina ESP13', 'España', 'Valiosa'),
    ('ESP14', 'Lámina ESP14', 'España', 'Común'),
    ('ESP15', 'Lámina ESP15', 'España', 'Muy Valiosa'),
    ('ESP16', 'Lámina ESP16', 'España', 'Común'),
    ('ESP17', 'Lámina ESP17', 'España', 'Común'),
    ('ESP18', 'Lámina ESP18', 'España', 'Común'),
    ('ESP19', 'Lámina ESP19', 'España', 'Común'),
    ('ESP20', 'Lámina ESP20', 'España', 'Común');

-- ---------- Cabo Verde (CPV) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CPV1', 'Lámina CPV1', 'Cabo Verde', 'Valiosa'),
    ('CPV2', 'Lámina CPV2', 'Cabo Verde', 'Común'),
    ('CPV3', 'Lámina CPV3', 'Cabo Verde', 'Común'),
    ('CPV4', 'Lámina CPV4', 'Cabo Verde', 'Común'),
    ('CPV6', 'Lámina CPV6', 'Cabo Verde', 'Común'),
    ('CPV7', 'Lámina CPV7', 'Cabo Verde', 'Común'),
    ('CPV8', 'Lámina CPV8', 'Cabo Verde', 'Común'),
    ('CPV9', 'Lámina CPV9', 'Cabo Verde', 'Común'),
    ('CPV10', 'Lámina CPV10', 'Cabo Verde', 'Común'),
    ('CPV11', 'Lámina CPV11', 'Cabo Verde', 'Común'),
    ('CPV13', 'Lámina CPV13', 'Cabo Verde', 'Poco Común'),
    ('CPV16', 'Lámina CPV16', 'Cabo Verde', 'Común'),
    ('CPV18', 'Lámina CPV18', 'Cabo Verde', 'Común'),
    ('CPV19', 'Lámina CPV19', 'Cabo Verde', 'Común'),
    ('CPV20', 'Lámina CPV20', 'Cabo Verde', 'Común');

-- ---------- Arabia Saudita (KSA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('KSA1', 'Lámina KSA1', 'Arabia Saudita', 'Valiosa'),
    ('KSA2', 'Lámina KSA2', 'Arabia Saudita', 'Común'),
    ('KSA3', 'Lámina KSA3', 'Arabia Saudita', 'Común'),
    ('KSA4', 'Lámina KSA4', 'Arabia Saudita', 'Común'),
    ('KSA5', 'Lámina KSA5', 'Arabia Saudita', 'Común'),
    ('KSA6', 'Lámina KSA6', 'Arabia Saudita', 'Común'),
    ('KSA7', 'Lámina KSA7', 'Arabia Saudita', 'Común'),
    ('KSA8', 'Lámina KSA8', 'Arabia Saudita', 'Común'),
    ('KSA9', 'Lámina KSA9', 'Arabia Saudita', 'Común'),
    ('KSA10', 'Lámina KSA10', 'Arabia Saudita', 'Común'),
    ('KSA11', 'Lámina KSA11', 'Arabia Saudita', 'Común'),
    ('KSA12', 'Lámina KSA12', 'Arabia Saudita', 'Común'),
    ('KSA13', 'Lámina KSA13', 'Arabia Saudita', 'Poco Común'),
    ('KSA14', 'Lámina KSA14', 'Arabia Saudita', 'Común'),
    ('KSA15', 'Lámina KSA15', 'Arabia Saudita', 'Común'),
    ('KSA16', 'Lámina KSA16', 'Arabia Saudita', 'Común'),
    ('KSA17', 'Lámina KSA17', 'Arabia Saudita', 'Común'),
    ('KSA18', 'Lámina KSA18', 'Arabia Saudita', 'Común'),
    ('KSA19', 'Lámina KSA19', 'Arabia Saudita', 'Común'),
    ('KSA20', 'Lámina KSA20', 'Arabia Saudita', 'Común');

-- ---------- Uruguay (URU) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('URU1', 'Lámina URU1', 'Uruguay', 'Muy Valiosa'),
    ('URU2', 'Lámina URU2', 'Uruguay', 'Común'),
    ('URU3', 'Lámina URU3', 'Uruguay', 'Común'),
    ('URU4', 'Lámina URU4', 'Uruguay', 'Común'),
    ('URU5', 'Lámina URU5', 'Uruguay', 'Común'),
    ('URU6', 'Lámina URU6', 'Uruguay', 'Común'),
    ('URU7', 'Lámina URU7', 'Uruguay', 'Común'),
    ('URU8', 'Lámina URU8', 'Uruguay', 'Común'),
    ('URU9', 'Lámina URU9', 'Uruguay', 'Común'),
    ('URU10', 'Lámina URU10', 'Uruguay', 'Común'),
    ('URU11', 'Lámina URU11', 'Uruguay', 'Común'),
    ('URU12', 'Lámina URU12', 'Uruguay', 'Común'),
    ('URU13', 'Lámina URU13', 'Uruguay', 'Poco Común'),
    ('URU14', 'Lámina URU14', 'Uruguay', 'Común'),
    ('URU15', 'Lámina URU15', 'Uruguay', 'Común'),
    ('URU16', 'Lámina URU16', 'Uruguay', 'Común'),
    ('URU17', 'Lámina URU17', 'Uruguay', 'Común'),
    ('URU18', 'Lámina URU18', 'Uruguay', 'Común'),
    ('URU19', 'Lámina URU19', 'Uruguay', 'Común'),
    ('URU20', 'Lámina URU20', 'Uruguay', 'Común');

-- ---------- Francia (FRA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('FRA1', 'Lámina FRA1', 'Francia', 'Super Valiosa'),
    ('FRA2', 'Lámina FRA2', 'Francia', 'Común'),
    ('FRA3', 'Lámina FRA3', 'Francia', 'Común'),
    ('FRA5', 'Lámina FRA5', 'Francia', 'Común'),
    ('FRA6', 'Lámina FRA6', 'Francia', 'Común'),
    ('FRA7', 'Lámina FRA7', 'Francia', 'Común'),
    ('FRA9', 'Lámina FRA9', 'Francia', 'Común'),
    ('FRA10', 'Lámina FRA10', 'Francia', 'Común'),
    ('FRA11', 'Lámina FRA11', 'Francia', 'Común'),
    ('FRA13', 'Lámina FRA13', 'Francia', 'Valiosa'),
    ('FRA14', 'Lámina FRA14', 'Francia', 'Común'),
    ('FRA15', 'Lámina FRA15', 'Francia', 'Común'),
    ('FRA17', 'Lámina FRA17', 'Francia', 'Común'),
    ('FRA18', 'Lámina FRA18', 'Francia', 'Común'),
    ('FRA20', 'Lámina FRA20', 'Francia', 'Super Valiosa');

-- ---------- Senegal (SEN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('SEN1', 'Lámina SEN1', 'Senegal', 'Valiosa'),
    ('SEN2', 'Lámina SEN2', 'Senegal', 'Común'),
    ('SEN3', 'Lámina SEN3', 'Senegal', 'Común'),
    ('SEN4', 'Lámina SEN4', 'Senegal', 'Común'),
    ('SEN5', 'Lámina SEN5', 'Senegal', 'Común'),
    ('SEN6', 'Lámina SEN6', 'Senegal', 'Común'),
    ('SEN7', 'Lámina SEN7', 'Senegal', 'Común'),
    ('SEN8', 'Lámina SEN8', 'Senegal', 'Común'),
    ('SEN9', 'Lámina SEN9', 'Senegal', 'Común'),
    ('SEN10', 'Lámina SEN10', 'Senegal', 'Común'),
    ('SEN11', 'Lámina SEN11', 'Senegal', 'Común'),
    ('SEN12', 'Lámina SEN12', 'Senegal', 'Común'),
    ('SEN13', 'Lámina SEN13', 'Senegal', 'Poco Común'),
    ('SEN14', 'Lámina SEN14', 'Senegal', 'Común'),
    ('SEN15', 'Lámina SEN15', 'Senegal', 'Común'),
    ('SEN16', 'Lámina SEN16', 'Senegal', 'Común'),
    ('SEN17', 'Lámina SEN17', 'Senegal', 'Común'),
    ('SEN18', 'Lámina SEN18', 'Senegal', 'Común'),
    ('SEN19', 'Lámina SEN19', 'Senegal', 'Común'),
    ('SEN20', 'Lámina SEN20', 'Senegal', 'Común');

-- ---------- Irak (IRQ) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('IRQ1', 'Lámina IRQ1', 'Irak', 'Valiosa'),
    ('IRQ2', 'Lámina IRQ2', 'Irak', 'Común'),
    ('IRQ3', 'Lámina IRQ3', 'Irak', 'Común'),
    ('IRQ4', 'Lámina IRQ4', 'Irak', 'Común'),
    ('IRQ5', 'Lámina IRQ5', 'Irak', 'Común'),
    ('IRQ6', 'Lámina IRQ6', 'Irak', 'Común'),
    ('IRQ7', 'Lámina IRQ7', 'Irak', 'Común'),
    ('IRQ8', 'Lámina IRQ8', 'Irak', 'Común'),
    ('IRQ9', 'Lámina IRQ9', 'Irak', 'Común'),
    ('IRQ10', 'Lámina IRQ10', 'Irak', 'Común'),
    ('IRQ11', 'Lámina IRQ11', 'Irak', 'Común'),
    ('IRQ12', 'Lámina IRQ12', 'Irak', 'Común'),
    ('IRQ13', 'Lámina IRQ13', 'Irak', 'Poco Común'),
    ('IRQ14', 'Lámina IRQ14', 'Irak', 'Común'),
    ('IRQ15', 'Lámina IRQ15', 'Irak', 'Común'),
    ('IRQ16', 'Lámina IRQ16', 'Irak', 'Común'),
    ('IRQ17', 'Lámina IRQ17', 'Irak', 'Común'),
    ('IRQ18', 'Lámina IRQ18', 'Irak', 'Común'),
    ('IRQ19', 'Lámina IRQ19', 'Irak', 'Común'),
    ('IRQ20', 'Lámina IRQ20', 'Irak', 'Común');

-- ---------- Noruega (NOR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('NOR1', 'Lámina NOR1', 'Noruega', 'Valiosa'),
    ('NOR2', 'Lámina NOR2', 'Noruega', 'Común'),
    ('NOR3', 'Lámina NOR3', 'Noruega', 'Común'),
    ('NOR4', 'Lámina NOR4', 'Noruega', 'Común'),
    ('NOR5', 'Lámina NOR5', 'Noruega', 'Común'),
    ('NOR6', 'Lámina NOR6', 'Noruega', 'Común'),
    ('NOR7', 'Lámina NOR7', 'Noruega', 'Común'),
    ('NOR8', 'Lámina NOR8', 'Noruega', 'Común'),
    ('NOR9', 'Lámina NOR9', 'Noruega', 'Común'),
    ('NOR10', 'Lámina NOR10', 'Noruega', 'Común'),
    ('NOR11', 'Lámina NOR11', 'Noruega', 'Común'),
    ('NOR12', 'Lámina NOR12', 'Noruega', 'Común'),
    ('NOR13', 'Lámina NOR13', 'Noruega', 'Poco Común'),
    ('NOR14', 'Lámina NOR14', 'Noruega', 'Común'),
    ('NOR15', 'Lámina NOR15', 'Noruega', 'Muy Valiosa'),
    ('NOR16', 'Lámina NOR16', 'Noruega', 'Común'),
    ('NOR17', 'Lámina NOR17', 'Noruega', 'Común'),
    ('NOR18', 'Lámina NOR18', 'Noruega', 'Común'),
    ('NOR19', 'Lámina NOR19', 'Noruega', 'Común'),
    ('NOR20', 'Lámina NOR20', 'Noruega', 'Común');

-- ---------- Argentina (ARG) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('ARG1', 'Lámina ARG1', 'Argentina', 'Ultra Valiosa'),
    ('ARG3', 'Lámina ARG3', 'Argentina', 'Común'),
    ('ARG4', 'Lámina ARG4', 'Argentina', 'Común'),
    ('ARG5', 'Lámina ARG5', 'Argentina', 'Común'),
    ('ARG8', 'Lámina ARG8', 'Argentina', 'Común'),
    ('ARG9', 'Lámina ARG9', 'Argentina', 'Común'),
    ('ARG10', 'Lámina ARG10', 'Argentina', 'Común'),
    ('ARG11', 'Lámina ARG11', 'Argentina', 'Común'),
    ('ARG12', 'Lámina ARG12', 'Argentina', 'Común'),
    ('ARG13', 'Lámina ARG13', 'Argentina', 'Valiosa'),
    ('ARG14', 'Lámina ARG14', 'Argentina', 'Común'),
    ('ARG15', 'Lámina ARG15', 'Argentina', 'Común'),
    ('ARG16', 'Lámina ARG16', 'Argentina', 'Común'),
    ('ARG17', 'Lámina ARG17', 'Argentina', 'Super Valiosa'),
    ('ARG18', 'Lámina ARG18', 'Argentina', 'Valiosa'),
    ('ARG19', 'Lámina ARG19', 'Argentina', 'Común'),
    ('ARG20', 'Lámina ARG20', 'Argentina', 'Común');

-- ---------- Argelia (ALG) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('ALG1', 'Lámina ALG1', 'Argelia', 'Valiosa'),
    ('ALG2', 'Lámina ALG2', 'Argelia', 'Común'),
    ('ALG3', 'Lámina ALG3', 'Argelia', 'Común'),
    ('ALG6', 'Lámina ALG6', 'Argelia', 'Común'),
    ('ALG7', 'Lámina ALG7', 'Argelia', 'Común'),
    ('ALG9', 'Lámina ALG9', 'Argelia', 'Común'),
    ('ALG10', 'Lámina ALG10', 'Argelia', 'Común'),
    ('ALG11', 'Lámina ALG11', 'Argelia', 'Común'),
    ('ALG12', 'Lámina ALG12', 'Argelia', 'Común'),
    ('ALG13', 'Lámina ALG13', 'Argelia', 'Poco Común'),
    ('ALG14', 'Lámina ALG14', 'Argelia', 'Común'),
    ('ALG15', 'Lámina ALG15', 'Argelia', 'Común'),
    ('ALG16', 'Lámina ALG16', 'Argelia', 'Común'),
    ('ALG17', 'Lámina ALG17', 'Argelia', 'Común'),
    ('ALG18', 'Lámina ALG18', 'Argelia', 'Común'),
    ('ALG19', 'Lámina ALG19', 'Argelia', 'Común'),
    ('ALG20', 'Lámina ALG20', 'Argelia', 'Común');

-- ---------- Austria (AUT) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('AUT1', 'Lámina AUT1', 'Austria', 'Valiosa'),
    ('AUT2', 'Lámina AUT2', 'Austria', 'Común'),
    ('AUT3', 'Lámina AUT3', 'Austria', 'Común'),
    ('AUT4', 'Lámina AUT4', 'Austria', 'Común'),
    ('AUT5', 'Lámina AUT5', 'Austria', 'Común'),
    ('AUT6', 'Lámina AUT6', 'Austria', 'Común'),
    ('AUT7', 'Lámina AUT7', 'Austria', 'Común'),
    ('AUT8', 'Lámina AUT8', 'Austria', 'Común'),
    ('AUT9', 'Lámina AUT9', 'Austria', 'Común'),
    ('AUT10', 'Lámina AUT10', 'Austria', 'Común'),
    ('AUT11', 'Lámina AUT11', 'Austria', 'Común'),
    ('AUT13', 'Lámina AUT13', 'Austria', 'Poco Común'),
    ('AUT14', 'Lámina AUT14', 'Austria', 'Común'),
    ('AUT16', 'Lámina AUT16', 'Austria', 'Común'),
    ('AUT17', 'Lámina AUT17', 'Austria', 'Común'),
    ('AUT19', 'Lámina AUT19', 'Austria', 'Común'),
    ('AUT20', 'Lámina AUT20', 'Austria', 'Común');

-- ---------- Jordania (JOR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('JOR2', 'Lámina JOR2', 'Jordania', 'Valiosa'),
    ('JOR3', 'Lámina JOR3', 'Jordania', 'Común'),
    ('JOR4', 'Lámina JOR4', 'Jordania', 'Común'),
    ('JOR5', 'Lámina JOR5', 'Jordania', 'Común'),
    ('JOR6', 'Lámina JOR6', 'Jordania', 'Común'),
    ('JOR7', 'Lámina JOR7', 'Jordania', 'Común'),
    ('JOR8', 'Lámina JOR8', 'Jordania', 'Común'),
    ('JOR9', 'Lámina JOR9', 'Jordania', 'Común'),
    ('JOR10', 'Lámina JOR10', 'Jordania', 'Común'),
    ('JOR11', 'Lámina JOR11', 'Jordania', 'Común'),
    ('JOR12', 'Lámina JOR12', 'Jordania', 'Común'),
    ('JOR13', 'Lámina JOR13', 'Jordania', 'Poco Común'),
    ('JOR14', 'Lámina JOR14', 'Jordania', 'Común'),
    ('JOR15', 'Lámina JOR15', 'Jordania', 'Común'),
    ('JOR16', 'Lámina JOR16', 'Jordania', 'Común'),
    ('JOR17', 'Lámina JOR17', 'Jordania', 'Común'),
    ('JOR18', 'Lámina JOR18', 'Jordania', 'Común'),
    ('JOR19', 'Lámina JOR19', 'Jordania', 'Común'),
    ('JOR20', 'Lámina JOR20', 'Jordania', 'Común');

-- ---------- Portugal (POR) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('POR1', 'Lámina POR1', 'Portugal', 'Super Valiosa'),
    ('POR2', 'Lámina POR2', 'Portugal', 'Común'),
    ('POR4', 'Lámina POR4', 'Portugal', 'Común'),
    ('POR5', 'Lámina POR5', 'Portugal', 'Común'),
    ('POR6', 'Lámina POR6', 'Portugal', 'Común'),
    ('POR7', 'Lámina POR7', 'Portugal', 'Común'),
    ('POR8', 'Lámina POR8', 'Portugal', 'Común'),
    ('POR9', 'Lámina POR9', 'Portugal', 'Común'),
    ('POR10', 'Lámina POR10', 'Portugal', 'Común'),
    ('POR11', 'Lámina POR11', 'Portugal', 'Común'),
    ('POR12', 'Lámina POR12', 'Portugal', 'Común'),
    ('POR13', 'Lámina POR13', 'Portugal', 'Valiosa'),
    ('POR14', 'Lámina POR14', 'Portugal', 'Común'),
    ('POR15', 'Lámina POR15', 'Portugal', 'Super Valiosa'),
    ('POR16', 'Lámina POR16', 'Portugal', 'Común'),
    ('POR17', 'Lámina POR17', 'Portugal', 'Común'),
    ('POR18', 'Lámina POR18', 'Portugal', 'Común'),
    ('POR19', 'Lámina POR19', 'Portugal', 'Común'),
    ('POR20', 'Lámina POR20', 'Portugal', 'Común');

-- ---------- Rep. Dem. del Congo (COD) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('COD1', 'Lámina COD1', 'Rep. Dem. del Congo', 'Valiosa'),
    ('COD2', 'Lámina COD2', 'Rep. Dem. del Congo', 'Común'),
    ('COD3', 'Lámina COD3', 'Rep. Dem. del Congo', 'Común'),
    ('COD4', 'Lámina COD4', 'Rep. Dem. del Congo', 'Común'),
    ('COD5', 'Lámina COD5', 'Rep. Dem. del Congo', 'Común'),
    ('COD6', 'Lámina COD6', 'Rep. Dem. del Congo', 'Común'),
    ('COD7', 'Lámina COD7', 'Rep. Dem. del Congo', 'Común'),
    ('COD8', 'Lámina COD8', 'Rep. Dem. del Congo', 'Común'),
    ('COD9', 'Lámina COD9', 'Rep. Dem. del Congo', 'Común'),
    ('COD10', 'Lámina COD10', 'Rep. Dem. del Congo', 'Común'),
    ('COD11', 'Lámina COD11', 'Rep. Dem. del Congo', 'Común'),
    ('COD12', 'Lámina COD12', 'Rep. Dem. del Congo', 'Común'),
    ('COD13', 'Lámina COD13', 'Rep. Dem. del Congo', 'Poco Común'),
    ('COD14', 'Lámina COD14', 'Rep. Dem. del Congo', 'Común'),
    ('COD15', 'Lámina COD15', 'Rep. Dem. del Congo', 'Común'),
    ('COD16', 'Lámina COD16', 'Rep. Dem. del Congo', 'Común'),
    ('COD17', 'Lámina COD17', 'Rep. Dem. del Congo', 'Común'),
    ('COD18', 'Lámina COD18', 'Rep. Dem. del Congo', 'Común'),
    ('COD19', 'Lámina COD19', 'Rep. Dem. del Congo', 'Común'),
    ('COD20', 'Lámina COD20', 'Rep. Dem. del Congo', 'Común');

-- ---------- Uzbekistán (UZB) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('UZB1', 'Lámina UZB1', 'Uzbekistán', 'Valiosa'),
    ('UZB2', 'Lámina UZB2', 'Uzbekistán', 'Común'),
    ('UZB3', 'Lámina UZB3', 'Uzbekistán', 'Común'),
    ('UZB4', 'Lámina UZB4', 'Uzbekistán', 'Común'),
    ('UZB5', 'Lámina UZB5', 'Uzbekistán', 'Común'),
    ('UZB6', 'Lámina UZB6', 'Uzbekistán', 'Común'),
    ('UZB7', 'Lámina UZB7', 'Uzbekistán', 'Común'),
    ('UZB8', 'Lámina UZB8', 'Uzbekistán', 'Común'),
    ('UZB9', 'Lámina UZB9', 'Uzbekistán', 'Común'),
    ('UZB10', 'Lámina UZB10', 'Uzbekistán', 'Común'),
    ('UZB11', 'Lámina UZB11', 'Uzbekistán', 'Común'),
    ('UZB12', 'Lámina UZB12', 'Uzbekistán', 'Común'),
    ('UZB13', 'Lámina UZB13', 'Uzbekistán', 'Poco Común'),
    ('UZB14', 'Lámina UZB14', 'Uzbekistán', 'Común'),
    ('UZB15', 'Lámina UZB15', 'Uzbekistán', 'Común'),
    ('UZB16', 'Lámina UZB16', 'Uzbekistán', 'Común'),
    ('UZB17', 'Lámina UZB17', 'Uzbekistán', 'Común'),
    ('UZB18', 'Lámina UZB18', 'Uzbekistán', 'Común'),
    ('UZB19', 'Lámina UZB19', 'Uzbekistán', 'Común'),
    ('UZB20', 'Lámina UZB20', 'Uzbekistán', 'Común');

-- ---------- Colombia (COL) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('COL1', 'Lámina COL1', 'Colombia', 'Muy Valiosa'),
    ('COL2', 'Lámina COL2', 'Colombia', 'Común'),
    ('COL3', 'Lámina COL3', 'Colombia', 'Común'),
    ('COL4', 'Lámina COL4', 'Colombia', 'Común'),
    ('COL5', 'Lámina COL5', 'Colombia', 'Común'),
    ('COL6', 'Lámina COL6', 'Colombia', 'Común'),
    ('COL7', 'Lámina COL7', 'Colombia', 'Común'),
    ('COL8', 'Lámina COL8', 'Colombia', 'Común'),
    ('COL9', 'Lámina COL9', 'Colombia', 'Común'),
    ('COL10', 'Lámina COL10', 'Colombia', 'Común'),
    ('COL11', 'Lámina COL11', 'Colombia', 'Común'),
    ('COL12', 'Lámina COL12', 'Colombia', 'Común'),
    ('COL13', 'Lámina COL13', 'Colombia', 'Valiosa'),
    ('COL14', 'Lámina COL14', 'Colombia', 'Muy Valiosa'),
    ('COL15', 'Lámina COL15', 'Colombia', 'Común'),
    ('COL16', 'Lámina COL16', 'Colombia', 'Común'),
    ('COL17', 'Lámina COL17', 'Colombia', 'Común'),
    ('COL18', 'Lámina COL18', 'Colombia', 'Común'),
    ('COL19', 'Lámina COL19', 'Colombia', 'Común'),
    ('COL20', 'Lámina COL20', 'Colombia', 'Muy Valiosa');

-- ---------- Inglaterra (ENG) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('ENG1', 'Lámina ENG1', 'Inglaterra', 'Super Valiosa'),
    ('ENG2', 'Lámina ENG2', 'Inglaterra', 'Común'),
    ('ENG3', 'Lámina ENG3', 'Inglaterra', 'Común'),
    ('ENG4', 'Lámina ENG4', 'Inglaterra', 'Común'),
    ('ENG5', 'Lámina ENG5', 'Inglaterra', 'Común'),
    ('ENG6', 'Lámina ENG6', 'Inglaterra', 'Común'),
    ('ENG7', 'Lámina ENG7', 'Inglaterra', 'Común'),
    ('ENG8', 'Lámina ENG8', 'Inglaterra', 'Común'),
    ('ENG9', 'Lámina ENG9', 'Inglaterra', 'Común'),
    ('ENG10', 'Lámina ENG10', 'Inglaterra', 'Común'),
    ('ENG11', 'Lámina ENG11', 'Inglaterra', 'Muy Valiosa'),
    ('ENG12', 'Lámina ENG12', 'Inglaterra', 'Común'),
    ('ENG13', 'Lámina ENG13', 'Inglaterra', 'Valiosa'),
    ('ENG14', 'Lámina ENG14', 'Inglaterra', 'Común'),
    ('ENG15', 'Lámina ENG15', 'Inglaterra', 'Común'),
    ('ENG16', 'Lámina ENG16', 'Inglaterra', 'Común'),
    ('ENG17', 'Lámina ENG17', 'Inglaterra', 'Común'),
    ('ENG18', 'Lámina ENG18', 'Inglaterra', 'Valiosa'),
    ('ENG19', 'Lámina ENG19', 'Inglaterra', 'Común'),
    ('ENG20', 'Lámina ENG20', 'Inglaterra', 'Común');

-- ---------- Croacia (CRO) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('CRO1', 'Lámina CRO1', 'Croacia', 'Muy Valiosa'),
    ('CRO2', 'Lámina CRO2', 'Croacia', 'Común'),
    ('CRO3', 'Lámina CRO3', 'Croacia', 'Común'),
    ('CRO4', 'Lámina CRO4', 'Croacia', 'Común'),
    ('CRO5', 'Lámina CRO5', 'Croacia', 'Común'),
    ('CRO6', 'Lámina CRO6', 'Croacia', 'Común'),
    ('CRO7', 'Lámina CRO7', 'Croacia', 'Común'),
    ('CRO8', 'Lámina CRO8', 'Croacia', 'Común'),
    ('CRO9', 'Lámina CRO9', 'Croacia', 'Valiosa'),
    ('CRO10', 'Lámina CRO10', 'Croacia', 'Común'),
    ('CRO11', 'Lámina CRO11', 'Croacia', 'Común'),
    ('CRO12', 'Lámina CRO12', 'Croacia', 'Común'),
    ('CRO13', 'Lámina CRO13', 'Croacia', 'Poco Común'),
    ('CRO14', 'Lámina CRO14', 'Croacia', 'Común'),
    ('CRO15', 'Lámina CRO15', 'Croacia', 'Común'),
    ('CRO16', 'Lámina CRO16', 'Croacia', 'Común'),
    ('CRO17', 'Lámina CRO17', 'Croacia', 'Común'),
    ('CRO18', 'Lámina CRO18', 'Croacia', 'Común'),
    ('CRO19', 'Lámina CRO19', 'Croacia', 'Común'),
    ('CRO20', 'Lámina CRO20', 'Croacia', 'Común');

-- ---------- Ghana (GHA) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('GHA1', 'Lámina GHA1', 'Ghana', 'Valiosa'),
    ('GHA2', 'Lámina GHA2', 'Ghana', 'Común'),
    ('GHA3', 'Lámina GHA3', 'Ghana', 'Común'),
    ('GHA4', 'Lámina GHA4', 'Ghana', 'Común'),
    ('GHA5', 'Lámina GHA5', 'Ghana', 'Común'),
    ('GHA6', 'Lámina GHA6', 'Ghana', 'Común'),
    ('GHA7', 'Lámina GHA7', 'Ghana', 'Común'),
    ('GHA8', 'Lámina GHA8', 'Ghana', 'Común'),
    ('GHA9', 'Lámina GHA9', 'Ghana', 'Común'),
    ('GHA10', 'Lámina GHA10', 'Ghana', 'Común'),
    ('GHA11', 'Lámina GHA11', 'Ghana', 'Común'),
    ('GHA12', 'Lámina GHA12', 'Ghana', 'Común'),
    ('GHA13', 'Lámina GHA13', 'Ghana', 'Poco Común'),
    ('GHA14', 'Lámina GHA14', 'Ghana', 'Común'),
    ('GHA15', 'Lámina GHA15', 'Ghana', 'Común'),
    ('GHA16', 'Lámina GHA16', 'Ghana', 'Común'),
    ('GHA18', 'Lámina GHA18', 'Ghana', 'Común'),
    ('GHA19', 'Lámina GHA19', 'Ghana', 'Común'),
    ('GHA20', 'Lámina GHA20', 'Ghana', 'Común');

-- ---------- Panamá (PAN) ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('PAN1', 'Lámina PAN1', 'Panamá', 'Valiosa'),
    ('PAN2', 'Lámina PAN2', 'Panamá', 'Común'),
    ('PAN3', 'Lámina PAN3', 'Panamá', 'Común'),
    ('PAN4', 'Lámina PAN4', 'Panamá', 'Común'),
    ('PAN5', 'Lámina PAN5', 'Panamá', 'Común'),
    ('PAN6', 'Lámina PAN6', 'Panamá', 'Común'),
    ('PAN8', 'Lámina PAN8', 'Panamá', 'Común'),
    ('PAN9', 'Lámina PAN9', 'Panamá', 'Común'),
    ('PAN10', 'Lámina PAN10', 'Panamá', 'Común'),
    ('PAN11', 'Lámina PAN11', 'Panamá', 'Común'),
    ('PAN13', 'Lámina PAN13', 'Panamá', 'Poco Común'),
    ('PAN14', 'Lámina PAN14', 'Panamá', 'Común'),
    ('PAN15', 'Lámina PAN15', 'Panamá', 'Común'),
    ('PAN16', 'Lámina PAN16', 'Panamá', 'Común'),
    ('PAN17', 'Lámina PAN17', 'Panamá', 'Común'),
    ('PAN18', 'Lámina PAN18', 'Panamá', 'Común'),
    ('PAN19', 'Lámina PAN19', 'Panamá', 'Común');

-- ---------- Extras Irremplazables y Colección Coca-Cola ----------
INSERT IGNORE INTO laminas (numero, nombre_jugador, equipo, rareza) VALUES
    ('REGU', 'Regular Season Award', 'FIFA', 'Irremplazable'),
    ('BRON', 'Bronze Ball Award', 'FIFA', 'Irremplazable'),
    ('PRAT', 'Pratfall Award', 'FIFA', 'Irremplazable'),
    ('OURO', 'Golden Ball Award', 'FIFA', 'Irremplazable'),
    ('CC1', 'Coca-Cola 1', 'Coca-Cola', 'Irremplazable'),
    ('CC2', 'Coca-Cola 2', 'Coca-Cola', 'Irremplazable'),
    ('CC3', 'Coca-Cola 3', 'Coca-Cola', 'Irremplazable'),
    ('CC4', 'Coca-Cola 4', 'Coca-Cola', 'Irremplazable'),
    ('CC5', 'Coca-Cola 5', 'Coca-Cola', 'Irremplazable'),
    ('CC6', 'Coca-Cola 6', 'Coca-Cola', 'Irremplazable'),
    ('CC7', 'Coca-Cola 7', 'Coca-Cola', 'Irremplazable'),
    ('CC8', 'Coca-Cola 8', 'Coca-Cola', 'Irremplazable'),
    ('CC9', 'Coca-Cola 9', 'Coca-Cola', 'Irremplazable'),
    ('CC10', 'Coca-Cola 10', 'Coca-Cola', 'Irremplazable'),
    ('CC11', 'Coca-Cola 11', 'Coca-Cola', 'Irremplazable'),
    ('CC12', 'Coca-Cola 12', 'Coca-Cola', 'Irremplazable'),
    ('CC13', 'Coca-Cola 13', 'Coca-Cola', 'Irremplazable'),
    ('CC14', 'Coca-Cola 14', 'Coca-Cola', 'Irremplazable');

-- ============================================================
-- VERIFICACIÓN
-- ============================================================
SELECT COUNT(*) AS total_laminas FROM laminas;
-- Resultado esperado: 954