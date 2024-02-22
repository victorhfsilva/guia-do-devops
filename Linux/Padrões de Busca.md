# **Padrões de Busca**

## **Comandos Básicos:**

1. **Listar Arquivos que Começam com "a":**
    ```bash
    ls a*
    ```

2. **Listar Arquivos que Terminam com ".txt":**
    ```bash
    ls *.txt
    ```

3. **Listar Arquivos que Contêm "file" no Nome:**
    ```bash
    ls *file*
    ```

4. **Listar Arquivos com Nomes de 3 Letras:**
    ```bash
    ls ???
    ```

5. **Listar Arquivos que Começam com "m", Seguido de Qualquer Caractere, Seguido de "g":**
    ```bash
    ls m?g*
    ```

## **Intervalos:**

1. **Listar Intervalo de Arquivos que Contêm "file", seguido de qualquer número entre 0 a 9:**
    ```bash
    ls file[0-9]
    ```

2. **Listar Arquivos que Contêm "file", seguido do número 1 ou 3:**
    ```bash
    ls file{1,3}
    ```

3. 2. **Listar Arquivos que Contêm "file", seguido do número 1 ou 2:**

    ```bash
    ls file[12]
    ```

## **Caracteres Especiais:**

1. **Listar Arquivos que Contêm "file" Seguido de Qualquer Caractere Único:**
    ```bash
    ls file?
    ```
2. **Listar Arquivos que Contêm "file", Seguido de Qualquer Dígito Único:**
    ```bash
    ls file[0-9]
    ```
3. **Listar Arquivos que Contêm "file", Seguido de Qualquer caractere minusculo:**
    ```bash
    ls file[a-z]
    ```

4. **Listar Arquivos que Contêm "file", Seguido de Qualquer caractere maiúsculo:**
    ```bash
    ls file[A-Z]
    ```

## **Comandos com Grep:**

1. **Procurar por Linhas que Contêm "pattern" em um Arquivo:**
    ```bash
    grep "pattern" arquivo.txt
    ```

2. **Procurar por Linhas que Começam com "start" em um Arquivo:**
    ```bash
    grep "^start" arquivo.txt
    ```

3. **Procurar por Linhas que Terminam com "end" em um Arquivo:**
    ```bash
    grep "end$" arquivo.txt
    ```

4. **Procurar por Linhas que Contêm "word1" ou "word2" em um Arquivo:**
    ```bash
    grep "word1\|word2" arquivo.txt
    ```

5. **Procurar por Linhas que Contêm "word" Seguido de Qualquer Caractere Único:**
    ```bash
    grep "word." arquivo.txt
    ```

6. **Além destes filtros o grep também aceita os filtros utilizados nos demais comandos:**

    ```bash
    grep "cat[1-9]" arquivo.txt
    ```