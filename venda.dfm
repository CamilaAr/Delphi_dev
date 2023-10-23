object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 115
    Width = 628
    Height = 327
    Align = alBottom
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'Descricao'
        Width = 267
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PrecoVenda'
        Width = 251
        Visible = True
      end>
  end
  object edtDataEmissao: TEdit
    Left = 0
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object edtCodigoCliente: TEdit
    Left = 152
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object edtNumeroPedido: TEdit
    Left = 312
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object edtCodigoProduto: TEdit
    Left = 464
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 4
  end
  object edtQuantidade: TEdit
    Left = 0
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 5
  end
  object edtValorUnitario: TEdit
    Left = 152
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 6
  end
  object btnInserirPedido: TBitBtn
    Left = 312
    Top = 48
    Width = 89
    Height = 41
    Caption = 'Inserir Pedido'
    TabOrder = 7
    OnClick = btnInserirPedidoClick
  end
  object btnInserirProduto: TBitBtn
    Left = 424
    Top = 48
    Width = 89
    Height = 41
    Caption = 'Inserir Produto'
    TabOrder = 8
    OnClick = btnInserirProdutoClick
  end
end
