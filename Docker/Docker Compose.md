# Docker 

## Docker Compose

O Docker Compose é uma ferramenta que permite definir e executar aplicativos Docker multi-contêiner com facilidade, usando um arquivo YAML para configurar os serviços do aplicativo. Aqui está um guia completo para ajudá-lo a começar com o Docker Compose.

### 1. Executando Serviços

Para iniciar todos os serviços definidos no arquivo docker-compose.yml:

```bash
docker-compose up
```

Para iniciar os serviços em segundo plano (modo detached):

```bash
docker-compose up -d
```

### 2. Parando Serviços

Para parar todos os serviços em execução:

```bash
docker-compose down
```

### 3. Visualizando Logs

Para visualizar os logs dos serviços em execução:

```bash
docker-compose logs
```

### 4. Listando Serviços

Para listar os serviços definidos no arquivo docker-compose.yml:

```bash
docker-compose ps
```

### 5. Construindo Imagens

Para construir ou reconstruir as imagens dos serviços:

```bash
docker-compose build
```

### 6. Executando Comandos em Serviços

Para executar comandos em um serviço específico:

```bash
docker-compose exec <nome_do_servico> <comando>
```

## Arquivo docker-compose.yml

### 1. Definindo Serviços

```yaml
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: example
```

### 2. Construindo uma Rede Personalizada

```yaml
networks:
  mynetwork:
    driver: bridge
```

### 3. Definindo Volumes

```yaml
volumes:
  data:
    driver: local
```

## Exemplos de Uso

### 1. Serviço de Aplicativo Web com Banco de Dados

```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: example
```


### 2. Aplicativo Node.js com MongoDB

```yaml
version: '3.8'
services:
  web:
    build: node:latest
    ports:
      - "3000:3000"
  db:
    image: mongo:latest
    volumes:
      - ./data:/data/db
```

### 2. MySQL Adminer

```yaml
version: "3.8"

services:

	mysqlsrv:
		image: mysql:5.7
		environment: 
			MYSQL_ROOT_PASSWORD:"password123"
			MYSQL_DATABASE: "dio"
		ports:
			- "3306:3306"
		volumes:
			- /home/victor/data/mysql-2:/var/lib/mysql
		networks:
			- minha-rede
			
	adminer:
		image: adminer
		ports: 
			- "8080:8080"
		networks:
			- minha-rede
		depends_on:
			- "mysqlsrv"
			
networks:
	minha-rede:
		driver: bridge
```

### Depends On

Ao usar o Docker Compose, é importante entender o conceito de dependências entre serviços usando a diretiva `depends_on` no arquivo docker-compose.yml. No entanto, é crucial observar que a diretiva `depends_on` apenas garante a ordem em que os serviços são iniciados e não garante que um serviço esteja totalmente pronto antes que outro seja iniciado.

Por exemplo, se um serviço depende de um banco de dados para iniciar, você pode usar `depends_on` para garantir que o serviço do banco de dados seja iniciado primeiro. No entanto, isso não significa necessariamente que o banco de dados estará pronto para aceitar conexões imediatamente após a inicialização do serviço.



