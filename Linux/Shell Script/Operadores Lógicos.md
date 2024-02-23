# **Operadores Lógicos no shell script:**

## Operadores Relacionais

Os operadores relacionais são utilizados para comparar valores numéricos no shell script. Aqui está uma descrição dos operadores relacionais suportados pelo Shell:

### **-eq:** 
Verifica se o valor de dois operandos é igual; se sim, a condição se torna verdadeira.

### **-ne:** 
Verifica se o valor de dois operandos é diferente; se os valores não forem iguais, a condição se torna verdadeira.

### **-gt:** 
Verifica se o valor do operando esquerdo é maior que o valor do operando direito; se sim, a condição se torna verdadeira.

### **-lt:**
 Verifica se o valor do operando esquerdo é menor que o valor do operando direito; se sim, a condição se torna verdadeira.
### **-ge:**
 Verifica se o valor do operando esquerdo é maior ou igual ao valor do operando direito; se sim, a condição se torna verdadeira.
### **-le:**
 Verifica se o valor do operando esquerdo é menor ou igual ao valor do operando direito; se sim, a condição se torna verdadeira.

### Exemplos 
Se a variável `a` contém 10 e a variável `b` contém 20, então:

- `[ $a -eq $b ]` não é verdadeiro.
- `[ $a -ne $b ]` é verdadeiro.
- `[ $a -gt $b ]` não é verdadeiro.
- `[ $a -lt $b ]` é verdadeiro.
- `[ $a -ge $b ]` não é verdadeiro.
- `[ $a -le $b ]` é verdadeiro.

**Observação:** Todas as expressões condicionais devem ser colocadas dentro de colchetes quadrados `[ ]` com espaços ao redor delas.

## **Operadores Booleanos:**

Os operadores booleanos são utilizados para criar expressões lógicas compostas no shell script. Aqui estão os operadores booleanos suportados pelo Bourne Shell:

### **!:** 
Negação lógica. Inverte uma condição verdadeira em falsa e vice-versa.

### **-o:** 
OR lógico. Se um dos operandos for verdadeiro, a condição se torna verdadeira.

### **-a:**
AND lógico. Se ambos os operandos forem verdadeiros, a condição se torna verdadeira; caso contrário, se torna falsa.

### Exemplos

Se a variável `a` contém 10 e a variável `b` contém 20, então:

- `[ ! false ]` é verdadeiro.
- `[ $a -lt 20 -o $b -gt 100 ]` é verdadeiro.
- `[ $a -lt 20 -a $b -gt 100 ]` é falso.