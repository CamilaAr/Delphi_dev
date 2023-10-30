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
    procedure edt_cli_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_pro_codKeyPress(Sender: TObject; var Key: Char);
    procedure BloqueiaCampos;
    procedure LiberaCampos;
    procedure IniciaVendas;
    procedure ProdutosAdd;
    procedure UpdateLista;
    procedure FormCreate(Sender: TObject);
    procedure btn_iniciar_vendaClick(Sender: TObject);
    procedure btn_pro_addClick(Sender: TObject);
    procedure edt_pro_qtdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbg_lancamentoDblClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure edt_pro_qtdExit(Sender: TObject);
    procedure edt_cli_nomeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoVenda : string;
    DataPedido : string;
    TotalPedido : double;
    ItemId, qtd: Integer;
    NomeProduto : string;
    preço : double;
  end;

var
  F_PDV: TF_PDV;

implementation

{$R *.dfm}

uses DM, U_Funcoes;



procedure TF_PDV.btnEditarClick(Sender: TObject);
begin
  with QRY_Itens do
  begin
    close;
    SQL.Clear;
    SQL.Add('update pedidosprodutos set Quantidade = :qtd, ValorTotal = :total ');
    SQL.Add('where Autoincrem = :id ');
    ParamByName('qtd').Value := edt_pro_qtd.Text;
    ParamByName('id').Value := ItemId;
    ParamByName('total').Value := StrToFloat(edt_pro_qtd.Text) * StrToFloat(edt_pro_preco.text);
    execSQL;
  end;
  ShowMessage ('Produto editado com sucesso!');
  //atualiza listagem de itens no pedido
  UpdateLista;

  edt_pro_cod.enabled := true;
  edt_pro_descr.enabled := true;
  edt_pro_preco.enabled := true;
  btn_pro_add.enabled := true;
  btnEditar.Enabled := false;


end;

procedure TF_PDV.btn_iniciar_vendaClick(Sender: TObject);
begin
  edt_cli_codigo.Enabled := false;
  IniciaVendas;
end;

procedure TF_PDV.btn_pro_addClick(Sender: TObject);
begin
  //chama a função de adicionar produtos
  if edt_pro_descr.Text = '' then
  begin
    ShowMessage('Produto não selecionado!');
    exit;
  end;
  produtosAdd;
end;

procedure TF_PDV.dbg_lancamentoDblClick(Sender: TObject);

begin
  if dbg_lancamento.DataSource.DataSet.Active then
  begin
    // Verifica se há uma linha selecionada no TDBGrid
    if not dbg_lancamento.DataSource.DataSet.IsEmpty then
    begin
      // Obtém o valor da coluna que contém o ID da linha selecionada
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


    end;
  end;
end;


procedure TF_PDV.edt_cli_codigoKeyPress(Sender: TObject; var Key: Char);
begin
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
         showMessage('Cliente não encontrado');
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
begin
  btn_iniciar_venda.Enabled := true;
  if edt_cli_nome.Text = '' then
  begin
     btn_iniciar_venda.Enabled := false;
  end;

end;

procedure TF_PDV.BloqueiaCampos;
begin
  //bloqueia os campos até que se inicie a venda
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
  //bloqueia os campos até que se inicie a venda
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
  produto := dataMod.QRY_ProdCodigo.Value;
  qtd :=  StrToInt(edt_pro_qtd.Text);
  preco := dataMod.QRY_ProdPrecoVenda.Value;


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
    edt_pro_qtd.text := '1';





end;

procedure TF_PDV.UpdateLista;
begin
//atualiza a visualização dos itens no pedido
  dataMod.QRY_listarPedido.close;
  dataMod.QRY_listarPedido.open;

  //pegando o total do pedido
  DataMod.QRY_ListarPedido.first;

  TotalPedido := 0;
  while not DataMod.QRY_ListarPedido.eof do
  begin
    TotalPedido := TotalPedido +  DataMod.QRY_ListarPedido.FieldByName('ValorTotal_PedidosProdutos').Value;


    DataMod.QRY_ListarPedido.next;
  end;

  edt_total.Text :=  FloatToStr(TotalPedido);




end;

procedure TF_PDV.edt_pro_codKeyPress(Sender: TObject; var Key: Char);
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
         showMessage('Produto não encontrado');
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
  // Verifica se o caractere não é um número (0-9) ou Backspace
  if not (Key in ['0'..'9', #8]) then
  begin
    // Se não for um número, impede a entrada do caractere
    Key := #0;
  end;
  

end;

procedure TF_PDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dataMod.QRY_Prod.close;
  dataMod.QRY_listarPedido.close;
  CodigoVenda := '';



end;

procedure TF_PDV.FormCreate(Sender: TObject);
begin
  BloqueiaCampos;
  btnEditar.Enabled := false;
  btn_iniciar_venda.Enabled := false;
end;

procedure TF_PDV.IniciaVendas;
//iniciar vendas

begin
  //Desbloqueia campos
  LiberaCampos;
  if CodigoVenda = '' then
  begin
    DataPedido := FormatDateTime('yymmdd', Date);
    F_PDV.caption := 'Venda: NOVA VENDA';
  end
  else
  begin
     F_PDV.caption := 'Venda: ' + CodigoVenda;
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

  //Se não existe a venda, inicia uma nova venda
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


  with DataMod.QRY_ListarPedido do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM view_ListarPedido');
    SQL.Add('WHERE NumeroPedido_PedidosDadosGerais = :codigo');
    ParamByName('codigo').Value := CodigoVenda;
    Open;
  end;


end;

end.
