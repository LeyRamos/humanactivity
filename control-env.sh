#!/usr/bin/env bash

function stop {
  echo "Stopping and removing containers"
  docker-compose --project-name ha down
}

function cleanup {
  echo "Removing volume"
  docker volume rm ha_postgres-data
  docker volume rm ha_superset
}

function start {
  echo "Starting up"
  docker-compose --project-name ha up -d
}

function update {
  echo "Updating code ..."
  git pull --all

  echo "Updating docker images ..."
  docker-compose --project-name ha pull

  echo "You probably should restart"
}

function info {
  echo '
  Everything is ready, access your host to learn more (ie: http://localhost/)
  '
}

function token {
  echo 'Your TOKEN for Jupyter Notebook is:'
  SERVER=$(docker exec -it jupyter jupyter notebook list)
  echo "${SERVER}" | grep '/notebook' | sed -E 's/^.*=([a-z0-9]+).*$/\1/'
}

function superset-init {
  echo 'Initializing Superset database using sqlite'
  docker exec -it ha_superset superset-init
}

function superset-ip {
  echo 'Superset ip is '
  docker container inspect -f '{{ .NetworkSettings.Networks.ha_default.IPAddress }}' ha_postgres
}

function superset-import {
  echo 'trying to import dashboard (JSON) from repository'
  docker exec -it ha_superset superset import-dashboards -p /home/superset/ha_dashboard.json
}

function superset-stop {
  echo 'Stopping Superset container'
  docker container stop superset
}


case $1 in
  start )
  start
  info
    ;;

  stop )
  stop
    ;;

  cleanup )
  stop
  cleanup
    ;;

  update )
  update
    ;;

  logs )
  docker-compose --project-name ha logs -f
    ;;

  token )
  token
    ;;
  
  superset-stop )
  superset-stop
    ;;

  superset-init )
  superset-init
    ;;

  superset-ip)
  superset-ip
  ;;

  superset-import)
  superset-import
  ;;

  * )
  printf "ERROR: Missing command\n  Usage: `basename $0` (start|stop|cleanup|token|logs|update|superset-start|superset-stop|superset-init)\n"
  exit 1
    ;;
esac
