object F_Principal: TF_Principal
  Left = 0
  Top = 0
  Caption = 'Controle de Vendas'
  ClientHeight = 519
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = menu_inicial
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 344
    Width = 327
    Height = 15
    Caption = 'VENDA E PRODUTOS ANTIGOS, APENAS PARA VISUALIZA'#199#195'O'
  end
  object Button1: TButton
    Left = 207
    Top = 376
    Width = 177
    Height = 57
    Caption = 'Produtos'
    TabOrder = 0
    OnClick = Button1Click
  end
  object btnVenda: TButton
    Left = 24
    Top = 376
    Width = 177
    Height = 57
    Caption = 'Venda'
    TabOrder = 1
    OnClick = btnVendaClick
  end
  object stb_inicial: TStatusBar
    Left = 0
    Top = 500
    Width = 788
    Height = 19
    Panels = <>
    ExplicitTop = 499
    ExplicitWidth = 784
  end
  object panel_menu: TPanel
    Left = 0
    Top = 0
    Width = 788
    Height = 73
    Align = alTop
    Color = clSilver
    ParentBackground = False
    TabOrder = 3
    ExplicitWidth = 784
    object btn_clientes: TSpeedButton
      Left = 0
      Top = 16
      Width = 97
      Height = 57
      Caption = 'Clientes'
      OnClick = btn_clientesClick
    end
    object btn_Produtos: TSpeedButton
      Left = 103
      Top = 16
      Width = 81
      Height = 57
      Caption = 'Produtos'
      OnClick = btn_ProdutosClick
    end
    object btn_pdv: TSpeedButton
      Left = 190
      Top = 16
      Width = 98
      Height = 57
      Caption = 'PDV'
      OnClick = btn_pdvClick
    end
  end
  object menu_inicial: TMainMenu
    Left = 704
    Top = 192
    object Cadastros1: TMenuItem
      Caption = 'Cadastros / Consultas'
      object N1: TMenuItem
        Caption = '-'
      end
      object produtos: TMenuItem
        Caption = 'Produtos'
        OnClick = produtosClick
      end
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
    end
    object Clientes2: TMenuItem
      Caption = '-'
    end
    object Movimentos1: TMenuItem
      Caption = 'Movimentos'
      object Movimentos2: TMenuItem
        Caption = '-'
      end
      object PDV1: TMenuItem
        Caption = 'PDV'
        OnClick = PDV1Click
      end
    end
  end
end
