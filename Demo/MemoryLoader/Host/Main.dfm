object MainForm: TMainForm
  Left = 283
  Top = 167
  Width = 791
  Height = 431
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    775
    392)
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 16
    Top = 8
    Width = 105
    Height = 33
    Caption = #20174#20869#23384#21152#36733'DLL'
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo1: TMemo
    Left = 16
    Top = 48
    Width = 745
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #24494#36719#38597#40657' Light'
    Font.Style = []
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    Lines.Strings = (
      #27492'Demo'#24847#20041#30456#24403#37325#22823#65281#20854#28436#31034#20102#20004#20010#38750#24120#37325#30917#23454#29992#30340#21151#33021#65306
      '1'#12289#31169#20154#23450#21046#26680#24515#25509#21475#34892#20026
      '      '#26412#20363#36890#36807#31169#20154#23450#21046#36733#20837#22120#25509#21475'IPluginLoader'#65292#23454#29616#20102#21482#36816#34892#22312#20869#23384#20013#30340#29305#27530#25554#20214#27169
      #22359#30340#36733#20837#65292#20197#21516#26679#26041#24335#25193#23637#24320#21435#65292#26694#26550#20013#20219#24847#26680#24515#26381#21153#22343#21487#25353#20320#29305#27530#35201#27714#31169#20154#23450#21046#12290
      '2'#12289#20869#23384#25554#20214#30340#20351#29992
      '      '#25554#20214#19981#20986#29616#22312#30913#30424#20013#65292#22914#20174#36164#28304#25991#20214#20013#36733#20837#65292#25110#20174#26381#21153#22120#25512#36865#32780#26469#65292#30452#25509#36827#20837#20869#23384
      #36816#34892#65292#23545#25554#20214#26377#20445#23494#38656#27714#25110#23545#23458#25143#31471#31243#24207#29615#22659#30340#20445#25345#26377#27905#30294#30340#21516#23398#65292#36825#20010#21512#20320#20102#65281
      ''
      #21478#65306
      '1'#12289#36825#20010'Demo'#20013#30340'MemoryLoader.dll'#25554#20214#65292#25903#25345'Delphi'#12289'C++'#30340'DLL'#27169#22359#36733#20837#65292#19981#26159#29609#20855#65292
      '      '#23436#20840#21487#20197#30452#25509#21830#29992#12290
      '2'#12289#20869#23384#36733#20837#21333#20803'MemoryModule.pas'#30001#22823#29275#20154#27494#31232#26494#26080#31169#24320#28304#20986#21697#65292#23545#27492#29275#33268#20197#23815#39640
      '      '#25964#24847#21644#24863#35874#65281
      ''
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object btn2: TButton
    Left = 128
    Top = 8
    Width = 105
    Height = 33
    Caption = #20174#20869#23384#21368#36733'DLL'
    Enabled = False
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 240
    Top = 8
    Width = 105
    Height = 33
    Caption = #35843#29992'ISortService'
    Enabled = False
    TabOrder = 3
    OnClick = btn3Click
  end
  object xpmnfst1: TXPManifest
    Left = 440
    Top = 16
  end
end
