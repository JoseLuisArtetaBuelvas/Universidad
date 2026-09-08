# ========================================================
# ETAPA 1: Construcción del artefacto (Maven + Java 21)
# ========================================================
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /build

# Copiar configuración Maven y descargar dependencias (aprovechando caché de capas)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código fuente y empaquetar el .war
COPY src ./src
RUN mvn clean package -DskipTests -B

# ========================================================
# ETAPA 2: Servidor en tiempo de ejecución (Tomcat 10.1 + Java 21)
# ========================================================
FROM tomcat:10.1-jdk21-temurin

# Limpiar aplicaciones de ejemplo preinstaladas en Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar el archivo .war compilado como ROOT.war para responder en la raíz (/)
COPY --from=builder /build/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto estándar HTTP de Tomcat
EXPOSE 8080

# Comando para iniciar Tomcat en primer plano
CMD ["catalina.sh", "run"]
