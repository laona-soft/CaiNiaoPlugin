object MainForm: TMainForm
  Left = 253
  Top = 97
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Delphi'#30340'Host EXE'#21644'VC++'#30340#25554#20214'DLL'#20114#35775#38382#28436#31034
  ClientHeight = 519
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 16
    Top = 16
    Width = 649
    Height = 225
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
  object btn1: TButton
    Left = 285
    Top = 248
    Width = 97
    Height = 33
    Caption = #35843#29992'C++'#25509#21475
    TabOrder = 1
    OnClick = btn1Click
  end
  object mmo2: TMemo
    Left = 16
    Top = 288
    Width = 649
    Height = 217
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    Lines.Strings = (
      #19968#12289#27492'Demo'#28436#31034#22914#20309#20351#29992'C++'#32534#20889#30340'DLL'#25554#20214#65292#23427#24178#20102#36825#20123#20107#24773#65306
      '    Host'#31243#24207#19968#36816#34892#31435#39532#27880#20876#19968#20010'ILog'#25509#21475#26381#21153#65292#28982#21518#29983#25104#21253#21547'10'#20010#38543#26426#25968#30340#25968#32452#65292#21448#36733#20837'VC++'#32534#20889
      #30340#25554#20214#65292#35843#29992#25554#20214#25552#20379#30340'ISortService'#26381#21153#36827#34892#25490#24207#65292#25554#20214#23436#25104#25490#24207#21518#35843#29992'ILog'#26381#21153#21453#39304#32467#26524#12290
      '   '#27492'Demo'#21521#20320#28436#31034#20102#22914#20309#21644'VC++'#32534#20889#30340#25554#20214#36827#34892#21452#21521#20114#21160#12290
      ''
      #20108#12289#28608#21160#20102#26159#19981#26159#65292#24320#24178#21069#21548#25105#35828#65292#26694#26550#40664#35748#21482#25903#25345'Delphi'#20570#30340'DLL'#65292#22240#27492#65292#20320#38656#35201#65306
      '1'#12289#22312'Delphi'#30340'Host'#31243#24207#20013#28155#21152#26465#20214#32534#35793#24320#20851#8220'_USE_FOR_CPP'#8221
      '2'#12289#21442#29031'Demo'#20351#29992'VC++'#20570#25554#20214#65292#22312'C++'#37324#65292#27599#33719#21462#25509#21475#29992#23436#35201#35760#24471#35843#29992'Release()'#12290
      '3'#12289#21253#21547#22836#25991#20214#8220'WisdomCoreInterfaceForC.h'#8221#21644#26680#24515#26381#21153#30021#24555#27807#36890#65292#20195#30721#25105#37117#36716#35793#22909#20102#65292#24456#36763#33510#30340#24037#20316#21834#65281
      ''
      '  '#29616#22312#65292#31449#22312#25105#30340#36763#33510#24037#20316#19978#65292#24320#21551#20320#20139#21463#25554#20214#32534#31243#30340#20048#36259#21543#65281#25105#30340#35201#27714#20165#26159#65292#20320#35273#21463#30410#26102#24515#37324#24863#35874#25105#19968#19979#12290)
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object xpmnfst1: TXPManifest
    Left = 560
    Top = 16
  end
end
