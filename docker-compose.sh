#!/bin/bash
ENV=".env"
YML=".yml"

echo "##### Qual arquivo deseja executar?"
echo "1) redis"
echo "2) redis + mysql5.7"
echo "3) mysql5.7 + redis + blackfire + phpmyadmin"
echo "4) mysql8.0 + redis + blackfire + phpmyadmin + minio"
echo "5) mysql8.0 + redis + minio"
echo "6) netdata"
echo "7) redis + mysql5.7 + code quality"
echo "8) redis + mysql8.0"
echo "9) redis + mysql8.0 + code quality"
echo

while true; do
  read -r -p "Selecione uma opção: " FILE
  case "$FILE" in
    1)
      FILENAME='redis'
      break
      ;;
    2)
      FILENAME='mysql-redis'
      break
      ;;
    3)
      FILENAME='all'
      break
      ;;
    4)
      FILENAME='all-80'
      break
      ;;
    5)
      FILENAME='mysql8-redis-minio'
      break
      ;;
    6)
      FILENAME='netdata'
      break
      ;;
    7)
      FILENAME='mysql-redis-code-quality'
      break
      ;;
    8)
      FILENAME='mysql8-redis'
      break
      ;;
    9)
      FILENAME='mysql8-redis-code-quality'
      break
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      ;;
  esac
done

read -p "##### Deseja iniciar todos os containers automaticamente (Y/n)?" AUTO
AUTO=${AUTO:-'Y'}

rm --f .env
if [ $AUTO == 'y' ] || [ $AUTO == 'Y' ]; then
  cp $FILENAME$ENV .env
  sed -i "s/ENV_RESTART/always/g" .env
else
  cp $FILENAME$ENV .env
  sed -i "s/ENV_RESTART/no/g" .env
fi

docker-compose -f $FILENAME$YML up -d --force --remove-orphans

read -p "##### Deseja instalar o servidor de e-mail (y/N)?" MAILU
MAILU=${MAILU:-'N'}

if [ $MAILU == 'y' ] || [ $MAILU == 'Y' ]; then
  rm --f mailu.env
  echo "##### Qual a chave ? (você pode gerar uma com $ pwgen 16) guarde sua chave"
  read SECRET
  echo "##### Qual o dominio ? "
  read DOMAIN
  echo "##### Qual o host ? "
  read HOST
  echo "##### Qual a porta ? "
  read PORT
  cp sample.mailu.env mailu.env
  sed -i "s/ENV_SECRET_KEY/$SECRET/g" mailu.env
  sed -i "s/ENV_DOMAIN/$DOMAIN/g" mailu.env
  sed -i "s/ENV_HOSTNAME/$HOST/g" mailu.env
  sed -i "s/ENV_PORT/$PORT/g" mailu.env

  docker-compose -f mailu.yml up -d --force
fi