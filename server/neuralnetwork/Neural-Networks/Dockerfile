#
# Build stage
#
FROM maven:3.6.3-jdk-11-slim AS build

COPY /server/neuralnetwork/Neural-Networks/src /home/app/src

COPY /server/neuralnetwork/Neural-Networks/pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim

COPY --from=build /home/app/target/Neural-Networks-0.0.2-SNAPSHOT.jar /usr/local/lib/gamma-ai.jar

RUN mkdir -p /data

VOLUME ["/data"]

EXPOSE 8080

EXPOSE 9000

ENTRYPOINT ["java","-jar","/usr/local/lib/gamma-ai.jar"]