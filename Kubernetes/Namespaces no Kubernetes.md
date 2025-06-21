#k8s 

## O que são Namespaces?

**Namespaces** são divisões lógicas dentro de um cluster Kubernetes. Eles permitem **isolar e organizar recursos** de forma granular, facilitando o gerenciamento, a segurança e a governança de ambientes compartilhados.

---

## **Por que usar Namespaces?**

- **Isolamento lógico**: separa times, aplicações ou ambientes (ex: `dev`, `staging`, `prod`).
    
- **Gerenciamento de acesso (RBAC)**: regras podem ser aplicadas por namespace.
    
- **Reutilização de nomes**: objetos com o mesmo nome podem existir em namespaces diferentes.
    
- **Limites de recursos (Quota & LimitRange)**: possível aplicar limites por namespace.
    
- **Evita a criação de múltiplos clusters** para separar ambientes simples.
    

---

## **Namespaces Padrão do Kubernetes**

| Namespace         | Função                                                              |
| ----------------- | ------------------------------------------------------------------- |
| `default`         | Usado quando nenhum namespace é especificado                        |
| `kube-system`     | Contém os componentes internos do cluster (ex: CoreDNS, kube-proxy) |
| `kube-public`     | Pode ser acessado publicamente, até mesmo sem autenticação          |
| `kube-node-lease` | Utilizado para heartbeat dos nodes (desde Kubernetes 1.13+)         |

> **Atenção**: **Não crie recursos no `kube-system`**, exceto se for necessário manipular componentes do cluster.

---

## **Listando Namespaces e Recursos**

```bash
kubectl get namespaces               # Lista todos os namespaces
kubectl get all -n kube-system       # Lista todos os recursos do kube-system
kubectl get pods --all-namespaces   # Lista todos os pods em todos os namespaces
```

---

## **Criando Namespaces**

### 🔹 Via comando:

```bash
kubectl create namespace producao
```

### 🔹 Via arquivo YAML:

```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: producao
```

```bash
kubectl apply -f namespace.yaml
```

---

## **Usando Namespaces com Recursos**

Existem duas formas principais:

### 1. **Com a flag `-n` ou `--namespace`**

```bash
kubectl create deployment nginx --image=nginx -n producao
kubectl get pods -n producao
```

### 2. **Especificando no YAML**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: producao
spec:
  replicas: 2
  ...
```

---

## **Namespaces vs Recursos Globais**

Alguns recursos são **namespaced**, outros são **globais** (não vinculados a namespaces).

### 🔹 Listar recursos namespaced:

```bash
kubectl api-resources --namespaced=true
```

### 🔹 Listar recursos globais:

```bash
kubectl api-resources --namespaced=false
```

|Tipo de Recurso|Namespaced?|Exemplo|
|---|---|---|
|Pods, Deployments|Sim|`kubectl get pods -n x`|
|Nodes, PersistentVolumes|Não|`kubectl get nodes`|
|ClusterRole, StorageClass|Não|`kubectl get clusterrole`|

---

## **Isolamento entre Namespaces**

Namespaces não compartilham objetos entre si **por padrão**. Mas é possível:

- Restringir comunicação via **Network Policies**
    
- Aplicar **RBAC** separado por namespace
    
- Gerenciar consumo de recursos com **ResourceQuotas**
    

---

## **Exemplo de Política de Isolamento**

```yaml
# network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
  namespace: producao
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```

Essa política bloqueia toda comunicação com os pods no namespace `producao`.

---

## **Boas Práticas com Namespaces**

- Use namespaces para separar ambientes (`dev`, `qa`, `prod`)
    
-  Crie namespaces por time ou aplicação em ambientes compartilhados
    
- Combine namespaces com RBAC e Network Policies
    
- Evite usar o namespace `default` para aplicações reais
    
- Use `ResourceQuota` e `LimitRange` para limitar uso de CPU/memória
    

---
