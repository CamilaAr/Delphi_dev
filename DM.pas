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
    QRY_ListarPedidoAutoincrem: TFDAutoIncField;
    QRY_ListarPedidoG_NumeroPedido: TFDAutoIncField;
    QRY_ListarPedidoCodigoProduto: TFDAutoIncField;
    QRY_ListarPedidoDescricao: TStringField;
    QRY_ListarPedidoQuantidade: TIntegerField;
    QRY_ListarPedidoValorUnitario: TBCDField;
    QRY_ListarPedidoValorTotal: TBCDField;
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
  HostName, Database, UserName, Password, VendorLib: string;
begin
 AppPath := ExtractFileDir(ParamStr(0));
 // Agora, você pode construir o caminho completo para o arquivo INI
  AppPath := IncludeTrailingPathDelimiter(AppPath) + 'config.ini'; // Construa o caminho completo do arquivo INI
 if FileExists(AppPath) then
  begin
    // O arquivo existe, podemos criá-lo
    ArquivoINI := TIniFile.Create(AppPath);
    // Agora, continue com o código para ler as configurações do INI
    end
  else
  begin
    ShowMessage('O arquivo config.ini não foi encontrado.');
  end;
  HostName := ArquivoINI.ReadString('MySQL', 'Server', 'localhost');
  Database := ArquivoINI.ReadString('MySQL', 'Database', 'minha_base_de_dados');
  UserName := ArquivoINI.ReadString('MySQL', 'User_Name', 'meu_usuario');
  Password := ArquivoINI.ReadString('MySQL', 'Password', 'minha_senha');
  VendorLib := ArquivoINI.ReadString('MySQL', 'VendorLib', 'link');

  conect.Params.Values['Database'] := Database;
  conect.Params.Values['User_Name'] := UserName;
  conect.Params.Values['Password'] := Password;
  mysqlLink.VendorLib := VendorLib;
  conect.params.Values['Server'] := HostName;

  try
    conect.Connected := True; // Tente estabelecer a conexão

    if conect.Connected then
    begin
      ShowMessage('Conexão estabelecida com sucesso.');
      // A conexão está ativa; você pode executar consultas ou outras operações aqui.
    end
    else
      ShowMessage('A conexão não pôde ser estabelecida, verifique os dados do arquivo config.ini');

  except
    on E: EFDDBEngineException do
    begin
      ShowMessage('Erro ao conectar ao banco de dados: ' + E.Message);

    end;
  end;


  ArquivoINI.Free;

end;

end.
