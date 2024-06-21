# RDS

### O que é o Amazon RDS?

Amazon Relational Database Service (RDS) é um serviço gerenciado que facilita a configuração, operação e escalabilidade de um banco de dados relacional na AWS. Ele oferece suporte a vários mecanismos de banco de dados, incluindo Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle e Microsoft SQL Server.

### Principais Componentes de um RDS

1. **Instância de Banco de Dados**: A unidade básica do RDS onde o banco de dados é executado.
2. **Subnets e Grupos de Subnets**: Redes onde as instâncias RDS são lançadas.
3. **Segurança**: Controle de acesso utilizando grupos de segurança e políticas de IAM.
4. **Backup e Restauração**: Recursos automáticos de backup e restauração de dados.
5. **Monitoramento**: Ferramentas como Amazon CloudWatch para monitorar o desempenho do banco de dados.

### Criando um Banco de Dados RDS usando CDK em Java

#### Definindo a Instância RDS

Edite o Stack para incluir a configuração do banco de dados RDS:

```java
public class MyRdsProjectStack extends Stack {
    public MyRdsProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyRdsProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)  // Disponibilidade em 2 zonas de disponibilidade
                .build();

        // Criar um Security Group para o RDS
        SecurityGroup rdsSecurityGroup = SecurityGroup.Builder.create(this, "RdsSecurityGroup")
                .vpc(vpc)
                .allowAllOutbound(true)
                .build();

        rdsSecurityGroup.addIngressRule(Peer.anyIpv4(), Port.tcp(3306), "Allow MySQL access");

        // Criar a instância RDS
        DatabaseInstance dbInstance = DatabaseInstance.Builder.create(this, "MyRdsInstance")
                .engine(DatabaseInstanceEngine.MYSQL)  // Substitua pelo mecanismo de banco de dados desejado
                .instanceType(InstanceType.of(software.amazon.awscdk.services.ec2.InstanceClass.BURSTABLE2, software.amazon.awscdk.services.ec2.InstanceSize.MICRO))
                .vpc(vpc)
                .credentials(Credentials.fromGeneratedSecret("admin"))  // Usuário admin com senha gerada automaticamente
                .vpcSubnets(subnetSelection -> subnetSelection.subnetType(software.amazon.awscdk.services.ec2.SubnetType.PUBLIC))
                .multiAz(true)  // Multi-AZ para alta disponibilidade
                .allocatedStorage(20)  // Armazenamento em GB
                .storageType(StorageType.GP2)  // Tipo de armazenamento
                .securityGroups(java.util.Collections.singletonList(rdsSecurityGroup))
                .backupRetention(software.amazon.awscdk.core.Duration.days(7))  // Retenção de backup de 7 dias
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyRdsProjectStack(app, "MyRdsProjectStack");

        app.synth();
    }
}
```

#### Implantando o Banco de Dados RDS

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar o Banco de Dados RDS na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Instância RDS MySQL com Alta Disponibilidade

- **Engine**: MySQL
- **Instância Tipo**: t2.micro (pode ser ajustado conforme necessário)
- **Armazenamento**: 20 GB, tipo GP2
- **Multi-AZ**: Habilitado para alta disponibilidade
- **Backup**: Retenção de backup de 7 dias
- **Segurança**: Grupo de segurança configurado para permitir acesso MySQL
