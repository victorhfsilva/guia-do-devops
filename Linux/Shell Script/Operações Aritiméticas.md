# **Operações Aritméticas no Shell Script:**

Operações aritméticas são comuns em scripts para realizar cálculos numéricos. Aqui estão algumas operações básicas e como realizá-las em shell script:

### 1. **Operadores Aritméticos:**

   | Operador | Descrição       |
   |----------|-----------------|
   | +        | Adição          |
   | -        | Subtração       |
   | *        | Multiplicação   |
   | /        | Divisão         |
   | %        | Resto da Divisão|

### 2. **Expressões Aritméticas:**

   As expressões aritméticas podem ser avaliadas usando `$(( ))` ou `expr`. Exemplos:

   ```bash
   resultado=$(( 5 + 3 ))
   resultado=$(expr 5 + 3)
   ```

### 3. **Variáveis Aritméticas:**

   É possível usar variáveis em expressões aritméticas:

   ```bash
   a=5
   b=3
   resultado=$(( a + b ))
   ```

### 4. **Operações de Incremento e Decremento:**

   ```bash
   a=5
   (( a++ ))  # Incremento de 'a'
   (( a-- ))  # Decremento de 'a'
   ```

### 5. **Comparação Numérica:**

   Para comparar números, você pode usar operadores de comparação:

   ```bash
   a=5
   b=3
   if (( a > b )); then
       echo "a é maior que b"
   fi
   ```

Operações aritméticas são úteis para calcular valores, controlar loops e tomar decisões com base em valores numéricos em scripts shell.