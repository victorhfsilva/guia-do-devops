# Docker

## Dockerfile

O Dockerfile é uma ferramenta essencial para construir imagens Docker de forma automatizada e reprodutível. Ele contém um conjunto de instruções que definem como a imagem Docker será construída e configurada.

### Construindo uma Imagem

Para construir uma imagem a partir de um Dockerfile, use o comando `docker build`, especificando o caminho para o diretório que contém o Dockerfile e o nome desejado para a imagem.

```bash
docker build -t <nome_da_imagem> <caminho_do_Dockerfile>
```

Exemplo:

```bash
docker build -t victorhfsilva/nginx .
```

O nome da imagem deve ser `Dockerfile` caso deseje-se que ela seja executada sem explicitar o arquivo. Para explicitá-lo basta utilizar `-f`.

```bash
docker build -t victorhfsilva/nginx -f ./nginx.dockerfile
```

### Estrutura Básica:

### Comandos no Dockerfile: Explorando os Fundamentos

#### FROM
A instrução `FROM` é fundamental no Dockerfile, pois define a imagem base a ser utilizada para construir a nova imagem. Ela indica o ponto de partida e influencia diretamente no tamanho e no conteúdo da imagem a ser criada. Exemplos comuns incluem:

```Dockerfile
FROM ubuntu
FROM node:14-alpine
FROM python:3.9
```

#### RUN
A instrução `RUN` é usada para executar comandos durante a construção da imagem. Esses comandos são executados em uma nova camada sobre a imagem atual e podem instalar pacotes, baixar arquivos e realizar outras tarefas. Exemplos:

```Dockerfile
RUN apt-get update && apt-get install -y python3
RUN npm install
RUN pip install requests
```

#### CMD e ENTRYPOINT
`CMD` e `ENTRYPOINT` são usados para definir o comando padrão a ser executado quando o contêiner é iniciado. A principal diferença entre eles é que o `CMD` pode ser substituído por argumentos `docker run <imagem> <cmd>`, enquanto o `ENTRYPOINT` não pode. Aqui está uma explicação mais detalhada:

- `CMD`: Define o comando padrão e seus parâmetros que serão executados quando o contêiner for iniciado. Se o `docker run` especificar um comando diferente, ele substituirá o comando padrão do `CMD`. Exemplo:

  ```Dockerfile
  CMD ["node", "app.js"]
  ```

- `ENTRYPOINT`: Define o executável que será executado quando o contêiner for iniciado. Os argumentos passados no `docker run` serão adicionados aos argumentos do `ENTRYPOINT` em vez de substitui-los. Isso permite que o contêiner seja executado como se fosse um executável único. Exemplo:

  ```Dockerfile
  ENTRYPOINT ["java", "-jar", "app.jar"]
  ```

#### ADD e COPY
`ADD` e `COPY` são usados para copiar arquivos e diretórios do sistema de arquivos do host para dentro da imagem Docker. A principal diferença entre eles é que o `ADD` permite URLs e pode extrair arquivos .tar automaticamente, enquanto o `COPY` apenas copia arquivos locais. Exemplos:

```Dockerfile
ADD http://example.com/big.tar.gz /usr/src/things/
COPY . /app/
```

#### EXPOSE
A instrução `EXPOSE` documenta as portas em que o contêiner aceita conexões. No entanto, não publica as portas, apenas serve como uma documentação para quem for usar o contêiner. Exemplo:

```Dockerfile
EXPOSE 8080
```

#### ENV
`ENV` é usado para definir variáveis ​​de ambiente que estarão disponíveis durante a construção da imagem e quando o contêiner estiver em execução. Exemplo:

```Dockerfile
ENV MY_VAR=123
```

#### LABEL
`LABEL` permite adicionar metadados a uma imagem, fornecendo informações adicionais, como descrição, versão e mantenedor. Isso é útil para documentar e organizar imagens. Exemplo:

```Dockerfile
LABEL description="This is a custom Docker image" version="1.0" maintainer="user@example.com"
```

#### VOLUME
`VOLUME` é usado para criar um ponto de montagem em um contêiner, permitindo compartilhar dados entre o host e o contêiner. Os dados neste ponto de montagem persistem mesmo após a remoção do contêiner. Exemplo:

```Dockerfile
VOLUME /var/log/nginx
```

#### WORKDIR
`WORKDIR` define o diretório de trabalho para as instruções subsequentes. Ele também cria o diretório, se ainda não existir. Todas as instruções que seguem usarão esse diretório como base. Exemplo:

```Dockerfile
WORKDIR /app
```


## Exemplos de Dockerfiles

Aqui estão alguns exemplos de Dockerfiles para diferentes tipos de aplicações:

### Nginx com página estática

```Dockerfile
FROM nginx
LABEL description="Hello Nginx" maintainer="Victor Silva"
COPY ./static-site/index.html /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
EXPOSE 80
```

Ou, caso o arquivo index.html esteja presente na pasta compartilhada:

```Dockerfile
FROM nginx
LABEL description="Hello Nginx" maintainer="Victor Silva"
WORKDIR /usr/share/nginx/html
VOLUME /usr/share/nginx/html
EXPOSE 80
```

Para construir a imagem:

```bash
docker build -t victorhfsilva/hello-nginx .
```

Para executá-la no primeiro exemplo: 

```bash
docker run -d --name hello-world -p 8080:80 victorhfsilva/hello-nginx
```

No segundo:

```bash
docker run -d --name hello-world -p 8080:80 -v ./static-site:/usr/share/nginx/html victorhfsilva/hello-nginx
```


### Ubuntu com um Aplicativo Python

```Dockerfile
# Define a imagem base
FROM ubuntu

# Atualiza os pacotes e instala o Python 3
RUN apt update && apt install -y python3 && apt clean

# Copia o arquivo app.py para o diretório /opt/app.py dentro da imagem
COPY app.py /opt/app.py

# Define o comando padrão para executar o aplicativo Python
CMD python3 /opt/app.py
```

Neste caso, o arquivo `app.py` está localizado no mesmo diretório do Dockerfile.

### Debian com Apache

```Dockerfile
# Define a imagem base
FROM debian

# Atualiza os pacotes e instala o Apache
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Define as variáveis de ambiente do Apache
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"

# Adiciona o conteúdo do arquivo site.tar ao diretório /var/www/html dentro da imagem
ADD site.tar /var/www/html

# Adiciona uma etiqueta (label) descritiva para a imagem
LABEL description="Apache webserver 1.0"

# Define o volume para o diretório /var/www/html
VOLUME /var/www/html

# Expõe a porta 80 para acessar o servidor Apache
EXPOSE 80

# Define o ponto de entrada para o contêiner, inicia o Apache em primeiro plano
ENTRYPOINT ["/usr/sbin/apachectl"]

# Define o comando padrão para o contêiner, executa o Apache em primeiro plano
CMD ["-D", "FOREGROUND"]
```

### Imagem de uma Linguagem de Programação (Python)

```Dockerfile
# Define a imagem base
FROM python

# Define o diretório de trabalho dentro da imagem
WORKDIR /opt/app

# Copia o arquivo app.py para o diretório de trabalho dentro da imagem
COPY app.py /opt/app/app.py

# Define o comando padrão para executar o aplicativo Python
CMD ["python", "./app.py"]
```

### Dockerfile Multi Estágio

O Docker suporta a construção de imagens em múltiplos estágios, útil para otimizar o tamanho final da imagem. Aqui está um exemplo de Dockerfile multi-estágio para construir um aplicativo Go sobre Alpine Linux:

```Dockerfile
# Estágio 1: Constrói o aplicativo Go
FROM golang as builder

# Copia o código fonte do aplicativo para o diretório de trabalho dentro da imagem
COPY app.go /go/src/app/

# Configuração do ambiente Go
ENV GO111MODULE=auto

# Define o diretório de trabalho para o código fonte do aplicativo
WORKDIR /go/src/app/

# Compila o código fonte do aplicativo para produzir um executável
RUN go build -o app.go .

# Estágio 2: Cria uma imagem leve para executar o aplicativo compilado
FROM alpine

# Define o diretório de trabalho para o aplicativo
WORKDIR /appexec

# Copia o aplicativo compilado do primeiro estágio para o diretório de trabalho
COPY --from=builder /go/src/app /appexec

# Define permissões de execução para o aplicativo
RUN chmod -R 755 /appexec

# Define o comando padrão para executar o aplicativo
ENTRYPOINT ./app.go
```

Este Dockerfile usa dois estágios: o primeiro estágio compila o aplicativo Go e o segundo estágio cria uma imagem leve para executar o aplicativo compilado. Isso ajuda a reduzir o tamanho final da imagem Docker.