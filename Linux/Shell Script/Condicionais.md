# Condicionais no Shell Script

Em shell script, é comum usar estruturas de decisão para controlar o fluxo do programa com base em condições específicas. Aqui está um resumo das principais estruturas de decisão:

### 1. **Estrutura if-then:**

   ```bash
   if [ condição ]; then
       # Comandos a serem executados se a condição for verdadeira
   fi
   ```

   Exemplo:

   ```bash
   if [ $idade -ge 18 ]; then
       echo "Você é maior de idade."
   fi
   ```

### 2. **Estrutura if-then-else:**

   ```bash
   if [ condição ]; then
       # Comandos a serem executados se a condição for verdadeira
   else
       # Comandos a serem executados se a condição for falsa
   fi
   ```

   Exemplo:

   ```bash
   if [ $nota -ge 7 ]; then
       echo "Você foi aprovado."
   else
       echo "Você foi reprovado."
   fi
   ```

### 3. **Estrutura if-then-elif-then-else:**

   ```bash
   if [ condição1 ]; then
       # Comandos a serem executados se a condição1 for verdadeira
   elif [ condição2 ]; then
       # Comandos a serem executados se a condição2 for verdadeira
   else
       # Comandos a serem executados se todas as condições anteriores forem falsas
   fi
   ```

   Exemplo:

   ```bash
   if [ $idade -lt 18 ]; then
       echo "Você é menor de idade."
   elif [ $idade -ge 18 ] && [ $idade -lt 60 ]; then
       echo "Você é adulto."
   else
       echo "Você é idoso."
   fi
   ```

### **Operador ternário:**

   A partir do Bash versão 4, você pode usar o operador ternário `? :` para tomar decisões em uma única linha.

   ```bash
   variável=$( [ condição ] && echo "valor_se_verdadeiro" || echo "valor_se_falso" )
   ```

   Exemplo:

   ```bash
   status=$( [ $nota -ge 7 ] && echo "Aprovado" || echo "Reprovado" )
   ```

Essas estruturas de decisão são essenciais para controlar o fluxo do programa em um script shell, permitindo que você execute diferentes ações com base em condições específicas.