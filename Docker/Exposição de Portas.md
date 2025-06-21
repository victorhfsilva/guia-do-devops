# Docker

## Expondo Portas durante a Execução

Durante a execução de um contêiner, você pode precisar expor portas específicas para acessar serviços ou aplicativos dentro dele. O Docker fornece opções para mapear portas do host para o contêiner.

### Mapeando Portas

Para mapear uma porta específica do host para uma porta específica do contêiner, use a opção `-p` seguida do número da porta do host e do número da porta do contêiner.

```bash
docker run -p <porta_do_host>:<porta_do_container> <imagem>
```

Por exemplo, para mapear a porta 8080 do host para a porta 80 do contêiner:

```bash
docker run -p 8080:80 <imagem>
```

### Expondo Todas as Portas

Você também pode expor todas as portas do contêiner para o host usando a opção `-P`.

```bash
docker run -P <imagem>
```

Este comando mapeará todas as portas expostas pelo contêiner para portas aleatórias no host.

### Verificando Portas Expostas

Para verificar as portas expostas por um contêiner em execução, você pode usar o comando `docker port`.

```bash
docker port <container>
```

Isso mostrará as portas mapeadas do contêiner para o host.

### Verificando Portas no Host

Para listar todas as portas do host mapeadas para os contêineres em execução, você pode usar o comando `docker ps` com a opção `-a`.

```bash
docker ps -a
```
