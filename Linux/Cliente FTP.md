# Cliente FTP

O File Transfer Protocol (FTP) é um protocolo padrão para transferência de arquivos entre sistemas. Um cliente FTP é usado para se conectar a servidores FTP e gerenciar a transferência de arquivos. 

### Conectando-se a um Servidor FTP

1. **Conectar a um Servidor FTP:**

   ```bash
   ftp nome-do-servidor
   ```

   Substitua `nome-do-servidor` pelo endereço do servidor FTP.

2. **Conectar com um Número de Porta Específico:**

   ```bash
   ftp -p porta nome-do-servidor
   ```

   Substitua `porta` pelo número da porta desejada.

### Comandos Básicos

3. **Listar Arquivos no Diretório Remoto:**

   ```bash
   ls
   ```

4. **Listar Arquivos Detalhadamente:**

   ```bash
   dir
   ```

5. **Navegar para um Diretório Remoto:**

   ```bash
   cd nome-do-diretorio
   ```

6. **Navegar para o Diretório Pai:**

   ```bash
   cd ..
   ```

7. **Navegar para o Diretório Raiz:**

   ```bash
   cd /
   ```

### Transferência de Arquivos do Cliente para o Servidor

8. **Transferir um Arquivo para o Servidor:**

   ```bash
   put nome-do-arquivo
   ```

9. **Transferir um Arquivo para o Servidor com Nome Diferente:**

    ```bash
    put nome-do-arquivo nome-no-servidor
    ```

10. **Transferir Múltiplos Arquivos para o Servidor:**

    ```bash
    mput *
    ```

11. **Transferir um Diretório para o Servidor (Recursivo):**

    ```bash
    put -r nome-do-diretorio
    ```

### Transferência de Arquivos do Servidor para o Cliente

12. **Transferir um Arquivo do Servidor para o Cliente:**

    ```bash
    get nome-do-arquivo
    ```

14. **Transferir Múltiplos Arquivos do Servidor para o Cliente:**

    ```bash
    mget *
    ```

### Informações e Configurações

15. **Exibir Informações sobre a Sessão Atual:**

    ```bash
    status
    ```

16. **Alterar o Modo de Transferência para Binário:**

    ```bash
    binary
    ```

17. **Alterar o Modo de Transferência para Texto:**

    ```bash
    ascii
    ```

### Encerrando a Sessão

18. **Encerrar a Sessão FTP:**

    ```bash
    bye
    ```
