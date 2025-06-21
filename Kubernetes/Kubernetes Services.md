#k8s

## O que é um Service?

No Kubernetes, um **Service** é um recurso responsável por fornecer **um ponto de acesso estável e confiável** para Pods que executam uma aplicação.

Isso resolve um problema crítico: os Pods são **efêmeros** e podem ser recriados com novos IPs a qualquer momento (ex: após uma atualização via Deployment). Um Service abstrai esse comportamento instável com:

- **Um IP fixo dentro do cluster**
    
- **Um nome DNS**
    
- **Balanceamento de carga entre os Pods selecionados**
    

---

## Como um Service funciona?

- Usa **selectors** (rótulos/labels) para localizar os Pods que ele deve "apontar"
    
- Usa o **Endpoint Controller** para manter uma lista atualizada dos Pods ativos
    
- Pode ser exposto **internamente** (ClusterIP) ou **externamente** (NodePort, LoadBalancer)
    

---

## Estrutura Básica de um Service YAML

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nome-do-service
spec:
  type: ClusterIP
  selector:
    app: minha-app
  ports:
    - name: http
      port: 80         # Porta "vista" pelo cliente
      targetPort: 8080 # Porta usada no container
```

---

## Tipos de Services

### 1. **ClusterIP (padrão)**

Cria um IP e DNS **acessíveis apenas dentro do cluster**.

✅ Ideal para comunicação entre microsserviços internos.

```yaml
spec:
  type: ClusterIP
  selector:
    app: backend
  ports:
    - port: 80
      targetPort: 8080
```

📌 DNS gerado: `backend.default.svc.cluster.local`

---

### 2. **NodePort**

Expõe o Service em **todas as interfaces dos nodes**, usando uma porta TCP entre `30000-32767`.

✅ Útil para testes locais ou clusters on-premises.

```yaml
spec:
  type: NodePort
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

📌 Acesso via: `http://<NodeIP>:30080`

---

### 3. **LoadBalancer**

Cria um Load Balancer externo automaticamente (em nuvens compatíveis: AWS, Azure, GCP).

✅ Recomendado para ambientes de produção em cloud.

```yaml
spec:
  type: LoadBalancer
  selector:
    app: frontend
  ports:
    - port: 80
      targetPort: 80
```

📌 O provedor de nuvem provisionará um **External IP** automaticamente.

---

### 4. **ExternalName**

Mapeia um Service para um nome DNS externo (não cria IP nem Proxy).

✅ Ideal para integrar recursos externos, como bancos de dados ou APIs legadas.

```yaml
spec:
  type: ExternalName
  externalName: banco.mysql.rds.amazonaws.com
```

📌 O DNS `external-db.default.svc.cluster.local` resolve para o host externo.

---

### 5. **Headless Service**

Service **sem IP fixo nem proxy**. Ele apenas registra o nome DNS, apontando diretamente para os Pods (útil para StatefulSets).

✅ Útil para aplicações que exigem conhecimento direto dos Pods, como bancos de dados distribuídos.

```yaml
spec:
  clusterIP: None
  selector:
    app: cassandra
  ports:
    - port: 9042
      targetPort: 9042
```

📌 O DNS resolve para **cada Pod individualmente**, não para um único IP.

---

##  Exemplo Prático: Service + Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
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
          image: nginx
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
    - port: 80
      targetPort: 80
```

> O Service vai automaticamente direcionar o tráfego para os Pods criados pelo Deployment.

---

## Boas Práticas

|Boas práticas|Por quê|
|---|---|
|Sempre use `labels` claras|Facilita a associação entre Pods e Services|
|Não exponha diretamente com NodePort em produção|Prefira LoadBalancer ou Ingress|
|Use `headless` para StatefulSets|Evita problemas com balanceamento em serviços com estado|
|Combine com `NetworkPolicies`|Para limitar quem pode acessar o Service|
|Use nomes DNS internos|Mais resilientes do que IPs fixos|

---

## Consultas Úteis

```bash
kubectl get svc                      # Lista todos os Services
kubectl describe svc nome-do-service  # Detalhes e endpoints associados
kubectl get endpoints nome-do-service # Ver IPs dos Pods ligados ao Service
```

---

##  Conclusão

Services são **fundamentais para comunicação entre componentes no Kubernetes**. Eles abstraem a volatilidade dos Pods e oferecem uma maneira limpa, escalável e segura de expor aplicações — tanto interna quanto externamente.

Compreender os diferentes tipos e aplicá-los corretamente garante alta disponibilidade, descoberta automática e balanceamento de carga eficiente.

---
