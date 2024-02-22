## **Rede e Conectividade**

1. **Testar Conectividade (Ping):**
    ```bash
    ping [endereçoIP ou domínio]
    ```

2. **Traçar Rota até um Destino (Traceroute):**
    ```bash
    traceroute [endereçoIP ou domínio]
    ```

3. **Verificar Informações de Rede:**
    - **ifconfig** (Ubuntu/Debian)
      ```bash
      ifconfig
      ```
    - **ip addr show** (Manjaro/Arch)
      ```bash
      ip addr show
      ```
    - **ipconfig** (Fedora/CentOS)
      ```bash
      ipconfig
      ```

4. **Conectar via SSH:**
    ```bash
    ssh [usuário]@[endereçoIP]
    ```

5. **Conectar via Telnet:**
    ```bash
    telnet [endereçoIP]
    ```

6. **Exibir Estatísticas de Conexão (netstat):**
    
    O comando `netstat` exibe informações detalhadas sobre conexões de rede, tabelas de roteamento, interfaces de rede e estatísticas de protocolo. 

    ```bash
    netstat
    ```
