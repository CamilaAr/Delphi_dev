unit U_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TF_Clientes = class(TForm)
    pg_clientes: TPageControl;
    StatusBar1: TStatusBar;
    tab_consultar: TTabSheet;
    tab_editar: TTabSheet;
    SpeedButton1: TSpeedButton;
    dbg_cli: TDBGrid;
    edt_busca: TEdit;
    Label1: TLabel;
    procedure edt_buscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Clientes: TF_Clientes;

implementation

{$R *.dfm}

uses DM, U_Funcoes;

procedure TF_Clientes.edt_buscaKeyPress(Sender: TObject; var Key: Char);
begin
   //fazer a busca
  if key = #13 then
  begin
     with DataMod.QRY_Cli do
     begin
       close;
       SQL.clear;
       SQL.add('select * from clientes ');
       SQL.add(' where Nome like :descricao ');
       SQL.add(' or Cidade like :descricao ');
       SQL.add(' or UF like :descricao ');
       ParamByName('descricao').value := '%' + edt_busca.text + '%';
       open;

       if recordcount = 0 then
       begin
         showMessage('Cliente não encontrado');
       end;


     end;
  end;
end;

procedure TF_Clientes.FormCreate(Sender: TObject);
begin
  DataMod.QRY_Cli.open;
end;

end.
