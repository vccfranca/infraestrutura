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
  * [DOCKER](https://docs.docker.com/get-docker/)
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
2 - Criar Virtual Network Gateway
  2.1 - No menu de pesquisa digitamos "Virtual network gateways" clicamos em cima do nome
  2.2 - Vamos no menu add
  2.3 - 
  
  
  
  
```

***
