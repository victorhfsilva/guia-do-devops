# Aliases

Para criar atalhos para comandos do Git podemos criar aliases.

```
git config --global alias.<atalho> <comando>
```

Exemplos:

```
git config --global alias.unstage 'reset HEAD --'

git unstage
```

```
git config --global alias.last-commit 'log -1 HEAD'

git last-commit
```