object FormEdicaoProd: TFormEdicaoProd
  Left = 0
  Top = 0
  Caption = 'FormEdicaoProd'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object edtNome: TEdit
    Left = 64
    Top = 112
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object EdtPreco: TEdit
    Left = 232
    Top = 112
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object Salvar: TButton
    Left = 80
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = SalvarClick
  end
  object Cancelar: TButton
    Left = 256
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = CancelarClick
  end
end
