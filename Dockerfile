# Stage 1: Build
FROM gradle:8-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle app:installDist --no-daemon && rm -rf ~/.gradle/caches

# Stage 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/app/build/install/app/ .
EXPOSE 8080
CMD ["bin/app"]
