# Kubernetes

## Definição YAML de Pods

Aqui está um exemplo sobre a definição YAML de Pods no Kubernetes:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nome-do-pod
  labels:
    chave1: valor1
    chave2: valor2
spec:
  containers:
  - name: nome-do-container
    image: nome-da-imagem
    ports:
    - containerPort: 80
  restartPolicy: Always
```

### Cabeçalho do Pod:

- `apiVersion`: Versão da API do Kubernetes usada para criar o recurso. Para Pods, é geralmente `v1`.
- `kind`: Tipo do recurso, que neste caso é `Pod`.

### Metadados do Pod:

```yaml
metadata:
  name: nome-do-pod
  labels:
    chave1: valor1
    chave2: valor2
```

- `name`: Nome único do Pod.
- `labels`: Rótulos atribuídos ao Pod para identificação e seleção.

### Especificação do Pod:

```yaml
spec:
  containers:
  - name: nome-do-container
    image: nome-da-imagem
    ports:
    - containerPort: 80
  restartPolicy: Always
```

- `containers`: Lista de contêineres dentro do Pod.
  - `name`: Nome do contêiner.
  - `image`: Imagem do contêiner a ser executada.
  - `ports`: Lista de portas expostas pelo contêiner.
    - `containerPort`: Porta exposta pelo contêiner.
- `restartPolicy`: Política de reinicialização do Pod em caso de falha.

### Exemplos Adicionais:

#### Pod com Dois Contêineres:

```yaml
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80
  - name: busybox-container
    image: busybox:latest
    command: ['sh', '-c', 'echo Hello from the second container']
```

#### Pod com Volume Montado:

```yaml
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80
  volumes:
  - name: meu-volume
    emptyDir: {}
```

#### Pod com Política de Reinicialização Diferente:

```yaml
spec:
  containers:
  - name: meu-container
    image: minha-imagem
  restartPolicy: OnFailure
```

Claro, aqui estão os tópicos sobre como executar o YAML de definição de Pod no Kubernetes:

### Executando o YAML de Definição de Pod

1. **Salvar o Arquivo YAML**: Baixe ou crie um arquivo YAML com a definição do Pod.

2. **Acessar o Cluster Kubernetes**: Certifique-se de estar conectado ao cluster Kubernetes onde deseja criar o Pod. Você pode usar o `kubectl` para gerenciar o cluster.

3. **Aplicar o YAML**: Use o comando `kubectl apply` seguido do caminho para o arquivo YAML para criar o Pod no cluster.

   ```bash
   kubectl apply -f caminho/para/arquivo.yaml
   ```

4. **Verificar o Pod**: Após aplicar o YAML, verifique se o Pod foi criado com sucesso usando o comando `kubectl get pods`.

   ```bash
   kubectl get pods
   ```

5. **Obter Detalhes do Pod**: Se desejar mais detalhes sobre o Pod recém-criado, use o comando `kubectl describe` seguido do nome do Pod.

   ```bash
   kubectl describe pod nome-do-pod
   ```

6. **Interagir com o Pod**: Você pode interagir com o Pod de várias maneiras, como visualizar logs, executar comandos dentro do contêiner, etc.

   - **Visualizar Logs**:
     ```bash
     kubectl logs nome-do-pod
     ```

   - **Acessar o Terminal do Contêiner**:
     ```bash
     kubectl exec -it nome-do-pod -- /bin/sh
     ```

7. **Atualizar o Pod (Opcional)**: Se você modificar o arquivo YAML do Pod e desejar aplicar essas alterações, basta reaplicar o YAML usando `kubectl apply`.

   ```bash
   kubectl apply -f caminho/para/arquivo-atualizado.yaml
   ```
