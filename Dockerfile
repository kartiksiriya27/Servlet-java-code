# ==============================
# Stage 1: Build + SonarQube
# ==============================
FROM maven:3.9.0-eclipse-temurin-17 AS build

# Set environment variables
ENV SONAR_HOST_URL=http://sonarqube:9000
ENV SONAR_LOGIN=your_sonar_token
ENV GIT_REPO=https://github.com/username/your-java-project.git
ENV PROJECT_KEY=my-java-project

# Install Git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Clone the project
WORKDIR /app
RUN git clone $GIT_REPO .

# Build the project with Maven
RUN mvn clean package -DskipTests

# Run SonarQube analysis
RUN mvn sonar:sonar \
    -Dsonar.projectKey=$PROJECT_KEY \
    -Dsonar.host.url=$SONAR_HOST_URL \
    -Dsonar.login=$SONAR_LOGIN

# ==============================
# Stage 2: Tomcat Deployment
# ==============================
FROM tomcat:10.1-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from build stage to Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
