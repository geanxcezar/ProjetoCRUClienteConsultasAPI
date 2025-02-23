Sistema de Cadastro de Clientes
Este projeto é um sistema de cadastro de clientes desenvolvido em Delphi. Ele permite o gerenciamento de informações de clientes, incluindo dados pessoais, endereços e coordenadas geográficas. 
O sistema também oferece funcionalidades de impressão de relatórios e integração com APIs externas para consulta de CEP, CNPJ e código IBGE.

Funcionalidades
Cadastro de Clientes:

Inclusão, alteração e exclusão de clientes.
Validação de CPF e CNPJ.
Consulta de CEP via API para preenchimento automático de endereço.
Consulta de CNPJ via API para preenchimento automático de dados da empresa.
Consulta de código IBGE via API para preenchimento automático de coordenadas geográficas.

Pesquisa de Clientes:
Filtragem de clientes por nome, CPF, CNPJ, CEP, endereço, bairro, cidade, UF, etc.

Impressão de Relatórios:
Geração de relatórios com os dados dos clientes.

Integração com APIs:
ViaCEP para consulta de endereços.
ReceitaWS para consulta de CNPJ.
IBGE para consulta de código de municípios e coordenadas geográficas.

Pré-requisitos
Delphi (versão XE ou superior).

Banco de Dados:

O sistema utiliza um banco "FIREBIRD" de dados para armazenar as informações dos clientes. Certifique-se de que o banco de dados esteja configurado e acessível.

APIs Externas:
ViaCEP: https://viacep.com.br
ReceitaWS: https://receitaws.com.br
IBGE: https://servicodados.ibge.gov.br

Configuração
Banco de Dados: em anexo ao projeto;


Compilação:
Abra o projeto no Delphi.
Compile e execute o projeto.

Como Usar:
Cadastro de Clientes:
Na tela principal, clique em "Novo" para adicionar um novo cliente.
Preencha os campos obrigatórios e utilize as funcionalidades de consulta de CEP, CNPJ e IBGE para preenchimento automático.

Clique em "Gravar" para salvar o cliente.

Pesquisa de Clientes:
Utilize o campo de pesquisa na tela principal para filtrar os clientes.
Clique duas vezes em um cliente para editá-lo.

Impressão de Relatórios:
Na tela principal do Cadastro de Clientes:
Clique em "Imprimir" para gerar o relatório com os clientes.

Estrutura do Projeto
uCadClientes.pas: Formulário principal do sistema, responsável pelo cadastro e pesquisa de clientes.
DMCadastros.pas: Módulo de dados, responsável pela conexão com o banco de dados e manipulação das queries.
Ufunc.pas: Unit com funções utilitárias, como validação de CPF e CNPJ.
ViaCEP.Intf, ViaCEP.Core, ViaCEP.Model: Units para integração com a API ViaCEP.
UCnpjAPI.Intf, UCnpjAPI.Core, UCnpjAPI.Model: Units para integração com a API ReceitaWS.
UIBGEAPI.Intf, UIBGEAPI.Core, UIBGEAPI.Model: Units para integração com a API IBGE.

