## **Gerenciamento de Processos**

1. **Listar Todos os Processos:**
    ```bash
    ps
    ```

2. **Listar Processos Detalhados:**
    ```bash
    ps aux
    ```

3. **Encerrar Processo por PID:**
    ```bash
    kill [PID]
    ```

4. **Encerrar Processo pelo Nome:**
    ```bash
    killall [nomeDoProcesso]
    ```

5. **Buscar Processo por Nome:**
    ```bash
    pgrep [nomeDoProcesso]
    ```

6. **Enviar Sinal para Processo:**
    ```bash
    kill -SIGNAL [PID]
    ```

7. **Exibir Lista de Processos em Tempo Real (top):**
    O comando `top` exibe uma lista de processos em tempo real, mostrando informações como uso de CPU, memória e tempo de execução.
    
    ```bash
    top
    ```