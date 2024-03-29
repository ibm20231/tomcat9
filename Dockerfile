FROM centos:7
WORKDIR /opt/
#Updated tomcat archive site and Version Changed 
ADD https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz .
#Installing openjdk 11
RUN yum install java-11-openjdk-devel wget -y && \
   tar -xzf apache-tomcat-9.0.87.tar.gz && \
   chmod -R 777 apache-tomcat-9.0.87 && \
   ln -sf "/usr/share/zoneinfo/Asia/Kolkata" /etc/localtime && \
   rm -rf apache-tomcat-9.0.87.tar.gz
WORKDIR /opt/apache-tomcat-9.0.87/webapps
#Download file from github repo
RUN wget https://github.com/ibm20231/tomcat9/raw/main/session.war
EXPOSE 8080
WORKDIR /opt/apache-tomcat-9.0.87/bin
RUN chmod 777 *
WORKDIR /opt/apache-tomcat-9.0.87/webapps/host-manager/META-INF
RUN rm -rf context.xml && \
wget https://raw.githubusercontent.com/ibm20231/tomcat9/main/context.xml
WORKDIR /opt/apache-tomcat-9.0.87/webapps/manager/META-INF
RUN rm -rf context.xml && \
wget https://raw.githubusercontent.com/ibm20231/tomcat9/main/context.xml
WORKDIR /opt/apache-tomcat-9.0.87/conf
RUN rm -rf tomcat-users.xml && \
wget https://raw.githubusercontent.com/ibm20231/tomcat9/main/tomcat-users.xml
CMD ["/opt/apache-tomcat-9.0.87/bin/catalina.sh", "run"]
