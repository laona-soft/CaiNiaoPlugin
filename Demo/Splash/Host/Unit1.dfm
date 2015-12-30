object MainForm: TMainForm
  Left = 367
  Top = 147
  Width = 737
  Height = 357
  Caption = #21551#21160#38378#23631#30028#38754#28436#31034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 64
    Width = 132
    Height = 77
    Caption = 'Hello'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -64
    Font.Name = 'Roboto Cn'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 29
    Top = 152
    Width = 662
    Height = 65
    Caption = 'WisdomPluginFramework'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -56
    Font.Name = 'Cambria'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object xpmnfst1: TXPManifest
    Left = 504
    Top = 40
  end
  object Timer1: TTimer
    Interval = 6000
    OnTimer = Timer1Timer
    Left = 576
    Top = 48
  end
end
