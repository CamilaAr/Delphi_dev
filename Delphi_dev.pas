unit Delphi_dev;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons;

type
  TF_Principal = class(TForm)
    Button1: TButton;
    btnVenda: TButton;
    stb_inicial: TStatusBar;
    panel_menu: TPanel;
    menu_inicial: TMainMenu;
    Sistema1: TMenuItem;
    Sistema2: TMenuItem;
    Cadastros1: TMenuItem;
    N1: TMenuItem;
    produtos: TMenuItem;
    Clientes1: TMenuItem;
    Clientes2: TMenuItem;
    Movimentos1: TMenuItem;
    Movimentos2: TMenuItem;
    PDV1: TMenuItem;
    PDV2: TMenuItem;
    MVendas1: TMenuItem;
    VendasAbertas1: TMenuItem;
    btn_clientes: TSpeedButton;
    btn_Produtos: TSpeedButton;
    btn_pdv: TSpeedButton;
    N3: TMenuItem;
    N4: TMenuItem;
    Sair1: TMenuItem;
    N5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnVendaClick(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure btn_clientesClick(Sender: TObject);
    procedure produtosClick(Sender: TObject);
    procedure btn_ProdutosClick(Sender: TObject);
    procedure PDV1Click(Sender: TObject);
    procedure btn_pdvClick(Sender: TObject);


  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Principal: TF_Principal;

implementation

{$R *.dfm}

uses ListaProd, ClientesDAO,  DM, venda, U_Clientes, U_Funcoes, U_Produtos,
  ProdutosDAO, U_PDV;






procedure TF_Principal.btnVendaClick(Sender: TObject);
var
  FormVenda: TForm1;
begin


  FormVenda := TForm1.Create(Application);
  FormVenda.ShowModal;
  FormVenda.Free;
end;

procedure TF_Principal.btn_clientesClick(Sender: TObject);
begin
  Clientes1.Click;
end;

procedure TF_Principal.btn_pdvClick(Sender: TObject);
begin
  PDV1.Click;
end;

procedure TF_Principal.btn_ProdutosClick(Sender: TObject);
begin
  produtos.Click;
end;

procedure TF_Principal.Button1Click(Sender: TObject);
var
  ClienteID: String;
  FormLP: TListaProdutos;


begin
  ClienteID := '0';
  // Passo 1: Solicitar o ID do cliente ao usu�rio
  if InputQuery('ID do Cliente', 'Digite o ID do Cliente:', ClienteID) then
  begin
    // Passo 2: Verificar se o cliente existe usando a fun��o do DAO
    if TClientesDAO.ClienteExiste(DataMod.conect, StrToInt(ClienteID)) then
    begin
      // Passo 3: Abrir o formul�rio TListaProdutos
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
      // Passo 4: Exibir uma mensagem se o cliente n�o existir
      ShowMessage('Cliente n�o encontrado. Verifique o ID do cliente.');
    end;
  end;
end;

procedure TF_Principal.Clientes1Click(Sender: TObject);
begin
   if TestarPermissao('F_Clientes') = false then
   begin
     exit;
   end;
   //chamar o form clientes
   FreeAndNil(F_Clientes);
   if(F_Clientes = nil) then
   begin
     F_Clientes := TF_Clientes.Create(self);
     F_Clientes.ShowModal;
     FreeAndNil(F_Clientes);
   end;
end;

procedure TF_Principal.FormCreate(Sender: TObject);
begin

   // DataMod.QRY_Prod.Open;

end;



procedure TF_Principal.PDV1Click(Sender: TObject);
begin
  if TestarPermissao('F_PDV') = false then
     begin
       exit;
     end;
     //chamar o form produtos
    FreeAndNil(F_PDV);
     if(F_PDV = nil) then
     begin
       F_PDV := TF_PDV.Create(self);
       F_PDV.ShowModal;
       FreeAndNil(F_PDV);
     end;
end;


procedure TF_Principal.produtosClick(Sender: TObject);
begin
  if TestarPermissao('F_Produtos') = false then
     begin
       exit;
     end;
     //chamar o form produtos
     FreeAndNil(F_Produtos);
     if(F_Produtos = nil) then
     begin
       F_Produtos := TF_Produtos.Create(self);
       F_Produtos.ShowModal;
       FreeAndNil(F_Produtos);
     end;
  end;

end.
