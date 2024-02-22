# Repositórios Remotos

## Listando repositórios remotos
Para listar as origens dos repositórios remotos:
```
git remote -v
```
## Adicionando repositórios remotos
Para adicionar um repositório remoto:
```
git remote add <nome_repositório_remoto> <endereço_https_repositório>
```
Exemplo:
```
git remote add origin https://github.com/victorhfsilva/Comandos-Terminal
```
Exemplo utilizando Access Token:
```
git remote add origin https://<token>@github.com/victorhfsilva/Comandos-Terminal.git
```
## Deletando repositórios remotos
Para deletar um repositório remoto:
```
git remote remove <nome_repositório_remoto>
```
Exemplo:
```
git remote remove origin
```

## Renomeando repositórios remotos

Para renomear um repositório remoto:

```
git remote rename <nome> <novo_nome>
```

## Mostrando informações do repositório remoto

Para mostrar informações sobre um repositório remoto:

```
git remote show <nome_repositório_remoto>
```

## Push

Para empurrar um ramo ao repositório remoto:
```
git push <nome_repositório_remoto> <ramo>
```
Exemplo:
```
git push origin master
```

## Fetch

Para puxar todas as informações do repositório remoto que você ainda não tem utilize o comando a seguir. Depois de executar este comando você terá referências de todos os ramos do repositório remoto.

```
git fetch <nome_repositório_remoto>
```

Fetch apenas baixa a informação para o seu repositório local, ele não mescla os dados nem os modifica. É necessário mesclar manualmente.

## Pull

Ao contrário do fetch, o comando pull realiza um fetch e logo em seguida já mescla as alterações com o seu ramo local.

Para puxar um ramo do repositório remoto:
```
git pull <nome_repositório_remoto> <ramo>
```
Exemplo:
```
git pull origin master
```