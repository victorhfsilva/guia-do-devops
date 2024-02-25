# Docker

## Execução do Container

O Docker é uma ferramenta poderosa para criar, distribuir e executar aplicativos em contêineres. Aqui estão alguns comandos básicos para começar:

### Instalando uma Imagem

Para baixar uma imagem do Docker Hub, use o comando `docker pull` seguido do nome da imagem.

```bash
docker pull <imagem>
```

### Executando uma Imagem

Para iniciar um contêiner a partir de uma imagem, use o comando `docker run` seguido do nome da imagem.

```bash
docker run <imagem>
```

### Executando por Determinado Tempo

Às vezes, você pode querer que o contêiner execute uma tarefa específica por um período definido. Você pode fazer isso passando um comando de `sleep` para o contêiner.

```bash
docker run <imagem> sleep <tempo_em_segundos>
```

### Interagindo com o container

Para interagir com o contêiner em tempo real use a opção `-i` (interactive). Já para definir o formato de saída desta interação como sendo um terminal utilize `-t` (tty).

```bash
docker run --interactive --tty <imagem>
```

ou simplesmente:

```bash
docker run -it <imagem>
```

### Executando o Container em Background

Se você quiser iniciar o contêiner em segundo plano, use a opção `-d` (detach).

```bash
docker run -dti <imagem>
```

O `-d` significa `--detach`.

### Nomeando a Execução

Para facilitar a identificação, você pode nomear o contêiner durante a execução.

```bash
docker run --name <nome> <imagem>
```

### Definindo o programa a ser executado no container

Para definir o programa que será executado quando este container for iniciado basta:

```bash
docker run -di <imagem> <programa>
```

Exemplo:

```bash
docker run -di --name ubuntu-1 ubuntu bash
```

Como a saída deste container foi desanexada (-d). Basta executar o comando a seguir para iniciar o bash.

```bash
docker start -a -i ubuntu-1
``` 

### Executando um Programa Dentro do Contêiner

Às vezes, você pode precisar executar um outro programa específico dentro do contêiner. Use o comando `docker exec` para isso.

```bash
docker exec -it <id_do_container> <caminho_do_programa ou comando>
```

Exemplo:

```bash
docker exec -it fdbbadb85b1e /bin/bash
```

Exemplo:

```bash
docker exec -it ubuntu-1 echo Hello World
```

### Pausando um Container

Para pausar os processos rodando em um container basta:

```bash
docker pause <container>
```

Para resumir os processos basta:

```bash
docker unpause <container>
```

### Parando a Execução de um Container

Para interromper um contêiner em execução, use o comando `docker stop`.

```bash
docker stop <container>
```

### Iniciando um Container

Para iniciar um container parado, use o comando `docker start`.

```bash
docker start <container>
```

Já para iniciar um container parado, e capturar sua saída, basta:

```bash
docker start -a -i <container>
```

Um exemplo de quando este comando pode ser utilizado é quando você deseja iniciar um container e acessar o bash ou outro programa definido no seu respectivo `docker run`.

### Encerrando a Execução de um Container

Para encerrar todos os processos rodando em um container basta:

```bash
docker kill <container>
```

### Container Lifecycle

![Container Lifecycle](/Images/container_lifecycle.jpg)

### Deletando um Container

Para remover um contêiner específico, use o comando `docker rm`.

```bash
docker rm <id_ou_nome_do_container>
```

Se você quiser excluir todos os contêineres parados, use `docker container prune`.

```bash
docker container prune
```

### Deletando Imagem

Antes de excluir uma imagem, certifique-se de que todos os contêineres associados a ela estejam parados e removidos.

```bash
docker rmi <imagem>
```
