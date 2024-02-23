# **Funções no Shell Script**

As funções permitem agrupar um conjunto de comandos em um bloco reutilizável, o que facilita a manutenção e a organização do código. No Shell Script, você pode definir e chamar funções para realizar tarefas específicas.

### Definindo Funções

Para definir uma função, use a seguinte sintaxe:

```bash
nome_da_funcao() {
    # Comandos a serem executados pela função
}
```

Exemplo:
```bash
saudacao() {
    echo "Olá, mundo!"
}
```

### Chamando Funções

Para chamar uma função, simplesmente insira o nome da função.

Exemplo:
```bash
saudacao
```

### Passagem de Parâmetros

Você pode passar parâmetros para funções da mesma forma que passa argumentos para scripts. Dentro da função, esses parâmetros são acessíveis por meio das variáveis posicionais `$1`, `$2`, `$3`, etc.

Exemplo:
```bash
saudar_usuario() {
    echo "Olá, $1!"
}

saudar_usuario "Alice"
```

### Retorno de Valores

As funções podem retornar valores por meio do comando `return`. O valor retornado pode ser acessado por meio da variável `$?` após a chamada da função.

Exemplo:
```bash
adicionar() {
    local resultado=$(( $1 + $2 ))
    return $resultado
}

adicionar 5 3
echo "O resultado da adição é: $?"
```

### Escopo de Variáveis

Variáveis definidas dentro de uma função são locais por padrão e não são visíveis fora da função.

### Exemplo Completo

Aqui está um exemplo completo de uma função que verifica se um número é par ou ímpar:

```bash
verificar_paridade() {
    local numero=$1
    if [ $((numero % 2)) -eq 0 ]
    then
        echo "$numero é um número par."
        return 0
    else
        echo "$numero é um número ímpar."
        return 1
    fi
}

verificar_paridade 5
```