# **Arrays no Shell Script:**

Arrays em shell script são usados para armazenar uma coleção de valores sob um único nome. Aqui está um resumo sobre arrays:

### 1. **Declarando Arrays:**

   Para declarar um array, basta atribuir uma lista de valores a ele, separados por espaços e envolvidos por parênteses `()`.
   
   Exemplo:
   ```bash
   nomes=("João" "Maria" "Pedro")
   ```

### 2. **Acessando Elementos do Array:**

   Para acessar um elemento específico do array, use o índice do elemento dentro de colchetes `[]`.
   
   Exemplo:
   ```bash
   echo ${nomes[0]}   # Saída: João
   ```

### 3. **Tamanho do Array:**

   O tamanho de um array pode ser obtido utilizando `${#array[@]}`.
   
   Exemplo:
   ```bash
   tamanho=${#nomes[@]}
   echo "O array 'nomes' tem $tamanho elementos."
   ```

### 4. **Adicionando Elementos:**

   Para adicionar um novo elemento a um array, basta atribuir um valor a um índice não ocupado.
   
   Exemplo:
   ```bash
   nomes[3]="Ana"
   ```

### 5. **Removendo Elementos:**

   Para remover um elemento do array, basta atribuir um valor vazio (`""`) ao elemento desejado.
   
   Exemplo:
   ```bash
   unset nomes[2]
   ```

### 6. **Iterando sobre um Array:**

   É possível percorrer todos os elementos de um array utilizando um loop `for`.
   
   Exemplo:
   ```bash
   for nome in "${nomes[@]}"; do
       echo "Olá, $nome!"
   done
   ```

### 7. **Arrays Associativos:**

   Em bash, também é possível criar arrays associativos, onde os elementos são indexados por chaves em vez de índices numéricos.
   
   Exemplo:
   ```bash
   declare -A frutas
   frutas[maçã]="vermelha"
   frutas[banana]="amarela"
   ```

   Para acessar elementos de um array associativo:
   ```bash
   echo ${frutas[maçã]}   # Saída: vermelha
   ```

### 8. **Copiando Arrays:**

   Para copiar um array, basta atribuir o valor do array original ao novo array.
   
   Exemplo:
   ```bash
   novos_nomes=("${nomes[@]}")
   ```