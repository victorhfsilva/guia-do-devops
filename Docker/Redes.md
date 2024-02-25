# Docker

## Redes

O Docker oferece recursos poderosos para gerenciar redes entre contêineres. Aqui estão alguns comandos úteis:

### Listando Redes

Para listar todas as redes disponíveis no Docker, use o comando:

```bash
docker network ls
```

Este comando exibirá uma lista das redes disponíveis, juntamente com seus IDs e drivers.

### Inspecionando uma Rede

Você pode inspecionar detalhes específicos sobre uma rede usando o comando `docker network inspect`.

```bash
docker network inspect <nome_da_rede>
```

Por exemplo, para inspecionar a rede padrão chamada "bridge", você pode usar:

```bash
docker network inspect bridge
```

Isso fornecerá informações detalhadas sobre a configuração da rede, incluindo os contêineres conectados a ela.

### Criando uma Rede

Se você precisar criar uma nova rede para seus contêineres, use o comando `docker network create`.

```bash
docker network create --driver bridge <nome_da_rede>
```

Por exemplo, para criar uma rede chamada "home-lab", você pode usar:

```bash
docker network create home-lab
```

Depois de criar a rede, você pode iniciar os contêineres e conectá-los a essa rede usando a opção `--network`.

```bash
docker run -dti --name Ubuntu-A --network home-lab ubuntu
docker run -dti --name Ubuntu-B --network home-lab ubuntu
```

Isso iniciará dois contêineres chamados "Ubuntu-A" e "Ubuntu-B" e os conectará à rede "home-lab".

### Tipos de Drivers de Rede

O Docker suporta diferentes tipos de drivers de rede para atender a diferentes necessidades de conectividade. Aqui estão alguns dos tipos mais comuns:

#### Bridge

O driver de rede "bridge" é o driver padrão usado quando nenhum driver é especificado ao criar uma rede. Ele cria uma rede interna isolada no host Docker, na qual os contêineres podem se comunicar entre si. Este é o tipo de rede mais comum para a maioria dos casos de uso.

#### Host

O driver de rede "host" remove o isolamento de rede entre o contêiner e o host Docker. Com este driver, o contêiner compartilha diretamente a interface de rede do host, o que significa que eles compartilham o mesmo espaço de rede. Isso pode ser útil em casos onde você deseja que o contêiner seja acessível diretamente no host.

#### None

O driver de rede "none" remove completamente a interface de rede do contêiner. Isso significa que o contêiner não terá conectividade de rede externa. Essa configuração pode ser útil em situações onde você deseja que o contêiner execute tarefas internas sem comunicação externa.

### Conectando um container a rede

Para conectar um contêinera uma rede Docker, você pode usar o comando `docker network connect`. Este comando permite conectar um contêiner a uma rede específica, tornando-o acessível a outros contêineres na mesma rede.

```bash
docker network connect <nome_da_rede> <nome_do_contêiner>
```

Já para desconectar, basta:

```bash
docker network disconnect <nome_da_red> <nome_do_container>
```