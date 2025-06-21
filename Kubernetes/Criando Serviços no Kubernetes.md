#k8s 

## Objetivo

**Services** são essenciais para que aplicações no Kubernetes possam se comunicar. Eles fornecem:

- Um **IP virtual estável** para acessar os Pods, mesmo que seus IPs mudem
    
- Um **nome DNS interno**
    
- **Balanceamento de carga** entre os Pods correspondentes
    

---

## Passo 1 – Criar um Deployment com Pods que queremos expor

Crie um Deployment que gere múltiplos Pods. Exemplo com a aplicação [`traefik/whoami`](https://hub.docker.com/r/traefik/whoami), que retorna informações do ambiente ao ser acessada:

```yaml
# whoami-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoami-deployment
  namespace: production
  labels:
    app: whoami
spec:
  replicas: 2
  selector:
    matchLabels:
      app: whoami
  template:
    metadata:
      labels:
        app: whoami
    spec:
      containers:
        - name: whoami
          image: traefik/whoami:v1.8.0
          ports:
            - containerPort: 80
```

> A label `app: whoami` será usada para o _selector_ do Service.

Crie o Deployment:

```bash
kubectl apply -f whoami-deployment.yaml
```

---

## Passo 2 – Criar o Service

Agora, crie um Service do tipo **ClusterIP** para expor os Pods **dentro do cluster**:

```yaml
# whoami-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: whoami-service
  namespace: production
spec:
  selector:
    app: whoami
  type: ClusterIP
  ports:
    - name: http
      port: 80
      targetPort: 80
```

> Esse Service seleciona todos os Pods com `app: whoami` e os expõe em `port: 80`.

Aplique o Service:

```bash
kubectl apply -f whoami-service.yaml
```

---

## Passo 3 – Verifique o funcionamento

Liste os Pods criados:

```bash
kubectl get pods -n production
```

Liste o Service e veja o IP interno:

```bash
kubectl get svc whoami-service -n production
kubectl describe svc whoami-service -n production
```

> Veja os **endpoints** (IPs dos Pods conectados ao Service) e o **ClusterIP** atribuído.

---

## Passo 4 – Testar o Service de dentro do Cluster

Como a imagem `traefik/whoami` não tem shell, crie um Pod com uma imagem interativa como `nginx` ou `busybox`:

```yaml
# pod-nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  namespace: production
spec:
  containers:
    - name: nginx
      image: nginx
      command: ["sleep", "infinity"]
```

Crie o Pod:

```bash
kubectl apply -f pod-nginx.yaml
```

Acesse o shell do Pod:

```bash
kubectl exec -it static-web -n production -- bash
```

Teste o Service com `curl`:

```bash
apt update && apt install -y curl  # Se necessário
curl http://whoami-service
```

> Você verá o nome do Pod que respondeu. Repetindo várias vezes, diferentes Pods responderão, confirmando o balanceamento de carga.

---

## Passo 5 – Testar o Service com `port-forward` (fora do cluster)

Crie um túnel local:

```bash
kubectl port-forward svc/whoami-service 8080:80 -n production
```

Acesse em seu navegador:

```http
http://localhost:8080
```

---

## Dica: Acesso via DNS interno

Todo Service no Kubernetes tem um DNS interno com o padrão:

```
<nome-do-service>.<namespace>.svc.cluster.local
```

No nosso exemplo:

- **whoami-service.production.svc.cluster.local**
    
- Ou, simplificadamente, apenas **whoami-service** se estiver no mesmo namespace.
    

Dentro do Pod de teste, execute:

```bash
curl http://whoami-service.production
```

---

## Reutilizando Selectors

O _selector_ do Service deve bater com as `labels` definidas no Deployment:

```yaml
# No Deployment
metadata:
  labels:
    app: whoami
# No Service
spec:
  selector:
    app: whoami
```

> Isso permite que o Kubernetes associe os Pods corretos ao Service automaticamente.

---

## Tipos Alternativos de Service

Se quiser expor sua aplicação para fora do cluster:

- **NodePort**: Acessível via IP do Node + porta alta (ex: 30080)
    
- **LoadBalancer**: Usado em nuvens para provisionar IP externo público
    
- **ExternalName**: Aponta para DNS externos
    
- **Headless (`clusterIP: None`)**: Usado em bancos distribuídos ou StatefulSets
    

---

## Conclusão

Criar Services é fundamental para tornar suas aplicações **acessíveis e escaláveis** dentro do Kubernetes.

Ao seguir este fluxo:

1. Crie um Deployment com rótulos (labels)
    
2. Crie um Service com selectors compatíveis
    
3. Teste com `curl`, DNS ou `port-forward`
    

Você terá um ambiente funcional e pronto para crescer com segurança.

---

