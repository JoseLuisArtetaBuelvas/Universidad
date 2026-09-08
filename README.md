# 🎓 Sistema de Gestión Universitaria

Aplicación web desarrollada en **Java (Jakarta EE)** bajo el patrón arquitectónico **MVC (Modelo - Vista - Controlador)** utilizando **Java Servlets**, **JSP (JavaServer Pages)** y **PostgreSQL** como motor de base de datos relacional.

Este proyecto corresponde a la actividad académica de desarrollo web para la gestión integral de **Usuarios** y **Universidades**, incluyendo autenticación, control de sesiones, reportes parametrizados y recuperación de contraseñas vía correo electrónico.

---

## 📋 Requisitos del Sistema

Antes de ejecutar el proyecto, asegúrate de contar con el siguiente software instalado y configurado en tu entorno:

* **Java Development Kit (JDK):** Versión 17, 21 o 24 (compatible con Jakarta EE).
* **Servidor de Aplicaciones:** [Apache Tomcat 10.1.x](https://tomcat.apache.org/download-10.cgi) o superior (indispensable para soporte de la especificación `jakarta.*`).
* **Gestor de Construcción:** [Apache Maven 3.8+](https://maven.apache.org/) (el proyecto incluye también los wrappers `mvnw` y `mvnw.cmd`).
* **Motor de Base de Datos:** [PostgreSQL 14+](https://www.postgresql.org/) (instalación local) o un servicio PostgreSQL en la nube ([Supabase](https://supabase.com/), [Neon.tech](https://neon.tech/), AWS RDS, etc.).
* **Navegador Web:** Google Chrome, Mozilla Firefox, Microsoft Edge o cualquier navegador moderno.

---

## 🗄️ Configuración de la Base de Datos

El proyecto utiliza PostgreSQL. Toda la estructura y datos de prueba se encuentran versionados dentro de la carpeta [`database/`](./database/).

### 1. Parámetros por Defecto de la Conexión
Definidos en la clase [`ConexionBaseDatos.java`](./src/main/java/universidad/modelo/ConexionBaseDatos.java):
* **Host / Servidor:** `localhost`
* **Puerto:** `5432`
* **Base de Datos:** `7502523005_2_Universidad`
* **Usuario:** `postgres`
* **Contraseña:** `admin`

### 2. Creación y Carga de Datos

#### Opción A: En PostgreSQL Local (Línea de Comandos / psql)
```bash
# 1. Crear la base de datos
createdb -U postgres 7502523005_2_Universidad

# 2. Ejecutar el script unificado (DDL + DML)
psql -U postgres -d 7502523005_2_Universidad -f database/init_db.sql
```

*(También puedes ejecutar por separado [`database/01_crear_tablas.sql`](./database/01_crear_tablas.sql) y luego [`database/02_datos_iniciales.sql`](./database/02_datos_iniciales.sql)).*

#### Opción B: En la Nube (Supabase o Neon)
1. Crea un nuevo proyecto en [Supabase](https://supabase.com/).
2. Entra al **SQL Editor**.
3. Pega el contenido completo del archivo [`database/init_db.sql`](./database/init_db.sql) y haz clic en **Run**.
4. Actualiza los datos de conexión (host, user, password, etc.) en [`ConexionBaseDatos.java`](./src/main/java/universidad/modelo/ConexionBaseDatos.java).

---

## 🔑 Credenciales de Acceso Inicial

Para ingresar al sistema una vez desplegado o ejecutado en local, utiliza el **Usuario Administrador General**:

| Campo | Valor |
| :--- | :--- |
| **Identificación / ID** | `1` |
| **Contraseña / Clave** | `admin` |
| **Nombre** | `Administrador General` |
| **Rol** | `Administrador` |
| **Correo** | `admin@universidad.edu.co` |

> En [`02_datos_iniciales.sql`](./database/02_datos_iniciales.sql) también se incluyen usuarios de prueba con roles de **Docente** y **Estudiante**, así como registros de universidades de prueba.

---

## ⚙️ Variables de Entorno y Configuración (.env)

Para proteger las credenciales sensibles y facilitar el despliegue tanto en local como en la nube (Render, Railway, AWS, Supabase, Neon), la aplicación soporta variables de entorno mediante la clase [`EnvConfig.java`](./src/main/java/universidad/config/EnvConfig.java).

### 1. Archivo `.env` (Desarrollo Local)
El repositorio incluye una plantilla [` .env.example `](./.env.example). Para trabajar localmente:
1. Copia `.env.example` y nómbralo `.env`:
   ```bash
   cp .env.example .env
   ```
2. *(Opcional)* Modifica los valores según tu configuración local. Si no creas el archivo `.env`, el sistema usará los valores de respaldo predeterminados.
3. El archivo `.env` está en `.gitignore` para proteger tus claves y contraseñas de accesos públicos.

### 2. Tabla de Variables Disponibles

| Variable | Descripción | Valor por Defecto Local | Ejemplo en la Nube |
| :--- | :--- | :--- | :--- |
| `DB_DRIVER` | Driver JDBC de base de datos | `org.postgresql.Driver` | `org.postgresql.Driver` |
| `DB_HOST` | Host / Servidor de BD | `localhost` | `aws-0-sa-east-1.pooler.supabase.com` |
| `DB_PORT` | Puerto de conexión a la BD | `5432` | `5432` / `6543` |
| `DB_NAME` | Nombre de la base de datos | `7502523005_2_Universidad` | `postgres` |
| `DB_USER` | Usuario de la base de datos | `postgres` | `postgres.tu_id_proyecto` |
| `DB_PASSWORD` | Contraseña del usuario de BD | `admin` | `TuPasswordSeguro123` |
| `DB_URL` | *(Opcional)* URL completa JDBC | *(Generada dinámicamente)* | `jdbc:postgresql://...` |
| `MAIL_HOST` | Servidor SMTP de correo | `smtp.gmail.com` | `smtp.gmail.com` |
| `MAIL_PORT` | Puerto SMTP con TLS | `587` | `587` |
| `MAIL_USER` | Correo emisor para restablecer claves | `josex.developer@gmail.com` | `tu_correo@gmail.com` |
| `MAIL_PASSWORD` | Clave de aplicación de Google | `yyss bqhm knnv cdrg` | `xxxx xxxx xxxx xxxx` |

### 3. Configuración para Despliegue en la Nube
Al desplegar en plataformas PaaS/IaaS como **Render**, **Railway**, **Docker** o **AWS**, no necesitas subir el archivo `.env`. Simplemente define estas mismas variables en la sección **Environment Variables** del panel de control de tu proveedor.

---

## 🚀 Instrucciones para Ejecutar el Proyecto Localmente

### Método 1: Ejecución desde IntelliJ IDEA (Recomendado)
1. Clona el repositorio:
   ```bash
   git clone https://github.com/JoseLuisArtetaBuelvas/Universidad.git
   ```
2. Abre la carpeta del proyecto en **IntelliJ IDEA**.
3. Asegúrate de tener configurado el JDK (versión 17, 21 o 24) en `File > Project Structure > Project > SDK`.
4. Configura una nueva configuración de ejecución:
   * Menú **Run > Edit Configurations...** > **+** > **Tomcat Server > Local**.
   * En el campo **Application server**, apunta a tu directorio de instalación de **Apache Tomcat 10.1+**.
   * En la pestaña **Deployment**, haz clic en **+** > **Artifact...** y selecciona `Universidad:war exploded` (o `Universidad:war`).
   * En **Application context**, puedes definir `/Universidad` o dejar la raíz.
5. Inicia el servidor haciendo clic en el botón **Run** (ícono verde de play).
6. El navegador abrirá automáticamente la aplicación en:
   ```
   http://localhost:8080/Universidad/
   ```

### Método 2: Compilación manual con Maven y Despliegue en Tomcat
1. Compila y empaqueta la aplicación generando el archivo `.war`:
   ```bash
   # En Windows
   .\mvnw.cmd clean package

   # En Linux / macOS
   ./mvnw clean package
   ```
2. El comando generará el archivo `Universidad-1.0-SNAPSHOT.war` dentro del directorio `target/`.
3. Copia dicho archivo `.war` a la carpeta `webapps/` de tu servidor Tomcat:
   ```bash
   cp target/Universidad-1.0-SNAPSHOT.war /ruta/a/tomcat/webapps/Universidad.war
   ```
4. Inicia Apache Tomcat ejecutando:
   * Windows: `/ruta/a/tomcat/bin/startup.bat`
   * Linux/macOS: `/ruta/a/tomcat/bin/startup.sh`
5. Accede desde tu navegador a:
   ```
   http://localhost:8080/Universidad/
   ```

---

## 🏛️ Estructura y Módulos del Proyecto

El proyecto sigue una arquitectura **MVC** organizada de la siguiente manera:

```text
Universidad/
├── database/                   # Scripts SQL (DDL, DML y unificado)
│   ├── 01_crear_tablas.sql
│   ├── 02_datos_iniciales.sql
│   ├── init_db.sql
│   └── README.md
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── universidad/
│   │   │       ├── controladores/  # Servlets controladores (ServletUsuario, ServletUniversidad)
│   │   │       ├── modelo/         # Clases de entidad (Usuario, Universidad) y DAOs (CRUDUsuario, CRUDUniversidad, ConexionBaseDatos)
│   │   │       └── servicios/      # ServicioCorreo (envío de correos HTML vía Jakarta Mail)
│   │   └── webapp/
│   │       ├── index.jsp           # Panel principal de la aplicación
│   │       ├── universidad/        # Vistas JSP del módulo Universidad (agregar, buscar, modificar, eliminar, listar, reportes)
│   │       └── usuario/            # Vistas JSP del módulo Usuario (login, recuperar, agregar, buscar, modificar, eliminar, listar, reportes)
├── pom.xml                     # Configuración de dependencias y plugins Maven
└── README.md                   # Documentación general del proyecto
```

### Funcionalidades Implementadas:
1. **Autenticación y Sesiones:**
   * Inicio de sesión validado contra base de datos.
   * Manejo de sesión HTTP (`usuario.login`) para control de acceso a vistas protegidas.
   * Cierre de sesión y protección de rutas.
2. **Módulo de Usuarios:**
   * CRUD completo (Crear, Consultar, Modificar, Eliminar, Listar).
   * Recuperación de contraseña por correo electrónico con formato HTML dinámico.
   * Reportes parametrizados (filtrado por rol específico y búsqueda parcial por nombre o email).
3. **Módulo de Universidades:**
   * CRUD completo (Crear, Consultar por ID, Modificar, Eliminar, Listar todas).
   * Reportes parametrizados (filtrado por ciudad y categoría).
