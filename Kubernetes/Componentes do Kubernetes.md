#k8s

O Kubernetes é uma plataforma de orquestração de contêineres que organiza, escala e gerencia aplicações em ambientes distribuídos. Sua arquitetura é dividida em **três camadas principais**:

- **Control Plane** (Plano de Controle)
- **Node Plane** (Plano de Execução)
- **Addons**

---

## **1. Control Plane**

É o **cérebro** do cluster Kubernetes. Ele toma decisões globais, como **agendamento de pods**, **resposta a eventos** e **gerenciamento do estado desejado**.

### **kube-apiserver**

- É a **porta de entrada** para qualquer interação com o cluster.
    
- Recebe comandos de usuários (via `kubectl`, por exemplo), valida e encaminha para os demais componentes.
    
- Suporta autenticação, autorização, controle de acesso e versionamento da API.
    
- Altamente crítico; normalmente executado em nós dedicados chamados de **Master Nodes**.
    

### **etcd**

- Banco de dados **chave-valor distribuído** usado como **fonte de verdade (source of truth)** do cluster.
    
- Armazena: configurações, estado atual, definições de objetos etc.
    
- Utiliza o algoritmo **Raft** para manter consistência entre múltiplas réplicas.
    

### **kube-scheduler**

- Decide **em qual Node** um Pod será executado.
    
- Avalia:
    
    - Recursos disponíveis (CPU, memória)
        
    - Afinidade/anti-afinidade
        
    - Restrições de tolerância e taints
        
    - Estratégias de balanceamento
        

### **kube-controller-manager**

- Executa múltiplos **controladores** (loops de reconciliação).
    
- Cada controlador mantém o estado real do cluster próximo ao estado desejado.
    

Principais controladores:

####  **ReplicationController / DeploymentController**

- Garante que um número desejado de réplicas de pods esteja rodando.
    

#### **Node Controller**

- Monitora a disponibilidade dos nós.
    

#### **Endpoints Controller**

- Atualiza os IPs dos Pods associados a um Service, com base no **selector**.
    

#### **ServiceAccount & Token Controller**

- Cria tokens e contas de serviço automaticamente.
    

#### **Cloud Controller Manager**

- Interface entre Kubernetes e a nuvem (AWS, GCP, Azure).
    
- Garante provisionamento automático de recursos como IPs públicos e volumes.
    

---

## **2. Node Plane**

Essa camada corresponde aos **nós de trabalho** (Workers). Cada Node executa componentes que permitem rodar os containers agendados pelo Control Plane.

### **kubelet**

- Agente que roda em **cada Node**.
    
- **Recebe instruções do kube-apiserver** sobre quais Pods devem ser executados.
    
- Garante que os contêineres estejam rodando e saudáveis.
    
- Se comunica com o **Container Runtime** (ex: containerd, CRI-O) via **CRI (Container Runtime Interface)**.
    

> **Observação**: o suporte direto ao Docker foi descontinuado, mas é possível usá-lo com **dockershim** (interface de compatibilidade legada).

### **kube-proxy**

- Gerencia **regras de rede** para permitir comunicação entre Pods e Services.
    
- Implementa:
    
    - Regras iptables/ipvs
        
    - NAT de pacotes
        
- Executado em todos os Nodes para garantir conectividade transparente.
    

---

## **3. Addons**

Complementam o Kubernetes com funcionalidades adicionais usando recursos nativos do cluster (Pods, Deployments, Services, etc.).

### Exemplos comuns:

#### **CoreDNS**

- Fornece resolução de nomes DNS para os Pods e Services.
    

#### **Dashboard**

- Interface gráfica para gerenciamento visual do cluster.
    

#### **Metrics Server**

- Fornece dados de uso de CPU/memória, usados por features como autoscaling.
    

#### **Ingress Controller**

- Controla o tráfego HTTP/HTTPS externo que entra no cluster.
    
- Implementações comuns: **NGINX Ingress**, **Traefik**, **HAProxy**.
    

---

## **4. Ferramenta de Interação**

### **kubectl**

- Ferramenta CLI que interage com o kube-apiserver.
    
- Permite aplicar, deletar, monitorar e depurar recursos.
    
- Exemplo:
    

```bash
kubectl get pods
kubectl describe node <node-name>
kubectl apply -f deployment.yaml
```

---

## **5. Componentes Opcionais / Complementares**

### **CRI (Container Runtime Interface)**

- Interface usada pelo Kubelet para se comunicar com o runtime de contêiner.
    
- Runtimes compatíveis:
    
    - **containerd**
        
    - **CRI-O**
        
    - (Antigamente: Docker com dockershim)
        

### **CNI (Container Network Interface)**

- Plugins que implementam a rede entre Pods.
    
- Exemplos:
    
    - **Calico**
        
    - **Flannel**
        
    - **Cilium**
        
    - **Weave**
        

---
