# Operações de File Test no Shell Script

As operações de file test no shell script permitem verificar várias propriedades de arquivos e diretórios. Aqui está um resumo das principais operações de file test:

### 1. **Verificar se um Arquivo Existe:**
   
   ```bash
   if [ -e arquivo ]; then
       echo "O arquivo existe."
   fi
   ```

### 2. **Verificar se um Arquivo é um Diretório:**
   
   ```bash
   if [ -d diretório ]; then
       echo "É um diretório."
   fi
   ```

### 3. **Verificar se um Arquivo é um Arquivo Regular (não um diretório ou dispositivo):**
   
   ```bash
   if [ -f arquivo ]; then
       echo "É um arquivo regular."
   fi
   ```

### 4. **Verificar se um Arquivo é Executável:**
   
   ```bash
   if [ -x arquivo ]; then
       echo "O arquivo é executável."
   fi
   ```

### 5. **Verificar se um Arquivo está Vazio:**
   
   ```bash
   if [ -s arquivo ]; then
       echo "O arquivo não está vazio."
   fi
   ```

### 6. **Verificar se Dois Arquivos São Iguais:**
   
   ```bash
   if [ arquivo1 -ef arquivo2 ]; then
       echo "Os arquivos são iguais."
   fi
   ```

### 7. **Verificar se um Arquivo é Mais Novo que Outro:**
   
   ```bash
   if [ arquivo1 -nt arquivo2 ]; then
       echo "O arquivo1 é mais novo que o arquivo2."
   fi
   ```

### 8. **Verificar se um Arquivo é Mais Antigo que Outro:**
   
   ```bash
   if [ arquivo1 -ot arquivo2 ]; then
       echo "O arquivo1 é mais antigo que o arquivo2."
   fi
   ```

Esses são alguns exemplos comuns de operações de file test. Eles ajudam a automatizar tarefas com base em várias condições relacionadas a arquivos e diretórios em um script shell.