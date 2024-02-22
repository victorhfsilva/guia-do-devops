# **Tratamento de Outputs**

Ao trabalhar no terminal do Linux, é comum encontrar saídas longas de comandos. 

### 1. **head**

O comando `head` é usado para exibir as primeiras linhas de um arquivo ou saída de comando.

```bash
head arquivo.txt    # Exibe as 10 primeiras linhas de arquivo.txt
head -n 20 arquivo.txt  # Exibe as 20 primeiras linhas de arquivo.txt
<comando> | head # Exibe as 10 primeiras linhas do comando
```

### 2. **tail**

O comando `tail` é usado para exibir as últimas linhas de um arquivo ou saída de comando.

```bash
tail arquivo.txt    # Exibe as 10 últimas linhas de arquivo.txt
tail -n 20 arquivo.txt  # Exibe as 20 últimas linhas de arquivo.txt
<comando> | tail # Exibe as 10 últimas linhas do comando
```

### 3. **more**

O comando `more` é usado para exibir uma saída de texto de uma maneira paginada, permitindo rolar para cima e para baixo.

```bash
ls -l | more    # Exibe o output paginado do comando ls -l
```

### 4. **less**

Similar ao `more`, o comando `less` também é usado para exibir uma saída de texto paginada, mas oferece mais funcionalidades de navegação.

```bash
ls -l | less    # Exibe o output paginado do comando ls -l com funcionalidades de navegação
```

### 5. **grep**

O comando `grep` é usado para pesquisar por padrões em um output de comando ou arquivo.

```bash
ls -l | grep "arquivo"   # Pesquisa por linhas contendo "arquivo" no output do comando ls -l
```

### 6. **wc**

O comando `wc` é usado para contar linhas, palavras e caracteres em um arquivo ou output de comando.

```bash
wc arquivo.txt    # Conta respectivamente linhas, palavras e caracteres em arquivo.txt
<comando> | wc # Conta respectivamente linhas, palavras e caracteres no comando
```

### 7. **cat**

O comando `cat` é usado para exibir o conteúdo completo de um arquivo.

```bash
cat arquivo.txt    # Exibe todo o conteúdo de arquivo.txt
```

### 8. **uniq**

O comando `uniq` é usado para filtrar ou relatar linhas duplicadas em um arquivo ou output de comando.

```bash
sort arquivo.txt | uniq   # Exibe linhas únicas do arquivo.txt após ordenação
```

### 9. **sort**

O comando `sort` é usado para classificar as linhas de um arquivo de texto.

```bash
sort arquivo.txt    # Classifica as linhas de arquivo.txt em ordem alfabética
```