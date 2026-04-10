FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copiamos los archivos necesarios
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Damos permisos y descargamos dependencias
RUN chmod +x gradlew
RUN ./gradlew dependencies --no-daemon

# Copiamos el código y generamos el JAR
COPY src src
RUN ./gradlew bootJar --no-daemon

# Etapa final de ejecución
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]