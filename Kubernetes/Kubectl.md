#k8s 

## O que é o `kubectl`?

O `kubectl` (pronuncia-se _"cube control"_) é o **cliente de linha de comando oficial do Kubernetes**, usado para:

- Criar, visualizar, modificar e excluir recursos do cluster
    
- Depurar aplicações
    
- Gerenciar namespaces, configurações, autenticação e contexto
    
- Observar o estado do cluster e das cargas de trabalho
    

---

## Conectando-se ao Cluster

O `kubectl` usa um arquivo chamado `kubeconfig` (geralmente em `~/.kube/config`) para saber como se conectar ao cluster.

Você pode listar os contextos disponíveis:

```bash
kubectl config get-contexts
```

Selecionar um contexto:

```bash
kubectl config use-context nome-do-contexto
```

---

## Comandos Essenciais

|Comando|Descrição|
|---|---|
|`kubectl get`|Lista recursos|
|`kubectl describe`|Mostra detalhes completos de um recurso|
|`kubectl apply -f arquivo.yaml`|Aplica/atualiza recursos com base em YAML|
|`kubectl delete -f arquivo.yaml`|Deleta recursos definidos em um YAML|
|`kubectl edit recurso nome`|Edita um recurso em tempo real (abre no editor)|
|`kubectl logs pod`|Exibe logs de um container em um Pod|
|`kubectl exec -it pod -- comando`|Executa um comando dentro do Pod|
|`kubectl port-forward svc/nome 8080:80`|Encaminha porta para acessar localmente|
|`kubectl rollout undo deployment/x`|Reverte uma atualização de Deployment|

---

## Recursos Comuns e Seus Comandos

### Pods

```bash
kubectl get pods
kubectl describe pod nome-do-pod
kubectl delete pod nome-do-pod
kubectl exec -it nome-do-pod -- /bin/sh
```

### Deployments

```bash
kubectl get deployments
kubectl apply -f deployment.yaml
kubectl rollout status deployment nome
kubectl rollout undo deployment nome
```

### Services

```bash
kubectl get svc
kubectl describe svc nome
kubectl port-forward svc/nome 8080:80
```

### Namespaces

```bash
kubectl get namespaces
kubectl get pods -n nome-do-namespace
```

### ConfigMaps e Secrets

```bash
kubectl create configmap nome --from-literal=chave=valor
kubectl get configmaps
kubectl describe secret nome
```

---

## Trabalhando com Arquivos YAML

Crie, atualize ou exclua recursos com base em arquivos declarativos:

```bash
kubectl apply -f arquivo.yaml    # Cria ou atualiza
kubectl delete -f arquivo.yaml   # Deleta
kubectl diff -f arquivo.yaml     # Mostra o que será alterado
```

Valide antes de aplicar:

```bash
kubectl apply -f arquivo.yaml --dry-run=client
```

---

## Filtragem e Visualização

- Listar Pods por label:
    

```bash
kubectl get pods -l app=nginx
```

- Mostrar colunas extras:
    

```bash
kubectl get pods -o wide
```

- Mostrar em YAML:
    

```bash
kubectl get pod nome -o yaml
```

---

## Dicas e Truques

- Usar _aliases_:
    

```bash
alias k=kubectl
alias kgp='kubectl get pods'
```

- Acompanhar logs em tempo real:
    

```bash
kubectl logs -f nome-do-pod
```

- Criar recursos interativamente:
    

```bash
kubectl run nginx --image=nginx --port=80
```

- Atualizar a imagem de um Deployment:
    

```bash
kubectl set image deployment/nginx-deploy nginx=nginx:1.21
```

---

## Boas Práticas

| Prática                                         | Por quê                                                  |
| ----------------------------------------------- | -------------------------------------------------------- |
| Use `kubectl apply` com YAML                    | Declarativo, versionável e reproduzível                  |
| Evite comandos imperativos em produção          | Difíceis de auditar e manter                             |
| Combine com `--namespace` sempre que necessário | Para evitar alterações no namespace errado               |
| Explore `kubectl explain recurso`               | Para obter documentação embutida diretamente no terminal |
| Use `--dry-run` antes de aplicar                | Evita aplicar recursos inválidos                         |

---

## Conclusão

O `kubectl` é sua principal ferramenta de interação com o Kubernetes. Com ele, você pode:

- Criar e gerenciar recursos
    
- Depurar aplicações e workloads
    
- Automatizar operações do cluster
    

Dominar o `kubectl` é essencial para operar com confiança em qualquer ambiente Kubernetes — de desenvolvimento local até clusters em produção.

---
