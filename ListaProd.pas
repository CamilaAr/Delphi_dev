unit ListaProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids;

type
    TListaProdutos = class(TForm)
    prodGrid: TDBGrid;
    edt_Grid: TEdit;
    procedure edt_GridChange(Sender: TObject);
    procedure prodGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure prodGridDblClick(Sender: TObject);
  private
    function BuildFilterExpression(DataSet: TDataSet;
      searchTerm: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaProdutos: TListaProdutos;

implementation

{$R *.dfm}

uses DM, ProdutosDAO, FormEdicaoProduto;

procedure TListaProdutos.edt_GridChange(Sender: TObject);
begin
  // Obt�m o termo de pesquisa do Edit
  var searchTerm := edt_Grid.Text;

  // Verifica se h� um termo de pesquisa
  if not string.IsNullOrWhiteSpace(searchTerm) then
  begin
    // Aplica o filtro �s colunas do DataSet associado ao DataSource do DBGrid
    if Assigned(ProdGrid.DataSource) then
    begin
      var DataSet := (ProdGrid.DataSource.DataSet as TDataSet);
      DataSet.Filtered := False; // Certifica-se de que o filtro anterior seja limpo
      DataSet.Filter := BuildFilterExpression(DataSet, searchTerm);
      DataSet.Filtered := True;
    end;
  end
  else
  begin
    // Se o campo de pesquisa estiver vazio, limpa o filtro
    var DataSet := (ProdGrid.DataSource.DataSet as TDataSet);
    DataSet.Filtered := False;
  end;
end;


procedure TListaProdutos.prodGridDblClick(Sender: TObject);
begin
  // Manipulador de evento para edi��o ao clicar duas vezes
  if not prodGrid.DataSource.DataSet.IsEmpty then
  begin
    // Habilite o modo de edi��o na c�lula atual
    prodGrid.Options := prodGrid.Options + [dgEditing];

    prodGrid.EditorMode := True;
  end;
end;

procedure TListaProdutos.prodGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Manipulador de evento para exclus�o ao pressionar "Delete"
  if (Key = VK_DELETE) and (prodGrid.SelectedRows.Count = 0) then
  begin
    if not prodGrid.DataSource.DataSet.IsEmpty then
    begin
      // Obtenha o valor do campo "Codigo" da linha selecionada
      var Codigo := prodGrid.DataSource.DataSet.FieldByName('Codigo').AsInteger;

      // Confirma��o antes da exclus�o (opcional)
      if MessageDlg('Deseja excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        // Chame o m�todo do DAO para excluir o produto pelo Codigo
        TProdutosDAO.RemoverProduto(DataMod.conect, Codigo );
        // Recarregue os dados no DBGrid para refletir a exclus�o
        prodGrid.DataSource.DataSet.Refresh;
      end;
    end;
  end;
  // Manipulador de evento para salvar as altera��es ao pressionar "Enter"
  if (Key = VK_RETURN) and (prodGrid.EditorMode) then
  begin
    // Salve as altera��es
    prodGrid.EditorMode := False;
    prodGrid.Options := prodGrid.Options - [dgEditing];
    prodGrid.DataSource.DataSet.Post; // Isso ir� salvar as altera��es no banco de dados
  end;
end;

function TListaProdutos.BuildFilterExpression(DataSet: TDataSet; searchTerm: string): string;
var
  i: Integer;
  filterExpression: string;
begin
  filterExpression := '';
  searchTerm := '%' + searchTerm + '%'; // Adicione % no in�cio e no final para pesquisa parcial
  for i := 0 to DataSet.FieldCount - 1 do
  begin
    if i > 0 then
      filterExpression := filterExpression + ' or ';
    filterExpression := filterExpression + Format('%s like ''%s''', [DataSet.Fields[i].FieldName, searchTerm]);
  end;
  Result := filterExpression;
end;





end.
