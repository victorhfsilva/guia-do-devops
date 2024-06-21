# EC2

### O que é o Amazon EC2?

Amazon Elastic Compute Cloud (EC2) é um serviço web que fornece capacidade computacional redimensionável na nuvem AWS. Ele permite que os usuários lancem instâncias de servidores virtuais para executar aplicações e serviços.

### Principais Componentes de uma Instância EC2

1. **Instância**: Unidade básica de computação no EC2.
2. **Tipo de Instância**: Especifica a capacidade da instância em termos de CPU, memória, armazenamento e rede.
3. **Imagens de Máquina Amazon (AMI)**: Modelos que contêm a configuração do sistema operacional e software.
4. **VPC e Subnet**: Redes virtuais onde as instâncias são lançadas.
5. **Security Groups**: Regras que controlam o tráfego de entrada e saída da instância.
6. **Key Pairs**: Usados para acessar a instância via SSH.

### Criando uma Instância EC2 usando CDK em Java

#### Definindo a Instância EC2

Edite o Stack para incluir a configuração da instância EC2:

```java
public class MyEC2ProjectStack extends Stack {
    public MyEC2ProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyEC2ProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)  // Disponibilidade em 2 zonas de disponibilidade
                .build();

        // Criar um Security Group para a instância EC2
        SecurityGroup ec2SecurityGroup = SecurityGroup.Builder.create(this, "EC2SecurityGroup")
                .vpc(vpc)
                .allowAllOutbound(true)
                .build();

        ec2SecurityGroup.addIngressRule(Peer.anyIpv4(), Port.tcp(22), "Allow SSH access");

        // Criar a instância EC2
        Instance ec2Instance = Instance.Builder.create(this, "MyEC2Instance")
                .instanceType(InstanceType.of(InstanceClass.BURSTABLE2, InstanceSize.MICRO))
                .machineImage(MachineImage.latestAmazonLinux())
                .vpc(vpc)
                .securityGroup(ec2SecurityGroup)
                .keyName("my-key-pair")  // Substitua pelo nome do seu par de chaves
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyEC2ProjectStack(app, "MyEC2ProjectStack");

        app.synth();
    }
}
```

#### Implantando a Instância EC2

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a Instância EC2 na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Instância EC2 com Amazon Linux

- **Tipo de Instância**: t2.micro (ajuste conforme necessário)
- **Imagem de Máquina**: Amazon Linux mais recente
- **Segurança**: Grupo de segurança configurado para permitir acesso SSH
