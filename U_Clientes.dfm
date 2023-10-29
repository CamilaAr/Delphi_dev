object F_Clientes: TF_Clientes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clientes'
  ClientHeight = 462
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object SpeedButton1: TSpeedButton
    Left = 136
    Top = 8
    Width = 23
    Height = 22
  end
  object pg_clientes: TPageControl
    Left = 0
    Top = 0
    Width = 738
    Height = 443
    ActivePage = tab_consultar
    Align = alClient
    TabOrder = 0
    TabWidth = 200
    ExplicitTop = -6
    object tab_consultar: TTabSheet
      Caption = 'Consultar'
      object Label1: TLabel
        Left = 3
        Top = 11
        Width = 80
        Height = 15
        Caption = 'Buscar Clientes'
      end
      object dbg_cli: TDBGrid
        Left = 0
        Top = 61
        Width = 730
        Height = 352
        Align = alBottom
        DataSource = DataMod.DS_Cli
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbg_cliDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 330
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cidade'
            Width = 222
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Width = 100
            Visible = True
          end>
      end
      object edt_busca: TEdit
        Left = 3
        Top = 32
        Width = 206
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyPress = edt_buscaKeyPress
      end
      object btn_editarCli: TButton
        Left = 556
        Top = 30
        Width = 171
        Height = 25
        Caption = 'Editar item selecionado'
        TabOrder = 2
        OnClick = btn_editarCliClick
      end
    end
    object tab_editar: TTabSheet
      Caption = 'Cadastrar - Editar'
      ImageIndex = 1
      object Label2: TLabel
        Left = 11
        Top = 62
        Width = 33
        Height = 15
        Caption = 'Nome'
        FocusControl = DBEdit1
      end
      object Label3: TLabel
        Left = 11
        Top = 136
        Width = 37
        Height = 15
        Caption = 'Cidade'
        FocusControl = DBEdit2
      end
      object Label4: TLabel
        Left = 336
        Top = 136
        Width = 14
        Height = 15
        Caption = 'UF'
        FocusControl = DBEdit3
      end
      object btn_novo: TButton
        Left = 64
        Top = 312
        Width = 100
        Height = 25
        Action = ac_insert
        TabOrder = 0
      end
      object btn_editar: TButton
        Left = 186
        Top = 312
        Width = 100
        Height = 25
        Action = ac_editar
        TabOrder = 1
      end
      object btn_ok: TButton
        Left = 304
        Top = 312
        Width = 100
        Height = 25
        Action = ac_ok
        TabOrder = 2
      end
      object btn_cancelar: TButton
        Left = 424
        Top = 312
        Width = 100
        Height = 25
        Action = ac_cancelar
        TabOrder = 3
      end
      object btn_delete: TButton
        Left = 544
        Top = 312
        Width = 100
        Height = 25
        Action = ac_apagar
        TabOrder = 4
      end
      object DBEdit1: TDBEdit
        Left = 11
        Top = 83
        Width = 300
        Height = 23
        DataField = 'Nome'
        DataSource = ds_cli_cad
        TabOrder = 5
      end
      object DBEdit2: TDBEdit
        Left = 11
        Top = 152
        Width = 300
        Height = 23
        DataField = 'Cidade'
        DataSource = ds_cli_cad
        TabOrder = 6
      end
      object DBEdit3: TDBEdit
        Left = 336
        Top = 152
        Width = 34
        Height = 23
        DataField = 'UF'
        DataSource = ds_cli_cad
        TabOrder = 7
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 443
    Width = 738
    Height = 19
    Panels = <>
    ExplicitLeft = 400
    ExplicitTop = 432
    ExplicitWidth = 0
  end
  object acm_cli: TActionManager
    Left = 668
    Top = 226
    StyleName = 'Platform Default'
    object ac_insert: TDataSetInsert
      Category = 'Dataset'
      Caption = 'Novo'
      Hint = 'Insert'
      ImageIndex = 4
      DataSource = ds_cli_cad
    end
    object ac_apagar: TDataSetDelete
      Category = 'Dataset'
      Caption = 'Apagar'
      Hint = 'ac_apagar'
      ImageIndex = 5
      DataSource = ds_cli_cad
    end
    object ac_editar: TDataSetEdit
      Category = 'Dataset'
      Caption = 'Editar'
      ImageIndex = 6
      DataSource = ds_cli_cad
    end
    object ac_ok: TDataSetPost
      Category = 'Dataset'
      Caption = 'Gravar'
      Hint = 'Post'
      ImageIndex = 7
      DataSource = ds_cli_cad
    end
    object ac_cancelar: TDataSetCancel
      Category = 'Dataset'
      Caption = 'Cancelar'
      Hint = 'Cancel'
      ImageIndex = 8
      DataSource = ds_cli_cad
    end
  end
  object ds_cli_cad: TDataSource
    DataSet = DataMod.tb_cli
    Left = 584
    Top = 232
  end
end
