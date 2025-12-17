# Étape 1: Build avec Maven
FROM maven:3.9-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Étape 2: Image finale légèreecee
FROM amazoncorretto:17-alpine3.19-jdk
WORKDIR /app
COPY --from=build /app/target/todo-api-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]