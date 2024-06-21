# Configurando Redes no AWS

### O que é uma VPC?

VPC (Virtual Private Cloud) é um serviço da Amazon Web Services (AWS) que permite criar uma rede virtual privada dentro da nuvem AWS. Com uma VPC, você pode provisionar uma seção isolada da nuvem AWS onde você pode lançar recursos AWS em uma rede virtual que você define.

### Principais Componentes de uma VPC

1. **Sub-redes**: São segmentos dentro da VPC onde você pode colocar seus recursos, como instâncias EC2. Existem dois tipos de sub-redes:
   - **Sub-rede pública**: Sub-rede com acesso à Internet.
   - **Sub-rede privada**: Sub-rede sem acesso direto à Internet.

2. **Gateway de Internet**: Um componente que permite a comunicação entre a VPC e a Internet.

3. **Roteamento**: Tabelas de rotas controlam o tráfego dentro da VPC e para fora dela.

4. **NAT Gateway**: Permite que instâncias em uma sub-rede privada acessem a Internet sem serem acessíveis de fora.

5. **Security Groups**: Conjuntos de regras que controlam o tráfego de entrada e saída para instâncias.

6. **Network ACLs**: Conjuntos de regras que controlam o tráfego de entrada e saída para sub-redes.

### Exemplos de Configurações

#### Sub-rede Pública

- **Bloco CIDR**: 10.0.1.0/24
- **Gateway de Internet**: Ativado
- **Tabela de Roteamento**:
  - Destino: 0.0.0.0/0
  - Target: Gateway de Internet

#### Sub-rede Privada

- **Bloco CIDR**: 10.0.2.0/24
- **NAT Gateway**: Ativado (para acesso à Internet)
- **Tabela de Roteamento**:
  - Destino: 0.0.0.0/0
  - Target: NAT Gateway

### Criando uma VPC usando CDK em Java

#### Definindo a VPC e os Componentes

Edite a Stack para incluir a configuração da VPC:

```java
public class MyVpcProjectStack extends Stack {
    public MyVpcProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyVpcProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .cidr("10.0.0.0/16")
                .maxAzs(3)
                .natGateways(1)
                .subnetConfiguration(java.util.Arrays.asList(
                        SubnetConfiguration.builder()
                                .cidrMask(24)
                                .name("PublicSubnet")
                                .subnetType(SubnetType.PUBLIC)
                                .build(),
                        SubnetConfiguration.builder()
                                .cidrMask(24)
                                .name("PrivateSubnet")
                                .subnetType(SubnetType.PRIVATE_WITH_NAT)
                                .build()
                ))
                .build();

        // Exemplo de criação de um Security Group
        SecurityGroup securityGroup = SecurityGroup.Builder.create(this, "MySecurityGroup")
                .vpc(vpc)
                .allowAllOutbound(true)
                .securityGroupName("MySecurityGroup")
                .build();

        // Adicionando regras ao Security Group
        securityGroup.addIngressRule(Peer.anyIpv4(), Port.tcp(22), "Allow SSH Access");
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyVpcProjectStack(app, "MyVpcProjectStack");

        app.synth();
    }
}
```

#### Implantando a VPC

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a VPC na AWS**:
   ```bash
   cdk deploy
   ```