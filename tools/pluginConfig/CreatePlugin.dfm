object frmCreatePlugin: TfrmCreatePlugin
  Left = 331
  Top = 237
  BorderStyle = bsDialog
  Caption = #25554#20214#39033#30446#29983#25104#21521#23548
  ClientHeight = 223
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 16
    Top = 13
    Width = 210
    Height = 15
    Caption = #25554#20214#39033#30446#29983#25104#65288#35831#20351#29992#33521#25991#65289#65306
  end
  object lbl3: TLabel
    Left = 16
    Top = 85
    Width = 318
    Height = 15
    Caption = #29983#25104#31034#20363#25509#21475#26381#21153#65288#21482#22635#22914'Test'#65292#19981#35201#21152#8220'I"'#65289
  end
  object edtPath: TEdit
    Left = 16
    Top = 32
    Width = 449
    Height = 23
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    ReadOnly = True
    TabOrder = 0
  end
  object btnBrowse: TBitBtn
    Left = 471
    Top = 31
    Width = 25
    Height = 25
    Hint = #31227#38500#36873#23450#30340#25554#20214#37197#32622
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnBrowseClick
  end
  object btn1: TBitBtn
    Left = 216
    Top = 176
    Width = 75
    Height = 25
    Caption = #29983#25104
    TabOrder = 3
    OnClick = btn1Click
  end
  object edt2: TEdit
    Left = 16
    Top = 104
    Width = 329
    Height = 23
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    TabOrder = 2
  end
  object mmo1: TMemo
    Left = 8
    Top = 208
    Width = 489
    Height = 153
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    Lines.Strings = (
      'library %s;'
      ''
      
        '{ Important note about DLL memory management: ShareMem must be t' +
        'he'
      
        '  first unit in your library'#39's USES clause AND your project'#39's (s' +
        'elect'
      
        '  Project-View Source) USES clause if your DLL exports any proce' +
        'dures or'
      
        '  functions that pass strings as parameters or function results.' +
        ' This'
      
        '  applies to all strings passed to and from your DLL--even those' +
        ' that'
      
        '  are nested in records and classes. ShareMem is the interface u' +
        'nit to'
      
        '  the BORLNDMM.DLL shared memory manager, which must be deployed' +
        ' along'
      
        '  with your DLL. To avoid using BORLNDMM.DLL, pass string inform' +
        'ation'
      '  using PChar or ShortString parameters. }'
      ''
      'uses'
      '  SysUtils,'
      '  Classes,'
      '  ExportFunc in '#39'ExportFunc.pas'#39','
      '  ServicesInterface in '#39'ServicesInterface.pas'#39','
      '  ServicesImplement in '#39'ServicesImplement.pas'#39';'
      ''
      '{$R *.res}'
      ''
      'begin'
      'end.'
      ''
      'unit ServicesInterface;'
      ''
      'interface'
      ''
      'const'
      '  %s = '#39'%s'#39';'
      ''
      'type'
      '  %s = interface(IInterface)'
      '    [%s]'
      '    procedure Hello();'
      '  end;'
      ''
      ''
      'implementation'
      ''
      'end.'
      ''
      'unit ServicesImplement;'
      ''
      'interface'
      ''
      'uses WisdomCoreInterfaceForD, ServicesInterface;'
      ''
      'type'
      '  %s = class(TPluginInterfacedObject, %s)'
      '  private'
      ''
      '  public'
      '    procedure Hello();'
      '  end;'
      ''
      'implementation'
      ''
      '{ %s}'
      ''
      'procedure %s.Hello;'
      'begin'
      ''
      'end;'
      ''
      'end.'
      ''
      'unit ExportFunc;'
      ''
      'interface'
      ''
      
        'uses WisdomCoreInterfaceForD, ServicesInterface, ServicesImpleme' +
        'nt;'
      ''
      
        '    function  DLLGetObject(const serviceID: PAnsiChar): IInterfa' +
        'ce; stdcall;'
      '    procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;'
      
        '    procedure DLLInitializePlugin(const IServiceMgr: IServiceMan' +
        'ager); stdcall;'
      
        '    procedure DLLUninitializePlugin(const IServiceMgr: IServiceM' +
        'anager); stdcall;'
      
        '    procedure DLLServiceStart(const serviceID: PAnsiChar); stdca' +
        'll;'
      
        '    procedure DLLServiceStop(const serviceID: PAnsiChar); stdcal' +
        'l;'
      ''
      'exports'
      '   DLLGetObject,'
      '   DLLGetPluginInfo,'
      '   DLLInitializePlugin,'
      '   DLLUninitializePlugin,'
      '   DLLServiceStart,'
      '   DLLServiceStop;'
      ''
      'implementation'
      ''
      '//'#22914#26524#22312'DLLGetPluginInfo'#26410#20351#29992'SetServiceClass'#35774#32622#26381#21153#25509#21475#30340#23454#29616#31867#65292#21017#26694#26550#20250#22312
      '//'#25509#21040#23545'serviceID'#30340#26381#21153#35831#27714#26102#65292#20250#35843#29992#27492#20989#25968#65292#35831#22312#27492#20989#25968#20013#21019#24314#35813#26381#21153#25509#21475#36820#22238#26694#26550#12290
      '//'#27492#20989#25968#20027#35201#35774#35745#20026#29992#20110'C++'#23454#29616#30340'DLL'#27169#22359#65292#22240#20026#22914'VC'#23454#29616#30340#25509#21475#31867#26080#27861#25552#20379'Delphi'#21487#29992#30340#23454#29616#31867'TClassxxx'
      
        'function DLLGetObject(const serviceID: PAnsiChar): IInterface; s' +
        'tdcall;'
      'begin'
      '  Result := nil;'
      'end;'
      ''
      '//'#35813#20989#25968#22312#26694#26550#33719#21462#25554#20214#20449#24687#26102#35843#29992#65292#26694#26550#20256#20837'im'#25509#21475#65292#36890#36807#35813#25509#21475#21453#39304#25554#20214#20449#24687#21644#25509#21475#26381#21153#20449#24687
      'procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;'
      'begin'
      '  im.SetAuthor('#39#39'); //'#25554#20214#27169#22359#20316#32773
      '  im.SetComment('#39#39');//'#25554#20214#31616#35201#35828#26126
      '  im.SetPluginID('#39'%s'#39');//'#25554#20214'ID'
      '  im.SetPluginName('#39'%s'#39');//'#25554#20214#21517#31216
      '  im.SetVersion('#39'1.0.0'#39');//'#25554#20214#29256#26412
      '  im.SetUpdateHistory('#39#39');//'#25554#20214#26356#26032#21382#21490
      ''
      '  with im.AppendServiceInfo(%s) do begin'
      '    SetAuthor('#39#39'); //'#26381#21153#25509#21475#20316#32773
      '    SetComment('#39#39');//'#26381#21153#21151#33021#29305#28857#31616#35201#35828#26126
      '    SetSingleton(True);//'#26381#21153#26159#21542#35201#20197#21333#20363#27169#24335#36816#34892
      '    SetServiceClass(%s);//'#26381#21153#25509#21475#30340#23454#29616#31867
      '    SetServiceName('#39'%s'#39');//'#26381#21153#21517#31216
      '    SetImplementServiceID('#39#39');//'#26381#21153#23454#29616#30340#25193#23637#28857'ID'
      '  end;'
      'end;'
      ''
      '{'#27492#22788#21487#20197#20570#19968#20123#25554#20214#27169#22359#27491#24120#36816#34892#25152#38656#35201#30340#21021#22987#21270#25805#20316#65292#35813#20989#25968#34987#35843#29992#30340
      #26102#26426#26159#65306#25554#20214'DLL'#24050#34987#26694#26550#36733#20837#65292#20294#26410#28608#27963'('#21253#25324#25554#20214#20013#30340#26381#21153#39033')}'
      
        'procedure DLLInitializePlugin(const IServiceMgr: IServiceManager' +
        '); stdcall;'
      'begin'
      ''
      'end;'
      ''
      '//'#27492#22788#20570#19968#20123#25554#20214#27169#22359#36864#20986#21069#30340#28165#29702#25805#20316#65292#35813#20989#25968#34987#26694#26550#35843#29992#30340
      '//'#26102#26426#26159#65306#25554#20214#25552#20379#30340#25152#26377#25509#21475#26381#21153#24050#20572#29992#65292#25554#20214#27169#22359#21363#23558#34987'DeActive'
      
        'procedure DLLUninitializePlugin(const IServiceMgr: IServiceManag' +
        'er); stdcall;'
      'begin'
      '  '
      'end;'
      ''
      '//'#26381#21153#34987#28608#27963#21518#35843#29992
      'procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;'
      'begin'
      ''
      'end;'
      ''
      '//'#26381#21153#34987'DeActive'#21069#35843#29992
      'procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;'
      'begin'
      ''
      'end;'
      ''
      'end.')
    TabOrder = 4
    Visible = False
    WordWrap = False
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.dpr'
    Filter = '*.dpr|*.dpr'
    Left = 56
    Top = 152
  end
end
