unit ClientesDAO;

interface

uses
  SysUtils, Classes, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param;

type
  TClientesDAO = class
  public
    class function ClienteExiste(Conn: TFDConnection; ClienteID: Integer): Boolean;
    class procedure AdicionarCliente(Conn: TFDConnection; Nome: string);
    class procedure EditarCliente(Conn: TFDConnection; ClienteID: Integer; Nome: string);
    class procedure RemoverCliente(Conn: TFDConnection; ClienteID: Integer);
  end;

implementation

{ TClientesDAO }

class function TClientesDAO.ClienteExiste(Conn: TFDConnection; ClienteID: Integer): Boolean;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'SELECT COUNT(*) FROM Clientes WHERE Codigo = :Codigo';
    FDQuery.ParamByName('Codigo').AsInteger := ClienteID;
    FDQuery.Open;
    Result := (FDQuery.Fields[0].AsInteger > 0);
  finally
    FDQuery.Free;
  end;
end;

class procedure TClientesDAO.AdicionarCliente(Conn: TFDConnection; Nome: string);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'INSERT INTO Clientes (Nome) VALUES (:Nome)';
    FDQuery.ParamByName('Nome').AsString := Nome;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

class procedure TClientesDAO.EditarCliente(Conn: TFDConnection; ClienteID: Integer; Nome: string);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'UPDATE Clientes SET Nome = :Nome WHERE Codigo = :Codigo';
    FDQuery.ParamByName('Codigo').AsInteger := ClienteID;
    FDQuery.ParamByName('Nome').AsString := Nome;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

class procedure TClientesDAO.RemoverCliente(Conn: TFDConnection; ClienteID: Integer);
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := Conn;
    FDQuery.SQL.Text := 'DELETE FROM Clientes WHERE Codigo = :Codigo';
    FDQuery.ParamByName('Codigo').AsInteger := ClienteID;
    FDQuery.ExecSQL;
  finally
    FDQuery.Free;
  end;
end;

end.

