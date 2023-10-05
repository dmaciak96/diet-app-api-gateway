FROM maven:3.6.3-openjdk-17-slim AS builder
WORKDIR /gateway
COPY src ./src
COPY pom.xml ./
RUN mvn -f ./pom.xml clean package

#Package stage
FROM openjdk:22-jdk-slim AS runner
WORKDIR /gateway
COPY --from=builder /gateway/target/api-gateway-*.jar ./webdiet-api-gateway.jar
COPY --from=builder /gateway/src/main/resources/application.yml ./application.yml
CMD ["java", "-jar", "./webdiet-api-gateway.jar"]
