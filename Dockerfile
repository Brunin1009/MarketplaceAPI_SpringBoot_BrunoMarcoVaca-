# 1. ETAPA DE CONSTRUCCIÓN (BUILD)
# Usamos una imagen con Maven para compilar el código
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# 2. ETAPA DE EJECUCIÓN (RUN)
# Usamos una imagen ligera de Java 17 para correr la App
FROM eclipse-temurin:17-jdk-alpine
# Copiamos el JAR generado en la etapa anterior
COPY --from=build /target/*.jar app.jar
# Informamos el puerto (aunque Render usa el suyo propio)
EXPOSE 8080
# Comando para iniciar la app
ENTRYPOINT ["java", "-jar", "app.jar"]