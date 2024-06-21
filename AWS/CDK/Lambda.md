# Lambda

### O que é AWS Lambda?

AWS Lambda é um serviço de computação serverless que executa seu código em resposta a eventos e gerencia automaticamente os recursos de computação subjacentes para você. Ele permite que você execute código sem provisionar ou gerenciar servidores, ideal para aplicativos que podem ser divididos em funções pequenas e independentes.

### Principais Componentes de uma Função Lambda

1. **Função**: O código que será executado em resposta a eventos.
2. **Triggers**: Eventos que disparam a execução da função (ex.: S3, DynamoDB, API Gateway).
3. **Permissões**: Define quais recursos a função pode acessar e quais eventos podem dispará-la.
4. **Camadas**: Adiciona bibliotecas externas que a função pode usar.

### Criando uma Função Lambda usando CDK em Java

#### Definindo a Função Lambda

Edite o Stack para incluir a configuração da função Lambda:

```java
public class MyLambdaProjectStack extends Stack {
    public MyLambdaProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyLambdaProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Definir a role IAM para a função Lambda
        Role lambdaRole = Role.Builder.create(this, "LambdaRole")
                .assumedBy(new ServicePrincipal("lambda.amazonaws.com"))
                .managedPolicies(java.util.Arrays.asList(
                        ManagedPolicy.fromAwsManagedPolicyName("service-role/AWSLambdaBasicExecutionRole")
                ))
                .build();

        // Criar a função Lambda
        Function myFunction = Function.Builder.create(this, "MyLambdaFunction")
                .functionName("MyFunction")
                .runtime(Runtime.NODEJS_14_X)
                .handler("index.handler")
                .code(Code.fromAsset("lambda"))  // Código da função armazenado na pasta 'lambda'
                .role(lambdaRole)
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyLambdaProjectStack(app, "MyLambdaProjectStack");

        app.synth();
    }
}
```

### Estrutura do Projeto Lambda

Crie uma pasta chamada `lambda` na raiz do seu projeto e adicione um arquivo `index.js` com o seguinte conteúdo:

```javascript
exports.handler = async (event) => {
    console.log("Evento recebido:", event);
    return {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
};
```

#### Implantando a Função Lambda

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a Função Lambda na AWS**:
   ```bash
   cdk deploy
   ```