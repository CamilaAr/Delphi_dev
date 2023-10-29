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
        TabOrder = 1
        OnKeyPress = edt_buscaKeyPress
      end
    end
    object tab_editar: TTabSheet
      Caption = 'Cadastrar - Editar'
      ImageIndex = 1
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
end
