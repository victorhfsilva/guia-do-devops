# Gerenciamento de Usuários

### **Exibir Todos os Usuários:**
- Para exibir todos os usuários do sistema:
   ```bash
   sudo cat /etc/passwd
   ```

###  Adicionando Usuários

- Para adicionar um novo usuário ao sistema:
  ```bash
  sudo adduser novo_usuario
  ```
  Isso criará um novo usuário com um diretório home padrão e um ID de usuário (UID) único.

### Definindo Senhas para Usuários

- Para definir uma senha para o novo usuário:
  ```bash
  sudo passwd novo_usuario
  ```
  Você será solicitado a inserir a nova senha e, em seguida, confirmá-la.

### Modificando Usuários

- Para modificar as propriedades de um usuário existente, como o diretório home, o grupo principal ou as informações do usuário:

  ```bash
  sudo usermod [opções] nome_do_usuario
  ```
  Exemplo: Alterar o diretório home de um usuário:
  ```bash
  sudo usermod -d /novo_diretorio_home nome_do_usuario
  ```

  Algumas opções úteis do `usermod` incluem:
  - `-d, --home` : Define o diretório home do usuário.
  - `-g, --gid` : Define o ID do grupo principal do usuário.
  - `-a, --append` : Adiciona o usuário a um grupo secundário sem remover de outros grupos.
  - `-L, --lock` : Bloqueia o acesso do usuário ao sistema.
  - `-U, --unlock` : Desbloqueia o acesso do usuário ao sistema.

### Removendo Usuários

- Para remover um usuário do sistema:
  ```bash
  sudo userdel nome_do_usuario
  ```
  Por padrão, o comando `userdel` não remove o diretório home do usuário. Para remover o diretório home e todos os arquivos relacionados:
  ```bash
  sudo userdel -r nome_do_usuario
  ```

### Gerenciamento de Grupos

- **Adicionar Grupo:**
  ```bash
  sudo addgroup novo_grupo
  ```
- **Remover Grupo:**
  ```bash
  sudo delgroup grupo_existente
  ```
- **Adicionar Usuário a um Grupo:**
  ```bash
  sudo usermod -aG grupo nome_do_usuario
  ```
- **Remover Usuário de um Grupo:**
  ```bash
  sudo deluser nome_do_usuario grupo
  ```
