#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

registryPort=5000
registry="localhost:${port}"

check_php() {
  echo ""
  echo "Checking if PHP is installed"
  if command -v php &> /dev/null; then
      echo -e "${GREEN}PHP is installed: $(php -v | head -n 1)${NC}"
  else
      echo -e "${RED}PHP is not installed. Please install PHP to proceed.${NC}"
      exit 1
  fi
}

check_composer() {
  echo ""
  echo "Checking if Composer is installed"
  if command -v composer &> /dev/null; then
      echo -e "${GREEN}Composer is installed: $(composer --version)${NC}"
  else
      echo -e "${RED}Composer is not installed. Please install Composer to proceed.${NC}"
      exit 1
  fi
}

run_docker_registry() {
  echo ""
  echo "Create local Docker registry"

  if [ "$(docker ps -q -f name=registry)" ]; then
    echo -e "${GREEN}Registry is running.${NC}"
  else
    if [ "$(docker ps -aq -f name=registry)" ]; then
      echo -e "${GREEN}Starting registry container.${NC}"
      docker start registry
    else
      echo "Registry container does not exist. Creating and starting it."
      docker run -d -p "${port}:${port}" --restart=always --name registry registry:2
      run_docker_registry
    fi
  fi
}

clear_laravel_directory() {
  echo ""
  echo "Clearing the ./laravel directory"
  if [ -d "./laravel" ]; then
      rm -rf ./laravel/* ./laravel/.[!.]* ./laravel/..?*
      if [ $? -eq 0 ]; then
          echo -e "${GREEN}The ./laravel directory has been cleared successfully, including hidden files.${NC}"
      else
          echo -e "${RED}Failed to clear the ./laravel directory.${NC}"
          exit 1
      fi
  else
      echo -e "${RED}The ./laravel directory does not exist.${NC}"
      exit 1
  fi
}

install_laravel() {
  echo ""
  echo "Installing Laravel"
  ERROR=$(composer create-project laravel/laravel laravel 2>&1)
  if [ $? -eq 0 ]; then
      echo -e "${GREEN}Laravel has been successfully installed in the 'laravel' directory.${NC}"
  else
      echo -e "${RED}Failed to install Laravel. Error:${NC}\n$ERROR"
      exit 1
  fi
}

build_docker_image() {
  echo ""
  echo "Building Docker image"
    if docker compose -f ./docker-compose.yml up -d --build &> /dev/null; then
        echo -e "${GREEN}Docker containers built and started successfully.${NC}"
    else
        echo -e "${RED}Failed to build and start Docker containers.${NC}"
        exit 1
    fi
}

tag_docker_image() {
  echo ""
    echo "Tag Docker image: laravel-php localhost:5000/laravel-php"
      if docker image tag laravel-php localhost:5000/laravel-php &> /dev/null; then
          echo -e "${GREEN}Docker image tagged successfully.${NC}"
      else
          echo -e "${RED}Failed to tag Docker image.${NC}"
          exit 1
      fi
}

push_docker_image() {
  echo ""
    echo "Pushing Docker image"
      if docker push localhost:5000/laravel-php &> /dev/null; then
          echo -e "${GREEN}Docker image pushed successfully.${NC}"
      else
          echo -e "${RED}Failed to push the Docker image.${NC}"
          exit 1
      fi
}

check_php
check_composer
run_docker_registry
clear_laravel_directory
install_laravel
build_docker_image
tag_docker_image
push_docker_image