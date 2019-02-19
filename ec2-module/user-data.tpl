#!/bin/bash

# Installing Gatling on CentOS latest version by script
# Bundle Gatling 2.2.5 with Java 8u144
# VERSION 2.3.1

#Environmental variables
GATLING_VERSION=2.3.1
JAVA_HOME=/usr/java/default

echo "Update CentOS Software repository"
yum update -y 
yum clean all

echo "Install EPEL"
yum -y install epel-release
yum repolist

echo "Install OpenJDK"
yum -y install java-1.8.0-openjdk-devel

echo "Install unzip"
yum -y install unzip

echo "Install Gatling"
curl -L -v https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/${GATLING_VERSION}/gatling-charts-highcharts-bundle-${GATLING_VERSION}-bundle.zip  -o gatling-bundle-${GATLING_VERSION}-bundle.zip
chown -R user:user gatling-bundle-${GATLING_VERSION}-bundle.zip
unzip gatling-bundle-${GATLING_VERSION}-bundle.zip
rm gatling-bundle-${GATLING_VERSION}-bundle.zip
mv gatling-charts-highcharts-bundle-${GATLING_VERSION} /opt/
chown -R user:user /opt/gatling-bundle-${GATLING_VERSION}

echo "Check if the Gatling folder has been installed."