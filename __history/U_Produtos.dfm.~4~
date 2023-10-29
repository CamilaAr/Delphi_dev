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
      object dbg_produtos: TDBGrid
        Left = 0
        Top = 144
        Width = 730
        Height = 271
        Align = alBottom
        DataSource = DataMod.DS_Prod
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
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
        Top = 115
        Width = 201
        Height = 23
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyPress = edt_buscarKeyPress
      end
    end
    object tab_cadastrar: TTabSheet
      Caption = 'Cadastrar'
      ImageIndex = 1
    end
  end
end
