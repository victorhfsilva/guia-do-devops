# Estrutura de um Aplicativo AWS CDK: App, Stack e Construct

O AWS Cloud Development Kit (CDK) é organizado em três componentes principais: App, Stack e Construct.

## App (Aplicativo)

### Descrição
Um App no CDK representa a aplicação completa. Ele serve como o contêiner raiz para todos os recursos de infraestrutura que você deseja definir e implantar.

### Função
- Inicializa e encapsula uma ou mais Stacks.
- Define a entrada principal do programa CDK.

### Exemplo em Java

```java
public class MeuProjetoCdkApp {
    public static void main(final String[] args) {
        App app = new App();

        new MeuProjetoCdkStack(app, "MeuProjetoCdkStack");

        app.synth();
    }
}
```

## Stack (Pilha)

### Descrição
Uma Stack no CDK representa uma unidade de implantação única. Cada Stack é convertida em um modelo CloudFormation que define um conjunto de recursos da AWS que serão implantados juntos.

### Função
- Organiza e agrupa recursos relacionados.
- Pode ser composta de múltiplas Stacks dentro de um único App.

### Exemplo em Java

```java
public class MeuProjetoCdkStack extends Stack {
    public MeuProjetoCdkStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MeuProjetoCdkStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        Bucket bucket = Bucket.Builder.create(this, "MeuBucket")
                                      .versioned(true)
                                      .build();
    }
}
```

## Construct

### Descrição
Um Construct é a unidade básica de abstração no CDK. Ele pode representar qualquer coisa, desde um recurso individual da AWS (como um Bucket S3) até um conjunto mais complexo de recursos.

### Função
- Abstrai recursos e composições de recursos.
- Pode ser reutilizado e aninhado dentro de outros Constructs.

### Exemplo em Java

```java
public class MeuBucketConstruct extends Construct {
    public MeuBucketConstruct(final Construct scope, final String id) {
        super(scope, id);

        Bucket bucket = Bucket.Builder.create(this, "MeuBucketConstruct")
                                      .versioned(true)
                                      .build();
    }
}
```

### Utilizando Construct na Stack

```java
public class MeuProjetoCdkStack extends Stack {
    public MeuProjetoCdkStack(final Construct scope, final String id) {
        this(scope, id, null);
    }

    public MeuProjetoCdkStack(final Construct scope, final String id, final StackProps props) {
        super(scope, id, props);

        new MeuBucketConstruct(this, "MeuBucketConstruct");
    }
}
```

## Estrutura Geral do Projeto

A estrutura do projeto CDK com Java pode ser organizada da seguinte forma:

```plaintext
meu-projeto-cdk/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── myorg/
│   │   │           └── MeuProjetoCdkApp.java
│   │   │           └── MeuProjetoCdkStack.java
│   │   │           └── MeuBucketConstruct.java
│   ├── test/
│   │   └── java/
│   │       └── com/
│   │           └── myorg/
│   │               └── MeuProjetoCdkTest.java
├── .gitignore
├── cdk.json
├── pom.xml
└── README.md
```

## Conclusão

Compreender a estrutura de um aplicativo CDK é crucial para organizar e gerenciar eficazmente sua infraestrutura na AWS. O App serve como a raiz, agrupando várias Stacks, cada Stack define um conjunto de recursos que são implantados juntos, e os Constructs permitem a criação de abstrações reutilizáveis e compostas de recursos da AWS. Este guia oferece uma visão geral para começar a trabalhar com esses componentes no AWS CDK usando Java.