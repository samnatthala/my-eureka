FROM openjdk:18.0.2.1-jdk
# Define build-time arguments
ARG JAR_SOURCE
ARG JAR_DEST
ARG APPLICATION_NAME

# Set environment variables based on the arguments
ENV JAR_SOURCE=${JAR_SOURCE}
ENV JAR_DEST=${JAR_DEST}
ENV APPLICATION_NAME=${APPLICATION_NAME}

# Create the target directory
RUN mkdir -p /opt/i27/

# Set the working directory
WORKDIR /opt/i27/

# Copy the JAR file from the build context into the container
COPY ${JAR_SOURCE} /opt/i27/${APPLICATION_NAME}.jar

# Set file permissions
RUN chmod 777 /opt/i27/

# Expose the application port (change if needed)
EXPOSE 8761

# Define the command to run the application
#CMD ["java", "-jar", "/opt/i27/${APPLICATION_NAME}.jar"]
CMD java -jar /opt/i27/${APPLICATION_NAME}.jar