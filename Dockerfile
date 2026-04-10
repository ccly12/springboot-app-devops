FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copiamos archivos de configuración de Gradle
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# LIMITAMOS LA MEMORIA: Esto es clave para que no se te quede en rojo
ENV GRADLE_OPTS="-Dorg.gradle.jvmargs=-Xmx512m"

RUN chmod +x gradlew

# REEMPLAZA el "RUN ./gradlew dependencies" por esto:
# Esto descarga las librerías pero no imprime miles de líneas
RUN ./gradlew classes --no-daemon --quiet

# Copiamos el código y armamos el JAR
COPY src src
RUN ./gradlew bootJar --no-daemon --quiet

# Etapa final
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]