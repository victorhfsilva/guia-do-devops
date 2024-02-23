# **Variáveis no Shell Script:**

Variáveis em shell script são usadas para armazenar valores ou informações temporárias. Aqui está um resumo sobre variáveis:

### 1. **Declarando Variáveis:**
   
   Para declarar uma variável, basta atribuir um valor a ela. Não é necessário especificar o tipo de dados.
   
   Exemplo:
   ```bash
   nome="Shell Script"
   idade=30
   ```

### 2. **Acessando Variáveis:**

   Para acessar o valor de uma variável, use o prefixo `$` antes do nome da variável.
   
   Exemplo:
   ```bash
   echo "Bem-vindo ao $nome. Você tem $idade anos."
   ```

### 3. **Variáveis Especiais:**

   Existem algumas variáveis especiais que já têm significados definidos no shell script, como:
   - `$0`: Nome do script.
   - `$1`, `$2`, ...: Argumentos passados para o script.
   - `$#`: Número de argumentos passados.
   - `$@`: Lista de todos os argumentos passados.
   - `$?`: Código de retorno do último comando.
   - `$$`: PID (Identificador de Processo) do script atual.

### 4. **Escopo das Variáveis:**

   As variáveis em shell script são globais por padrão, ou seja, podem ser acessadas de qualquer lugar do script. No entanto, é possível definir variáveis locais dentro de funções.

### 5. **Nomes de Variáveis:**

   - Os nomes de variáveis devem começar com uma letra ou sublinhado (`_`).
   - Podem conter letras, números e sublinhados.
   - Não podem conter espaços ou caracteres especiais.

### 6. **Removendo Variáveis:**

   Para remover uma variável, use o comando `unset`.
   
   Exemplo:
   ```bash
   unset nome
   ```

### 7. **Variáveis de Ambiente:**

   Variáveis de ambiente são variáveis que são definidas no ambiente de execução do shell. Elas estão disponíveis para todos os programas e scripts em execução no ambiente.

   Exemplo:
   ```bash
   export PATH="/usr/local/bin:$PATH"
   ```