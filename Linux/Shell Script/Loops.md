# **Loops no Shell Script**

Os loops são estruturas de controle que permitem executar um bloco de código repetidamente enquanto uma determinada condição for verdadeira. No Shell Script, os loops mais comuns são o `for`, o `while` e o `until`.

### Loop `for`

O loop `for` é usado para iterar sobre uma lista de elementos e executar um conjunto de comandos para cada elemento na lista.

```bash
for item in lista_de_itens
do
    # Comandos a serem executados para cada item na lista
done
```

Exemplo:
```bash
for num in 1 2 3 4 5
do
    echo "Número: $num"
done
```

### Loop `while`

O loop `while` executa um conjunto de comandos repetidamente enquanto uma condição especificada for verdadeira.

```bash
while [ condição ]
do
    # Comandos a serem executados enquanto a condição for verdadeira
done
```

Exemplo:
```bash
contador=0
while [ $contador -lt 5 ]
do
    echo "Contador: $contador"
    ((contador++))
done
```

### Loop `until`

O loop `until` é semelhante ao `while`, mas executa um conjunto de comandos repetidamente enquanto uma condição especificada for falsa.

```bash
until [ condição ]
do
    # Comandos a serem executados enquanto a condição for falsa
done
```

Exemplo:
```bash
contador=0
until [ $contador -eq 5 ]
do
    echo "Contador: $contador"
    ((contador++))
done
```

### Comandos de Controle de Loop

- `break`: Interrompe a execução do loop.
- `continue`: Pula para a próxima iteração do loop.

Exemplo:
```bash
for num in {1..10}
do
    if [ $num -eq 5 ]
    then
        continue
    elif [ $num -eq 8 ]
    then
        break
    fi
    echo "Número: $num"
done
```

Este é um guia básico sobre iterações e loops no Shell Script. Você pode usar essas estruturas para automatizar tarefas repetitivas e processar dados de forma eficiente.