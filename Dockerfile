# 使用 Maven + JDK 為 build base
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 使用 JDK slim 為運行 base
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/argo-workflow-test-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

