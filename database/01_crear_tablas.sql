-- ==========================================================
-- Sistema Universidad - Script DDL de Creación de Tablas
-- Motor de Base de Datos: PostgreSQL
-- Base de datos objetivo: 7502523005_2_Universidad
-- ==========================================================

SET client_encoding = 'UTF8';

-- 1. Tabla de Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER NOT NULL,
    clave VARCHAR(60) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    rol VARCHAR(40) NOT NULL,
    email VARCHAR(100),
    CONSTRAINT usuario_pkey PRIMARY KEY (id)
);

-- 2. Tabla de Universidades
CREATE TABLE IF NOT EXISTS universidades (
    id INTEGER NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    categoria VARCHAR(40) NOT NULL,
    web VARCHAR(50) NOT NULL,
    rector VARCHAR(40) NOT NULL,
    email VARCHAR(30) NOT NULL,
    acceso VARCHAR(40) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    numeroCarreras INTEGER NOT NULL,
    numeroSedes INTEGER NOT NULL,
    CONSTRAINT universidad_pkey PRIMARY KEY (nombre)
);

-- Índices para optimización de consultas y reportes
CREATE INDEX IF NOT EXISTS idx_usuarios_rol ON usuarios (LOWER(rol));
CREATE INDEX IF NOT EXISTS idx_universidades_ciudad ON universidades (LOWER(ciudad));
CREATE INDEX IF NOT EXISTS idx_universidades_categoria ON universidades (LOWER(categoria));
CREATE INDEX IF NOT EXISTS idx_universidades_id ON universidades (id);
