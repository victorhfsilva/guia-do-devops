# Instalação

### 1. Instalação do Virtualbox

Primeiramente instale o [VirtualBox](https://www.virtualbox.org/wiki/Downloads) na máquina. 

### 2. Instalação do Vagrant

Em seguida instale o [Vagrant](https://developer.hashicorp.com/vagrant/install).

### 3. Adição de Variáveis de Ambiente

Adicione as seguintes variáveis de ambiente no profile de seu terminal:

```bash
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
```

### 4. Instale o plugin do WSL2

```bash
vagrant plugin install virtualbox_WSL2
```

### 5. Edição do Vagrantfile

Edite o Vagrantfile da sua máquina virtual caso encontre o erro (VERR_PATH_NOT_FOUND).

```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"

    #Desabilita as portas seriais da máquina virtual
    config.vm.provider "virtualbox" do |vb|
        vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
    end
end
```