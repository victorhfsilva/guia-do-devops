
## Introdução

Toda aplicação precisa ser configurada. Em ambientes Kubernetes, **não é uma boa prática embutir essas configurações no código-fonte**. Em vez disso, o ideal é externalizar essas informações, tornando sua aplicação mais flexível, segura e reutilizável.

Kubernetes fornece dois recursos fundamentais para isso:

|Recurso|Uso|
|---|---|
|**ConfigMap**|Armazenar dados de configuração **não sensíveis**|
|**Secret**|Armazenar **informações sensíveis** como senhas, tokens, certificados|

---

## ConfigMaps

### O que são

Um **ConfigMap** é um objeto do Kubernetes usado para armazenar pares chave-valor que representam **dados de configuração não sensíveis**. Pode ser usado para:

- Injetar variáveis de ambiente nos Pods
    
- Montar arquivos de configuração no sistema de arquivos do container
    
- Compartilhar configurações entre múltiplos Pods
    

---

### Criando um ConfigMap a partir de arquivo

#### Exemplo: `nginx.conf`

```bash
kubectl create configmap nginx-conf \
  --from-file=./configmaps/nginx.conf \
  -n production
```

Isso criará um ConfigMap onde a chave é `nginx.conf` e o valor é o conteúdo do arquivo.

---

### Exemplo em YAML (`configmap.yaml`)

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-conf
  namespace: production
data:
  nginx.conf: |
    user nginx;
    worker_processes 1;
    events {
      worker_connections 1024;
    }
    http {
      server {
        listen 80;
        server_name localhost;
        location / {
          root /usr/share/nginx/html;
          index index.html index.htm;
        }
      }
    }
```

---

### Usando o ConfigMap em um Pod

#### Exemplo de uso como Volume (`deployment-cm.yaml`)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment-cm
  namespace: production
spec:
  replicas: 1
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
        volumeMounts:
        - name: nginx-config
          mountPath: /config
      volumes:
      - name: nginx-config
        configMap:
          name: nginx-conf
```

#### Teste:

```bash
kubectl exec -it <pod-name> -n production -- cat /config/nginx.conf
```

---

## Secrets

### O que são

**Secrets** armazenam dados sensíveis como:

- Senhas
    
- Chaves de API
    
- Certificados SSL
    
- Credenciais para registries privados
    

O Kubernetes trata Secrets com mais cuidado que ConfigMaps:

- São armazenadas codificadas em Base64
    
- Podem ser criptografadas no `etcd`
    
- Permitem integração com sistemas de cofre (HashiCorp Vault, AWS Secrets Manager etc.)
    

---

### Tipos de Secrets

| Tipo                             | Finalidade                                         |
| -------------------------------- | -------------------------------------------------- |
| `Opaque`                         | Padrão, aceita qualquer chave/valor                |
| `kubernetes.io/basic-auth`       | Para autenticação básica (usuário/senha)           |
| `kubernetes.io/tls`              | Para armazenar certificados e chaves TLS           |
| `kubernetes.io/dockerconfigjson` | Para autenticação em container registries privados |

---

### Exemplo: Secret básica (`secret.yaml`)

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-basic-auth
  namespace: production
type: kubernetes.io/basic-auth
stringData:
  username: admin
  password: t0p-Secret
```

---

### Criando uma Secret com `kubectl`

```bash
kubectl create secret generic db-secret \
  --from-literal=username=dbuser \
  --from-literal=password=SuperS3cret \
  -n production
```

---

### Usando Secrets em um Pod (via variável de ambiente)

```yaml
env:
- name: DB_USER
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: username
- name: DB_PASS
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: password
```

---

### Usando Secrets como Volume

```yaml
volumeMounts:
- name: cert-volume
  mountPath: "/tls"
  readOnly: true
volumes:
- name: cert-volume
  secret:
    secretName: certificado-tls
```

---

## Criando Secrets com Certificados TLS

### Gerando certificado autoassinado:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=www.example.com"
```

### Criando a Secret:

```bash
kubectl create secret tls certificado \
  --key=tls.key --cert=tls.crt \
  -n production
```

---

## Secrets para Registries Privados

### Criando Secret:

```bash
kubectl create secret docker-registry pull-secret \
  --docker-username=USUARIO \
  --docker-password=SENHA \
  --docker-email=email@exemplo.com \
  -n production
```

### Usando no Pod:

```yaml
spec:
  imagePullSecrets:
  - name: pull-secret
```

---

## Verificando ConfigMaps e Secrets

- Listar:
    

```bash
kubectl get configmaps -n production
kubectl get secrets -n production
```

- Descrever:
    

```bash
kubectl describe configmap nginx-conf -n production
kubectl describe secret db-secret -n production
```

- Ver conteúdo codificado:
    

```bash
kubectl get secret db-secret -o yaml -n production
```

- Decodificar Base64:
    

```bash
echo 'YWRtaW4=' | base64 -d
```

---

## Conclusão

ConfigMaps e Secrets permitem **separar lógica de código da configuração**, o que facilita:

- Reutilização de imagens entre ambientes (dev, staging, prod)
    
- Gerenciamento de credenciais com segurança
    
- Personalização de configurações via Kubernetes, sem rebuilds
    

**Boas práticas:**

- Não codifique segredos no código-fonte
    
- Use RBAC para limitar acesso a Secrets
    
- Ative criptografia de Secrets no etcd (recomendado para produção)
    

---

