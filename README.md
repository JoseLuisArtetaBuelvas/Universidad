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

## ⚙️ Variables y Parámetros de Configuración

### 1. Conexión a Base de Datos
Ubicación: [`src/main/java/universidad/modelo/ConexionBaseDatos.java`](./src/main/java/universidad/modelo/ConexionBaseDatos.java)
```java
protected String driver = "org.postgresql.Driver";
protected String nombreIPServidorBD = "localhost";
protected String url = "jdbc:postgresql://";
protected int puertoServidorBD = 5432;
protected String usuarioBD = "postgres";
protected String passwordUsuarioBD = "admin";
protected String nombreBD = "7502523005_2_Universidad";
```
*Si utilizas un servicio en la nube como Supabase, reemplaza `nombreIPServidorBD`, `usuarioBD`, `passwordUsuarioBD` y el nombre de la BD por los datos proporcionados por tu proveedor.*

### 2. Servicio de Correo Electrónico (Recuperación de Contraseñas)
Ubicación: [`src/main/java/universidad/servicios/ServicioCorreo.java`](./src/main/java/universidad/servicios/ServicioCorreo.java)
* **Protocolo:** SMTP (TLS puerto 587 con autenticación).
* **Host:** `smtp.gmail.com`
* **Credenciales requeridas:**
  * `REMITENTE`: Dirección de correo Gmail emisora.
  * `CLAVE_APLICACION`: Contraseña de aplicación de 16 dígitos generada en la configuración de seguridad de la cuenta de Google.

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
