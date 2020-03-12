FROM maven:3.5-jdk-8 AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean package

FROM fabric8/java-jboss-openjdk8-jdk:1.2.6

ENV JAVA_APP_JAR hello-swarm.jar
ENV AB_ENABLED off
ENV JAVA_OPTIONS -Xmx512m

EXPOSE 8080

COPY --from=build /usr/src/app/target/hello-swarm.jar /deployments/
#ADD target/hello-swarm.jar /deployments/
