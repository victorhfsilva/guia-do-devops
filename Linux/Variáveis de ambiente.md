# **Variáveis de Ambiente:**

As variáveis de ambiente no Unix desempenham um papel crucial na configuração e personalização do ambiente do usuário. Elas são usadas para armazenar informações importantes sobre o sistema e as preferências do usuário. Aqui estão algumas das variáveis de ambiente mais relevantes:

## **Definindo Variáveis:**

```bash
NOME_DA_VARIAVEL="valor"
```

#### Exemplo:

```bash
USERNAME="john_doe"
```

## **Acessando o Valor de uma Variável:**

```bash
echo $NOME_DA_VARIAVEL
```

### Exemplo:

```bash
echo $USERNAME
```

## **Variáveis Importantes:**

#### **`$HOME` - Diretório Pessoal:**
- Indica o diretório pessoal do usuário.

#### **`$PATH` - Caminho para Comandos:**
- Especifica os diretórios nos quais a shell deve procurar por comandos.
  ```bash
  PATH=/bin:/usr/bin
  ```

#### **`$PWD` - Diretório de Trabalho Atual:**
- Indica o diretório atual em que o usuário está trabalhando.

#### **`$USER` - Nome do Usuário:**
- Armazena o nome do usuário atual.

#### **`$SHELL` - Shell Atual:**
- Indica o ambiente da shell atual.

#### **`$TERM` - Tipo de Terminal:**
- Refere-se ao tipo de display ou terminal utilizado.

#### **`$LANG` - Configuração de Localidade:**
- Expande para a localidade padrão do sistema.

#### **`$DISPLAY` - Identificador de Display:**
- Contém o identificador do display padrão para programas X11.

#### **`$LD_LIBRARY_PATH` - Caminho para Objetos Compartilhados:**

- Lista de diretórios para a busca de objetos compartilhados.

### **Visualizando Valores:**

```bash
echo $VARIAVEL_DE_AMBIENTE
```

#### Exemplo:

```bash
echo $HOME
```

### **Modificando Variáveis de Ambiente:**

```bash
VARIAVEL_DE_AMBIENTE="novo_valor"
```

#### Exemplo:

```bash
PATH=$PATH:/usr/local/bin
```

## **Personalizando o Ambiente:**

- `$PS1`: Define o prompt principal.
- `$PS2`: Define o prompt secundário para comandos incompletos.

#### Exemplo de `$PS1`:
```bash
PS1="[\u@\h \w]\$"
```
#### Resultado
```
[root@ip-72-167-112-17 /var/www/tutorialspoint/unix]$
```
### Alguns Escape Sequences para PS1:

- \t: Hora atual (HH:MM:SS).
- \d: Data atual (Weekday Month Date).
- \n: Nova linha.
- \s: Ambiente da shell atual.
- \W: Diretório de trabalho.
- \w: Caminho completo do diretório.
- \u: Nome do usuário atual.
- \h: Nome do host atual.
- \\#: Número do comando atual.
- \$: Exibe # se root; $ se usuário comum.
