object frmMain: TfrmMain
  Left = 308
  Top = 158
  Width = 707
  Height = 494
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    691
    455)
  PixelsPerInch = 96
  TextHeight = 15
  object lbl16: TLabel
    Left = 8
    Top = 429
    Width = 410
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 
      'WisdomPluginFramework  pluginConfig tool ver1.6  Copyright  IceA' +
      'ir 2014'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Cambria'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 8
    Top = 48
    Width = 675
    Height = 371
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object spl1: TSplitter
      Left = 210
      Top = 0
      Height = 371
      ResizeStyle = rsUpdate
    end
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 210
      Height = 371
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      DesignSize = (
        210
        371)
      object tvPlugin: TTreeView
        Left = 10
        Top = 40
        Width = 189
        Height = 314
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Cambria'
        Font.Style = []
        HideSelection = False
        Indent = 20
        ParentFont = False
        ReadOnly = True
        StateImages = ImageList1
        TabOrder = 3
        OnChange = tvPluginChange
        Items.Data = {
          0100000023000000FFFFFFFFFFFFFFFF01000000FFFFFFFF0000000002000000
          0A506C7567696E2E646C6C20000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000000100000007536572766963651D000000FFFFFFFFFFFFFFFF01000000FF
          FFFFFF000000000000000004494C6F6724000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF00000000010000000B457874656E74506F696E7421000000FFFFFFFF
          FFFFFFFF03000000FFFFFFFF000000000000000008494D657373616765}
      end
      object btnNewPlugin: TBitBtn
        Left = 10
        Top = 9
        Width = 25
        Height = 25
        Hint = #29983#25104#25554#20214#39033#30446
        Caption = 'I'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnNewPluginClick
      end
      object btnAddPluginDll: TBitBtn
        Left = 140
        Top = 9
        Width = 25
        Height = 25
        Hint = #28155#21152#25554#20214'(*.dll)'
        Anchors = [akTop, akRight]
        Caption = '+'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnAddPluginDllClick
      end
      object btnRemovePlugin: TBitBtn
        Left = 171
        Top = 9
        Width = 25
        Height = 25
        Hint = #31227#38500#36873#23450#30340#25554#20214#37197#32622
        Anchors = [akTop, akRight]
        Caption = '-'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnRemovePluginClick
      end
      object btnActiveService: TButton
        Left = 50
        Top = 8
        Width = 75
        Height = 26
        Caption = #28608#27963
        TabOrder = 4
        Visible = False
        OnClick = btnActiveServiceClick
      end
    end
    object pgc1: TPageControl
      Left = 213
      Top = 0
      Width = 462
      Height = 371
      ActivePage = ts1
      Align = alClient
      TabOrder = 1
      object ts1: TTabSheet
        Caption = #25554#20214#20449#24687
        DesignSize = (
          454
          340)
        object lbl1: TLabel
          Left = 16
          Top = 15
          Width = 45
          Height = 15
          Caption = #21517#31216#65306
        end
        object lbl2: TLabel
          Left = 30
          Top = 75
          Width = 31
          Height = 15
          Caption = 'ID'#65306
        end
        object lbl3: TLabel
          Left = 16
          Top = 135
          Width = 45
          Height = 15
          Caption = #20316#32773#65306
        end
        object lbl4: TLabel
          Left = 16
          Top = 45
          Width = 45
          Height = 15
          Caption = #29256#26412#65306
        end
        object lbl5: TLabel
          Left = 16
          Top = 166
          Width = 45
          Height = 15
          Caption = #35828#26126#65306
        end
        object lbl11: TLabel
          Left = 16
          Top = 228
          Width = 45
          Height = 15
          Caption = #21382#21490#65306
        end
        object lbl12: TLabel
          Left = 16
          Top = 287
          Width = 75
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = #21487#29992#29366#24577#65306
        end
        object Label1: TLabel
          Left = 0
          Top = 105
          Width = 60
          Height = 15
          Caption = #36733#20837#22120#65306
        end
        object edtName: TEdit
          Left = 60
          Top = 10
          Width = 317
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Cambria'
          Font.Style = []
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object edtID: TEdit
          Left = 60
          Top = 71
          Width = 317
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Cambria'
          Font.Style = []
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object edtAuthor: TEdit
          Left = 60
          Top = 132
          Width = 381
          Height = 23
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 4
        end
        object edtVersion: TEdit
          Left = 60
          Top = 41
          Width = 317
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Cambria'
          Font.Style = []
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object mmoComment: TMemo
          Left = 60
          Top = 161
          Width = 381
          Height = 57
          Anchors = [akLeft, akTop, akRight]
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 5
        end
        object mmoHistory: TMemo
          Left = 60
          Top = 224
          Width = 381
          Height = 57
          Anchors = [akLeft, akTop, akRight, akBottom]
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 6
        end
        object rb1: TRadioButton
          Left = 113
          Top = 287
          Width = 81
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #21487#29992
          TabOrder = 7
          TabStop = True
          OnClick = rb1Click
        end
        object rb2: TRadioButton
          Left = 200
          Top = 287
          Width = 81
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #31105#29992
          TabOrder = 8
          TabStop = True
          OnClick = rb2Click
        end
        object pnl4: TPanel
          Left = 2
          Top = 308
          Width = 447
          Height = 37
          Anchors = [akLeft, akBottom]
          BevelOuter = bvNone
          ParentBackground = True
          TabOrder = 9
          object lbl13: TLabel
            Left = 14
            Top = 10
            Width = 75
            Height = 15
            Caption = #36733#20837#26041#24335#65306
          end
          object rb3: TRadioButton
            Left = 111
            Top = 8
            Width = 81
            Height = 17
            Caption = #24635#26159
            TabOrder = 0
            TabStop = True
            OnClick = rb3Click
          end
          object rb4: TRadioButton
            Left = 198
            Top = 8
            Width = 75
            Height = 17
            Caption = #25353#38656
            TabOrder = 1
            TabStop = True
            OnClick = rb4Click
          end
          object rb5: TRadioButton
            Left = 279
            Top = 8
            Width = 97
            Height = 17
            Caption = #33258#21160
            TabOrder = 2
            TabStop = True
            OnClick = rb5Click
          end
        end
        object edtLoaderID: TEdit
          Left = 60
          Top = 101
          Width = 317
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Cambria'
          Font.Style = []
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ParentFont = False
          TabOrder = 3
        end
      end
      object ts2: TTabSheet
        Caption = #26381#21153#20449#24687
        ImageIndex = 1
        DesignSize = (
          454
          340)
        object lbl6: TLabel
          Left = 24
          Top = 21
          Width = 45
          Height = 15
          Caption = #21517#31216#65306
        end
        object lbl7: TLabel
          Left = 38
          Top = 103
          Width = 31
          Height = 15
          Caption = 'ID'#65306
        end
        object lbl8: TLabel
          Left = 26
          Top = 195
          Width = 45
          Height = 15
          Caption = #20316#32773#65306
        end
        object lbl9: TLabel
          Left = 24
          Top = 61
          Width = 45
          Height = 15
          Caption = #29256#26412#65306
        end
        object lbl10: TLabel
          Left = 26
          Top = 238
          Width = 45
          Height = 15
          Caption = #35828#26126#65306
        end
        object lbl14: TLabel
          Left = 16
          Top = 312
          Width = 75
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = #21487#29992#29366#24577#65306
        end
        object lbl15: TLabel
          Left = 24
          Top = 149
          Width = 45
          Height = 15
          Caption = #20381#36182#65306
        end
        object edtServiceName: TEdit
          Left = 68
          Top = 18
          Width = 309
          Height = 23
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 0
        end
        object edtServiceID: TEdit
          Left = 68
          Top = 100
          Width = 309
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Cambria'
          Font.Style = []
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object edtServiceAuthor: TEdit
          Left = 70
          Top = 192
          Width = 251
          Height = 23
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 4
        end
        object edtServiceVer: TEdit
          Left = 68
          Top = 58
          Width = 309
          Height = 23
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 1
        end
        object mmoServiceComment: TMemo
          Left = 70
          Top = 238
          Width = 371
          Height = 64
          Anchors = [akLeft, akTop, akRight, akBottom]
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 5
        end
        object chk2: TCheckBox
          Left = 287
          Top = 312
          Width = 93
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #21333#20363#27169#24335
          TabOrder = 8
          OnClick = chk2Click
        end
        object rb6: TRadioButton
          Left = 113
          Top = 312
          Width = 81
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #21487#29992
          TabOrder = 6
          TabStop = True
          OnClick = rb6Click
        end
        object rb7: TRadioButton
          Left = 200
          Top = 312
          Width = 81
          Height = 17
          Anchors = [akLeft, akBottom]
          Caption = #31105#29992
          TabOrder = 7
          TabStop = True
          OnClick = rb7Click
        end
        object edtServiceImp: TEdit
          Left = 68
          Top = 146
          Width = 309
          Height = 23
          ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
  end
  object pnl3: TPanel
    Left = 8
    Top = 3
    Width = 675
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      675
      41)
    object edtXMLPath: TEdit
      Left = 8
      Top = 7
      Width = 636
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      ReadOnly = True
      TabOrder = 1
    end
    object btnBrowse: TBitBtn
      Left = 643
      Top = 6
      Width = 25
      Height = 25
      Hint = #31227#38500#36873#23450#30340#25554#20214#37197#32622
      Anchors = [akTop, akRight]
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnBrowseClick
    end
  end
  object btnApply: TButton
    Left = 520
    Top = 423
    Width = 75
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = #24212#29992
    Enabled = False
    TabOrder = 2
    OnClick = btnApplyClick
  end
  object btnCancel: TButton
    Left = 600
    Top = 423
    Width = 75
    Height = 28
    Anchors = [akRight, akBottom]
    Caption = #21462#28040
    Enabled = False
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object XPManifest1: TXPManifest
    Left = 120
    Top = 216
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.dll'
    Filter = #25554#20214#25991#20214'|*.dll'
    Left = 48
    Top = 216
  end
  object ImageList1: TImageList
    Left = 416
    Top = 48
    Bitmap = {
      494C0101040008008C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5B5B500A5A5A500D0D0D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ADBCAE009CAE9F00CAD4CA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFB4F100B0A4EE00D8D0F600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CBCBCB00BFBFBF00E2E2E200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AAAAAA00474A4E0054596100575D67004F535A0064646500E1E1
      E100000000000000000000000000000000000000000000000000000000000000
      000000000000A0B3A2001A7E20000FA119000EA719000F9819004C7D5000DEE5
      DE00000000000000000000000000000000000000000000000000000000000000
      000000000000B7A9EF003A28CC002216C2001910BE002A1AC5006C5BDE00E7E1
      F900000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6008B8B8B00A4A4A400A8A8A8009E9E9E0092929200EFEF
      EF00000000000000000000000000000000000000000000000000000000000000
      0000BEBEBE00464950004A505B004B515C004B515C004B515C00494E59006062
      6400000000000000000000000000000000000000000000000000000000000000
      0000B4C7B60012A21D000DB919000DB919000DB919000DB919000EB51A004489
      4B00000000000000000000000000000000000000000000000000000000000000
      0000C8BCF2002819C7000000C0000000C1000000C1000000C1000704C000634E
      D800000000000000000000000000000000000000000000000000000000000000
      0000DADADA00A5A5A600B6B6B600B7B7B700B7B7B700B7B7B700B3B3B3009B9C
      9E00000000000000000000000000000000000000000000000000000000000000
      00005A5C5E00282A2F00292C3100292C3100292C3100292C3100292C31002E31
      3500C8C8C8000000000000000000000000000000000000000000000000000000
      0000409E48000DB919000DB919000DB919000DB919000DB919000DB9190011B0
      1D00BED2BF000000000000000000000000000000000000000000000000000000
      00005E46D7000D03D3000E03D7000E03D7000E03D7000E03D7000E03D7001F0F
      D200D3C6F5000000000000000000000000000000000000000000000000000000
      0000ACADAE00B7B7B700BABABA00BABABA00BABABA00BABABA00BABABA00AFAF
      B000E5E5E600000000000000000000000000000000000000000000000000DADA
      DA002B2B2D0018181A002E2E2F00323234003F3F410032323400303032001A1A
      1B0090919100000000000000000000000000000000000000000000000000D3E0
      D4001DAD28001BBD260030C33B0035C53F0042C84B0035C53F0033C43D001DBE
      290082BA8600000000000000000000000000000000000000000000000000E4D9
      F8004725DD003A19ED004E2EF2005233F2005D40F3005233F2005031F2003A1B
      E900A089E800000000000000000000000000000000000000000000000000EFEF
      EF00B0B1B200C0C0C000C8C8C800C9C9C900CDCDCD00C9C9C900C9C9C900BDBD
      BD00CCCDCE00000000000000000000000000000000000000000000000000D8D8
      D8003A3A3B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006262
      620094949400000000000000000000000000000000000000000000000000D0DF
      D10035B63D0074D77B0076D87C0078D97F007BDA81007EDB830082DD86007EDC
      820089C28E00000000000000000000000000000000000000000000000000E1D7
      F8006645E700957BFB00987CFE00997CFF00997CFF00997CFF00987CFE008C72
      F700AA94EE00000000000000000000000000000000000000000000000000EEEE
      EE00BABABA00D9D9D900DCDCDC00DCDCDC00DCDCDC00DCDCDC00DBDBDB00D4D4
      D400D3D3D300000000000000000000000000000000000000000000000000E7E7
      E70054545500616161006F6F6F006F6F6F006F6F6F006F6F6F006F6F6F004646
      4600C4C4C400000000000000000000000000000000000000000000000000E3E9
      E30051B9580080DE84008FE2920093E3950097E599009BE79C009FE89F007EDC
      7F00B9D3BA00000000000000000000000000000000000000000000000000EDE7
      FA007F63E7009581F400A590FB00A791FD00A891FE00A691FD00A28EF9007C64
      EA00D2C3F600000000000000000000000000000000000000000000000000F4F4
      F400BFBFBF00D5D5D500DDDDDD00DFDFDF00DFDFDF00DEDEDE00DBDBDB00C6C6
      C600E7E7E7000000000000000000000000000000000000000000000000000000
      0000C1C1C1002F2F2F006A6A6A007272720072727200727272005B5B5B006D6D
      6D00E5E5E5000000000000000000000000000000000000000000000000000000
      0000B7D3B8006AD26A00A7ECA500AFEFAE00B3F0B000B6F2B300ADF0A8007FC7
      8000E1E9E1000000000000000000000000000000000000000000000000000000
      0000D0C1F500715EE300A497F200ADA0F700AEA2F800AC9FF6009689EE00967E
      E900EBE5FA000000000000000000000000000000000000000000000000000000
      0000E6E6E600BBBBBB00D8D8D800DCDCDC00DDDDDD00DCDCDC00D1D1D100C9C9
      C900F4F4F4000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF004848480040404000454545004242420086868600DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      000000000000B4D2B60078D0770099E69400A9EEA20093E08E008ECA8F00D8E3
      D900000000000000000000000000000000000000000000000000000000000000
      000000000000CEBFF500826EE4008377E4008980E6008374E400A993ED00E7DE
      F900000000000000000000000000000000000000000000000000000000000000
      000000000000E5E5E500BEBEBE00C2C2C200C6C6C600C3C3C300D3D3D300F1F1
      F100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E0E0E000CCCCCC00C7C7C700D5D5D500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DAE4DB00C2D7C400BAD3BD00CBDCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7DFF900DACBF700D6C7F600DED3F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F2F2F200EAEAEA00E8E8E800EDEDED00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFE3FFE3FFE3FFE3FF80FF80FF80FF80FF00FF00FF00FF00F
      F007F007F007F007E007E007E007E007E007E007E007E007E007E007E007E007
      F007F007F007F007F80FF80FF80FF80FFC3FFC3FFC3FFC3FFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end