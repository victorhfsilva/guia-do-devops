FROM gradle:8.4.0-jdk17 AS build

WORKDIR /gs-rest-service

COPY build.gradle .
COPY settings.gradle .
COPY src /gs-rest-service/src

RUN gradle clean build

FROM eclipse-temurin:17-jdk-alpine

COPY --from=build /gs-rest-service/build/libs/rest-service-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]