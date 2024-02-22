# Tags

### Listando as Tags

```
git tag
```

Ou, para listar apenas as tags que obedecem determinado padrão:

```
git tag -l "<padrão>"
```

Exemplo:

```
git tag -l "v1.8.5*"
```

## Lightweight vs Annotated

Uma tag lightweight é muito parecida com um branch que não muda — é apenas um ponteiro para um commit específico.

As tags annotated, entretanto, são armazenadas como objetos completos no banco de dados Git. Elas contêm o checksum, o nome do etiquetador, e-mail e data; tem uma mensagem de marcação; e podem ser assinadas e verificadas com GNU Privacy Guard (GPG). Geralmente é recomendado que você crie tags annotated para ter todas essas informações; mas se você quiser uma tag temporária ou por algum motivo não quiser manter as outras informações, tags lightweight também estão disponíveis.

## Annotated Tags

Para criar uma annotated tag basta:

```
git tag -a <tag_name> -m "<tag_message>"
```

## Lightweigth Tag

```
git tag <tag_name>
```

## Tagging commits passados

```
git tag -a <tag_name> <commit_checksum>
```

## Pushing tags

Por padrão o `git push` não empurra tags para o servidor remoto. É necessários empurrá-las explicitamente com:

```
git push <nome_repositório_remoto> <tag>
```

Para transferir todas as tags de uma vez:

```
git push origin --tags
```

## Deletando Tags

Deletando uma tag localmente:

```
git tag -d <tag_name>
```

Para deletar uma tag do servidor remoto:

```
git push <remote> :refs/tags/<tag_name>
```

Ou,

```
git push origin --delete <tag_name>
```

### Acessando Tags

Para acessar o commit referente a determinada Tag.

```
git checkout <tag_name>
```
