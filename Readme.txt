O sistema est� finalizado, algumas ressalvas:

Foi optado finalizar todas as funcionalidades utilizando orienta��o a eventos ao inv�s de orienta��o a objetos por quest�o de tempo e cuidado com erros.


O arquivo ini a ser editado com as configura��s do banco �:
	C:\Users\camila\Documents\Delphi_dev\Win32\Debug
� recomend�vel compilar o projeto apenas e 32 bits, uma vez que a biblioteca FIREDAC aceita somente banco de 32 bits quando se utiliza MySQL. Com 32 bits funcionar� perfeitamente em qualquer m�quina



� possível acessar o arquivo dump do banco pelo arquivo banco.sql

O sistema apresenta um menu inicial com bot�es abaixo dele para selecionar as telas de:
Clientes: Visaliza��o, Cadastro e edi��o.
Produtos: Visaliza��o, Cadastro e edi��o.
PDV: Realiza��o de vendas, inser��o e edi��o de itens na venda, cancelamento de itens, totaliza��o, listagem de produtos, cancelamento de venda, grava��o de venda, busca de cliente e produto por id, acessar uma venda j� feita.


Ao entrar no sistema v�o ter duas op��es antigas no fim da tela, essas op��es foram as implementadas anteriormente e carregam um pouco de orienta��o a objetos:
Produtos:
	Para acessar � necess�rio digitar um c�digo de cliente existente no banco.
	Traz uma listagem de produtos, a qual � poss�vel editar cliando no campo desejado
	� poss�vel excluir clicando na linha desejada e apertando delete
	� poss�vel tamb�m pesquisar em tempo real em qualquer coluna da tabela pelo edit da tela

Venda:
	Est� incompleto
