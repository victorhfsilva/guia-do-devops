# Permissões

As permissões de arquivo no Linux são fundamentais para controlar quem pode acessar, modificar ou executar arquivos no sistema. 

## 1. **Comando chmod**

O comando `chmod` é utilizado para alterar as permissões de um arquivo ou diretório. Ele pode ser usado de duas formas:

### a. **Modo Octal**

No modo octal, as permissões são representadas como um número de 3 dígitos (0-7), onde cada dígito representa as permissões para o proprietário, grupo e outros, respectivamente.

- Leitura (4)
- Escrita (2)
- Execução (1)

Para modificar permissões usando o modo octal, use o seguinte formato:

```bash
chmod <ogw> <nome_arquivo>
```

#### Exemplo:

```bash
chmod 777 arquivo.txt
```

### b. **Modo Simbólico**

No modo simbólico, as permissões são representadas por letras (r, w, x) e símbolos (+, -, =).

```bash
chmod <ugo><+-=><rwx> <nome_arquivo>
```

Onde:
- `<ugo>`: Define para quem as permissões serão aplicadas (u = owner, g = group, o = others).
- `<+-=>`: Indica se as permissões serão adicionadas (+), removidas (-) ou definidas (=).
- `<rwx>`: Especifica as permissões (read, write, execute).

#### Exemplo:

Para adicionar permissões de escrita (write) para outros (others) no arquivo "exemplo.txt", você pode usar:

```bash
chmod o+wx exemplo.txt
```

- `o`: Aplica a mudança para o grupo de outros (others).
- `+`: Adiciona permissões.
- `wx`: Concede permissões de escrita e execução.

## 2. **Comando chown**

O comando `chown` é utilizado para alterar o proprietário e o grupo de um arquivo ou diretório.

```bash
chown <novoProprietário>:<novoGrupo> <nome_arquivo>
```

#### Exemplo:

Para definir o usuário `novoUsuario` como o proprietário do arquivo "arquivo.txt", você pode usar:

```bash
chown novoUsuario arquivo.txt
```
