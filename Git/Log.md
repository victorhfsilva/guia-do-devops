# Log 

Para listar todos os commits de um ramo (branch):
```
git log
```

* Para incluir as alterações de cada commit no log:
```
git log -p
```

```
git log --patch
```
Para incluir a quantidade de linhas e arquivos modificados:

```
git log --stat
```

Para mostrar as informações do commit em apenas uma linha:

```
git log --pretty=oneline
```

Para incluir um gráfico mostrando o histórico de merges:
```
git log --pretty=oneline --graph
```

A seguir seguem mais algumas opções:

![Alt text](<images/Screenshot from 2023-10-03 20-36-57.png>)

## Filtrando logs

A seguir podem ser visualizados alguns exemplos de como limitar os logs a um intervalo específico de tempo:

```
git log --since=2.weeks
```

```
git log --since=2008-01-15 --until=2008-02-15
```

```
git log --until="2 years 1 day 3 minutes ago"
```

Para filtrar baseado no autor.

```
git log --author=victorhfsilva
```

Para filtrar baseado em um trecho da mensagem de commit.

```
git log --grep="<trecho da mensagem>"
```

Para filtrar baseado em um trecho alterado do código: 
```
git log -S "<trecho do código>"
```

Para filtrar baseado em um diretório ou arquivo alterado:
```
git log -- <caminho do diretório ou arquivo>
```

![Alt text](<images/Screenshot from 2023-10-03 20-55-27.png>)

## Reflog

Lista a referência de cada commit (usado nos resets)
```
git reflog
```