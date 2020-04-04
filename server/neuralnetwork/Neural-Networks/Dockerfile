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

COPY --from=build /home/app/target/Neural-Networks-0.0.4-SNAPSHOT.jar /usr/local/lib/gamma-ai.jar

RUN mkdir -p /data

RUN mkdir -p /data/pretraining

RUN mkdir -p /data/training

RUN mkdir -p /model

VOLUME ["/data"]

VOLUME ["/model"]

EXPOSE 8080

EXPOSE 9000

ENTRYPOINT ["java","-jar","/usr/local/lib/gamma-ai.jar"]
