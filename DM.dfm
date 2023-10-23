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
    Left = 232
    Top = 136
  end
  object mysqlLink: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\camila\Documents\Delphi_dev\libmysql.dll'
    Left = 304
    Top = 224
  end
  object waitcursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 432
    Top = 72
  end
  object QRY_Prod: TFDQuery
    Active = True
    Connection = conect
    SQL.Strings = (
      'select * from produtos ')
    Left = 552
    Top = 48
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
      Precision = 10
      Size = 2
    end
  end
  object DS_Prod: TDataSource
    DataSet = QRY_Prod
    Left = 312
    Top = 72
  end
end