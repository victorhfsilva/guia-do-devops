# **Operações de String no Shell Script:**

No shell script, é possível realizar diversas operações com strings, como concatenação, comparação, verificação de tamanho, extração de substrings, entre outras. Abaixo estão algumas das operações mais comuns com strings:

### **Concatenação de Strings:**
  ```bash
  str1="Olá"
  str2="Mundo"
  concatenado="$str1 $str2"
  echo $concatenado  # Saída: Olá Mundo
  ```

### **Comparação de Strings:**
  - **Igualdade:**
    ```bash
    str1="hello"
    str2="world"
    if [ "$str1" = "$str2" ]; then
        echo "As strings são iguais."
    else
        echo "As strings são diferentes."
    fi
    ```
  - **Diferença:**
    ```bash
    str1="hello"
    str2="world"
    if [ "$str1" != "$str2" ]; then
        echo "As strings são diferentes."
    else
        echo "As strings são iguais."
    fi
    ```

### **Verificação de Tamanho da String:**
  ```bash
  str="hello"
  tamanho=${#str}
  echo "O tamanho da string é: $tamanho"  # Saída: O tamanho da string é: 5
  ```

### **Extração de Substrings:**
  ```bash
  str="hello world"
  substr=${str:3:5}
  echo $substr  # Saída: lo wo
  ```

### **Verificação de Substring:**

  ```bash
  str="hello world"
  if [[ $str == *"world"* ]]; then
      echo "A substring 'world' está presente na string."
  else
      echo "A substring 'world' não está presente na string."
  fi
  ```