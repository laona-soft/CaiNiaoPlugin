object FrmClientTest: TFrmClientTest
  Left = 258
  Top = 216
  Width = 855
  Height = 767
  Caption = 'FrmClientTest'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 145
    Width = 847
    Height = 4
    Cursor = crVSplit
    Align = alTop
  end
  object pnl: TPanel
    Left = 0
    Top = 0
    Width = 847
    Height = 145
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      847
      145)
    object lbl_tablelist: TLabel
      Left = 24
      Top = 11
      Width = 12
      Height = 13
      Caption = #34920
    end
    object lbl_Sql: TLabel
      Left = 16
      Top = 43
      Width = 19
      Height = 13
      Caption = 'SQL'
    end
    object cbb_tableList: TComboBox
      Left = 48
      Top = 8
      Width = 161
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object btn_Qry: TButton
      Left = 679
      Top = 8
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #25191#34892
      Enabled = False
      TabOrder = 1
      OnClick = btn_QryClick
    end
    object btn_exit: TButton
      Left = 767
      Top = 8
      Width = 65
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986
      TabOrder = 2
      OnClick = btn_exitClick
    end
    object mmo_sql: TMemo
      Left = 48
      Top = 40
      Width = 793
      Height = 100
      Anchors = [akLeft, akTop, akRight, akBottom]
      PopupMenu = pm_sql
      TabOrder = 3
    end
    object btn_load: TButton
      Left = 216
      Top = 8
      Width = 60
      Height = 23
      Caption = #21152#36733#34920#21517
      TabOrder = 4
      OnClick = btn_loadClick
    end
  end
  object pgc: TPageControl
    Left = 0
    Top = 149
    Width = 847
    Height = 591
    ActivePage = ts
    Align = alClient
    TabOrder = 1
    object ts: TTabSheet
      Caption = #25968#25454#25805#20316
      object dbgrd: TDBGrid
        Left = 0
        Top = 0
        Width = 839
        Height = 563
        Align = alClient
        DataSource = ds
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object ts_log: TTabSheet
      Caption = #25805#20316#26085#24535
      ImageIndex = 1
      object mmo_log: TMemo
        Left = 0
        Top = 0
        Width = 839
        Height = 563
        Align = alClient
        PopupMenu = pm_log
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object ds: TDataSource
    DataSet = Cds
    Left = 120
    Top = 264
  end
  object pm_log: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 468
    Top = 361
    object N1: TMenuItem
      Tag = 1
      Caption = #28165#31354#26085#24535
      OnClick = N1Click
    end
  end
  object Cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 156
    Top = 269
  end
  object pm_sql: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Left = 500
    Top = 65
    object N_stress: TMenuItem
      Tag = 1
      Caption = #21387#21147#27979#35797
      object N11: TMenuItem
        Tag = 1000
        Caption = '1000'
        OnClick = N11Click
      end
      object N51: TMenuItem
        Tag = 5000
        Caption = '5000'
        OnClick = N11Click
      end
      object N12: TMenuItem
        Tag = 10000
        Caption = '10000'
        OnClick = N11Click
      end
      object N13: TMenuItem
        Tag = 50000
        Caption = '50000'
        OnClick = N11Click
      end
      object N14: TMenuItem
        Tag = 100000
        Caption = '100000'
        OnClick = N11Click
      end
      object N52: TMenuItem
        Tag = 500000
        Caption = '500000'
        OnClick = N11Click
      end
      object N2: TMenuItem
        Caption = #25351#23450#27425#25968
        OnClick = N11Click
      end
    end
    object N_NoGrid: TMenuItem
      AutoCheck = True
      Caption = ' '#19981#26174#31034#21040#32593#26684
      Checked = True
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #20854#23427#21151#33021
      object N5: TMenuItem
        Tag = 1
        Caption = #26816#27979#26356#26032
        OnClick = N5Click
      end
      object N6: TMenuItem
        Tag = 2
        Caption = #26381#21153#22120#29366#24577
        OnClick = N5Click
      end
      object N7: TMenuItem
        Tag = 3
        Caption = #38745#24577#32593#39029
        OnClick = N5Click
      end
    end
    object TMenuItem
    end
  end
end
