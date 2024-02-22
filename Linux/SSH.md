# Configurando Acesso Remoto com SSH

1. Instalação do OpenSSH

```bash
sudo apt install openssh-server
```

2. Acesso de outra máquina Linux:

```
sudo ssh user@192.168.0.12
```

3. O servidor também pode ser acessado de uma máquina Windows utilizando Putty.


## Configurando o SSHD

Para configurar o serviço SSHD basta editar o arquivo `/etc/ssh/sshd_config`.

- **Exemplo:** Para permitir a autenticação do root via SSH basta descomentar a linha `#PermitRootLogin prohibit-password` e substituí-la por `PermitRootLogin yes`.

### Opções Adicionais do `sshd_config`:**

A seguir serão mencionadas outras configurações avançadas para personalizar e fortalecer a segurança do SSH. 

#### **Porta SSH Personalizada:**
Por padrão, o SSH opera na porta 22. Alterar a porta pode adicionar uma camada adicional de segurança.

```ssh
Port 2222
```

#### **Permitir ou Negar Acesso de Usuários:**
Configurar quais usuários têm permissão para acessar o SSH.

```ssh
AllowUsers usuario1 usuario2
DenyUsers usuario3
```

#### **Permitir ou Negar Acesso com Base no Endereço IP:**
Restringir o acesso com base nos endereços IP.

```ssh
AllowUsers usuario@endereco_ip
DenyUsers usuario@endereco_ip
```

#### **Desativar o Acesso do Root:**
Desativar o login direto do root pode aumentar a segurança.

```ssh
PermitRootLogin no
```

#### **Tempo de Inatividade:**
Configurar o tempo antes que uma sessão inativa seja desconectada.

```ssh
ClientAliveInterval 300
ClientAliveCountMax 2
```

#### ** Chaves de Acesso SSH:**

Configurar a autenticação por chave pública.

```ssh
PubkeyAuthentication yes
PasswordAuthentication no
```

#### **Restringir Comandos para Chaves Específicas:**

Limitar os comandos que podem ser executados usando uma chave específica.

```ssh
command="comando permitido" ssh-rsa chave_publica
```

### **Reiniciando o Serviço SSH:**

Depois de fazer alterações no `sshd_config`, reinicie o serviço SSH para aplicar as configurações.

```bash
sudo systemctl restart sshd
```

## Configurando o Firewall (se aplicável):

- **Habilitando o SSH:**

```bash
sudo ufw allow ssh
```

Este comando libera o tráfego na porta padrão do SSH (porta 22). Se você configurou uma porta personalizada no sshd_config, substitua ssh pela porta desejada, por exemplo:

```bash
sudo ufw allow 2222
```