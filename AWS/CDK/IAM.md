# IAM 

### O que é AWS IAM?

AWS Identity and Access Management (IAM) permite que você gerencie o acesso aos serviços e recursos da AWS de forma segura. Você pode criar e gerenciar usuários e grupos de usuários e usar permissões para permitir ou negar acesso aos recursos da AWS.

### Principais Componentes do IAM

1. **Usuários**: Entidades que representam uma pessoa ou um serviço que interage com a AWS.
2. **Grupos**: Coleções de usuários para os quais você pode atribuir permissões.
3. **Roles**: Identidades com permissões específicas que os usuários da AWS, serviços ou contas assumem temporariamente.
4. **Políticas**: Documentos JSON que definem permissões para ações sobre recursos.

### Configurando o IAM usando CDK em Java

#### Definindo Usuários, Roles e Políticas IAM

Edite o arquivo `src/main/java/com/myiamproject/MyIAMProjectStack.java` para incluir a configuração do IAM:

```java
public class MyIAMProjectStack extends Stack {
    public MyIAMProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyIAMProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar uma política gerenciada personalizada
        ManagedPolicy myManagedPolicy = ManagedPolicy.Builder.create(this, "MyManagedPolicy")
                .statements(java.util.Arrays.asList(
                        PolicyStatement.Builder.create()
                                .actions(java.util.Arrays.asList("s3:ListBucket", "s3:GetObject"))
                                .resources(java.util.Arrays.asList("arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"))
                                .build()
                ))
                .build();

        // Criar um usuário IAM com a política gerenciada
        User myUser = User.Builder.create(this, "MyUser")
                .managedPolicies(java.util.Arrays.asList(myManagedPolicy))
                .build();

        // Criar uma role IAM para uma função Lambda
        Role lambdaRole = Role.Builder.create(this, "LambdaRole")
                .assumedBy(new ServicePrincipal("lambda.amazonaws.com"))
                .managedPolicies(java.util.Arrays.asList(
                        ManagedPolicy.fromAwsManagedPolicyName("service-role/AWSLambdaBasicExecutionRole")
                ))
                .build();

        // Adicionar uma política inline à role
        Policy inlinePolicy = Policy.Builder.create(this, "InlinePolicy")
                .statements(java.util.Arrays.asList(
                        PolicyStatement.Builder.create()
                                .actions(java.util.Arrays.asList("dynamodb:Query", "dynamodb:Scan"))
                                .resources(java.util.Arrays.asList("arn:aws:dynamodb:us-east-1:123456789012:table/my-table"))
                                .build()
                ))
                .build();

        lambdaRole.attachInlinePolicy(inlinePolicy);
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyIAMProjectStack(app, "MyIAMProjectStack");

        app.synth();
    }
}
```

#### Implantando as Configurações IAM

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a configuração IAM na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Usuário IAM com Política Gerenciada

- **Managed Policy**: Permissões para listar e obter objetos do bucket S3.
- **Usuário IAM**: Atribuído com a política gerenciada.

#### Role IAM para Lambda com Política Inline

- **Role**: Permissões básicas de execução do Lambda.
- **Inline Policy**: Permissões para consultar e escanear uma tabela DynamoDB específica.
