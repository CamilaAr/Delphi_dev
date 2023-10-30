O sistema está finalizado, com algumas ressalvas:

Foi optado finalizar todas as funcionalidades utilizando orientação a eventos ao invés de orientação a objetos por questão de tempo e cuidado com erros.


O arquivo ini a ser editado com as configuraçõs do banco é:
	Delphi_dev\Win32\Debug
É recomendável compilar o projeto apenas e 32 bits, uma vez que a biblioteca FIREDAC aceita somente banco de 32 bits quando se utiliza MySQL. Com 32 bits funcionará perfeitamente em qualquer máquina



É possí­vel acessar o arquivo dump do banco pelo arquivo banco.sql na raiz do projeto

O sistema apresenta um menu inicial com botões abaixo dele para selecionar as telas de:
Clientes: Visualização, Cadastro e edição.
Produtos: Visualização, Cadastro e edição.
PDV: Realização de vendas, inserção e edição de itens na venda, cancelamento de itens, totalização, listagem de produtos, cancelamento de venda, gravação de venda, busca de cliente e produto por id, acessar uma venda já feita.


Ao entrar no sistema vão ter duas opções antigas no fim da tela, essas opções foram as implementadas anteriormente e carregam um pouco de orientação a objetos:
Produtos:
	Para acessar é necessário digitar um código de cliente existente no banco.
	Traz uma listagem de produtos, a qual é possível editar cliando no campo desejado
	É possível excluir clicando na linha desejada e apertando delete
	É possível também pesquisar em tempo real em qualquer coluna da tabela pelo edit da tela

Venda:
	Está incompleto
