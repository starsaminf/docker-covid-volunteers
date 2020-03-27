#!/bin/bash

apt update && apt upgrade -y
git clone https://github.com/helpwithcovid/covid-volunteers

mv covid-volunteers rails
cp Dockerfile rails/Dockerfile
cp -f database.yml rails/config/database.yml

docker-compose up --build
