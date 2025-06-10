FROM tomcat:10-jdk17-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/
RUN rm -rf ROOT
COPY target/skyTicket-1.0-SNAPSHOT.war ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]