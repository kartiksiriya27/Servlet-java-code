# ==============================
# Stage 1: Build the Java project
# ==============================

# Use Maven image with JDK 17 for building the project
FROM maven:3.9.2-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Clone the GitHub repository containing the Java project
RUN git clone https://github.com/kartiksiriya27/Servlet-java-code.git

# Build the project using Maven, skip tests for faster build
RUN mvn clean package -DskipTests


# ==============================
# Stage 2: Deploy to Tomcat
# ==============================

# Use official Tomcat image with JDK 17 for running the application
FROM tomcat:10.1-jdk17

# Remove default Tomcat webapps to deploy only our application
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file built in Stage 1 into Tomcat's webapps directory as ROOT.war
# ROOT.war will be deployed as the default application on Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default HTTP port
EXPOSE 8080

# Command to start Tomcat in the foreground
CMD ["catalina.sh", "run"]
