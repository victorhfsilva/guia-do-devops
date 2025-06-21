#k8s
## O que é um Deployment?

Um **Deployment** é um recurso do Kubernetes usado para **gerenciar a criação e atualização de múltiplos Pods** de forma declarativa, garantindo:

- **Alta disponibilidade**
    
- **Escalabilidade horizontal**
    
- **Atualizações sem downtime**
    
- **Rollback automático**
    

---

## Relação entre Deployment, ReplicaSet e Pods

```text
Deployment → ReplicaSet → Pod(s)
```

- **Pod**: Executa os containers.
    
- **ReplicaSet**: Garante um número fixo de réplicas de Pods.
    
- **Deployment**: Gerencia ReplicaSets e permite atualizações e rollbacks com segurança.
    

---

## Exemplo Básico de YAML de Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: production
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
            - containerPort: 80
```

> Esse Deployment cria 3 Pods com a imagem `nginx:1.14.2`, todos com a label `app: nginx`.

Para aplicar o deployment basta:

```bash
kubectl -f deployment.yaml -n <namespace> --save-config
```

A opção `--save-config` foi adicionada para que as configurações definidas no arquivo sejam salvas no objeto, assim poderemos aplicar atualizações neste deployment.

---

## Componentes do YAML de Deployment

|Campo|Descrição|
|---|---|
|`apiVersion`|Versão da API usada (para Deployment: `apps/v1`)|
|`kind`|Tipo do recurso (`Deployment`)|
|`metadata`|Nome e labels do Deployment|
|`spec.replicas`|Quantidade de réplicas desejadas|
|`spec.selector`|Define quais Pods o ReplicaSet gerado deve controlar|
|`spec.template`|Modelo de Pod a ser criado pelo ReplicaSet|
|`spec.template.spec.containers`|Lista de containers que o Pod irá executar|

---

## Estratégias de Atualização

### 🔹 `RollingUpdate` (padrão)

Atualiza os Pods gradualmente. Permite atualização sem downtime (zero-downtime rollout).

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1         # Pods acima do desejado permitidos temporariamente
    maxUnavailable: 1   # Pods que podem ficar indisponíveis durante o update
```

### 🔹 `Recreate`

Para todos os Pods antigos antes de criar novos. Causa downtime.

```yaml
strategy:
  type: Recreate
```

---

## Exemplo com Estratégia de Atualização

```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 25%
```

---

## Atualizando um Deployment (exemplo de troca de imagem)

Altere no YAML:

```yaml
image: nginx:1.21.0
```

E re-aplique:

```bash
kubectl apply -f deployment.yaml
```

Kubernetes criará um **novo ReplicaSet** com os Pods atualizados e removerá os antigos gradualmente.

---

## Histórico de Revisões e Rollbacks

### 🔹 Ver o histórico de versões:

```bash
kubectl rollout history deployment nginx-deployment
```

### 🔹 Fazer rollback para a versão anterior:

```bash
kubectl rollout undo deployment nginx-deployment
```

### 🔹 Fazer rollback para uma versão específica:

```bash
kubectl rollout undo deployment nginx-deployment --to-revision=2
```

---

## Consultando o Status do Deployment

```bash
kubectl get deployments
kubectl describe deployment nginx-deployment
```

Você verá:

- A estratégia usada
    
- Quantidade de réplicas desejadas e disponíveis
    
- Histórico de eventos (criação, escalonamento, atualizações)
    

---

## Exemplos Avançados

### Deployment com variáveis de ambiente

```yaml
containers:
  - name: web
    image: nginx
    env:
      - name: AMBIENTE
        value: "producao"
```

---

### Deployment com readiness e liveness probes

```yaml
containers:
  - name: web
    image: nginx
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 15
      periodSeconds: 20
```

---

### Deployment com montagem de volume

```yaml
spec:
  volumes:
    - name: html
      emptyDir: {}
  containers:
    - name: web
      image: nginx
      volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: html
```

---

## Boas Práticas com Deployments

|Boas práticas|Por quê|
|---|---|
|Use `RollingUpdate`|Evita downtime durante atualizações|
|Aplique `livenessProbe`/`readinessProbe`|Aumenta confiabilidade e evita falhas silenciosas|
|Separe YAMLs por ambiente|Um `deployment-dev.yaml`, `deployment-prod.yaml`, etc.|
|Use `ConfigMaps` e `Secrets`|Evita hardcoding de configs e senhas|
|Mantenha controle de versão dos YAMLs|Facilita rollback e histórico|

---
