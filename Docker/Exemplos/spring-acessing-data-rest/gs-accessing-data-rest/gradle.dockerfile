FROM gradle:8.4.0-jdk17 AS build

WORKDIR /gs-accessing-data-rest

COPY build.gradle .
COPY settings.gradle .
COPY src /gs-accessing-data-rest/src

RUN gradle clean build

FROM eclipse-temurin:17-jdk-alpine

COPY --from=build /gs-accessing-data-rest/build/libs/accessing-data-rest-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]