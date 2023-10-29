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
    procedure edt_cli_codigoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_pro_codKeyPress(Sender: TObject; var Key: Char);
    procedure BloqueiaCampos;
    procedure LiberaCampos;
    procedure IniciaVendas;
    procedure FormCreate(Sender: TObject);
    procedure btn_iniciar_vendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoVenda : string;
    DataPedido : string;
  end;

var
  F_PDV: TF_PDV;

implementation

{$R *.dfm}

uses DM, U_Funcoes;



procedure TF_PDV.btn_iniciar_vendaClick(Sender: TObject);
begin
  IniciaVendas;
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

procedure TF_PDV.FormCreate(Sender: TObject);
begin
  BloqueiaCampos;
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
    SQL.add('select * from pedidos ');
    SQL.add('where NumeroPedido = :codigo ');
    paramByName('codigo').Value := CodigoVenda;
    open;
  end;

  //Se n�o existe a venda, inicia uma nova venda
  if QRY_VerificaVenda.recordcount = 0  then
  begin

  end;

end;

end.
