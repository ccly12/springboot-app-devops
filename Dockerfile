FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

ENV GRADLE_OPTS="-Dorg.gradle.jvmargs=-Xmx512m"

RUN chmod +x gradlew

RUN ./gradlew classes --no-daemon --quiet

COPY src src
RUN ./gradlew bootJar --no-daemon --quiet


FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]