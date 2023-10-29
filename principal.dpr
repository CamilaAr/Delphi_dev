program principal;

uses
  Vcl.Forms,
  Delphi_dev in 'Delphi_dev.pas' {F_Principal},
  DM in 'DM.pas' {DataMod: TDataModule},
  ProdutosDAO in 'ProdutosDAO.pas',
  ListaProd in 'ListaProd.pas' {ListaProdutos},
  U_Clientes in 'U_Clientes.pas' {F_Clientes},
  U_Funcoes in 'U_Funcoes.pas',
  U_Produtos in 'U_Produtos.pas' {F_Produtos},
  U_PDV in 'U_PDV.pas' {F_PDV};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataMod, DataMod);
  Application.CreateForm(TF_principal, F_principal);
  Application.CreateForm(TF_PDV, F_PDV);
  Application.Run;
end.
