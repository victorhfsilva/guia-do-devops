# Docker 

## Administrando Recursos do Container

### Consultando os Recursos

Você pode monitorar o uso de recursos do contêiner com `docker stats`.

```bash
docker stats <nome_do_container>
```

### Limitando os Recursos

Para limitar o uso de recursos como memória e CPU, use `docker update`.

```bash
docker update <container> -m <memória> --cpus <porcentagem_de_processamento>
```

Exemplo:

```bash
docker update apache-1 --memory=128m --memory-swap=256m --cpus 0.2
```