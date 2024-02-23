# **Vagrantfile**

O Vagrantfile é um arquivo de configuração usado pelo Vagrant para definir e configurar máquinas virtuais. Ele utiliza uma sintaxe Ruby simples e oferece uma variedade de opções para personalizar o ambiente de desenvolvimento. Abaixo estão os principais componentes e configurações do Vagrantfile:

### **1. Configuração Básica:**

- **Definir a Box Base:**
  ```ruby
  config.vm.box = "nome_da_box"
  ```
  Especifica a box base que será usada para criar a máquina virtual.

- **Definir o Nome da Máquina Virtual:**
  ```ruby
  config.vm.hostname = "nome_da_maquina"
  ```
  Define o nome da máquina virtual.

### **2. Rede:**

- **Definir IP Fixo:**
  ```ruby
  config.vm.network "private_network", ip: "192.168.56.1"
  ```
  Atribui um endereço IP fixo à máquina virtual.

- **Encaminhamento de Porta:**
  ```ruby
  config.vm.network "forwarded_port", guest: 80, host: 8080
  ```
  Encaminha as solicitações de uma porta na máquina host para uma porta na máquina guest.

### **3. Provisionamento:**

- **Shell Script:**
  ```ruby
  config.vm.provision "shell", path: "script.sh"
  ```
  Executa um script shell durante a inicialização da máquina virtual.

- **Shell inline:**
  ```ruby
  config.vm.provision "shell", inline: <<-SHELL
    echo "Configuração Personalizada"
    # Comandos Personalizados Aqui
  SHELL
  ```
  Permite a execução de comandos diretamente no Vagrantfile.

- **Definir Variáveis de Ambiente:**
  ```ruby
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
  ```
  Define variáveis de ambiente para configurar o Vagrant.

### **4. Personalização:**

- **Memória e CPU:**
  ```ruby
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
  end
  ```
  Define a quantidade de memória e CPUs atribuídas à máquina virtual.

- **Nome da VM na GUI do VirtualBox:**
  ```ruby
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Meu Projeto"
  end
  ```
  Especifica o nome exibido na interface gráfica do VirtualBox.

### 5. Exemplos:

#### 1. Básico

```ruby
Vagrant.configure("2") do |config|
    #Define a VM 
    config.vm.box = "hashicorp/bionic64"
end
```

#### 2. Configurações de Rede

```ruby
Vagrant.configure("2") do |config|
  #Define a VM
  config.vm.box = "ubuntu/trusty64"
  
  #Faz o encaminhamento entre portas host e guest
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  
  #Define um IP estático para a VM
  config.vm.network "private_network", ip: "192.168.56.1"

  #Desabilita as portas seriais da máquina virtual
  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end
end 
```

#### 3. Provisionamento

```ruby
Vagrant.configure("2") do |config|
  #Define a VM
  config.vm.box = "ubuntu/trusty64"
  
  #Faz o encaminhamento entre portas host e guest
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  #Define um IP estático para a VM
  config.vm.network "private_network", ip: "192.168.56.1"

  #Istalação do Nginx durante o provisionamento
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update && apt-get install -y nginx
  SHELL

  #Desabilita as portas seriais da máquina virtual
  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end
end 
```