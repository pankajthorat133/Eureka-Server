FROM maven:latest as maven

COPY ./pom.xml ./pom.xml

COPY ./src ./src

RUN mvn dependency:go-offline -B

RUN mvn package

FROM openjdk:latest

WORKDIR /client

COPY --from=maven target/eurekaServer-0.0.1-SNAPSHOT.jar ./eurekaServer-0.0.1-SNAPSHOT.jar

CMD ["java", "-jar", "./eurekaServer-0.0.1-SNAPSHOT.jar"]
