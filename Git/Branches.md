# Ramos (Branches)

## Listando os ramos
```
git branch
```
Para também mostrar o último commit de cada ramo:
```
git branch -v
```
Para filtrar por ramos merged ou não, utilize `--merged` ou `--no-merged`.

## Criando um Ramo
```
git branch <nome_ramo>
```
Ou, para criar um novo ramo e migrar automaticamente para ele:
```
git switch -c <nome_ramo>
```
Ou,
```
git checkout -b <nome_ramo>
```
## Trocando de Ramo
```
git checkout <nome_ramo>
```
Ou,
```
git switch <nome_ramo>
```

## Mesclando ramos

Mescla o ramo atual com o inserido.

```
git merge <nome_ramo>
```

## Deletando Ramos

```
git branch -d <nome_ramo>
```

## Renomeando Ramos

```
git branch --move <old_branch_name> <new_branch_name>
```

Para empurra a alteração para o repositório remoto:

```
git push --set-upstream origin <new_branch_name>
git push origin --delete <old_branch_name>
```

## Real-World Example

1. Você está trabalhando no issue #53. Então cria um ramo para este issue e migra para ele:

```
git checkout -b iss53
```

![Alt text](<images/Screenshot from 2023-10-04 11-41-09.png>)

2. Você corrigiu o issue e então comita as alterações.

```
vim index.html
git commit -a -m 'Create new footer [issue 53]'
```

![Alt text](<images/Screenshot from 2023-10-04 11-42-50.png>)

3. Você recebe uma ligação urgente sobre um issue no servidor em produção que deve ser feita imediatamente. Então primeiramente você migra para o ramo Master.

```
git checkout master
```

* Quando você faz isso o git reseta os arquivos do seu diretório para o estado deste ramo.

4. Em seguida é criado o ramo hotfix para a correção urgente.

```
git checkout -b hotfix
```

5. Feita as correções necessárias é feito um novo commit.

```
vim index.html
git commit -a -m 'Fix broken email address'
```

![Alt text](<images/Screenshot from 2023-10-04 11-50-24.png>)

6. Testadas estas alterações, elas são mescladas com o ramo master para serem colocadas em produção.

```
git checkout master
git merge hotfix
```

![Alt text](<images/Screenshot from 2023-10-04 12-00-17.png>)

7. Logo depois do deploy de hotfix seu ramo que não será mais utilizado foi deletado.

```
git branch -d hotfix
```

8. Em seguida você migrou de volta para o ramo do issue #53, terminou suas alterações e as comitou.

```
git checkout iss53
vim index.html
git commmit -a -m "Finish the new footer [issue 53]"
```

![Alt text](<images/Screenshot from 2023-10-04 13-04-22.png>)

- É importante notar que as alterações comitadas em C4 não estão presentes em C5. Caso estas alterações sejam necessárias para terminar a alteração do issue 35 bastaria mesclar master com iss53 antes de terminar as correções.

```
git merge master
```

9. Depois de testar as alterações do issue #53 já podemos mesclar estas alterações com o master e então deletar o ramo iss53.

```
git checkout master
git merge iss53
```

![Alt text](<images/Screenshot from 2023-10-04 13-15-08.png>)

```
git branch -d iss53
```

### Resolvendo Conflitos

 Caso você tenha alterado a mesma parte do código no hotfix e no iss53 de forma com que eles possuam versões diferentes das mesmas linhas de código. Ao executar `git merge iss53` na `master`, o git irá adicionar marcações de resolução de conflitos nos arquivos para que você as solucione manualmente.

No exemplo a seguir o git adiciona as seguintes marcações:

```
<<<<<<< HEAD:index.html
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
 please contact us at support@github.com
</div>
>>>>>>> iss53:index.html
```

Então você escolhe um dos blocos de código e substitui por toda a marcação.

```
<div id="footer">
please contact us at email.support@github.com
</div>
```

Em seguida basta basta adicionar as alterações (`git add index.html`) e comitar (`git commit`).

## Ramo Remoto

São referências aos ramos do repositório remoto que indicam onde os ramos estavam na última vez que você se comunicou com o repositório.

![Alt text](<images/Screenshot from 2023-10-05 10-01-08.png>)

No exemplo a seguir após você fazer algumas alterações no master local os ramos ficariam:

![Alt text](<images/Screenshot from 2023-10-05 10-03-55.png>)

Supondo que neste período alguém atualizou o ramo master do repositório remoto, e então você sincronizou com o repositório remoto utilizando `git fetch origin`, seu repositório local ficaria assim:


![Alt text](<images/Screenshot from 2023-10-05 10-07-26.png>)

Após fazer o `fetch` você ainda não tem uma copia local dos arquivos, apenas uma referência ao ramo. Para mesclar este ramo remoto com seu ramo local utilize:

```
git merge <repositório>/<ramo_remoto>
```

Exemplo:

```
git merge origin/master
```

Ou, caso vocÊ queira uma cópia do ramo remoto no seu repositório local.:

```
git checkout -b <novo_ramo> <repositorio>/<ramo_remoto>
```

Exemplo:

```
git checkout -b serverfix origin/serverfix
```

Caso o ramo local tenha um relacionamento direto com o ramo remoto (tracking branch) também podemos executar o comando a seguir para fazer a cópia: 

```
git checkout --track origin/server
```

Caso você já tenha um ramo local que queira relacionar com um ramo remoto (track) basta executar o comando a seguir neste ramo.

```
git branch -u origin/serverfix
```

Para visualizar todos os ramos tracking ramos remotos basta:

```
git branch -vv
```

Já para deletar um ramo remoto basta:

```
git push origin --delete serverfix
```