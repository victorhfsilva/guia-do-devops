# ECS

### O que é o Amazon ECS?

Amazon Elastic Container Service (ECS) é um serviço de gerenciamento de contêineres altamente escalável e de alta performance que suporta Docker containers, permitindo que você execute e dimensione aplicações em contêineres facilmente na AWS.

### Principais Componentes de um Cluster ECS

1. **Cluster**: Um agrupamento lógico de recursos do ECS, como instâncias EC2 ou tarefas Fargate.
2. **Task Definition**: Define como os contêineres serão executados, incluindo a imagem Docker, memória, CPU, e políticas de rede.
3. **Service**: Gerencia e escala as tarefas baseadas nas definições de tarefas, garantindo a execução das tarefas desejadas.
4. **Container**: Unidade básica de implantação, baseada em uma imagem Docker.

### Criando um Cluster ECS usando CDK em Java

#### Definindo o Cluster ECS

Edite o Stack para incluir a configuração do cluster ECS:

```java
public class MyECSProjectStack extends Stack {
    public MyECSProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyECSProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)  // Disponibilidade em 2 zonas de disponibilidade
                .build();

        // Criar o cluster ECS
        Cluster cluster = Cluster.Builder.create(this, "MyEcsCluster")
                .vpc(vpc)
                .build();

        // Definir a task definition para o serviço Fargate
        FargateTaskDefinition taskDefinition = FargateTaskDefinition.Builder.create(this, "MyFargateTaskDefinition")
                .memoryLimitMiB(512)
                .cpu(256)
                .build();

        // Adicionar um contêiner à task definition
        taskDefinition.addContainer("MyContainer", software.amazon.awscdk.services.ecs.ContainerDefinitionOptions.builder()
                .image(ContainerImage.fromRegistry("amazon/amazon-ecs-sample"))
                .logging(software.amazon.awscdk.services.ecs.LogDriver.awsLogs(software.amazon.awscdk.services.ecs.AwsLogDriverProps.builder()
                        .streamPrefix("MyContainer")
                        .build()))
                .portMappings(java.util.Arrays.asList(PortMapping.builder()
                        .containerPort(80)
                        .protocol(Protocol.TCP)
                        .build()))
                .build());

        // Criar o serviço Fargate baseado na task definition
        FargateService service = FargateService.Builder.create(this, "MyFargateService")
                .cluster(cluster)
                .taskDefinition(taskDefinition)
                .desiredCount(1)
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyECSProjectStack(app, "MyECSProjectStack");

        app.synth();
    }
}
```

#### Implantando o Cluster ECS

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar o Cluster ECS na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Cluster ECS com Fargate

- **Cluster**: ECS cluster na VPC criada.
- **Task Definition**: Definida para usar 512 MiB de memória e 256 unidades de CPU.
- **Container**: Imagem do contêiner definida como "amazon/amazon-ecs-sample".
- **Service**: Serviço Fargate com uma tarefa desejada.