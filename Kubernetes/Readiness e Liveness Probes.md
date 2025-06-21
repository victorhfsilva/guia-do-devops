#k8s 

## O que são Probes?

**Probes** são verificações de saúde que o Kubernetes realiza nos containers de um Pod para determinar:

- **Se o container está funcionando corretamente** (_livenessProbe_)
    
- **Se o container está pronto para receber requisições** (_readinessProbe_)
    

Essas verificações são feitas de forma contínua pelo **Kubelet**, e ajudam o cluster a tomar decisões como reiniciar um container com falha ou removê-lo de um _Service_ até que ele esteja pronto.

---

## Diferença entre Liveness e Readiness

|Característica|**livenessProbe**|**readinessProbe**|
|---|---|---|
|**Objetivo**|Verificar se o container ainda está saudável|Verificar se o container está pronto para receber tráfego|
|**Falha provoca**|Reinício do container|Remoção do Pod do Service|
|**Impacto no tráfego**|Não afeta a exposição ao tráfego|Afeta diretamente o balanceamento de carga|
|**Uso típico**|Detectar _deadlocks_, falhas irreversíveis|Esperar cache, conexão com banco, ou config externa|

---

## Métodos de Probes

1. **HTTP GET**
    
2. **Command (exec)**
    
3. **TCP Socket**
    

---

## Estrutura Geral no YAML

```yaml
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 5

readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
```

---

## Campos Comuns

|Campo|Significado|
|---|---|
|`initialDelaySeconds`|Tempo para começar a verificar após o container subir|
|`periodSeconds`|Intervalo entre uma verificação e outra|
|`timeoutSeconds`|Tempo máximo de espera por uma resposta|
|`failureThreshold`|Quantas falhas consecutivas são necessárias para considerar a verificação mal sucedida|
|`successThreshold`|Quantos sucessos consecutivos são necessários para considerar o container saudável (útil para readiness)|

---

## Exemplos Práticos

### 1. **HTTP GET Probe (mais comum)**

```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 5
  timeoutSeconds: 2
  failureThreshold: 3
```

---

### 2. **Exec Probe (comando shell)**

```yaml
readinessProbe:
  exec:
    command:
      - cat
      - /tmp/ready
  initialDelaySeconds: 5
  periodSeconds: 10
```

> O container será considerado **pronto** apenas se o arquivo `/tmp/ready` existir.

---

### 3. **TCP Socket Probe**

```yaml
livenessProbe:
  tcpSocket:
    port: 3306
  initialDelaySeconds: 15
  periodSeconds: 20
```

> Verifica se uma porta está aberta e aceitando conexões TCP (ex: banco de dados).

---

## Comportamento Esperado

| Situação                        | Resultado com `readiness`    | Resultado com `liveness`              |
| ------------------------------- | ---------------------------- | ------------------------------------- |
| Serviço demorando a subir       | Pod não recebe tráfego       | Container não é reiniciado            |
| Serviço travado (deadlock)      | Pode continuar "pronto"      | Container é reiniciado                |
| Falha temporária em dependência | Pod retirado temporariamente | Container não reiniciado (idealmente) |

---

## Boas Práticas

|Dica|Por quê|
|---|---|
|Use `readinessProbe` para processos que demoram a ficar prontos|Evita tráfego para serviços ainda não iniciados|
|Use `livenessProbe` para containers suscetíveis a travamentos|Garante autorecuperação automática|
|Evite `exec` em imagens mínimas sem `sh`, `bash`, etc.|Pode falhar se os comandos não existirem|
|Teste as probes localmente antes de aplicar em produção|Evita reinícios desnecessários|
|Cuidado com `failureThreshold` baixo em sistemas lentos|Pode causar reinício precoce|

---

## Dica para Debug

Para simular um container pronto:

```bash
touch /tmp/ready
```

Para simular um container com falha:

```bash
rm /tmp/ready
```

---

## 📦 Exemplo Completo de Deployment com Probes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
        - name: app
          image: myapp:latest
          ports:
            - containerPort: 8080
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 10
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
```

---

## Conclusão

**Readiness e Liveness Probes** são recursos fundamentais para garantir que seu aplicativo:

- **Não receba tráfego antes da hora**
    
- **Seja reiniciado automaticamente em caso de falha**
    
- **Mantenha alta disponibilidade e confiabilidade no cluster**
    

---

