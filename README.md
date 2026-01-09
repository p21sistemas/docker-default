## instalação
Clone este repositório em seu computador local. 

`shell
git clone https://github.com/p21sistemas/docker-default.git container
`

Entre no repositório e execute o arquivo `./docker-compose.sh` e siga os passos.
`shell
cd container 
./docker-compose.sh
`

## phpMyAdmin

phpMyAdmin está configurado para ser executado na porta 8080. Use as seguintes credenciais padrão.

http://localhost:8080/  
username: root  
password: root

## Redis

Ele vem com o Redis. Ele roda na porta padrão `6379`.

## AWS CLI
Para opções com o AWS CLI, basta executar `docker exec -i default-aws aws COMANDO` para interagir com o CLI. 

## Contribuindo

bem-vindo para discutir bugs, recursos e idéias.

## License

p21sistemas/docker-default é lançado sob a licença do MIT.