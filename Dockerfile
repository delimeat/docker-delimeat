FROM openjdk:alpine
VOLUME /data /output
WORKDIR /data

ADD delimeat.jar /delimeat.jar

EXPOSE 8080/tcp

ENTRYPOINT ["java","-Dio.delimeat.home=/data","-Dio.delimeat.config.defaultOutputDir=/output","-Djava.security.egd=file:/dev/.urandom","-jar","/delimeat.jar"]
