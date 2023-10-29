unit U_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.DBActns, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.DBCtrls;

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
    btn_novo: TButton;
    btn_editar: TButton;
    btn_ok: TButton;
    btn_cancelar: TButton;
    btn_delete: TButton;
    acm_cli: TActionManager;
    ac_insert: TDataSetInsert;
    ac_apagar: TDataSetDelete;
    ac_editar: TDataSetEdit;
    ac_ok: TDataSetPost;
    ac_cancelar: TDataSetCancel;
    ds_cli_cad: TDataSource;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    btn_editarCli: TButton;
    procedure edt_buscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btn_editarCliClick(Sender: TObject);
    procedure dbg_cliDblClick(Sender: TObject);
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

procedure TF_Clientes.btn_editarCliClick(Sender: TObject);
begin
  //Seleção de produto para edição
  dataMod.TB_cli.locate('Codigo', dataMod.QRY_CliCodigo.Value,[]);
  pg_Clientes.activePage := tab_editar;

end;

procedure TF_Clientes.dbg_cliDblClick(Sender: TObject);
begin
  btn_editarCli.click;
end;

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
  DataMod.tb_cli.active := true;
  pg_Clientes.activePage := tab_consultar;
end;

end.
