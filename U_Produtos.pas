unit U_Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls;

type
  TF_Produtos = class(TForm)
    stb_produtos: TStatusBar;
    pg_produtos: TPageControl;
    tab_consultar: TTabSheet;
    tab_cadastrar: TTabSheet;
    dbg_produtos: TDBGrid;
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

end.
