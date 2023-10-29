object DataMod: TDataMod
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object conect: TFDConnection
    Params.Strings = (
      'Database=lojateste'
      'User_Name=root'
      'Password=1234'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 8
    Top = 8
  end
  object mysqlLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\camila\Documents\Delphi_dev\libmysql.dll'
    Left = 72
    Top = 8
  end
  object waitcursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 144
    Top = 8
  end
  object QRY_Prod: TFDQuery
    Active = True
    Connection = conect
    SQL.Strings = (
      'select * from produtos ')
    Left = 16
    Top = 112
    object QRY_ProdCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QRY_ProdDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 255
    end
    object QRY_ProdPrecoVenda: TBCDField
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      Required = True
      DisplayFormat = ',0.00;-,0.00'
      Precision = 10
      Size = 2
    end
  end
  object DS_Prod: TDataSource
    DataSet = QRY_Prod
    Left = 112
    Top = 112
  end
  object tb_prod: TFDTable
    IndexFieldNames = 'Codigo'
    Connection = conect
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'lojateste.produtos'
    Left = 64
    Top = 112
    object tb_prodCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tb_prodDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 255
    end
    object tb_prodPrecoVenda: TBCDField
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      Required = True
      Precision = 10
      Size = 2
    end
  end
  object QRY_Cli: TFDQuery
    Connection = conect
    SQL.Strings = (
      'select * from clientes')
    Left = 16
    Top = 176
    object QRY_CliCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object QRY_CliNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 255
    end
    object QRY_CliCidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Size = 100
    end
    object QRY_CliUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
  end
  object tb_cli: TFDTable
    IndexFieldNames = 'Codigo'
    Connection = conect
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'lojateste.clientes'
    Left = 64
    Top = 176
    object tb_cliCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tb_cliNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 255
    end
    object tb_cliCidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Size = 300
    end
    object tb_cliUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      FixedChar = True
      Size = 2
    end
  end
  object DS_Cli: TDataSource
    DataSet = QRY_Cli
    Left = 112
    Top = 176
  end
end
