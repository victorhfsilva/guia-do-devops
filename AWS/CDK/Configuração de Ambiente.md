# Configuração do Ambiente para AWS CDK

O AWS Cloud Development Kit (CDK) é uma ferramenta poderosa que permite definir infraestruturas de nuvem usando linguagens de programação conhecidas. Este guia irá ajudá-lo a configurar seu ambiente para começar a trabalhar com o AWS CDK.

## Pré-requisitos

Antes de começar, certifique-se de ter o seguinte:

1. **Conta na AWS**: Se você ainda não tem uma conta na AWS, crie uma em [aws.amazon.com](https://aws.amazon.com/).
2. **Node.js**: O AWS CDK é uma ferramenta baseada em Node.js. Certifique-se de ter o Node.js instalado. Você pode baixar e instalar o Node.js a partir de [nodejs.org](https://nodejs.org/).
3. **AWS CLI**: A AWS Command Line Interface (CLI) é necessária para configurar suas credenciais de AWS. Siga as instruções em [aws.amazon.com/cli](https://aws.amazon.com/cli/) para instalar a AWS CLI.

## Instalar o AWS CDK

1. Abra seu terminal ou prompt de comando.
2. Execute o comando abaixo para instalar o CDK globalmente usando npm (Node Package Manager):

   ```bash
   npm install -g aws-cdk
   ```

3. Verifique a instalação executando o comando:

   ```bash
   cdk --version
   ```

## Configurar Credenciais da AWS

1. Configure suas credenciais da AWS usando o AWS CLI. No terminal, execute:

   ```bash
   aws configure
   ```

2. Insira suas credenciais de acesso, ID da chave de acesso e a chave secreta. Você também precisará fornecer a região padrão (por exemplo, `sa-east-1`) e o formato de saída padrão (por exemplo, `json`).

## Criar um Novo Projeto CDK

1. Crie um novo diretório para o seu projeto CDK e navegue até ele:

   ```bash
   mkdir meu-projeto-cdk
   cd meu-projeto-cdk
   ```

2. Inicialize um novo projeto CDK para Java:

   ```bash
   cdk init app --language java
   ```

## Estrutura do Projeto

Após inicializar o projeto, a estrutura do diretório será similar a esta:

```plaintext
meu-projeto-cdk/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── myorg/
│   │   │           └── MeuProjetoCdkApp.java
│   │   │           └── MeuProjetoCdkStack.java
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

- **src/main/java**: Contém o código-fonte Java.
- **src/test/java**: Contém os testes Java.
- **cdk.json**: Arquivo de configuração do CDK.
- **pom.xml**: Arquivo de configuração do Maven.

## Definir a Infraestrutura

1. Edite o arquivo `src/main/java/com/myorg/MeuProjetoCdkStack.java` para definir os recursos da AWS. Por exemplo, para criar um bucket S3:

   ```java
   package com.myorg;

   import software.amazon.awscdk.core.*;
   import software.amazon.awscdk.services.s3.Bucket;

   public class MeuProjetoCdkStack extends Stack {
       public MeuProjetoCdkStack(final Construct scope, final String id) {
           this(scope, id, null);
       }

       public MeuProjetoCdkStack(final Construct scope, final String id, final StackProps props) {
           super(scope, id, props);

           Bucket.Builder.create(this, "MeuBucket")
                   .versioned(true)
                   .build();
       }
   }
   ```

## Build e Deploy da Infraestrutura

1. Compile o projeto usando Maven:

   ```bash
   mvn compile
   ```

2. Use o comando `cdk deploy` para fazer o deploy da stack:

   ```bash
   cdk deploy
   ```

3. O CDK irá mostrar um resumo das mudanças que serão aplicadas e solicitará confirmação para proceder.

## Limpar Recursos

1. Para destruir a stack criada e limpar os recursos, use:

   ```bash
   cdk destroy
   ```

## Conclusão

Você configurou com sucesso seu ambiente para desenvolver infraestruturas na AWS usando o CDK com Java. Agora, você pode explorar mais recursos e serviços da AWS, integrar testes automatizados e continuar a construir soluções de nuvem robustas e escaláveis.

Se precisar de mais informações, consulte a [documentação oficial do AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/home.html).