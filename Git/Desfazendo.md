# Desfazendo as coisas

## Reescrevendo a mensagem do commit

Para refazer um commit com outra mensagem basta executar o comando a seguir e então fazer outro commit.

```
git commit --amend
```

## Desfazendo o stage de um arquivo

Para retornar um arquivo para o estado de unstaged basta:

```
git reset <arquivo>
```

Lembrando que um arquivo é considerado staged após a execução do comando `add`.

## Desfazendo uma modificação em um arquivo

Reverte um arquivo não staged para o que ele era no último commit.

```
git checkout -- <arquivo>
```

## Reset
Reseta os arquivos para determinado commit (deleta arquivos)
```
git reset --hard <commit_ID>
```
Reseta os arquivos para um estado ainda não staged (antes do add) de determinado commit.
```
git reset --mixed <commit_ID>
```
Reseta os arquivos para o estado staged de determinado commit
```
git reset --soft <commit_ID>
```
*Utilizar restore para restaurar arquivos alterados após reset.*

## **Reflog e Recuperação de Commits**

Após realizar um `git reset`, é possível recuperar commits resetados utilizando o reflog e o comando `git reset --hard HEAD@{<n>}`.

### **Reflog (Registro de Referências)**

O reflog mantém um registro de todas as mudanças no HEAD, incluindo resets e movimentos de branch. Ele permite visualizar o histórico recente e recuperar commits perdidos.

```bash
git reflog
```

### **Recuperação de Commits com o Reflog**

Após identificar o commit desejado no reflog, você pode recuperá-lo utilizando o comando:

```bash
git reset --hard HEAD@{<n>}
```

Substitua `<n>` pelo número do commit desejado no registro de referências fornecido pelo reflog.

## Restore

- Para desfazer um stage basta:

```
git restore --staged <arquivo>
```

- Para reverter alterações ainda não comitadas de arquivos não staged para a versão do commit mais recente.

```
git restore <file>
```

Ao contrário do `git checkout` o `git restore` não pode ser utilizado para recuperar arquivos exluidos, ele é utilizado apenas para descartar alterações nos arquivos existentes.
