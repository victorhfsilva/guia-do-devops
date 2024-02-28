# Docker 

## Informações

### Visualizando as imagens no sistema

Para visualizar a lista de imagens no sistema basta executar:

```bash
docker images
```

### História da Imagem

Para visualizar todos os comandos que foram executados em uma imagem via containers, basta:

```
docker history <imagem>
```

### Inspecionando uma imagem ou container

Para visualizar detalhes de uma imagem ou container basta executar:

```
sudo docker inspect <imagem | container>
```

### Mostrando os Containers em Execução

Para listar todos os contêineres em execução, use o comando `docker ps`.

```bash
docker ps
```

### Mostra Histórico de Execução dos Containers

Para ver todos os contêineres, incluindo os que não estão em execução, use `docker ps -a`.

```bash
docker ps -a
```

### Mostrando Informações do Docker

Para exibir informações detalhadas sobre a instalação do Docker, use o comando `docker info`.

```bash
docker info
```

### Mostrando os Logs de um Container

Para visualizar os logs de um contêiner específico, use `docker container logs`.

```bash
docker container logs <container>
```

### Mostrando os Processos Dentro de um Container

Se precisar ver os processos em execução dentro de um contêiner, use `docker container top`.

```bash
docker container top <container>
```