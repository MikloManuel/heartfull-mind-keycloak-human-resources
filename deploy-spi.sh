#!/bin/bash
set -e

echo "Building SPI module..."
cd custom-db-module-relations
mvn clean install

echo "Copying JAR to providers directory..."
mkdir -p ../quarkus/dist/target/keycloak-999.0.0-SNAPSHOT/providers
cp target/keycloak-custom-db-*.jar ../quarkus/dist/target/keycloak-999.0.0-SNAPSHOT/providers/

echo "Building Keycloak..."
cd ../quarkus/dist/target/keycloak-999.0.0-SNAPSHOT/bin
./kc.sh build

echo "Starting Keycloak..."
./kc.sh start-dev
