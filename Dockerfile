FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install -y openjdk-17-jdk
RUN apt-get install -y maven

WORKDIR /app
COPY . .

RUN mvn clean package

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/target/demo-1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
