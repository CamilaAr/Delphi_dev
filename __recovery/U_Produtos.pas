unit U_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  TF_Produtos = class(TForm)
    stb_produtos: TStatusBar;
    pg_produtos: TPageControl;
    tab_consultar: TTabSheet;
    tab_cadastrar: TTabSheet;
    dbg_produtos: TDBGrid;
    edt_buscar: TEdit;
    procedure edt_buscarKeyPress(Sender: TObject; var Key: Char);
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

end.
