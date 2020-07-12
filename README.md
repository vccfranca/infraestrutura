# Tutorial infraestrutura

Montando uma infraestrutura com deployment automatizado com aplicações multi-cloud.

**Vamos criar conta na AWS e Azure para conseguirmos executar os passos seguintes**
  * [AWS](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
  * [AZURE](https://azure.microsoft.com/en-us/free/search/?&ef_id=Cj0KCQjw6ar4BRDnARIsAITGzlBZcWUpKQEvvPfJj7WTrwAq9z2m7yYttgZYmOOqKsT-SlC7HBxmibcaAnmQEALw_wcB:G:s&OCID=AID2100014_SEM_Cj0KCQjw6ar4BRDnARIsAITGzlBZcWUpKQEvvPfJj7WTrwAq9z2m7yYttgZYmOOqKsT-SlC7HBxmibcaAnmQEALw_wcB:G:s&dclid=CjgKEAjw6ar4BRDimfbH0p7znRYSJABLJXnin26MZ93jiWKaMa3wUerzn6ovuHkb0njVmse9a15ViPD_BwE)
  
**Ferramentas utilizadas, clicar no link para instalação**
  * [Terraform](https://www.terraform.io/downloads.html)
  * [AWS-Cli](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/install-cliv2.html)
  * [AZURE-CLI](https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli?view=azure-cli-latest)
  * [KUBERNETES](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  * [GIT](https://git-scm.com/downloads)
***

## **Configurando VPN site-to-site para comunicar as aplicações criadas AWS com banco de dados na Azure*

```
1 - Criar Virtual NetWork Azure
  1.1 - No menu de pesquisa digitamos "Virtual NetWorks" clicamos em cima do nome
  1.2 - Vamos no menu add
  1.3 - Clicar em "create new" para criar um novo "Resource group"
  1.4 - Da um nome para sua Virutal NetWork
  1.5 - Escolher a região que ela vai subir.
  1.6 - Menu IP Addreses para configurarmos a faixa de ip.
  1.7 - Pode deixar a faixa que vem padrão apenas adicionando uma subnet
  1.7.1 - Obs: A subnet deve ter a mesma faixa contida na virtual network
  1.8 - Clicar em create
2 - Criar Virtual Network Gateway
  2.1 - No menu de pesquisa digitamos "Virtual network gateways" clicamos em cima do nome
  2.2 - Vamos no menu add
  2.3 - Da um nome para sua Virtual Network Gateway
  2.4 - O Gateway type deixa marcado com VPN
  2.5 - O VPN type deixa marcado com Route-based
  2.6 - No SKU escolhemos o tipo basic
  2.7 - O Virtual NetWork escolhemos o que criamos no item 1.
  2.8 - Clicar em create
  2.9 - Agora vamos pegar o ip public que foi gerado para que possamos configurar na AWS
  2.9.1 - Obs: O processo acima pode levar alguns minutos para ser criardo.
3 -  Agora vamos configura a VPC na nossa conta da AWS
  3.1 - No menu de pesquisa digitamos "VPC" clicamos em cima do nome
  3.2 - Dentro da VPC vamos procurar o menu "VIRTUAL PRIVATE NETWORK (VPN) => Customer Gateways"
  3.3 - Clicar em "Create Customer Gateway" colocamos uma "Name"
  3.4 - Routing deixamos como "Static"
  3.5 - IP Address usamos o ip que foi criado no item 2.9, os itens "Certificate ARN, Device" não precisa preencher
  3.6 - Ainda no menu "VIRTUAL PRIVATE NETWORK (VPN)" entramos na aba "Virtual Private Gateway" clicamos em "Create Virtual Private Gateway"
  3.7 - Damos um nome e clicamos em criar
  3.8 - Agora no menu "VIRTUAL PRIVATE NETWORK (VPN) => Site-to-Site VPN Connections" clicamos em Create VPN Connection
  3.9 - Colocamos o "Name tag" e selecionamos a Virtual Private Gateway, Customer Gateway ID feitas nos itens anterios e o Tunnel Options pode deixar default
 4.0 - Criado o item acima vamos fazer o download das configurações no botão Download Configuration" ao lado do Create VPN Connection.
 4.0.1 - Obs: Na hora de baixar escolha o tipo "Vendor Geneic"
 4.1 - Vamos no menu "VIRTUAL PRIVATE CLOUD => Route Tables" e vamos adicionar a faixa de interno criado dentro da Azure no item 1.6
 4.1.1 - Obs: Pode conseguir essa infromação voltando ao console da Azure "Virtual NetWorks" ao entrar no virtual network criado na aba Overview 
              consgue essa informação no campo "Address space"
5 - Para finalizarmos vamos voltar ao console da Azure e passar as informações da VPN criada na AWS
 5.1 - Na busca digitamos "Local NetWork gateways" em seguida selecionamos o botão add
 5.2 - Damos um nome, o campo "ID address" vamos pegar no arquivo que fizemos download "Outside IP Addresses => Virtual Private Gateway"
 5.3 - Em seguida o campo "Address space" vamos colocar nossa faixa de ip defaul que podemos encontrar na AWS "VIRTUAL PRIVATE CLOUD => Your VPCs => CIDR Blocks"
 5.4 - "Resource group" vamos escolher o group criado no item 2.1 e cliacamos em criar
 5.6 - Voltando no menu de busca colocamos "Virtual network gateway" entramos na configuração feita, e vamos no menu "Connections"
 5.7 - Colocamos um nome, no "Connection Type" selecionamos a opção Site-to-Site(IPsec)
 5.8 - O campo "Shared key (PSK)" também vamos encontrar no arquivo de download feito na AWS "Pre-Shared Key" copiamos a chave e adicionamos dentro do campo na Azure
 5.9 - Caso ja tenha 2 instâcias em execução nas 2 clouds, basta executar o comando "ping ip-interno-maquina-destino"
```
***

## **Criando o cluster kubernets na AWS*

```
1 - Fazer o clone do projeto
    git clone git@github.com:vccfranca/infraestrutura.git
  1.1 - Para que possamos executar os camandos abaixo, temos de ter um usuário na AWS com permissões no IAM "Identity and Access Management".
  1.2 - Vamos buscar por "IAM" no grid de busca, na tela do IAM clicamos no menu "Users" em seguida "Add User"
  1.3 - Escolhemos o nome do usuário, "Access type" como "Programmatic access", clicamos em "Next" adicionamos 
        um grupo com as permissões "AdministratorAccess, AmazonEKSClusterPolicy", avanço até o final onde vai aparecer a opção de baixar as credencias de acesso.
    1.3.1 - Obs: Manter as credencias de forma segura e não compartilhar
  1.4 - Escolha um diretorio para criar o arquivo "credentials" a ser usardo na criação do kluster.
    1.4.1 - Ex:
            mkdir /home/meu_usuario/.aws/credentials
    1.4.2 - Parametros dentro do arquivo: 
            [nome_profile_para_nos_providers]
            aws_access_key_id = "informação no arquivo gerado no item 1.3"
            aws_secret_access_key = "informação no arquivo gerado no item 1.3"
  1.5 - Considerando que estamos na raiz do projeto clone, vamos executar o comando:
        cd infraestrutura/terraform/eks/
  1.6 - Com um editor de texto da sua preferencia vamos editar os seguintes arquivos: "provider-k8s.tf, main-k8s.tf"
    1.6.1 - No arquivo provider-k8s.tf, alterar o caminho da variavel "shared_credentials_file e profile" com os valores criado no item 1.4.2
    1.6.2 - No arquivo "main-k8s.tf" vamos editar os subnet_ids de acordo com o painel AWS no menu "VPC => VIRTUAL PRIVATE CLOUD => Subnets".        
  1.7 - Vamos executar os comandos para criar o kluster
        $ terraform init
            Obs: Caso tenho problema no comando acima verificar se foi instalado corretamente.
            * [Configurando Terraform](https://learn.hashicorp.com/terraform/getting-started/install)
        $ terraform.exe apply
            Obs: Após a execução do comando ele vai te mostra na tela as informações de tudo que ele irá criar dentro da AWS, ao final vai 
                 esperar uma confirmação "yes/no" se deve ou não criar o kluster.
        $ terraform.exe destroy
            Obs: O comando destroy vai desfazer tudo o que foi criado no comando appy. "Antes de desfazer ele também espera uma confiração"
        
            
             
  
  
```


