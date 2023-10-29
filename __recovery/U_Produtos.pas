unit U_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBActns, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TF_Produtos = class(TForm)
    stb_produtos: TStatusBar;
    pg_produtos: TPageControl;
    tab_consultar: TTabSheet;
    tab_cadastrar: TTabSheet;
    dbg_produtos: TDBGrid;
    edt_buscar: TEdit;
    lb_busca: TLabel;
    lb_descricao: TLabel;
    DBEdit1: TDBEdit;
    ds_prod_cad: TDataSource;
    lb_preco: TLabel;
    DBEdit2: TDBEdit;
    acm_prod: TActionManager;
    ac_insert: TDataSetInsert;
    ac_apagar: TDataSetDelete;
    ac_editar: TDataSetEdit;
    ac_ok: TDataSetPost;
    ac_cancelar: TDataSetCancel;
    btn_novo: TButton;
    btn_editar: TButton;
    btn_ok: TButton;
    btn_cancelar: TButton;
    btn_delete: TButton;
    btn_editarProd: TButton;
    procedure edt_buscarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btn_editarProdClick(Sender: TObject);
    procedure dbg_produtosDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Produtos: TF_Produtos;

implementation

{$R *.dfm}

uses DM;

procedure TF_Produtos.btn_editarProdClick(Sender: TObject);
begin
//Seleção de produto para edição
  dataMod.TB_prod.locate('Codigo', dataMod.QRY_ProdCodigo.Value,[]);
  pg_Produtos.activePage := tab_cadastrar;

end;

procedure TF_Produtos.dbg_produtosDblClick(Sender: TObject);
begin
   btn_editarProd.Click;
end;

procedure TF_Produtos.edt_buscarKeyPress(Sender: TObject; var Key: Char);
begin
  //fazer a busca
  if key = #13 then
  begin
     with DataMod.QRY_Prod do
     begin
       close;
       SQL.clear;
       SQL.add('select * from produtos ');
       SQL.add('where Descricao like :descricao ');
       ParamByName('descricao').value := '%' + edt_buscar.text + '%';
       open;

       if recordcount = 0 then
       begin
         showMessage('Produto não encontrado');
       end;


     end;
  end;
end;

procedure TF_Produtos.FormCreate(Sender: TObject);
begin
  DataMod.tb_prod.active := true;
  pg_Produtos.activePage := tab_consultar;
  DataMod.QRY_Prod.open;

end;

end.
