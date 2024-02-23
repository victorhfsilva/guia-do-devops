# **Comandos Básicos do Vagrant**

### 1. **Inicializar um Ambiente Vagrant:**
   ```bash
   vagrant init [nomeDaBox]
   ```
   Inicializa um novo arquivo `Vagrantfile` no diretório atual, que será usado para configurar a máquina virtual.

### 2. **Iniciar uma Máquina Virtual:**
   ```bash
   vagrant up
   ```
   Inicia a máquina virtual de acordo com as configurações definidas no `Vagrantfile`.

### 3. **Parar uma Máquina Virtual:**
   ```bash
   vagrant halt
   ```
   Interrompe a execução da máquina virtual.

### 4. **Suspender uma Máquina Virtual:**
   ```bash
   vagrant suspend
   ```
   Coloca a máquina virtual em um estado de suspensão, permitindo que você a retome posteriormente com todos os dados do estado atual.

### 5. **Retomar uma Máquina Virtual Suspensa:**
   ```bash
   vagrant resume
   ```
   Retoma uma máquina virtual previamente suspensa.

### 6. **Destruir uma Máquina Virtual:**
   ```bash
   vagrant destroy
   ```
   Remove completamente a máquina virtual e todos os seus recursos associados.

### 7. **Conectar à Máquina Virtual via SSH:**
   ```bash
   vagrant ssh
   ```
   Conecta à máquina virtual via SSH, permitindo acesso ao terminal.

### 8. **Listar Status das Máquinas Virtuais:**
   ```bash
   vagrant status
   ```
   Exibe o status atual de todas as máquinas virtuais no diretório Vagrant.

### 9. **Listar Status de Todas Máquinas Virtuais

   ```
   vagrant global-status --prune
   ```

Exibe o status atual de todas as máquinas virtuais.

### 10. **Atualizar Configurações de uma Máquina Virtual:**
   ```bash
   vagrant reload
   ```
   Recarrega a configuração da máquina virtual a partir do `Vagrantfile`.

### 11. **Atualizar Boxes Disponíveis:**
    ```bash
    vagrant box update
    ```
    Atualiza as boxes disponíveis para uso no Vagrant.

### 12. **Listar Boxes Disponíveis:**
    ```bash
    vagrant box list
    ```
    Lista todas as boxes disponíveis para uso no Vagrant.

### 13. **Aplicar provisionamento:**
    ```bash
    vagrant provision
    ```
    Aplica o provisionamento em uma máquina ainda não provisionada.

### 14. **Desfazer Provisionamento:**
    ```bash
    vagrant provision --provision-with none
    ```
    Desfaz qualquer provisionamento feito anteriormente na máquina virtual.

Esses comandos básicos são fundamentais para iniciar, gerenciar e interagir com as máquinas virtuais criadas pelo Vagrant.