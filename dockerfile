FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests


FROM nginx:alpine


COPY --from=builder /app/target/*.jar /app/app.jar
RUN java -jar /app/app.jar


COPY --from=builder /app/output /usr/share/nginx/html

EXPOSE 80