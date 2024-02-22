
# **Gerenciamento de Pacotes**

1. **Atualizar Lista de Pacotes:**
    ```bash
    sudo apt update  # Ubuntu/Debian
    ```
    ```bash
    sudo pacman -Sy  # Manjaro/Arch
    ```
    ```bash
    sudo dnf check-update  # Fedora/CentOS
    ```

2. **Instalar Pacote:**
    ```bash
    sudo apt install [nomeDoPacote]  # Ubuntu/Debian
    ```
    ```bash
    pamac install [nomeDoPacote]  # Manjaro/Arch
    ```
    ```bash
    sudo dnf install [nomeDoPacote]  # Fedora/CentOS
    ```

3. **Remover Pacote:**
    ```bash
    sudo apt remove [nomeDoPacote]  # Ubuntu/Debian (Remove apenas o binário)
    ```
    ```bash
    sudo apt purge [nomeDoPacote]  # Ubuntu/Debian (Remove o binário e todos arquivos de configuração e temporários)
    ```
    ```bash
    pamac remove [nomeDoPacote]  # Manjaro/Arch
    ```
    ```bash
    sudo dnf remove [nomeDoPacote]  # Fedora/CentOS
    ```

4. **Buscar por Pacote:**
    ```bash
    apt search [termoDeBusca]  # Ubuntu/Debian
    ```
    ```bash
    pamac search [termoDeBusca]  # Manjaro/Arch
    ```
    ```bash
    dnf search [termoDeBusca]  # Fedora/CentOS
    ```

5. **Atualizar Pacotes Instalados:**
    ```bash
    sudo apt upgrade  # Ubuntu/Debian
    ```
    ```bash
    pamac upgrade  # Manjaro/Arch
    ```
    ```bash
    sudo dnf upgrade  # Fedora/CentOS
    ```