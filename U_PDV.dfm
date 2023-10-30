object F_PDV: TF_PDV
  Left = 0
  Top = 0
  Caption = 'PDV'
  ClientHeight = 462
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object desc: TLabel
    Left = 101
    Top = 62
    Width = 96
    Height = 15
    Caption = 'Nome do produto'
  end
  object TLabel
    Left = 8
    Top = 62
    Width = 25
    Height = 15
    Caption = 'Cod.'
  end
  object TLabel
    Left = 8
    Top = 8
    Width = 25
    Height = 15
    Caption = 'Cod.'
  end
  object TLabel
    Left = 102
    Top = 8
    Width = 93
    Height = 15
    Caption = 'Nome do Cliente '
  end
  object TLabel
    Left = 364
    Top = 62
    Width = 26
    Height = 15
    Caption = 'Valor'
  end
  object TLabel
    Left = 455
    Top = 62
    Width = 23
    Height = 15
    Caption = 'Qtd.'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 443
    Width = 752
    Height = 19
    Panels = <>
    ExplicitTop = 442
    ExplicitWidth = 748
  end
  object pnl_pdv_baixo: TPanel
    Left = 0
    Top = 383
    Width = 752
    Height = 60
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 382
    ExplicitWidth = 748
    object Label1: TLabel
      Left = 544
      Top = 32
      Width = 25
      Height = 15
      Caption = 'Total'
    end
    object edt_total: TEdit
      Left = 584
      Top = 31
      Width = 121
      Height = 23
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object btn_remove_item: TButton
      Left = 24
      Top = 19
      Width = 105
      Height = 25
      Caption = 'Remover Item'
      TabOrder = 1
      OnClick = btn_remove_itemClick
    end
  end
  object dbg_lancamento: TDBGrid
    Left = 8
    Top = 112
    Width = 611
    Height = 249
    DataSource = DataMod.ds_listarPedido
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = dbg_lancamentoDblClick
    OnKeyDown = dbg_lancamentoKeyDown
    OnKeyPress = dbg_lancamentoKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'Autoincrem'
        Title.Caption = 'id Item'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodigoProduto'
        Title.Caption = 'id Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 234
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantidade'
        Title.Caption = 'QTD'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorUnitario'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorTotal'
        Title.Caption = 'Valor Total'
        Visible = True
      end>
  end
  object edt_pro_descr: TEdit
    Left = 101
    Top = 83
    Width = 257
    Height = 23
    CharCase = ecUpperCase
    Enabled = False
    TabOrder = 3
  end
  object edt_pro_preco: TEdit
    Left = 364
    Top = 83
    Width = 85
    Height = 23
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object edt_pro_qtd: TEdit
    Left = 455
    Top = 83
    Width = 57
    Height = 23
    TabOrder = 5
    Text = '1'
    OnExit = edt_pro_qtdExit
    OnKeyPress = edt_pro_qtdKeyPress
  end
  object btn_pro_add: TButton
    Left = 544
    Top = 82
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 6
    OnClick = btn_pro_addClick
  end
  object btn_gravar_venda: TButton
    Left = 625
    Top = 336
    Width = 105
    Height = 25
    Caption = 'Gravar Venda'
    TabOrder = 7
    OnClick = btn_gravar_vendaClick
  end
  object btn_cancelar_venda: TButton
    Left = 625
    Top = 305
    Width = 105
    Height = 25
    Caption = 'Cancelar Venda'
    TabOrder = 8
    OnClick = btn_cancelar_vendaClick
  end
  object edt_cli_codigo: TEdit
    Left = 8
    Top = 24
    Width = 73
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 9
    OnKeyPress = edt_cli_codigoKeyPress
  end
  object edt_cli_nome: TEdit
    Left = 101
    Top = 24
    Width = 322
    Height = 23
    Enabled = False
    TabOrder = 10
    OnChange = edt_cli_nomeChange
  end
  object edt_pro_cod: TEdit
    Left = 8
    Top = 84
    Width = 73
    Height = 23
    TabOrder = 11
    OnKeyPress = edt_pro_codKeyPress
  end
  object btn_iniciar_venda: TButton
    Left = 566
    Top = 15
    Width = 139
    Height = 42
    Caption = 'Iniciar Venda'
    TabOrder = 12
    OnClick = btn_iniciar_vendaClick
  end
  object btnEditar: TButton
    Left = 625
    Top = 82
    Width = 80
    Height = 25
    Caption = 'Salvar Edi'#231#227'o'
    TabOrder = 13
    OnClick = btnEditarClick
  end
  object QRY_VerificaVenda: TFDQuery
    Connection = DataMod.conect
    SQL.Strings = (
      'select * from pedidosdadosgerais')
    Left = 656
    Top = 128
  end
  object tb_pedido: TFDTable
    IndexFieldNames = 'NumeroPedido'
    Connection = DataMod.conect
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'lojateste.pedidosdadosgerais'
    Left = 664
    Top = 232
    object tb_pedidoNumeroPedido: TFDAutoIncField
      FieldName = 'NumeroPedido'
      Origin = 'NumeroPedido'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tb_pedidoDataEmissao: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DataEmissao'
      Origin = 'DataEmissao'
    end
    object tb_pedidoCodigoCliente: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'CodigoCliente'
      Origin = 'CodigoCliente'
    end
    object tb_pedidoValorTotal: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Precision = 10
      Size = 2
    end
  end
  object QRY_Itens: TFDQuery
    Connection = DataMod.conect
    Left = 656
    Top = 184
  end
  object QRY_CancelaVenda: TFDQuery
    Connection = DataMod.conect
    Left = 704
    Top = 192
  end
end
