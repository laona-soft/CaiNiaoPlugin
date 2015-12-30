object MainForm: TMainForm
  Left = 339
  Top = 246
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21160#24577#28155#21152#26381#21153#28436#31034
  ClientHeight = 169
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 38
    Top = 24
    Width = 161
    Height = 49
    Caption = #19968#34892#31243#24207#23436#25104#26381#21153#28155#21152
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 214
    Top = 24
    Width = 161
    Height = 49
    Caption = #31532#20108#31181#24555#36895#28155#21152#26381#21153#26041#27861
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 130
    Top = 96
    Width = 129
    Height = 49
    Caption = #35843#29992#28155#21152#30340#26381#21153
    TabOrder = 2
    OnClick = btn3Click
  end
  object xpmnfst1: TXPManifest
    Left = 304
    Top = 96
  end
end
