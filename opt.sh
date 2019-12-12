#!/bin/bash

if [ ! -f "docker-compose.yml" ];then
  echo "docker-compose.yml not exist"
  exit 0
fi

declare -a services
services=(
  `docker-compose ps | awk 'NR <= 2 {next} {print $1}'`
  # $(docker ps | awk 'NR == 1 {next} {print $NF}')
)


if [ x"$1" == x"stop" ];then
  if [ ${#services} == 0 ];then
    echo "stopped"
    exit 0
  fi
  echo "stop..."
  docker-compose down
  exit 0
elif [ x"$1" == x"restart" ];then
  if [ ${#services} == 0 ];then
    echo "please start first"
    exit 0
  fi
  echo "restart..."
  docker-compose restart
  exit 0
fi

if [ ${#services[@]} -le 1 ];then
  if [ ${#services[@]} == 1 ];then
    docker-compose down
  fi
  echo "start..."
  docker-compose up -d
  services=`docker-compose ps | awk 'NR <= 2 {next} {print $1}'`
  # services=($(docker ps | awk 'NR == 1 {next} {print $NF}'))
fi

server="kafka"
if [ -n "$1" ];then
  server=$1
fi

echo "start servers: ${services[*]}"
echo "bash server: $server"
if [[ ${services[*]/$server} == ${services[*]} ]];then
  echo "server not exist or start"
  exit 0
fi

docker exec -it $server bash
