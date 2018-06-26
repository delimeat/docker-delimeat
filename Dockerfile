FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/delimeat/delimeat.git

FROM maven:3.5.3-jdk-8 as build
WORKDIR /app
COPY --from=clone /app/delimeat /app
RUN mvn install

FROM openjdk:8-jre-alpine
VOLUME /data /output
WORKDIR /data

COPY --from=build /app/target/delimeat.jar /delimeat.jar 

EXPOSE 8080/tcp

ENTRYPOINT ["java","-Dio.delimeat.home=/data","-Dio.delimeat.config.defaultOutputDir=/output","-Djava.security.egd=file:/dev/.urandom","-jar","/delimeat.jar"]
