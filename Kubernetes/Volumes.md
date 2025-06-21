#k8s

## O que são Volumes?

Em Kubernetes, **volumes** são recursos que fornecem **armazenamento persistente ou temporário** para os containers de um Pod. Diferente do sistema de arquivos do container, que é efêmero e apagado após o reinício, os volumes oferecem um **espaço de armazenamento mais durável e compartilhável**.

> Volumes podem ser usados para:

- Compartilhar dados entre containers do mesmo Pod
    
- Persistir dados entre reinícios de containers
    
- Montar arquivos de configuração ou certificados
    
- Conectar a volumes persistentes (PVCs/PVs)
    

---

## Como funciona um Volume no Pod

- Os volumes são declarados no nível do Pod (em `spec.volumes`)
    
- Cada container no Pod pode montar esse volume em um caminho diferente (`volumeMounts`)
    
- O ciclo de vida do volume está ligado ao ciclo de vida do Pod (exceto volumes persistentes)
    

---

## Exemplo Básico com `emptyDir` (armazenamento temporário)

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-com-volume
spec:
  containers:
    - name: app
      image: busybox
      command: ["sh", "-c", "echo teste > /dados/teste.txt && sleep 3600"]
      volumeMounts:
        - name: meu-volume
          mountPath: /dados
  volumes:
    - name: meu-volume
      emptyDir: {}
```

> O volume `emptyDir` é criado **vazio no momento em que o Pod é iniciado** e apagado quando ele termina.

---

## Tipos Comuns de Volumes no Kubernetes

|Tipo|Uso Principal|
|---|---|
|`emptyDir`|Armazenamento temporário para o Pod|
|`hostPath`|Acessar um diretório local do Node (geralmente para testes)|
|`configMap`|Montar configurações declarativas em arquivos|
|`secret`|Montar dados sensíveis (senhas, tokens) como arquivos|
|`persistentVolumeClaim` (PVC)|Montar volumes persistentes que sobrevivem ao Pod|
|`projected`|Combinar múltiplos volumes (secret + configMap + token)|
|`nfs`|Montar volumes em rede (Network File System)|
|`awsElasticBlockStore`, `gcePersistentDisk`, etc.|Volumes gerenciados por clouds|

---

## Exemplos Práticos

### Montar um `configMap` como volume

```yaml
volumes:
  - name: config-vol
    configMap:
      name: minha-configmap

volumeMounts:
  - name: config-vol
    mountPath: /app/config
```

---

### Montar um `secret` como volume

```yaml
volumes:
  - name: secret-vol
    secret:
      secretName: meu-segredo

volumeMounts:
  - name: secret-vol
    mountPath: /etc/segredos
    readOnly: true
```

---

### Usar `hostPath` (⚠️ cuidado em produção)

```yaml
volumes:
  - name: local-data
    hostPath:
      path: /tmp/dados
      type: DirectoryOrCreate
```

---

### Montar um PVC (PersistentVolumeClaim)

```yaml
volumes:
  - name: armazenamento
    persistentVolumeClaim:
      claimName: meu-pvc

volumeMounts:
  - name: armazenamento
    mountPath: /dados
```

---

## Compartilhamento entre Containers do Mesmo Pod

```yaml
spec:
  volumes:
    - name: cache
      emptyDir: {}
  containers:
    - name: app1
      image: busybox
      volumeMounts:
        - name: cache
          mountPath: /compartilhado
    - name: app2
      image: busybox
      volumeMounts:
        - name: cache
          mountPath: /tambem-aqui
```

> Ambos containers compartilham os arquivos do mesmo volume.

---

## Campos importantes de `volumeMounts`

|Campo|Descrição|
|---|---|
|`mountPath`|Caminho dentro do container onde o volume será montado|
|`readOnly`|Se o volume deve ser montado como somente leitura|
|`subPath`|Monta apenas um subdiretório do volume no `mountPath`|
|`name`|Nome do volume (deve coincidir com `spec.volumes`)|

---

## Boas Práticas com Volumes

|Prática|Por quê|
|---|---|
|Use `emptyDir` para cache ou dados temporários|Evita persistência desnecessária|
|Use `PVCs` para persistência real|Permite recriação do Pod sem perda de dados|
|Nunca use `hostPath` em produção|Altamente dependente do host e não portátil|
|Combine `readOnly` com `secrets` e `configMaps`|Evita modificações acidentais|
|Nomeie volumes e mountPaths de forma clara|Facilita manutenção e leitura|

---

## Conclusão

Volumes são parte essencial da execução de aplicações no Kubernetes, pois oferecem:

- Persistência
    
- Compartilhamento
    
- Configuração segura
    

Compreender os diferentes tipos e usos ajuda a projetar Pods mais confiáveis, escaláveis e resilientes.

---