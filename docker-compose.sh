#!/bin/bash
ENV=".env"
YML=".yml"
echo "##### Qual arquivo deseja executar 1 - (redis) 2 - (redis e mysql)  3 - (mysql, redis, blackfire e phpmyadmin)? "
read FILE

read -p "##### Deseja iniciar todos os containers automaticamente (Y/n)?" AUTO
AUTO=${AUTO:-'Y'}

if [ $FILE == '1' ]; then
    FILENAME='redis'
elif [ $FILE == '2' ]; then
   FILENAME='mysql-redis'
elif [ $FILE == '3' ]; then
   FILENAME='all'
fi
rm --f .env
if [ $AUTO == 'y' ] || [ $AUTO == 'Y' ]; then
  cp $FILENAME$ENV .env
  sed -i "s/ENV_RESTART/always/g" .env
else
  cp $FILENAME$ENV .env
  sed -i "s/ENV_RESTART/no/g" .env
fi

docker-compose -f $FILENAME$YML up -d --force

read -p "##### Deseja instalar o servidor de e-mail (y/N)?" MAILU
MAILU=${MAILU:-'N'}

if [ $MAILU == 'y' ] || [ $MAILU == 'Y' ]; then
  echo "##### Qual a chave ? "
  read SECRET
  echo "##### Qual o dominio ? "
  read DOMAIN
  echo "##### Qual o host ? "
  read HOST
  cp sample.mailu.env mailu.env
  sed -i "s/ENV_SECRET_KEY/$SECRET/g" mailu.env
  sed -i "s/ENV_DOMAIN/$DOMAIN/g" mailu.env
  sed -i "s/ENV_HOSTNAME/$HOST/g" mailu.env

  docker-compose -f mailu.yml up -d --force
fi