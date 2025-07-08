# ---------- Stage 1: Build ----------
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy source and build
COPY . .
RUN mvn clean package -DskipTests

# ---------- Stage 2: Runtime ----------
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

