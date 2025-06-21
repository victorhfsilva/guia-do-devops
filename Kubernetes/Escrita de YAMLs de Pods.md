#k8s

Um Pod é definido no Kubernetes por meio de um arquivo YAML, que descreve **como** ele será criado, **quais containers** ele conterá, **quais portas exporá**, **volumes usados**, e **outras configurações específicas**.

---

## Estrutura Básica de um YAML de Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
  labels:
    app: minha-app
spec:
  containers:
    - name: meu-container
      image: nginx:latest
      ports:
        - containerPort: 80
  restartPolicy: Always
```

---

## Explicando Cada Bloco

### 🔹 `apiVersion`

Define a versão da API Kubernetes usada. Para Pods, geralmente:

```yaml
apiVersion: v1
```

---

### 🔹 `kind`

Especifica o tipo de objeto que está sendo criado:

```yaml
kind: Pod
```

---

### 🔹 `metadata`

Contém dados descritivos do recurso:

```yaml
metadata:
  name: meu-pod
  labels:
    app: nginx
```

- `name`: nome único do Pod no namespace.
    
- `labels`: pares chave-valor usados para identificar e selecionar Pods (ex: por Services, Deployments, etc.).
    

---

### 🔹 `spec`

Contém a **especificação** do Pod, ou seja, o que ele executa e como se comporta.

---

#### ▸ `containers`

Lista de containers executados no Pod:

```yaml
spec:
  containers:
    - name: app
      image: nginx:latest
      ports:
        - containerPort: 80
```

- `name`: nome do container (único dentro do Pod).
    
- `image`: imagem Docker a ser usada.
    
- `ports`: portas expostas pelo container.
    

---

#### ▸ `restartPolicy` (opcional)

Define como o Pod se comporta ao falhar:

```yaml
restartPolicy: Always  # default
```

Outras opções:

- `OnFailure`
    
- `Never`
    

---

### Pod com Dois Containers

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-multicontainer
spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
    - name: sidecar
      image: busybox
      command: ["sh", "-c", "while true; do echo sidecar ativo; sleep 10; done"]
```

---

###  Pod com Volume Compartilhado (`emptyDir`)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-com-volume
spec:
  containers:
    - name: nginx
      image: nginx:latest
      volumeMounts:
        - mountPath: /usr/share/nginx/html
          name: cache-volume
  volumes:
    - name: cache-volume
      emptyDir: {}
```

---

### Pod com `initContainers`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-com-init
spec:
  initContainers:
    - name: init-script
      image: busybox
      command: ["sh", "-c", "echo preparando ambiente"]
  containers:
    - name: nginx
      image: nginx
```

---

### Pod com `command` e `args`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-comando
spec:
  containers:
    - name: alpine
      image: alpine
      command: ["sh", "-c"]
      args: ["echo Hello Kubernetes && sleep 3600"]
```

---

### Pod com Variáveis de Ambiente

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-env
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "echo $MEU_NOME && sleep 3600"]
      env:
        - name: MEU_NOME
          value: "Victor"
```

---

### Pod com `readinessProbe` e `livenessProbe`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-healthcheck
spec:
  containers:
    - name: app
      image: nginx
      ports:
        - containerPort: 80
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

##  Boas Práticas ao Escrever YAMLs de Pods

|Prática|Por quê|
|---|---|
|Use `labels`|Permite seleção por Services e organizadores|
|Use nomes descritivos|Facilita identificação e depuração|
|Evite hardcode de dados sensíveis|Use `Secrets` e `ConfigMaps` para variáveis e credenciais|
|Sempre use `restartPolicy`|Define claramente o comportamento em falha|
|Separe `initContainers`|Para lógica de setup ou pré-validação antes de rodar a app|
|Teste seu YAML com `kubectl apply --dry-run=client -f arquivo.yaml`|Valida antes de aplicar|

---

