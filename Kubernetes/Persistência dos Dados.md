#k8s 

## Conceito Geral

No Kubernetes, aplicações são classificadas em dois grandes grupos:

- **Sem estado (stateless)**: não mantêm dados entre reinicializações (ex: frontend de um site).
    
- **Com estado (stateful)**: armazenam dados em disco, como bancos de dados, caches ou serviços que manipulam arquivos.
    

Contêineres, por definição, são efêmeros. Se um Pod é reiniciado, **tudo que estava gravado localmente é perdido** (porque o sistema de arquivos é temporário). Para lidar com essa limitação, o Kubernetes oferece recursos nativos de persistência.

---

## Tipos de Armazenamento no Kubernetes

### 🔹 Volumes Efêmeros (`emptyDir`, `hostPath`, `configMap`, `secret`)

- Criados junto com o Pod, desaparecem quando o Pod morre.
    
- Úteis para cache ou comunicação entre contêineres de um mesmo Pod.
    

### 🔹 Volumes Persistentes (PV + PVC)

- **Persistent Volume (PV)**: volume real, alocado no cluster (manual ou dinâmico).
    
- **Persistent Volume Claim (PVC)**: solicitação de uso de armazenamento feita pela aplicação.
    
- Permitem que dados sobrevivam a reinícios, realocação e upgrades.
    

---

## Estrutura de Persistência

### 1. **Persistent Volume (PV)**

Recurso do cluster que representa o volume de disco disponível.

### 2. **Persistent Volume Claim (PVC)**

Recurso criado pela aplicação para requisitar um volume específico.

### 3. **StorageClass**

Define como os PVs são dinamicamente provisionados. Pode descrever diferentes “classes de armazenamento” como SSD, HDD, provisionamento manual ou automático.

---

## Exemplo Completo

### 📌 StorageClass (`storageclass.yaml`)

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: rancher.io/local-path
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

### 📌 PersistentVolumeClaim (`pvc.yaml`)

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dados-web
  namespace: production
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: fast-storage
  volumeMode: Filesystem
```

### 📌 Pod com Volume (`pod.yaml`)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-com-dados
  namespace: production
spec:
  containers:
  - name: web
    image: nginx
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: volume-web
  volumes:
  - name: volume-web
    persistentVolumeClaim:
      claimName: dados-web
```

---

## Modos de Acesso (AccessModes)

| Modo            | Descrição                                                |
| --------------- | -------------------------------------------------------- |
| `ReadWriteOnce` | Um único Pod pode montar o volume em leitura e escrita   |
| `ReadOnlyMany`  | Vários Pods podem montar o volume em **leitura somente** |
| `ReadWriteMany` | Vários Pods podem montar o volume em leitura e escrita   |

---

## Bindings de Volume

|Modo|Descrição|
|---|---|
|`Immediate`|Volume é provisionado assim que o PVC é criado|
|`WaitForFirstConsumer`|Volume só é provisionado quando um Pod consome o PVC|

---

## StatefulSets: Para Aplicações com Estado

Enquanto `Deployments` são usados para workloads stateless, **StatefulSets** são apropriados para aplicações que precisam de:

- Nomes fixos para os Pods
    
- Ordens de inicialização
    
- Um volume dedicado e fixo por Pod
    

### Exemplo de StatefulSet com PVC

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: banco
  namespace: production
spec:
  serviceName: "banco"
  replicas: 1
  selector:
    matchLabels:
      app: banco
  template:
    metadata:
      labels:
        app: banco
    spec:
      containers:
      - name: postgres
        image: postgres
        ports:
        - containerPort: 5432
        volumeMounts:
        - name: dados-banco
          mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
  - metadata:
      name: dados-banco
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

---

## Como Verificar

- Ver todos os volumes persistentes criados:
    

```bash
kubectl get pv
```

- Ver todas as requisições de volumes:
    

```bash
kubectl get pvc -n production
```

- Descrever detalhes de um PVC:
    

```bash
kubectl describe pvc dados-web -n production
```

---

## Considerações Importantes

- **Backups**: Kubernetes não realiza backups de dados nativamente. Use ferramentas como:
    
    - [Velero](https://velero.io/)
        
    - Snapshots de disco da nuvem
        
    - Replicação para outro volume
        
- **Segurança**:
    
    - Use PVCs em namespaces apropriados.
        
    - Controle o acesso com `RBAC`.
        
    - Considere criptografia do volume em disco.
        

---

## Conclusão

A persistência de dados no Kubernetes exige o uso consciente de **Persistent Volumes (PV)**, **Persistent Volume Claims (PVC)**, **StorageClasses** e **StatefulSets**. Esses recursos permitem que suas aplicações armazenem dados de forma segura e resiliente mesmo em ambientes altamente dinâmicos.
