# Kubernetes 

## Serviços

### **Criar um Serviço**:

- **Usando YAML**:
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: nome-do-servico
  spec:
    selector:
      app: app-label
    ports:
      - protocol: TCP
        port: 80
  ```

- **Usando o comando kubectl**:
  ```bash
  kubectl create service clusterip nome-do-servico --tcp=80:8080
  ```

### **Listar Serviços**:

```bash
kubectl get services
```

### **Verificar Status do Serviço**:

```bash
kubectl get service nome-do-servico -o wide
``` 

### **Detalhes de um Serviço**:

```bash
kubectl describe service nome-do-servico
```

### **Excluir um Serviço**:

```bash
kubectl delete service nome-do-servico
```

### **Tipos de Serviço**:

- **ClusterIP**: O serviço é acessível somente internamente dentro do cluster.
- **NodePort**: O serviço é exposto em cada nó do cluster em uma porta estática.
- **LoadBalancer**: O provedor de nuvem cria um balanceador de carga externo para acessar o serviço.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: service-name
spec:
  type: ClusterIP
```

### **Selectors**:

- Use `selector` para direcionar o tráfego do serviço para todos os Pods com rótulos correspondentes.

- Por exemplo, se você tem vários Pods com o rótulo app: frontend, e você cria um serviço com o selector definido com o selector app: frontend, o serviço irá direcionar o tráfego para os Pods que possuem esse rótulo em específico.

*Pod:*
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: frontend-pod
  labels:
    app: frontend
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
      - containerPort: 80
```

*Serviço:*
```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  type: NodePort
  selector:
    app: frontend
  ports:
  - protocol: TCP
    port: 80
    nodePort: 30000
```

- `port`: Porta no serviço.
- `nodePort`: Porta no node (localhost)


