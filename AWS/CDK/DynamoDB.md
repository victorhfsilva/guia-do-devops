# DynamoDB

### O que é o Amazon DynamoDB?

Amazon DynamoDB é um serviço de banco de dados NoSQL gerenciado que fornece desempenho rápido e previsível com escalabilidade perfeita. Ele é ideal para aplicativos que requerem baixa latência de acesso a dados e alta taxa de transferência de dados.

### Principais Componentes de uma Tabela DynamoDB

1. **Tabela**: Estrutura principal de armazenamento de dados no DynamoDB.
2. **Chave Primária**: Definida por um atributo de partição (ou uma combinação de partição e classificação).
3. **Atributos**: Dados armazenados na tabela, organizados em itens.
4. **Índices**: Ajudam a acelerar as consultas, incluindo índices secundários locais (LSI) e globais (GSI).
5. **Provisionamento de Capacidade**: Determina a taxa de transferência de leitura e escrita.
6. **Streams**: Permitem capturar mudanças nos itens da tabela.

### Criando uma Tabela DynamoDB usando CDK em Java

#### Definindo a Tabela DynamoDB

Edite o Stack para incluir a configuração da tabela DynamoDB:

```java
public class MyDynamoDBProjectStack extends Stack {
    public MyDynamoDBProjectStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MyDynamoDBProjectStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        // Criar a Tabela DynamoDB
        Table table = Table.Builder.create(this, "MyDynamoDBTable")
                .tableName("MyTable")
                .partitionKey(Attribute.builder()
                        .name("id")
                        .type(AttributeType.STRING)
                        .build())
                .sortKey(Attribute.builder()
                        .name("sortKey")
                        .type(AttributeType.STRING)
                        .build())
                .billingMode(BillingMode.PAY_PER_REQUEST)  // Modo de cobrança on-demand
                .stream(StreamViewType.NEW_AND_OLD_IMAGES)  // Configurar Streams
                .build();
    }

    public static void main(final String[] args) {
        App app = new App();

        new MyDynamoDBProjectStack(app, "MyDynamoDBProjectStack");

        app.synth();
    }
}
```

#### Implantando a Tabela DynamoDB

1. **Compilar o projeto**:
   ```bash
   mvn compile
   ```

2. **Criar o ambiente CDK na AWS**:
   ```bash
   cdk bootstrap
   ```

3. **Implantar a Tabela DynamoDB na AWS**:
   ```bash
   cdk deploy
   ```

### Exemplos de Configurações

#### Tabela DynamoDB com Chave de Partição e Chave de Classificação

- **Partition Key**: `id` (tipo STRING)
- **Sort Key**: `sortKey` (tipo STRING)
- **Billing Mode**: PAY_PER_REQUEST para escalabilidade automática com base no tráfego.
- **Streams**: Habilitado para capturar imagens novas e antigas de itens.
