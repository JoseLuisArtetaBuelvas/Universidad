-- ==========================================================
-- Sistema Universidad - Script Completo de Inicialización (DDL + DML)
-- Motor de Base de Datos: PostgreSQL
-- Base de datos objetivo: 7502523005_2_Universidad (o Supabase / Cloud Postgres)
-- ==========================================================

SET client_encoding = 'UTF8';

-- ==========================================================
-- 1. ESTRUCTURA (DDL)
-- ==========================================================

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER NOT NULL,
    clave VARCHAR(60) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    rol VARCHAR(40) NOT NULL,
    email VARCHAR(100),
    CONSTRAINT usuario_pkey PRIMARY KEY (id)
);

-- Tabla de Universidades
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

-- ==========================================================
-- 2. DATOS INICIALES (DML)
-- ==========================================================

-- ----------------------------------------------------------
-- A. USUARIO ADMINISTRADOR GENERAL (Acceso Inicial al Sistema)
-- ----------------------------------------------------------
-- Credenciales de inicio de sesión:
--   Identificación (ID): 1
--   Contraseña:          admin
--   Rol:                 Administrador
-- ----------------------------------------------------------
INSERT INTO usuarios (id, clave, nombre, rol, email)
VALUES (1, 'admin', 'Administrador General', 'Administrador', 'admin@universidad.edu.co')
ON CONFLICT (id) DO UPDATE 
SET clave = EXCLUDED.clave, 
    nombre = EXCLUDED.nombre, 
    rol = EXCLUDED.rol, 
    email = EXCLUDED.email;

-- ----------------------------------------------------------
-- B. USUARIOS DE PRUEBA ADICIONALES (Roles Variados)
-- ----------------------------------------------------------
INSERT INTO usuarios (id, clave, nombre, rol, email) VALUES
(10010001, 'Carlos#2024', 'Carlos Andrés Mendoza', 'Docente', 'cmendoza@universidad.edu.co'),
(10010002, 'LauraG!2024', 'Laura Sofía Gómez', 'Estudiante', 'lgomez@universidad.edu.co'),
(10010003, 'JorgeH$123', 'Jorge Luis Herrera', 'Administrador', 'jherrera@universidad.edu.co'),
(10010004, 'ValenR*987', 'Valentina Ruiz Morales', 'Estudiante', 'vruiz@universidad.edu.co'),
(10010005, 'RpenaS!321', 'Ricardo Peña Silva', 'Docente', 'rpena@universidad.edu.co'),
(10010006, 'CamilaC#456', 'Camila Andrea Castro', 'Estudiante', 'ccastro@universidad.edu.co'),
(10010007, 'DiegoR&789', 'Diego Fernando Rojas', 'Docente', 'drojas@universidad.edu.co'),
(10010008, 'MarianaT%111', 'Mariana Torres Gil', 'Administrador', 'mtorres@universidad.edu.co'),
(10010009, 'FelipeA@222', 'Felipe Antonio Castro', 'Estudiante', 'fcastro@universidad.edu.co'),
(10010010, 'DianaO?333', 'Diana Marcela Ortiz', 'Docente', 'dortiz@universidad.edu.co')
ON CONFLICT (id) DO NOTHING;

-- ----------------------------------------------------------
-- C. UNIVERSIDADES INICIALES DE PRUEBA
-- ----------------------------------------------------------
INSERT INTO universidades (id, nombre, categoria, web, rector, email, acceso, telefono, ciudad, numeroCarreras, numeroSedes) VALUES
(101, 'Universidad de Cartagena', 'Pública', 'https://unicartagena.edu.co', 'William Malkún Castillejo', 'rectoria@unicartagena.edu.co', 'Pruebas Saber 11 / ICFES', '6056699800', 'Cartagena', 40, 4),
(102, 'Universidad Nacional de Colombia', 'Pública', 'https://unal.edu.co', 'Leopoldo Múnera Ruiz', 'contacto@unal.edu.co', 'Examen de Admisión', '6013165000', 'Bogotá', 94, 9),
(103, 'Universidad de Antioquia', 'Pública', 'https://udea.edu.co', 'John Jairo Arboleda', 'info@udea.edu.co', 'Examen de Admisión', '6042198332', 'Medellín', 82, 12),
(104, 'Universidad del Valle', 'Pública', 'https://univalle.edu.co', 'Guillermo Murillo Vargas', 'rectoria@univalle.edu.co', 'Pruebas Saber 11 / ICFES', '6023212100', 'Cali', 65, 8),
(105, 'Pontificia Universidad Javeriana', 'Privada', 'https://javeriana.edu.co', 'Luis Fernando Múnera', 'contacto@javeriana.edu.co', 'Ingreso Directo', '6013208320', 'Bogotá', 45, 2),
(106, 'Universidad del Norte', 'Privada', 'https://uninorte.edu.co', 'Adolfo Meisel Roca', 'info@uninorte.edu.co', 'Pruebas Saber 11 / ICFES', '6053509509', 'Barranquilla', 38, 1),
(107, 'Universidad Industrial de Santander', 'Pública', 'https://uis.edu.co', 'Hernán Porras Díaz', 'contacto@uis.edu.co', 'Pruebas Saber 11 / ICFES', '6076344000', 'Bucaramanga', 52, 5),
(108, 'Universidad de Caldas', 'Pública', 'https://ucaldas.edu.co', 'Fabio Hernando Arias', 'atencion@ucaldas.edu.co', 'Pruebas Saber 11 / ICFES', '6068781500', 'Manizales', 35, 4),
(109, 'Universidad del Cauca', 'Pública', 'https://unicauca.edu.co', 'Deibar René Hurtado', 'prensa@unicauca.edu.co', 'Examen de Admisión', '6028209800', 'Popayán', 42, 3),
(110, 'Universidad Tecnológica de Pereira', 'Pública', 'https://utp.edu.co', 'Luis Fernando Gaviria', 'contacto@utp.edu.co', 'Pruebas Saber 11 / ICFES', '6063137300', 'Pereira', 36, 2),
(111, 'Universidad del Magdalena', 'Pública', 'https://unimagdalena.edu.co', 'Pablo Vera Salazar', 'info@unimagdalena.edu.co', 'Examen de Admisión', '6054381000', 'Santa Marta', 32, 1),
(112, 'Universidad de los Andes', 'Privada', 'https://uniandes.edu.co', 'Raquel Bernal Salazar', 'contacto@uniandes.edu.co', 'Pruebas Saber 11 / ICFES', '6013394949', 'Bogotá', 43, 2),
(113, 'Universidad EAFIT', 'Privada', 'https://eafit.edu.co', 'Claudia Restrepo Montoya', 'contacto@eafit.edu.co', 'Ingreso Directo', '6042619500', 'Medellín', 28, 4),
(114, 'Universidad Icesi', 'Privada', 'https://icesi.edu.co', 'Esteban Piedrahita', 'info@icesi.edu.co', 'Pruebas Saber 11 / ICFES', '6025552334', 'Cali', 30, 1),
(115, 'Universidad de La Sabana', 'Privada', 'https://unisabana.edu.co', 'Rolando Roncancio', 'atencion@unisabana.edu.co', 'Pruebas Saber 11 / ICFES', '6018615555', 'Chía', 26, 1),
(116, 'Universidad Pontificia Bolivariana', 'Privada', 'https://upb.edu.co', 'Diego Alonso Marulanda', 'asesoria@upb.edu.co', 'Ingreso Directo', '6044488388', 'Medellín', 37, 5)
ON CONFLICT (nombre) DO NOTHING;
