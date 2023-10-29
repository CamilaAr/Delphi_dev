unit DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, 
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, IniFiles, Vcl.Dialogs;

type
  TDataMod = class(TDataModule)
    conect: TFDConnection;
    mysqlLink: TFDPhysMySQLDriverLink;
    waitcursor: TFDGUIxWaitCursor;
    QRY_Prod: TFDQuery;
    QRY_ProdCodigo: TFDAutoIncField;
    QRY_ProdDescricao: TStringField;
    QRY_ProdPrecoVenda: TBCDField;
    DS_Prod: TDataSource;
    tb_prod: TFDTable;
    tb_prodCodigo: TFDAutoIncField;
    tb_prodDescricao: TStringField;
    tb_prodPrecoVenda: TBCDField;
    QRY_Cli: TFDQuery;
    QRY_CliCodigo: TFDAutoIncField;
    QRY_CliNome: TStringField;
    QRY_CliCidade: TStringField;
    QRY_CliUF: TStringField;
    tb_cli: TFDTable;
    tb_cliCodigo: TFDAutoIncField;
    tb_cliNome: TStringField;
    tb_cliCidade: TStringField;
    tb_cliUF: TStringField;
    DS_Cli: TDataSource;
    QRY_ListarPedido: TFDQuery;
    ds_listarPedido: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataMod: TDataMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TDataMod.DataModuleCreate(Sender: TObject);
var
  ArquivoINI: TINIFile;
  AppPath, IniFileName: string;
  HostName, Database, UserName, Password: string;
begin
 AppPath := ExtractFileDir(ParamStr(0));
 // Agora, voc� pode construir o caminho completo para o arquivo INI
  AppPath := IncludeTrailingPathDelimiter(AppPath) + 'config.ini'; // Construa o caminho completo do arquivo INI
 if FileExists(AppPath) then
  begin
    // O arquivo existe, podemos cri�-lo
    ArquivoINI := TIniFile.Create(AppPath);
    // Agora, continue com o c�digo para ler as configura��es do INI
    end
  else
  begin
    ShowMessage('O arquivo config.ini n�o foi encontrado.');
  end;
  //HostName := ArquivoINI.ReadString('MySQL', 'Server', 'localhost');
  Database := ArquivoINI.ReadString('MySQL', 'Database', 'minha_base_de_dados');
  UserName := ArquivoINI.ReadString('MySQL', 'User_Name', 'meu_usuario');
  Password := ArquivoINI.ReadString('MySQL', 'Password', 'minha_senha');

  
  conect.Params.Values['Database'] := Database;
  conect.Params.Values['User_Name'] := UserName;
  conect.Params.Values['Password'] := Password;
  //conect.params.Values['Server'] := HostName;

  try
    conect.Connected := True; // Tente estabelecer a conex�o

    if conect.Connected then
    begin
      ShowMessage('Conex�o estabelecida com sucesso.');
      // A conex�o est� ativa; voc� pode executar consultas ou outras opera��es aqui.
    end
    else
      ShowMessage('A conex�o n�o p�de ser estabelecida.');

  except
    on E: EFDDBEngineException do
    begin
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);
      // Trate o erro de conex�o aqui.
    end;
  end;

  
  ArquivoINI.Free;

end;

end.
