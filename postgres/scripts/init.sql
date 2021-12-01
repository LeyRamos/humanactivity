CREATE SCHEMA agricultura;

DROP TABLE IF EXISTS argentina_datos;
CREATE TABLE argentina_datos (
    id_provincia INT NOT NULL,
    provincia VARCHAR(22) NOT NULL,
    id_departamento INT NOT NULL,
    departamento VARCHAR(40) NOT NULL,
    id_cultivo INT NOT NULL,
    cultivo VARCHAR(22) NOT NULL,
    id_campania INT NOT NULL,
    campania VARCHAR(16) NOT NULL,
    ha_sembrada DOUBLE PRECISION NOT NULL,
    ha_cosechada DOUBLE PRECISION NOT NULL,
    produccion_tn DOUBLE PRECISION NOT NULL,
    rendimiento_kgha DOUBLE PRECISION NOT NULL,
    fecha DATE
);

