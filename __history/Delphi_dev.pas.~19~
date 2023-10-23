unit Delphi_dev;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls;

type
  TPrincip = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);


  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Princip: TPrincip;

implementation

{$R *.dfm}

uses ListaProd, ClientesDAO,  DM;






procedure TPrincip.Button1Click(Sender: TObject);
var
  ClienteID: String;
  FormLP: TListaProdutos;

begin
  ClienteID := '0';
  // Passo 1: Solicitar o ID do cliente ao usuário
  if InputQuery('ID do Cliente', 'Digite o ID do Cliente:', ClienteID) then
  begin
    // Passo 2: Verificar se o cliente existe usando a função do DAO
    if TClientesDAO.ClienteExiste(DataMod.conect, StrToInt(ClienteID)) then
    begin
      // Passo 3: Abrir o formulário TListaProdutos
      FormLP := TListaProdutos.Create(Application);
      try
        DataMod.QRY_Prod.Active := True;
        FormLP.ShowModal;
      finally
        FormLP.Free;
      end;
    end
    else
    begin
      // Passo 4: Exibir uma mensagem se o cliente não existir
      ShowMessage('Cliente não encontrado. Verifique o ID do cliente.');
    end;
  end;
end;

procedure TPrincip.FormCreate(Sender: TObject);
begin

   // DataMod.QRY_Prod.Open;

end;



end.
