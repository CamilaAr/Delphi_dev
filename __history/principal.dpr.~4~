program principal;

uses
  Vcl.Forms,
  Delphi_dev in 'Delphi_dev.pas' {Form2},
  DM in 'DM.pas' {DataMod: TDataModule},
  ProdutosDAO in 'ProdutosDAO.pas',
  ListaProd in 'ListaProd.pas' {ListaProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataMod, DataMod);
  Application.CreateForm(TListaProdutos, ListaProdutos);
  Application.Run;
end.
