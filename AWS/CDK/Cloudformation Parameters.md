# CloudFormation Parameters 

### O que são CloudFormation Parameters?

Os parâmetros do AWS CloudFormation permitem que você passe valores para o seu template CloudFormation em tempo de execução, tornando os templates mais dinâmicos e reutilizáveis. Com parâmetros, você pode definir entradas que variam, como IDs de VPC, tamanhos de instância, nomes de buckets S3, entre outros.

### Principais Componentes

1. **Parâmetros**: Valores dinâmicos que são passados ao template no momento da execução.
2. **Referências**: Utilização de parâmetros dentro dos recursos definidos no template.
3. **Padrões e Restrições**: Valores padrão e restrições de entrada que podem ser definidos para parâmetros.

### CriandoCloudFormation Parameters usando CDK em Java

#### Definindo Parâmetros e Usando-os no CDK

Edite o Stack para incluir a configuração dos parâmetros e seu uso:

```java
public class MyCfnParametersProjectStack extends Stack {
    public MyCfnParametersProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyCfnParametersProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Definindo um parâmetro para o nome do bucket S3
        CfnParameter bucketNameParam = CfnParameter.Builder.create(this, "BucketNameParam")
                .type("String")
                .description("O nome do bucket S3")
                .defaultValue("my-default-bucket")
                .build();

        // Definindo um parâmetro para o tipo de instância EC2
        CfnParameter instanceTypeParam = CfnParameter.Builder.create(this, "InstanceTypeParam")
                .type("String")
                .description("O tipo de instância EC2")
                .defaultValue("t2.micro")
                .allowedValues(java.util.Arrays.asList("t2.micro", "t2.small", "t2.medium"))
                .build();

        // Usando o parâmetro do nome do bucket S3
        Bucket bucket = Bucket.Builder.create(this, "MyBucket")
                .bucketName(bucketNameParam.getValueAsString())
                .build();

        // Criando uma VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)
                .build();

        // Usando o parâmetro do tipo de instância EC2
        Instance instance = Instance.Builder.create(this, "MyInstance")
                .instanceType(new InstanceType(instanceTypeParam.getValueAsString()))
                .machineImage(MachineImage.latestAmazonLinux())
                .vpc(vpc)
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyCfnParametersProjectStack(app, "MyCfnParametersProjectStack");

        app.synth();
    }
}
```

#### Implantando a Stack com Parâmetros

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a Stack com os Parâmetros na AWS**:
   ```bash
   cdk deploy
   ```

   Durante o deploy, você pode especificar os parâmetros:
   ```bash
   cdk deploy --parameters BucketNameParam=my-bucket --parameters InstanceTypeParam=t2.small
   ```

### Exemplos de Configurações

#### Parâmetro para Nome do Bucket S3

- **Nome**: `BucketNameParam`
- **Tipo**: `String`
- **Descrição**: Nome do bucket S3.
- **Valor Padrão**: `my-default-bucket`

#### Parâmetro para Tipo de Instância EC2

- **Nome**: `InstanceTypeParam`
- **Tipo**: `String`
- **Descrição**: Tipo de instância EC2.
- **Valor Padrão**: `t2.micro`
- **Valores Permitidos**: `t2.micro`, `t2.small`, `t2.medium`