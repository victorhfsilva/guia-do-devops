
## O que é um Pod?

Um **Pod** é a menor e mais simples unidade de implantação no Kubernetes. Ele representa **um ou mais containers** que compartilham:

- **Rede (IP e porta)**
    
- **Sistema de arquivos (volumes)**
    
- **Ciclo de vida**
    
- **Namespace**
    

> Pense em um Pod como um “envelope” que agrupa containers fortemente acoplados que **precisam estar juntos para funcionar**.

---

## **Características dos Pods**

|Característica|Descrição|
|---|---|
|Unidade básica|É o menor objeto criado pelo Kubernetes|
|Compartilhamento de rede|Todos os containers do Pod compartilham IP, porta e localhost|
|Armazenamento|Compartilham volumes definidos no Pod|
|Namespaced|Pods existem dentro de namespaces e o nome deve ser único por namespace|
|Efêmero por padrão|Se um Pod falha, ele não é recriado automaticamente sem outro recurso (ex: Deployment)|

---

## **Quando usar mais de um container em um Pod?**

- Containers com **forte acoplamento**
    
- Padrão **Sidecar** (ex: proxy, logger)
    
- **Init Containers**: executados antes dos containers principais
    
- **Ephemeral Containers**: usados para debug (temporários)
    

---

## **Criando Pods**

### 1. Usando `kubectl run` (modo imperativo)

```bash
kubectl run nginx-pod --image=nginx:latest --port=80
```

> Cria um Pod chamado `nginx-pod` com um container baseado na imagem `nginx`.

---

### 2. Usando YAML (modo declarativo)

```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  namespace: default
  labels:
    role: frontend
spec:
  containers:
    - name: web
      image: nginx:latest
      ports:
        - name: http
          containerPort: 80
```

Criação via terminal:

```bash
kubectl apply -f pod.yaml
```

---

## **Gerenciamento de Pods**

|Ação|Comando|
|---|---|
|Listar Pods|`kubectl get pods -n <namespace>`|
|Detalhes do Pod|`kubectl describe pod <nome> -n <namespace>`|
|Ver logs do Pod|`kubectl logs <nome> -n <namespace>`|
|Acessar Pod (bash/sh)|`kubectl exec -it <nome> -n <ns> -- /bin/bash` ou `/bin/sh`|
|Editar Pod (em tempo real)|`kubectl edit pod <nome> -n <namespace>`|
|Excluir Pod|`kubectl delete pod <nome> -n <namespace>`|
|Excluir imediatamente|`kubectl delete pod <nome> --grace-period=0 --force`|

---

## **Comandos úteis com exemplos**

### Ver todos os Pods em todos os namespaces:

```bash
kubectl get pods --all-namespaces
```

### Executar comandos em um Pod:

```bash
kubectl exec -it static-web -- bash
```

> `-i` envia input, `-t` abre terminal TTY

---

## **Criação de Pods com múltiplos containers**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "while true; do echo 'App running'; sleep 10; done"]
    - name: logger
      image: busybox
      command: ["sh", "-c", "while true; do echo 'Logger ativo'; sleep 5; done"]
```

---

## **Init Containers**

Executam antes dos containers principais, ideal para:

- Verificar dependências
    
- Realizar inicializações específicas
    

```yaml
initContainers:
  - name: init-db
    image: busybox
    command: ['sh', '-c', 'echo init > /init.txt']
```

---

## **Ephemeral Containers (debug)**

Exemplo de debug em um Pod rodando:

```bash
kubectl debug -it nome-do-pod --image=busybox --target=nome-do-container
```

> Requer o `EphemeralContainers` habilitado no cluster.

---

## **Importante: Pods ≠ Containers**

- O **Kubernetes não gerencia containers diretamente**, mas sim **Pods**
    
- É o **Kubelet** que conversa com o runtime de containers (ex: containerd)
    
- **Deployments** ou **ReplicaSets** são usados para **replicação automática** e atualização de Pods
    

---

## **Limitações dos Pods**

|Limitação|Melhor solução|
|---|---|
|Não se replicam sozinhos|Use **Deployment** para múltiplas réplicas|
|Sem auto-recuperação completa|Use **ReplicaSet** ou **StatefulSet** para resiliência|
|Não expõem rede automaticamente|Use um **Service** para tornar o Pod acessível|

---
