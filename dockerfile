
FROM eclipse-temurin:17-jdk-jammy as builder
WORKDIR application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract


#FROM eclipse-temurin:17-jre-jammy
FROM apache/tika:2.6.0.1
USER root
RUN apt-get update && apt-get install -y \
    tesseract-ocr-ara \
    tesseract-ocr-fra \
    && rm -rf /var/lib/apt/lists/* \
USER 35002:35002
WORKDIR /app
RUN mkdir -p files/inputs && mkdir -p files/outputs
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]