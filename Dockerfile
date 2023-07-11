#
# Build stage
#
FROM maven:3.8.3-openjdk-17 AS build
WORKDIR /src
COPY . /src/
RUN mvn clean package

#
# Package stage
#
FROM openjdk:17-alpine
WORKDIR /src
COPY --from=build /src/target/*.jar /src/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
