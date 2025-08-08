FROM openjdk:21-jdk

WORKDIR /app

COPY build/libs/SpringOauth2-0.0.1-SNAPSHOT.jar /app/SpringOauth2.jar

EXPOSE 8080

CMD ["java", "-jar", "SpringOauth2.jar"]