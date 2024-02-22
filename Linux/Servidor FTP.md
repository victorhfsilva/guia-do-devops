# **Configurando o Ubuntu Server como Servidor FTP**

## **Instalação do vsftpd:**

Certifique-se de que seu sistema esteja atualizado e, em seguida, instale o servidor FTP vsftpd.

```bash
sudo apt update
sudo apt install vsftpd
```

## Configurações do usuário

### Crie um diretório para os uploads

```bash
sudo mkdir /home/user/ftp
```

### Defina o usuário como proprietário desta pasta

```bash
sudo chown user:user /home/user/ftp
```

## **Configuração do vsftpd:**

Copie o arquivo de configuração do vsftpd original.

```bash
cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
```

Abra o arquivo de configuração do vsftpd para edição.

```bash
sudo vim /etc/vsftpd.conf
```

### **Desativar o Acesso Anônimo:**

```conf
anonymous_enable=NO
```

### **Permitir usuários locais a fazerem login:**

```conf
local_enable=YES
```

### **Ativar ou Desativar o Modo de Gravação:**

Para permitir ou proibir que usuários gravem arquivos.

```conf
write_enable=YES
```

### Previnir que usuários acessem arquivos fora da pasta especificada

```conf
chroot_local_user=YES
allow_writeable_chroot=YES
```

### Assegure que cada usuário só tem acesso a sua respectiva pasta

```conf
user_sub_token=$USER
local_root=/home/$USER/ftp #fix: 500 OOPS: vsftpd: refusing to run with writable root inside chroot()
```

### **Configurar o Intervalo de Portas para Modo Ativo:**

Se você precisar configurar um intervalo de portas para o modo ativo, adicione o seguinte:

```conf
pasv_min_port=30000
pasv_max_port=31000
```

### Permitir que apenas os usuários especificados tenham acesso ao FTP

```conf
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
```

```bash
echo "user" | sudo tee -a /etc/vsftpd.userlist
```

### **Reiniciar o Serviço vsftpd:**

Depois de fazer alterações, reinicie o serviço vsftpd para aplicar as configurações.

```bash
sudo service vsftpd restart
```

### **Configurar Firewall (se aplicável):**

Se estiver usando um firewall, abra as portas necessárias.

```bash
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 990/tcp
sudo ufw allow 30000:31000/tcp
```

### **5. Testar a Conexão FTP:**

Use um cliente FTP para conectar-se ao seu servidor e teste o acesso anônimo ou com credenciais.

### **6. Considerações Adicionais:**

- **Logs do vsftpd:** Os logs do vsftpd podem ser úteis para solucionar problemas. Eles estão localizados em `/var/log/vsftpd.log`.

- **Segurança:** Certifique-se de ajustar as permissões dos diretórios e arquivos conforme necessário para garantir a segurança.