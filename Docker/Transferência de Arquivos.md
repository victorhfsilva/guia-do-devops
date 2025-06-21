# Docker

## Transferência de arquivos entre o Container e o Hospedeiro

### Copiando Arquivos para o Container

Use `docker cp` para copiar arquivos do seu sistema de arquivos local para o contêiner.

```bash
docker cp <arquivo> <container>:<caminho>
```

Exemplo:

```bash
docker cp arquivo.txt ubuntu-1:/home
```

#### Copiando Arquivos do Container

Para copiar arquivos do contêiner para o sistema de arquivos local, inverta os argumentos.

```bash
docker cp <container>:<arquivo> <caminho>
```