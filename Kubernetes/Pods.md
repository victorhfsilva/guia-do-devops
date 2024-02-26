# Kubernetes 

## Criação e Gerenciamento de Pods

### O que são Pods?

- **Unidade básica**: Um Pod é a menor unidade computacional no Kubernetes, representando um único processo em um cluster.
  
- **Agrupamento de Containers**: Ele encapsula um ou mais contêineres, armazenando recursos compartilhados, como volumes, endereço IP e espaço de armazenamento.

- **Comunicação e Coordenação**: Os contêineres em um Pod compartilham o mesmo espaço de rede e podem se comunicar facilmente entre si através de localhost.

- **Ciclo de Vida**: Os Pods são escaláveis e podem ser replicados, reiniciados e movidos entre nós do cluster conforme necessário.

- **Abstração de Implantação**: São utilizados para implantar e gerenciar aplicações no Kubernetes, representando a menor unidade gerenciável de implantação.

### Criação de um Pod:

1. **Usando YAML**:
   
   Crie um arquivo YAML com a definição do Pod e use o comando `kubectl apply` para criar o Pod a partir deste arquivo.
   
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: meu-pod
   spec:
     containers:
     - name: meu-container
       image: nome-da-imagem
   ```

    #### Aplicar uma Configuração em um Pod:

    Use o comando `kubectl apply` para aplicar uma configuração contida em um arquivo YAML a um Pod.

    ```
    kubectl apply -f nome-do-arquivo.yaml
    ```

2. **Usando o comando kubectl**:
   
   Use o comando `kubectl run` para criar um Pod de forma imperativa.
   
   ```
   kubectl run meu-pod --image=nome-da-imagem
   ```

    Exemplo:

    ```
    kubectl run nginx-test --image=nginx:latest
    ```

### Edição de um Pod:

Use o comando `kubectl edit pod` seguido do nome do Pod para editá-lo.

```
kubectl edit pod nome-do-pod
```


### Exclusão de um Pod:

Use o comando `kubectl delete pod` seguido do nome do Pod para excluí-lo.

```
kubectl delete pod nome-do-pod
```

#### Forçar a Exclusão de um Pod:

Use o comando `kubectl delete pod` com as opções `--grace-period=0 --force` para forçar a exclusão imediata de um Pod.

```
kubectl delete pod nome-do-pod --grace-period=0 --force
```


### Informações sobre os pods:

#### Listar Pods:

Use o comando `kubectl get pods` para listar todos os Pods no cluster.

```
kubectl get pods
```

#### Verificar o Status de um Pod:

Use o comando `kubectl get pod` com a opção `-o wide` para obter informações detalhadas sobre o estado de um Pod.

```
kubectl get pod nome-do-pod -o wide
```

#### Detalhes de um Pod específico:

Use o comando `kubectl describe` seguido do nome do Pod para obter detalhes específicos sobre um Pod.

```
kubectl describe pod nome-do-pod
```

#### Logs de um Pod:

Use o comando `kubectl logs` seguido do nome do Pod para visualizar os logs do Pod.

```
kubectl logs nome-do-pod
```

### Executando comandos:

#### Executar Comandos em um Container dentro de um Pod:

Use o comando `kubectl exec` seguido do nome do Pod e do comando desejado para executar comandos dentro de um Container.

```
kubectl exec nome-do-pod -- comando
```

#### Acessar o Terminal de um Container dentro de um Pod:

Use o comando `kubectl exec` para acessar o terminal de um Container dentro de um Pod.

```
kubectl exec -it nome-do-pod -- /bin/sh
```

### Escalonamento de um Pod (adicionar réplicas):

Use o comando `kubectl scale` para aumentar ou diminuir o número de réplicas de um Pod.

```
kubectl scale --replicas=3 deployment/nome-do-deployment
```




### Criando um Pod com Porta Exposta:

Defina a porta que deseja expor no arquivo YAML do Pod.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
  - name: meu-container
    image: nome-da-imagem
    ports:
    - containerPort: 80
```

Isso criará um Pod com o Container expondo a porta 80.