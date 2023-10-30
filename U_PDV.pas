unit U_PDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TF_PDV = class(TForm)
    StatusBar1: TStatusBar;
    pnl_pdv_baixo: TPanel;
    dbg_lancamento: TDBGrid;
    edt_pro_descr: TEdit;
    edt_pro_preco: TEdit;
    edt_pro_qtd: TEdit;
    btn_pro_add: TButton;
    edt_total: TEdit;
    Label1: TLabel;
    btn_gravar_venda: TButton;
    btn_cancelar_venda: TButton;
    btn_remove_item: TButton;
    edt_cli_codigo: TEdit;
    edt_cli_nome: TEdit;
    edt_pro_cod: TEdit;
    btn_iniciar_venda: TButton;
    desc: TLabel;
    QRY_VerificaVenda: TFDQuery;
    tb_pedido: TFDTable;
    tb_pedidoNumeroPedido: TFDAutoIncField;
    tb_pedidoDataEmissao: TDateField;
    tb_pedidoCodigoCliente: TIntegerField;
    tb_pedidoValorTotal: TBCDField;
    QRY_Itens: TFDQuery;
    btnEditar: TButton;
    QRY_CancelaVenda: TFDQuery;
    procedure edt_cli_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_pro_codKeyPress(Sender: TObject; var Key: Char);
    procedure BloqueiaCampos;
    procedure LiberaCampos;
    procedure IniciaVendas;
    procedure ProdutosAdd;
    procedure UpdateLista;
    procedure ReabrirVenda;
    procedure FormCreate(Sender: TObject);
    procedure btn_iniciar_vendaClick(Sender: TObject);
    procedure btn_pro_addClick(Sender: TObject);
    procedure edt_pro_qtdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbg_lancamentoDblClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure edt_pro_qtdExit(Sender: TObject);
    procedure edt_cli_nomeChange(Sender: TObject);
    procedure dbg_lancamentoKeyPress(Sender: TObject; var Key: Char);
    procedure btn_remove_itemClick(Sender: TObject);
    procedure dbg_lancamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_cancelar_vendaClick(Sender: TObject);
    procedure btn_gravar_vendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoVenda : string; //guarda o codigo da venda atual
    DataPedido : string; //guarda a data do pedido
    TotalPedido : double; //guarda o total do pedido
    ItemId, qtd: Integer; //Guarda o id do item do pedido e a quantidade
    NomeProduto : string; //guarda o nome do produto
    pre�o : double; //guarda o pre�o do item
    podeFechar : bool; //permite o usu�rio fechar a tela
  end;

var
  F_PDV: TF_PDV;

implementation

{$R *.dfm}

uses DM, U_Funcoes;



procedure TF_PDV.btnEditarClick(Sender: TObject);
begin
  //Recebe a nova quantidade no produto selecionado
  with QRY_Itens do
  begin
    close;
    SQL.Clear;
    SQL.Add('update pedidosprodutos set Quantidade = :qtd, ValorTotal = :total ');
    SQL.Add('where Autoincrem = :id ');
    ParamByName('qtd').Value := edt_pro_qtd.Text;
    ParamByName('id').Value := ItemId;
    ParamByName('total').Value := StrToFloat(edt_pro_qtd.Text) * StrToFloat(edt_pro_preco.text);  //calcula o total
    execSQL;
  end;

  ShowMessage ('Produto editado com sucesso!');
  //atualiza listagem de itens no pedido
  UpdateLista;
   //Ap�s a edi��o � necess�rio liberar e bloquear alguns elementos
  edt_pro_cod.enabled := true;
  edt_pro_descr.enabled := true;
  edt_pro_preco.enabled := true;
  btn_pro_add.enabled := true;
  btnEditar.Enabled := false;


end;

procedure TF_PDV.btn_cancelar_vendaClick(Sender: TObject);
begin
  //primeiro cancelamos todos os produtos da venda
  with QRY_CancelaVenda do
  begin
    close;
    SQL.Clear;
    SQL.Add('Delete from pedidosprodutos where NumeroPedido = :numPedido');
    ParamByName('numPedido').Value := CodigoVenda;
    execSQL;
  end;
  //Agora cancelamos a venda total
  with QRY_CancelaVenda do
  begin
    close;
    SQL.Clear;
    SQL.Add('Delete from pedidosdadosgerais where NumeroPedido = :numPedido');
    ParamByName('numPedido').Value := CodigoVenda;
    execSQL;
  end;

  //libera o form para poder ser fechado
  podeFechar := true;

  ShowMessage('Pedido cancelado com sucesso!');

  //limpa a lista de pedidos
  CodigoVenda := '0';
  with DataMod.QRY_ListarPedido do
  begin
    close;
    SQL.Clear;
    SQL.Add('select * from view_listarpedido where G_NumeroPedido = :numPedido');
    ParamByName('numPedido').Value := CodigoVenda;
    Open;
  end;

  DataMod.QRY_ListarPedido.Close;
  BloqueiaCampos;
  Close; //fecha o formul�rio
end;

procedure TF_PDV.btn_gravar_vendaClick(Sender: TObject);
begin
  //Para gravar salvamos o novo valor total
  with QRY_VerificaVenda do
  begin
    SQL.Clear;
    SQL.Add('UPDATE pedidosdadosgerais');
    SQL.Add('SET ValorTotal = :novoValorTotal');
    SQL.Add('WHERE NumeroPedido = :codigo');
    ParamByName('novoValorTotal').Value :=  TotalPedido; // Novo valor para ValorTotal
    ParamByName('codigo').Value := CodigoVenda; // N�mero do pedido
    ExecSQL;
  end;
  podeFechar := true;//libera o formul�rio para ser fechado

  ShowMessage('Pedido gravado com sucesso!');

  CodigoVenda := '0';   //Limpa a lista
  with DataMod.QRY_ListarPedido do
  begin
    close;
    SQL.Clear;
    SQL.Add('select * from view_listarpedido where G_NumeroPedido = :numPedido');
    ParamByName('numPedido').Value := CodigoVenda;
    Open;
  end;

  DataMod.QRY_ListarPedido.Close;
  BloqueiaCampos;
  Close;  //fecha o formul�rio
end;

procedure TF_PDV.btn_iniciar_vendaClick(Sender: TObject);
begin
  edt_cli_codigo.Enabled := false;  //n�o pode mais mudar o cliente
  IniciaVendas;
end;

procedure TF_PDV.btn_pro_addClick(Sender: TObject);
begin
  //chama a fun��o de adicionar produtos
  if edt_pro_descr.Text = '' then
  begin
    ShowMessage('Produto n�o selecionado!');  //impede a chamada da fun��o se n�o tem produto selecionado
    exit;
  end;
  produtosAdd;
end;

procedure TF_PDV.btn_remove_itemClick(Sender: TObject);
var
  item, quantidade : integer;
begin
//recebemos o id do item selecionado e deletemos ele do banco
  item := dataMod.QRY_ListarPedido.FieldByName('Autoincrem').Value;
  with QRY_Itens do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM pedidosprodutos WHERE Autoincrem = :id');
    ParamByName('id').Value := item;
    ExecSQL;
  end;

  ShowMessage ('Produto exclu�do com sucesso!');
  //atualiza listagem de itens no pedido
  UpdateLista;

end;

procedure TF_PDV.dbg_lancamentoDblClick(Sender: TObject);

begin
  if dbg_lancamento.DataSource.DataSet.Active then
  begin
    // Verifica se h� uma linha selecionada no TDBGrid
    if not dbg_lancamento.DataSource.DataSet.IsEmpty then
    begin
      // Obt�m o valor da coluna que cont�m o ID da linha selecionada
      ItemId := dbg_lancamento.DataSource.DataSet.FieldByName('Autoincrem_PedidosProdutos').AsInteger;
      edt_pro_cod.Text := dbg_lancamento.DataSource.DataSet.FieldByName('Codigo').AsString;
      edt_pro_descr.text := dbg_lancamento.DataSource.DataSet.FieldByName('Descricao').AsString;
      edt_pro_preco.Text := dbg_lancamento.DataSource.DataSet.FieldByName('PrecoVenda').AsString;
      edt_pro_qtd.Text := dbg_lancamento.DataSource.DataSet.FieldByName('Quantidade_PedidosProdutos').AsString;
      edt_pro_cod.enabled := false;
      edt_pro_descr.enabled := false;
      edt_pro_preco.enabled := false;
      btn_pro_add.enabled := false;
      btnEditar.Enabled := true;

      ShowMessage ('Selecione a nova quantidade');
      //libera para selecionar a nova quantidade e salvar a edi��o

    end;
  end;
end;


procedure TF_PDV.dbg_lancamentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then  //se clicar em delete dentro de algum item da lista
                          //chama a fun��o para deletar
  begin
    btn_remove_itemClick(Sender);
  end;
end;

procedure TF_PDV.dbg_lancamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then //Se clicar em enter em algum item da lista, chama a fun��o de editar
  begin
    dbg_lancamentoDblClick(self);
  end;
end;

procedure TF_PDV.edt_cli_codigoKeyPress(Sender: TObject; var Key: Char);
begin
  //ao clicar enter no codigo do cliente, tras os dados dele
  if key = #13 then
  begin
    with DataMod.QRY_Cli do
     begin
       close;
       SQL.clear;
       SQL.add('select * from clientes ');
       SQL.add(' where Codigo = :codigo ');
       ParamByName('codigo').value :=  edt_cli_codigo.text;
       open;

       if recordcount = 0 then
       begin
         showMessage('Cliente n�o encontrado');
         edt_cli_nome.clear;
         edt_cli_codigo.clear;
       end
       else if recordcount = 1 then
       begin
         edt_cli_nome.text := dataMod.QRY_cliNome.AsString;
       end;




     end;

  end;

end;

procedure TF_PDV.edt_cli_nomeChange(Sender: TObject);
begin  //se o nome do cliente estiver vazio n�o permite iniciar venda
  btn_iniciar_venda.Enabled := true;
  if edt_cli_nome.Text = '' then
  begin
     btn_iniciar_venda.Enabled := false;
  end;

end;

procedure TF_PDV.BloqueiaCampos;
begin
  //bloqueia os campos at� que se inicie a venda
  edt_pro_descr.enabled := false;
  edt_pro_preco.enabled := false;
  edt_pro_cod.enabled := false;
  edt_pro_qtd.enabled := false;
  btn_pro_add.enabled := false;
  btn_cancelar_venda.enabled := false;
  btn_gravar_venda.enabled := false;
  btn_remove_item.enabled  := false;
  dbg_lancamento.enabled  := false;

end;

procedure TF_PDV.LiberaCampos;
begin
  //bloqueia os campos at� que se inicie a venda
  edt_pro_descr.enabled := true;
  edt_pro_preco.enabled := true;
  edt_pro_cod.enabled := true;
  edt_pro_qtd.enabled := true;
  btn_pro_add.enabled := true;
  btn_cancelar_venda.enabled := true;
  btn_gravar_venda.enabled := true;
  btn_remove_item.enabled  := true;
  dbg_lancamento.enabled  := true;

end;

//adiciona o produto dentro do pedido
procedure TF_PDV.ProdutosAdd;
var
  produto, qtd:integer;
  preco : double;
begin
  //dados do produto digitados na tela que vamos usar pra adicionar na lista
  produto := dataMod.QRY_ProdCodigo.Value;
  qtd :=  StrToInt(edt_pro_qtd.Text);
  preco := dataMod.QRY_ProdPrecoVenda.Value;

    //adiciona o produto com os dados passados
    with QRY_Itens do
    begin
      close;
      SQL.Clear;
      SQL.Add('insert into pedidosprodutos ');
      SQL.Add(' (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) ');
      SQL.Add('VALUES (:pedido, :produto, :qtd, :valor, :total) ');
      paramByName('pedido').Value := CodigoVenda;
      paramByName('produto').Value := produto;
      paramByName('qtd').Value := qtd;
      paramByName('valor').Value := preco;
      paramByName('total').Value := preco * qtd;
      execSQL;

      ShowMessage ('Produto Adicionado com Sucesso!');

      //atualiza listagem de itens no pedido
      UpdateLista;

    end;
    edt_pro_qtd.text := '1';  //qtd setada para 1





end;

procedure TF_PDV.ReabrirVenda;
//reabre uma venda j� feita
begin
  podeFechar := false; //bloqueia para o usu�rio n�o fechar a tela
  F_PDV.caption := 'Venda: ' + CodigoVenda;

  tb_pedido.active := true;
  //localiza a venda, se n�o pergunta ao usu�rio se quer reabrir uma venda de novo
  while not tb_pedido.Locate('NumeroPedido', CodigoVenda, []) do
  begin
    if MessageDlg('Id n�o encontrado. Deseja reabrir uma venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      CodigoVenda := InputBox('Informe o id da venda', 'Digite o id:', '');
      ReabrirVenda;
    end else
    begin
      exit;
      //se o usu�rio n�o quiser reabrir o sistema volta a rotina de novo pedido
    end;


  end;

  //se o usu�rio digitar uma venda que existe pegamos os valores para colocar na tela

  edt_cli_codigo.text := tb_pedidoCodigoCliente.AsString;
  with DataMod.QRY_Cli do
     begin
       close;
       SQL.clear;
       SQL.add('select * from clientes ');
       SQL.add(' where Codigo = :codigo ');
       ParamByName('codigo').value :=  edt_cli_codigo.text;
       open;

       if recordcount = 0 then
       begin
         showMessage('Cliente n�o encontrado');
         edt_cli_nome.clear;
         edt_cli_codigo.clear;
       end
       else if recordcount = 1 then
       begin
         edt_cli_nome.text := dataMod.QRY_cliNome.AsString;
       end;




     end;
     //Listamos os itens desse pedido na lista
     with DataMod.QRY_ListarPedido do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM view_ListarPedido');
        SQL.Add('WHERE G_NumeroPedido = :codigo');
        ParamByName('codigo').Value := CodigoVenda;
        Open;
      end;

      UpdateLista; //update para recarregar a lista

end;

procedure TF_PDV.UpdateLista;
begin
//atualiza a visualiza��o dos itens no pedido
  dataMod.QRY_listarPedido.close;
  dataMod.QRY_listarPedido.open;

  //pegando o total do pedido
  DataMod.QRY_ListarPedido.first;

  TotalPedido := 0;//zera o total e refaz a contagem para n�o gerar erros
  while not DataMod.QRY_ListarPedido.eof do
  begin
    TotalPedido := TotalPedido +  DataMod.QRY_ListarPedido.FieldByName('ValorTotal').Value;


    DataMod.QRY_ListarPedido.next;
  end;

  edt_total.Text :=  FloatToStr(TotalPedido);   //recebendo o total na v�riavel que guardar� o valor




end;

procedure TF_PDV.edt_pro_codKeyPress(Sender: TObject; var Key: Char);
//se digitado enter no codigo do produto, trar� informa��es do produto na tela
begin
  if key = #13 then
  begin
    with DataMod.QRY_Prod do
     begin
       close;
       SQL.clear;
       SQL.add('select * from produtos ');
       SQL.add(' where Codigo = :codigo ');
       ParamByName('codigo').value :=  edt_pro_cod.text;
       open;

       if recordcount = 0 then
       begin
         showMessage('Produto n�o encontrado');
         edt_pro_descr.clear;
         edt_pro_preco.clear;
         edt_pro_cod.clear;
       end
       else if recordcount = 1 then
       begin
         edt_pro_descr.text := dataMod.QRY_ProdDescricao.AsString;
         edt_pro_preco.text := dataMod.QRY_ProdPrecoVenda.AsString;
         edt_pro_qtd.SetFocus;
       end;




     end;
  end;

end;

procedure TF_PDV.edt_pro_qtdExit(Sender: TObject);
//trata a quantidade para n�o ser 0 e nem vazia
begin
  if (edt_pro_qtd.text = '') then
  begin
    edt_pro_qtd.text := '1';
  end
  else if (strToInt(edt_pro_qtd.text) < 1)  then
  begin
    edt_pro_qtd.text := '1';
  end;
end;

procedure TF_PDV.edt_pro_qtdKeyPress(Sender: TObject; var Key: Char);
begin
  // Verifica se o caractere n�o � um n�mero (0-9) ou Backspace
  if not (Key in ['0'..'9', #8]) then
  begin
    // Se n�o for um n�mero, impede a entrada do caractere
    Key := #0;
  end;
  

end;

procedure TF_PDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dataMod.QRY_Prod.close;
  dataMod.QRY_listarPedido.close;
  CodigoVenda := '';
  //fecha as querys ao sair do formul�rio



end;

procedure TF_PDV.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Adicione sua l�gica aqui para determinar se o formul�rio pode ser fechado
  if podeFechar then
  begin
    CanClose := True; // Permite o fechamento do formul�rio

  end
  else
  begin
    CanClose := false; //bloqueia o fechamento do formul�rio
    ShowMessage ('� necess�rio gravar a venda ou cancelar a venda para sair');
  end;
end;

procedure TF_PDV.FormCreate(Sender: TObject);

begin
  podeFechar := true; //libera o fechamento do formul�rio
  BloqueiaCampos;  //bloqueia os campos
  btnEditar.Enabled := false; //bloquear mais alguns bot�es
  btn_iniciar_venda.Enabled := false;


end;

procedure TF_PDV.FormShow(Sender: TObject);
begin
//ao iniciar o formul�rio pergunta se quer reabrir a venda, se sim pega o valor do id da venda
  if MessageDlg('Deseja reabrir uma venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    CodigoVenda := InputBox('Informe o id da venda', 'Digite o id:', '');
    ReabrirVenda;
  end;
end;

procedure TF_PDV.IniciaVendas;
//iniciar vendas

begin
  //Desbloqueia campos
  podeFechar := false;
  LiberaCampos;
  if CodigoVenda = '' then
  begin
    DataPedido := FormatDateTime('yymmdd', Date);
    F_PDV.caption := 'Venda: NOVA VENDA';
  end;


  //verificando se existe a venda
  with QRY_VerificaVenda do
  begin
    close;
    SQL.Clear;
    SQL.add('select * from pedidosdadosgerais ');
    SQL.add('where NumeroPedido = :codigo ');
    paramByName('codigo').Value := CodigoVenda;
    open;
  end;

  //Se n�o existe a venda, inicia uma nova venda
  if QRY_VerificaVenda.recordcount = 0  then
  begin
    tb_pedido.active := true;
    tb_pedido.append;
    tb_pedidoDataEmissao.Value := Date;
    tb_pedidoCodigoCliente.Value :=  dataMod.QRY_CliCodigo.Value;
    tb_pedidoValorTotal.Value := 0;

    tb_pedido.Post;
    CodigoVenda := IntToStr(tb_pedidoNumeroPedido.Value);
  end;

  //inicia a lista
  with DataMod.QRY_ListarPedido do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM view_ListarPedido');
    SQL.Add('WHERE G_NumeroPedido = :codigo');
    ParamByName('codigo').Value := CodigoVenda;
    Open;
  end;


end;

end.
