# Scripts de Base de Datos - Sistema Universidad

Este directorio contiene los scripts SQL para la creación de la estructura y la carga de datos iniciales en **PostgreSQL** (compatible tanto para desarrollo local como para servicios en la nube como Supabase, Neon, RDS, etc.).

---

## 📁 Archivos disponibles

1. **`01_crear_tablas.sql` (DDL):**
   * Crea las tablas `usuarios` y `universidades`.
   * Define las claves primarias (`id` para usuarios, `nombre` para universidades).
   * Genera los índices para optimizar las consultas y reportes parametrizados.

2. **`02_datos_iniciales.sql` (DML):**
   * Inserta el **Usuario Administrador General** para el primer acceso tras el despliegue.
   * Inserta usuarios de prueba con variedad de roles (`Administrador`, `Docente`, `Estudiante`).
   * Inserta universidades de prueba públicas y privadas de diferentes ciudades.

3. **`init_db.sql` (Todo en uno):**
   * Script consolidado que incluye la creación de estructura (DDL) y la carga de datos iniciales (DML). Ideal para ejecutar en la consola SQL de Supabase o en un solo comando de `psql`.

---

## 🔑 Usuario Administrador Inicial (Credenciales de Acceso)

Para que cualquier persona o evaluador pueda acceder inmediatamente al sistema tras desplegarlo:

| Campo | Valor por Defecto |
| :--- | :--- |
| **Identificación / ID** | `1` |
| **Contraseña / Clave** | `admin` |
| **Nombre** | `Administrador General` |
| **Rol** | `Administrador` |
| **Correo Electrónico** | `admin@universidad.edu.co` |

> También se incluyen usuarios con roles de `Docente` y `Estudiante` en el script de datos iniciales.

---

## 🚀 Instrucciones de Ejecución

### Opción A: En servicios en la nube (Supabase / Neon)
1. Inicia sesión en tu proyecto de **Supabase** (o **Neon**).
2. Dirígete a la sección **SQL Editor**.
3. Abre el archivo [`init_db.sql`](./init_db.sql), copia todo su contenido y pégalo en el editor.
4. Haz clic en **Run**. Las tablas y datos iniciales quedarán listos inmediatamente.

### Opción B: En PostgreSQL Local mediante `psql`
Ejecuta los siguientes comandos en tu terminal:

```bash
# Crear base de datos si aún no existe
createdb -U postgres 7502523005_2_Universidad

# Ejecutar el script consolidado
psql -U postgres -d 7502523005_2_Universidad -f database/init_db.sql
```
O de forma separada:
```bash
psql -U postgres -d 7502523005_2_Universidad -f database/01_crear_tablas.sql
psql -U postgres -d 7502523005_2_Universidad -f database/02_datos_iniciales.sql
```
