# Docker

## Gerenciamento de Volumes

Os volumes no Docker são uma maneira de persistir e compartilhar dados entre contêineres e o host. Eles permitem que os dados sejam armazenados fora do sistema de arquivos do contêiner, o que é útil para manter a persistência dos dados mesmo após a remoção de um contêiner. Abaixo, vamos explorar como configurar, montar e gerenciar volumes no Docker.

### Bind Volume

Com um bind volume, um diretório no host é montado no contêiner. Isso permite que você acesse e persista dados fora do contêiner.

```bash
docker run -e MYSQL_ROOT_PASSWORD=<senha> --name <nome_do_container> -d -p <porta_do_servidor>:<porta_do_container> --volume=<pasta_no_servidor>:<pasta_no_container> mysql
```

Exemplo:

```bash
docker run -e MYSQL_ROOT_PASSWORD=password --name mysql-1 -d -p 3306:3306 --volume=/home/victor/data/mysql-1:/var/lib/mysql mysql
```

### Named Volume

Os volumes nomeados são volumes criados explicitamente pelo usuário e podem ser referenciados pelo nome.

```bash
docker volume create <nome_do_volume>
```

Você pode montar um volume nomeado diretamente em um contêiner usando o nome do volume.

```bash
docker run -v <nome_do_volume>:<diretório_do_container> mysql
```

### Montando Volumes

Além de configurar volumes durante a criação do contêiner, você também pode montar volumes durante a execução do contêiner usando a opção `--mount`.

```bash
docker run -dti --mount type=<tipo_de_volume>,src=<pasta_do_volume>,dst=<destino_do_volume_no_container> <imagem>
```

Exemplo:

```bash
docker run -dti --mount type=bind,src=/home/victor/data/mysql-1,dst=/data mysql
```

### Montando Volumes Somente de Leitura

Se você deseja montar um volume somente para leitura, adicione a opção `ro` ao comando de montagem.

```bash
docker run -dti --mount type=<tipo_de_volume>,src=<pasta_do_volume>,dst=<destino_do_volume_no_container>,ro <imagem>
```

Exemplo:

```bash
docker run -dti --mount type=bind,src=/home/victor/data/mysql-1,dst=/data,ro mysql
```

### Listando e Removendo Volumes

Você pode listar todos os volumes disponíveis no sistema usando o comando `docker volume ls`.

```bash
docker volume ls
```

Para remover um volume específico, use o comando `docker volume rm`.

```bash
docker volume rm <nome_do_volume>
```

Se você deseja excluir todos os volumes não utilizados, você pode usar o comando `docker volume prune`.

```bash
docker volume prune
```