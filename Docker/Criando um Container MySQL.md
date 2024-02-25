# Docker

## Criando e Gerenciando Contêineres MySQL

O MySQL é um dos sistemas de gerenciamento de banco de dados relacional mais populares, e é comumente utilizado em contêineres Docker para facilitar o desenvolvimento e a implantação de aplicativos. Abaixo, vamos explorar como criar e gerenciar contêineres MySQL no Docker.

## Instalação da Imagem MySQL

Antes de criar um contêiner MySQL, você precisa baixar a imagem oficial do MySQL do Docker Hub. Você pode fazer isso usando o comando `docker pull`.

```bash
docker pull mysql
```

## Criando e Executando um Contêiner MySQL

Depois de baixar a imagem, você pode criar e executar um contêiner MySQL com o seguinte comando. Certifique-se de substituir `<senha>` pela senha desejada e `<nome_do_container>` pelo nome que você deseja dar ao seu contêiner.

```bash
docker run -e MYSQL_ROOT_PASSWORD=<senha> --name <nome_do_container> -d -p <porta_do_servidor>:<porta_do_container> mysql
```

Por exemplo, para criar um contêiner chamado `mysql-1` com a senha `password` e expor a porta 3306 do contêiner para acesso externo, você pode usar:

```bash
docker run -e MYSQL_ROOT_PASSWORD=password --name mysql-1 -d -p 3306:3306 mysql
```

## Acessando o MySQL Dentro do Contêiner

Depois que o contêiner estiver em execução, você pode acessar o MySQL dentro dele executando o cliente MySQL. Use o seguinte comando e insira a senha quando solicitado:

```bash
mysql -u root -p --protocol=tcp
```

## Acessando o MySQL de Fora do Contêiner

Se você deseja acessar o MySQL de fora do contêiner, você precisará instalar o cliente MySQL em sua máquina host. Você pode fazer isso com o seguinte comando no Ubuntu:

```bash
sudo apt install mysql-client
```

Depois de instalar o cliente MySQL, você pode se conectar ao servidor MySQL no contêiner usando o endereço IP da máquina host e a porta mapeada, bem como o nome de usuário e senha fornecidos durante a criação do contêiner.

