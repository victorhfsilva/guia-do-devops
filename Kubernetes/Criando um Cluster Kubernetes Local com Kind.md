#k8s

O **Kind** (Kubernetes IN Docker) permite criar clusters Kubernetes locais executados **dentro de containers Docker**. É ideal para testes, aprendizado e integração contínua (CI).

---

## Pré-requisitos

Antes de tudo, certifique-se de ter instalado:

| Ferramenta | Comando de Verificação | Link de Instalação                                                                                 |
| ---------- | ---------------------- | -------------------------------------------------------------------------------------------------- |
| Docker     | `docker version`       | [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)                         |
| kubectl    | `kubectl version`      | [https://kubernetes.io/docs/tasks/tools/#kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) |
| Kind       | `kind version`         | [https://kind.sigs.k8s.io/](https://kind.sigs.k8s.io/)                                             |

---

## Criando um Cluster Simples

### Criar o cluster

```bash
kind create cluster --name meu-cluster
```

Isso irá:

- Baixar a imagem do Kubernetes no Docker
    
- Criar um container “node” com a imagem
    
- Inicializar o cluster
    

### Verificar se o cluster está funcionando

```bash
kubectl cluster-info --context kind-meu-cluster
kubectl get nodes
```

Você verá um nó ativo com status `Ready`.

---

## Criar Cluster com Configuração Personalizada

Você pode criar clusters com **vários nós (multi-node)** ou configurações específicas com arquivos YAML.

### Exemplo: cluster com 1 control-plane e 2 workers

Crie um arquivo `cluster-config.yaml`:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

E crie o cluster:

```bash
kind create cluster --name multi-node --config cluster-config.yaml
```

---

## Acessar o Cluster de Fora do Container

O Kind expõe serviços apenas dentro do Docker por padrão. Para acesso externo (como um browser ou outro host), você pode usar o **port forwarding** ou configurar o **Ingress**.

Exemplo – Expor a porta 30000 de um Pod:

```bash
kubectl port-forward svc/meu-servico 30000:80
```

---

## Apagar um Cluster

Para limpar tudo:

```bash
kind delete cluster --name meu-cluster
```

---

## Teste rápido: Criar um Pod

```bash
kubectl run nginx --image=nginx --restart=Never --port=80
kubectl expose pod nginx --type=NodePort --port=80
kubectl get svc
```

Depois acesse com:

```bash
kubectl port-forward svc/nginx 8080:80
```

E abra: `http://localhost:8080`

---

## Usar Volumes e Ingress com Kind

Você pode mapear volumes e configurar Ingress Controllers para simular clusters de produção.

### Exemplo: Montar volume local no container do Kind

```yaml
nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /meus/dados
        containerPath: /mnt/dados
```

---

## Dicas Adicionais

- **Clusters paralelos:** você pode rodar vários clusters simultaneamente com diferentes nomes (`kind create cluster --name outro-cluster`).
    
- **CI/CD:** Kind é excelente para pipelines de integração contínua (ex: GitHub Actions).
    
- **Compatibilidade:** cada versão do Kind usa uma versão fixa do Kubernetes (pode ser configurada).
    

---
