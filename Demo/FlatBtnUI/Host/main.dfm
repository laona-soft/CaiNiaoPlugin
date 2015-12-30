object MainForm: TMainForm
  Left = 358
  Top = 145
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MainForm'
  ClientHeight = 453
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object LoadPluginBtn: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = #36733#20837#25554#20214
    TabOrder = 0
    OnClick = LoadPluginBtnClick
  end
  object pnl1: TPanel
    Left = 8
    Top = 56
    Width = 673
    Height = 385
    TabOrder = 1
    OnEnter = pnl1Enter
    object lbl1: TLabel
      Left = 64
      Top = 344
      Width = 311
      Height = 15
      Caption = '4'#12289#28966#28857#22312#20027#31383#21475#21450'DLL'#31383#21475#30340#20999#25442#65288#25353'Tab'#38190#65289
    end
    object Label1: TLabel
      Left = 40
      Top = 248
      Width = 122
      Height = 15
      Caption = #27492'Demo'#20027#35201#28436#31034#65306
    end
    object Label2: TLabel
      Left = 64
      Top = 272
      Width = 542
      Height = 15
      Caption = '1'#12289'DLL'#31383#21475#20013'TSpeedButton'#30340#20351#29992#65288#20165#28436#31034#65292#30495#24515#19981#24314#35758#22312'DLL'#20013#20351#29992#24179#38754#25353#38062#65289
    end
    object Label3: TLabel
      Left = 64
      Top = 296
      Width = 338
      Height = 15
      Caption = '2'#12289#25554#20214#31995#32479#20013#25193#23637#28857#23450#20041#21450#23454#29616#25193#23637#28857#30340#26381#21153#25554#20214
    end
    object Label4: TLabel
      Left = 64
      Top = 320
      Width = 233
      Height = 15
      Caption = '3'#12289#21160#24577#22686#21152#26381#21153#25509#21475#21450#25193#23637#28857#23450#20041
    end
  end
  object UnLoadPluginBtn: TButton
    Left = 96
    Top = 16
    Width = 75
    Height = 25
    Caption = #21368#36733#25554#20214
    TabOrder = 2
    OnClick = UnLoadPluginBtnClick
  end
  object xpmnfst1: TXPManifest
    Left = 456
    Top = 16
  end
end
