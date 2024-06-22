# Cloudformation Outputs

### O que são CloudFormation Outputs?

CloudFormation Outputs permitem que você exporte valores de sua stack CloudFormation. Esses valores podem ser usados para compartilhar informações entre stacks ou para exibir informações importantes ao final da implantação. Por exemplo, você pode exportar o ARN de um bucket S3, a URL de um site ou o ID de uma VPC.

### Principais Componentes

1. **Outputs**: Valores exportados da stack CloudFormation que podem ser utilizados em outras stacks ou exibidos como informações úteis.
2. **Exportar Valores**: Permite compartilhar valores entre stacks CloudFormation.
3. **Referências**: Utilização de valores de saída em outras stacks ou em scripts pós-implantação.

### Usando CloudFormation Outputs com CDK em Java

#### Definindo Outputs e Usando-os no CDK

Edite o Stack para incluir a configuração dos outputs:

```java
public class MyCfnOutputsProjectStack extends Stack {
    public MyCfnOutputsProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyCfnOutputsProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar um bucket S3
        Bucket bucket = Bucket.Builder.create(this, "MyBucket")
                .bucketName("my-unique-bucket-name")
                .build();

        // Criar uma VPC
        Vpc vpc = Vpc.Builder.create(this, "MyVpc")
                .maxAzs(2)
                .build();

        // Criar uma instância EC2
        Instance instance = Instance.Builder.create(this, "MyInstance")
                .instanceType(InstanceType.of(InstanceClass.BURSTABLE2, InstanceSize.MICRO))
                .machineImage(MachineImage.latestAmazonLinux())
                .vpc(vpc)
                .build();

        // Definir um output para o ARN do bucket S3
        CfnOutput bucketArnOutput = CfnOutput.Builder.create(this, "BucketArnOutput")
                .description("The ARN of the S3 bucket")
                .value(bucket.getBucketArn())
                .exportName("BucketArn")
                .build();

        // Definir um output para o ID da instância EC2
        CfnOutput instanceIdOutput = CfnOutput.Builder.create(this, "InstanceIdOutput")
                .description("The ID of the EC2 instance")
                .value(instance.getInstanceId())
                .exportName("InstanceId")
                .build();

        // Definir um output para o ID da VPC
        CfnOutput vpcIdOutput = CfnOutput.Builder.create(this, "VpcIdOutput")
                .description("The ID of the VPC")
                .value(vpc.getVpcId())
                .exportName("VpcId")
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyCfnOutputsProjectStack(app, "MyCfnOutputsProjectStack");

        app.synth();
    }
}
```

#### Utilizando os valores exportados

```java
public class MyImportStack extends Stack {
    public MyImportStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyImportStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Importar o ID da VPC da outra stack
        String vpcId = Fn.importValue("VpcId");

        // Importar o ARN do bucket S3 da outra stack
        String bucketArn = Fn.importValue("BucketArn");

        // Usar o ID da VPC importado
        Vpc vpc = Vpc.fromVpcAttributes(this, "ImportedVpc", Vpc.VpcAttributes.builder()
                .vpcId(vpcId)
                .availabilityZones(java.util.Collections.singletonList("us-east-1a"))
                .build());

        // Usar o ARN do bucket S3 importado
        Bucket bucket = Bucket.fromBucketArn(this, "ImportedBucket", bucketArn);

        // Criação de recursos adicionais na VPC importada e uso do bucket importado conforme necessário
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyImportStack(app, "MyImportStack");

        app.synth();
    }
}
```

#### Implantando a Stack com Outputs

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a Stack com Outputs na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Output para ARN do Bucket S3

- **Descrição**: The ARN of the S3 bucket
- **Valor**: ARN do bucket S3 criado
- **Nome de Exportação**: BucketArn

#### Output para ID da Instância EC2

- **Descrição**: The ID of the EC2 instance
- **Valor**: ID da instância EC2 criada
- **Nome de Exportação**: InstanceId

#### Output para ID da VPC

- **Descrição**: The ID of the VPC
- **Valor**: ID da VPC criada
- **Nome de Exportação**: VpcId

### Boas Práticas

- **Nomeação de Exports**: Use nomes de exportação únicos e descritivos para evitar conflitos ao usar os valores em outras stacks.
- **Descrição Clara**: Sempre adicione descrições claras aos outputs para facilitar o entendimento.
- **Uso de Outputs**: Utilize outputs para compartilhar informações importantes entre stacks ou para exibir informações críticas ao final da implantação.
- **Segurança**: Seja cauteloso ao exportar informações sensíveis.

### Conclusão

Usar outputs do CloudFormation no AWS CDK com Java oferece uma maneira eficaz de compartilhar informações entre stacks e exibir valores importantes após a implantação. Ao seguir os passos e práticas recomendadas descritas acima, você pode configurar stacks que exportam valores úteis e reutilizáveis, atendendo às necessidades da sua aplicação ou serviço.