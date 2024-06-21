# EFS 

### O que é o Amazon EFS?

Amazon Elastic File System (EFS) é um serviço de sistema de arquivos NFS (Network File System) que permite que você crie e configure sistemas de arquivos escaláveis e elásticos na AWS. Ele é projetado para ser altamente disponível e durável, permitindo que múltiplas instâncias EC2 acessem os dados simultaneamente.

### Principais Componentes de um EFS

1. **Sistema de Arquivos**: O recurso principal do EFS onde os dados são armazenados.
2. **Mount Targets**: Pontos de montagem que permitem que instâncias EC2 acessem o sistema de arquivos em uma VPC.
3. **Permissões e Segurança**: Controle de acesso utilizando grupos de segurança e políticas de IAM.
4. **Classes de Armazenamento**: Escolha entre Standard e Infrequent Access para otimização de custo.

### Criando um EFS usando CDK em Java

#### Definindo o Sistema de Arquivos EFS

Edite o Stack para incluir a configuração do EFS:

```java
public class MyEfsProjectStack extends Stack {
    public MyEfsProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyEfsProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)  // Disponibilidade em 2 zonas de disponibilidade
                .build();

        // Criar um Security Group para o EFS
        SecurityGroup efsSecurityGroup = SecurityGroup.Builder.create(this, "EfsSecurityGroup")
                .vpc(vpc)
                .allowAllOutbound(true)
                .build();

        efsSecurityGroup.addIngressRule(Peer.anyIpv4(), Port.tcp(2049), "Allow NFS traffic");

        // Criar o sistema de arquivos EFS
        FileSystem fileSystem = FileSystem.Builder.create(this, "MyEfsFileSystem")
                .vpc(vpc)
                .securityGroup(efsSecurityGroup)
                .lifecyclePolicy(LifecyclePolicy.AFTER_30_DAYS)
                .performanceMode(software.amazon.awscdk.services.efs.PerformanceMode.GENERAL_PURPOSE)
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyEfsProjectStack(app, "MyEfsProjectStack");

        app.synth();
    }
}
```

#### Implantando o EFS

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar o EFS na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Sistema de Arquivos EFS com Política de Ciclo de Vida

- **Lifecycle Policy:** Transfere arquivos para a classe de armazenamento Infrequent Access após 30 dias.
- **Performance Mode:** General Purpose para latência baixa e alta simultaneidade de operações.