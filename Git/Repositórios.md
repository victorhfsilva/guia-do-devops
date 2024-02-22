# Repositórios

![Alt text](images/git_status.png)

## Status

Para verificar o status de cada arquivo:

```
git status
```

Também é possível verificar o status em uma versão simplificada do git status:

```
git status -s
```

## Diff

Para verificar o que foi alterado em cada arquivo unstaged execute:

```
git diff
```

Para verificar as alterações entre os arquivos staged e o último commit execute:

```
git diff --staged
```

## Inicialização
Para inicializar um repositório do Git basta executar o comando a seguir dentro da pasta do projeto:

```
git init
```

## Add
Para adicionar (track ou stage) um arquivo ao Commit:

```
git add <arquivo>
```

Para adicionar (track ou stage) todos os arquivos da pasta:

```
git add *
```

Para adicionar (track ou stage) todas as alterações, incluindo adições, modificações e exclusões da pasta:

```
git add -A
```

## Remove

Para tornar um arquivo que foi excluído do diretório como staged basta executar:

```
git rm <file>
```

Para excluir um arquivo já com status staged do repositório é necessário forçar a remoção com -f:

```
git rm -f <file>
```

Para manter um arquivo no diretório local mas deletá-lo da staging area, basta executar o comando:

```
git rm --cached <file>
```

Isto é útil, por exemplo, para excluir algum arquivo que não sido colocado no .gitignore do repositório mas não do diretório local.

## Move

Para renomear ou mover um arquivo no Git basta:

```
git mv <path/file_name> <path/new_file_name>
```

## Git Ignore

É possível criar uma lista de padrões de nomes de arquivos que devem ser ignorados no arquivo .gitignore. Algumas convenções destes padrões pode ser visualizadas a seguir:

```
# Ignorar todos os arquivos .a
*.a

# Rastreia lib.a, mesmo que você esteja ignorando os arquivos .a acima
!lib.a

# Ignorar apenas o arquivo TODO no diretório atual, não subdir/TODO
/TODO

# Ignorar todos os arquivos em qualquer diretório chamado build
build/

# Ignorar doc/notes.txt, mas não doc/server/arch.txt
doc/*.txt

# Ignorar todos os arquivos .pdf no diretório doc/ e em seus subdiretórios
doc/**/*.pdf
```

Para escolher quais arquivos devem ser ignorados para cada linguagem ou ferramenta, consultar:

- https://github.com/github/gitignore
- https://www.toptal.com/developers/gitignore

## Commit

Para comitar as alterações utilizando o editor de escolha para salvar a descrição do commit:

```
git commit
```

Para comitar as alterações incluindo uma descrição do commit inline.

```
git commit -m "<descrição_commit>"
```

O git também permite que todos os arquivos tracked sejam comitados automaticamente sem a necessidade de passarem pelo status staged.

```
git commit -a
```

