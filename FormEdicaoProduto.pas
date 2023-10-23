unit FormEdicaoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormEdicaoProd = class(TForm)
    edtNome: TEdit;
    EdtPreco: TEdit;
    Salvar: TButton;
    Cancelar: TButton;

    procedure CancelarClick(Sender: TObject);
    procedure SalvarClick(Sender: TObject);
  private
    FProdutoID: Integer; // Vari�vel para armazenar o ID do produto
  public
    procedure LoadProduto(ProdutoID: Integer);
  end;

implementation

uses ProdutosDAO, DM;

{$R *.dfm}

procedure TFormEdicaoProd.SalvarClick(Sender: TObject);
var
  Nome: string;
  Preco: Currency;
begin
  // Obtenha os valores dos campos do formul�rio
  Nome := edtNome.Text;
  Preco := StrToCurr(EdtPreco.Text); // Converte a string para Currency

  // Chame o m�todo EditarProduto para atualizar o produto no banco de dados
  TProdutosDAO.EditarProduto(DataMod.conect, FProdutoID, Nome, Preco);

  // Feche o formul�rio de edi��o
  Close;
end;


procedure TFormEdicaoProd.CancelarClick(Sender: TObject);
begin
  // Feche o formul�rio de edi��o sem salvar as altera��es
  Close;
end;



procedure TFormEdicaoProd.LoadProduto(ProdutoID: Integer);
begin
  // Carregue os dados do produto com base no ID
  FProdutoID := ProdutoID;
  var ProdutoQuery := TProdutosDAO.GetProdutoByID(DataMod.conect, ProdutoID);

  // Preencha os campos do formul�rio com os dados do produto
  edtNome.Text := ProdutoQuery.FieldByName('Nome').AsString;
  EdtPreco.Text := CurrToStr(ProdutoQuery.FieldByName('Preco').AsCurrency);
end;




end.

