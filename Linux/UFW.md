# Firewall UFW (Uncomplicated Firewall)

O UFW (Uncomplicated Firewall) é uma ferramenta de firewall fácil de usar para gerenciar as regras de firewall no Linux. Aqui está um cheatsheet com comandos úteis do UFW:

### Configuração Básica

1. **Habilitar o UFW:**

   ```bash
   sudo ufw enable
   ```

2. **Desabilitar o UFW:**

   ```bash
   sudo ufw disable
   ```

3. **Verificar o Status do UFW:**

   ```bash
   sudo ufw status
   ```

4. **Resetar Todas as Regras (CUIDADO - Remove todas as regras):**

   ```bash
   sudo ufw reset
   ```

### Regras Básicas

5. **Permitir Tráfego em uma Porta (ex: SSH - Porta 22):**

   ```bash
   sudo ufw allow 22
   ```

6. **Permitir Tráfego UDP (ex: DNS - Porta 53):**

   ```bash
   sudo ufw allow 53/udp
   ```

7. **Negar Tráfego em uma Porta:**

   ```bash
   sudo ufw deny 25
   ```

### Aplicações Pré-Configuradas

8. **Permitir SSH (Porta 22):**

    ```bash
    sudo ufw allow ssh
    ```

9. **Permitir HTTP (Porta 80):**

    ```bash
    sudo ufw allow http
    ```

10. **Permitir HTTPS (Porta 443):**

    ```bash
    sudo ufw allow https
    ```

### Configurações Avançadas

11. **Definir uma Regra por Número de Ordem:**

    ```bash
    sudo ufw insert 1 allow 8080
    ```

12. **Apagar uma Regra por Número de Ordem:**

    ```bash
    sudo ufw delete 1
    ```

13. **Definir uma Política Padrão (ex: Negar Tudo):**

    ```bash
    sudo ufw default deny
    ```

14. **Permitir Tráfego de um Endereço IP Específico:**

    ```bash
    sudo ufw allow from 192.168.1.2
    ```

    ```bash
    sudo ufw allow from 203.0.113.4 to any port 22
    ```
    
15. **Limitar Número de Conexões por Minuto:**

    ```bash
    sudo ufw limit 22
    ```

16. **Habilitar Logging de Pacotes Negados:**

    ```bash
    sudo ufw logging on
    ```

### Reiniciando o UFW

17. **Reiniciar o UFW:**

    ```bash
    sudo ufw reload
    ```

18. **Reiniciar Todas as Regras (CUIDADO - Remove e Aplica Todas as Regras):**

    ```bash
    sudo ufw reload
    ```