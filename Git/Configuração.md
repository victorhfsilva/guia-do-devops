# Configuração

## System, Global e Local

- `git config --system`: define as configurações para todos os usuários. Esta opção modifica o arquivo /etc/gitconfig.
- `git config --global`: define as configurações para todos os repoisitórios de um único usuário. Modifica o arquivo ~/.gitconfig ou ~/.config/git/config.
- `git config --local`: define as configurações para um único repositório. Modifica o arquivo .git/config.

## Listando Configurações

Lista configurações do git
```
git config --list
```

Ou, para também mostrar a origem de cada configuração:
```
git config --list --show-origin
```

## Configuração de Identidade

Define o nome do autor dos commits
```
git config --global user.name "<nome>"
```
Define o e-mail do autor dos commits
```
git config --global user.email "<email>"
```

## Configuração do Editor

Define o editor de texto padrão utilizado quando Git precisa que uma mensagem seja inserida.

```
git config --global core.editor <editor>
```

Exemplos:

```
git config --global core.editor emacs
```

```
$ git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"
```

## Configurando o nome padrão para as branches

Por padrão git cria uma branch com o nome master para todos os repositórios inicializados com `git init`. Para definir outro nome padrão para esta branch:

```
git config --global init.defaultBranch <nome>
```

## Autenticando o Github no dispositivo
Autentica o github no dispositivo
```
gh auth login
```

 É uma maneira conveniente de configurar a autenticação entre o GitHub CLI e a conta do GitHub, permitindo a interação com seus repositórios e outros recursos do GitHub a partir da linha de comando de maneira segura e eficiente, sem a necessidade de fornecer as credenciais repetidamente.

## Configuração das Chaves SSH no Ubuntu

As chaves SSH são usadas para estabelecer uma conexão segura entre o computador e os servidores do GitHub.

Verificar se já existem chaves
```
ls -al ~/.ssh
```
Gerando par de chaves SSH
```
ssh-keygen -t ed25519 -C <endereço_email>
```
Exibindo a Chave SSH pública (adicionar esta chave ao Github)
```
cat <chave_pública>
```
Inicializar Agente SSH (na pasta .ssh)
```
eval $(ssh-agent -s)
```
Adicionar a Chave Privada ao Agente SSH
```
ssh-add <chave_privada>
```
Exemplo:
```
ssh-add id_ed25519
```