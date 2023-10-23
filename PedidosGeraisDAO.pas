unit PedidosGeraisDAO;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TPedidosGeraisDAO = class
  public
    class procedure InserirPedidoGeral(Conn: TFDConnection; DataEmissao: TDate; CodigoCliente: Integer; ValorTotal: Currency);
  end;

implementation

{ TPedidosGeraisDAO }

class procedure TPedidosGeraisDAO.InserirPedidoGeral(Conn: TFDConnection; DataEmissao: TDate; CodigoCliente: Integer; ValorTotal: Currency);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'INSERT INTO PedidosGerais (DataEmissao, CodigoCliente, ValorTotal) ' +
                        'VALUES (:DataEmissao, :CodigoCliente, :ValorTotal)';
    FDQuery.ParamByName('DataEmissao').AsDate := DataEmissao;
    FDQuery.ParamByName('CodigoCliente').AsInteger := CodigoCliente;
    FDQuery.ParamByName('ValorTotal').AsCurrency := ValorTotal;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

end.

