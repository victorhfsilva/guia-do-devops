FROM maven:3.8.5-eclipse-temurin-17 AS builder

WORKDIR /gs-rest-service

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src /gs-rest-service/src
RUN mvn install

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /gs-rest-service

COPY --from=builder /gs-rest-service/target/rest-service-complete-0.0.1-SNAPSHOT.jar app.jar 

ENTRYPOINT ["java", "-jar", "app.jar"]