unit PedidosProdutosDAO;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TPedidosProdutosDAO = class
  public
    class procedure InserirPedidoProduto(Conn: TFDConnection; NumeroPedido, CodigoProduto, Quantidade: Integer; ValorUnitario, ValorTotal: Currency);
  end;

implementation

{ TPedidosProdutosDAO }

class procedure TPedidosProdutosDAO.InserirPedidoProduto(Conn: TFDConnection; NumeroPedido, CodigoProduto, Quantidade: Integer; ValorUnitario, ValorTotal: Currency);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'INSERT INTO PedidosProdutos (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) ' +
                        'VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
    FDQuery.ParamByName('NumeroPedido').AsInteger := NumeroPedido;
    FDQuery.ParamByName('CodigoProduto').AsInteger := CodigoProduto;
    FDQuery.ParamByName('Quantidade').AsInteger := Quantidade;
    FDQuery.ParamByName('ValorUnitario').AsCurrency := ValorUnitario;
    FDQuery.ParamByName('ValorTotal').AsCurrency := ValorTotal;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

end.

