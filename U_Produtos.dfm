object F_Produtos: TF_Produtos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produtos'
  ClientHeight = 464
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
  object stb_produtos: TStatusBar
    Left = 0
    Top = 445
    Width = 738
    Height = 19
    Panels = <>
    ExplicitTop = 442
    ExplicitWidth = 734
  end
  object pg_produtos: TPageControl
    Left = 0
    Top = 0
    Width = 738
    Height = 445
    ActivePage = tab_consultar
    Align = alClient
    TabOrder = 1
    TabWidth = 200
    object tab_consultar: TTabSheet
      Caption = 'Consultar'
      object lb_busca: TLabel
        Left = 3
        Top = 16
        Width = 81
        Height = 15
        Caption = 'Buscar Produto'
      end
      object dbg_produtos: TDBGrid
        Left = 0
        Top = 66
        Width = 730
        Height = 349
        Align = alBottom
        DataSource = DataMod.DS_Prod
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbg_produtosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Title.Caption = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descricao'
            Title.Caption = 'Produto'
            Width = 559
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoVenda'
            Title.Caption = 'Valor'
            Visible = True
          end>
      end
      object edt_buscar: TEdit
        Left = 0
        Top = 37
        Width = 201
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyPress = edt_buscarKeyPress
      end
      object btn_editarProd: TButton
        Left = 556
        Top = 35
        Width = 171
        Height = 25
        Caption = 'Editar item selecionado'
        TabOrder = 2
        OnClick = btn_editarProdClick
      end
    end
    object tab_cadastrar: TTabSheet
      Caption = 'Cadastrar - Editar'
      ImageIndex = 1
      object lb_descricao: TLabel
        Left = 24
        Top = 120
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
        FocusControl = DBEdit1
      end
      object lb_preco: TLabel
        Left = 24
        Top = 179
        Width = 30
        Height = 15
        Caption = 'Pre'#231'o'
        FocusControl = DBEdit2
      end
      object DBEdit1: TDBEdit
        Left = 24
        Top = 136
        Width = 425
        Height = 23
        CharCase = ecUpperCase
        DataField = 'Descricao'
        DataSource = ds_prod_cad
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 24
        Top = 200
        Width = 169
        Height = 23
        CharCase = ecUpperCase
        DataField = 'PrecoVenda'
        DataSource = ds_prod_cad
        TabOrder = 1
      end
      object btn_novo: TButton
        Left = 24
        Top = 272
        Width = 100
        Height = 25
        Action = ac_insert
        TabOrder = 2
      end
      object btn_editar: TButton
        Left = 146
        Top = 272
        Width = 100
        Height = 25
        Action = ac_editar
        TabOrder = 3
      end
      object btn_ok: TButton
        Left = 264
        Top = 272
        Width = 100
        Height = 25
        Action = ac_ok
        TabOrder = 4
      end
      object btn_cancelar: TButton
        Left = 384
        Top = 272
        Width = 100
        Height = 25
        Action = ac_cancelar
        TabOrder = 5
      end
      object btn_delete: TButton
        Left = 504
        Top = 272
        Width = 100
        Height = 25
        Action = ac_apagar
        TabOrder = 6
      end
    end
  end
  object ds_prod_cad: TDataSource
    DataSet = DataMod.tb_prod
    Left = 680
    Top = 48
  end
  object acm_cli: TActionManager
    Left = 612
    Top = 42
    StyleName = 'Platform Default'
    object ac_insert: TDataSetInsert
      Category = 'Dataset'
      Caption = 'Novo'
      Hint = 'Insert'
      ImageIndex = 4
      DataSource = ds_prod_cad
    end
    object ac_apagar: TDataSetDelete
      Category = 'Dataset'
      Caption = 'Apagar'
      Hint = 'ac_apagar'
      ImageIndex = 5
      DataSource = ds_prod_cad
    end
    object ac_editar: TDataSetEdit
      Category = 'Dataset'
      Caption = 'Editar'
      ImageIndex = 6
      DataSource = ds_prod_cad
    end
    object ac_ok: TDataSetPost
      Category = 'Dataset'
      Caption = 'Gravar'
      Hint = 'Post'
      ImageIndex = 7
      DataSource = ds_prod_cad
    end
    object ac_cancelar: TDataSetCancel
      Category = 'Dataset'
      Caption = 'Cancelar'
      Hint = 'Cancel'
      ImageIndex = 8
      DataSource = ds_prod_cad
    end
  end
end
