object FrmMain: TFrmMain
  Left = 323
  Top = 385
  Width = 623
  Height = 563
  Caption = #31243#24207#30028#38754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Rzsb: TRzStatusBar
    Left = 0
    Top = 498
    Width = 615
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    VisualStyle = vsGradient
  end
  object Rztb: TRzToolbar
    Left = 0
    Top = 0
    Width = 615
    Height = 29
    BorderInner = fsNone
    BorderOuter = fsGroove
    BorderSides = [sdTop]
    BorderWidth = 0
    TabOrder = 1
    VisualStyle = vsGradient
  end
  object RzPc: TRzPageControl
    Left = 0
    Top = 29
    Width = 615
    Height = 469
    Align = alClient
    ShowCloseButton = True
    ShowMenuButton = True
    TabOrder = 2
    OnClose = RzPcClose
    FixedDimension = 19
  end
  object mm: TMainMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    Images = il
    Left = 136
    Top = 72
    object e1: TMenuItem
      Caption = #29992#25143#31649#29702
      object N1: TMenuItem
        Caption = #29992#25143#30331#24405
        ImageIndex = 0
      end
      object N2: TMenuItem
        Caption = #29992#25143#27880#38144
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #36864#20986#31995#32479
        OnClick = N4Click
      end
    end
    object N8: TMenuItem
      Caption = #26381#21153#31649#29702
    end
    object u1: TMenuItem
      Caption = #24110#21161
      object N5: TMenuItem
        Caption = #24110#21161
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Caption = #20851#20110
      end
    end
  end
  object il: TImageList
    Left = 176
    Top = 72
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      00000000000000000000000000000000000000000000391F14FF391F14FF391F
      14FF512D1DFF533628FFB2B2B2FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000574A37FF6565
      54FF595742FF3C3B2CFF706249FF70634AFF706249FF0066CCFF0066CCFF0E28
      16FF0066CCFF0066CCFFB2B2B2FF000000009E3A01FF5D2D0EFF342E26FF3838
      34FF33322CFF262622FF3D372FFF3D3730FF3D372FFF0C3969FF0C3969FF121E
      19FF0C3969FF0B4279FF9F9F9FFFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B7456FFFFFFE1FFCDCC
      9AFFCDCC9AFFCDCC9AFFCDCC9AFFCDCC9AFFCDCC9AFF40B2E7FF007BD6FF8F8E
      6BFF40B2E7FF007BD6FF752E00FF00000000682E0DFF333332FF706D6DFF706D
      6DFF706D6DFF706D6DFF706D6DFF706D6DFF706D6DFF706D6DFF706D6DFF706D
      6DFF706D6DFF666363FF352A24FFE3E3E3FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F6D4FFFFFFFFFFFFFFF
      E1FFFFFFDFFFFFFFDDFFFFFFDAFFFFFFD9FFFFFFD7FF67DDF6FF0099E5FFB2B2
      94FF66DDF6FF0099E5FF7B3300FF00000000484848FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6
      C6FFC6C6C6FFC6C6C6FFC6C6C6FFBFBDBFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFC689
      5BFFC7895AFFC68959FFC68958FFC68958FFFFFFD9FF8DF9FEFF00B7F5FFB2B2
      95FF8DF9FEFF00B7F5FF813900FF00000000585858FFEAEAEAFFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFEAEA
      EAFFEAEAEAFFEAEAEAFFEAEAEAFFBFBDBFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B7FFFFFFFFFFCD8F
      5CFFFFEEC2FFFFEEC2FFFFEEC0FFCD8F59FFFFFFDCFF99FFFFFF00CCFFFFB2B2
      95FF99FFFFFF00CCFFFF884000FF000000005C5C5CFFD5D5D5FFD5D5D5FFD5D5
      D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5
      D5FFD5D5D5FFD5D5D5FFD5D5D5FFBFBDBFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CFCFCFFFFFFFFFFFD497
      5EFFFFF4D0FFFFF4CFFFF7DDA1FFD4975AFFFFEBBBFF0066CCFF0066CCFFFFFF
      D9FF0066CCFF0066CCFF0000000000000000626262FFEEEEEEFFEEEEEEFFE7E7
      E7FFCDCDCDFFCDCDCDFFCDCDCDFFCDCDCDFFCDCDCDFFE7E7E7FFE6E6E6FFDDDD
      DDFFD2D2D2FF00FF55FFEEEEEEFFBFBFC1FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFDC9E
      5FFFFFFADCFFF7DDA3FFF7DDA3FFDC9E5BFFECC186FFFFF1C6FFD09459FFFFFF
      DCFFCDCC9AFFA65300FF0000000000000000424242FFFFFFFFFFFFFFFFFFA842
      00FFA84100FFA94200FFA84100FFA84200FFA84200FFDCDCDCFFD2D2D2FFFFFF
      FFFFFFFFFFFFD2D2D2FFD9D9D9FFD9D9DAFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFE0A3
      60FFE0A35FFFE0A35EFFE0A35EFFE0A35DFFFFF7D5FFFFF7D3FFD89B5AFFFFFF
      DEFFCDCC9AFFA17526FF0000000000000000000000000000000000000000B049
      00FFFFE3AEFFFFE3AEFFFFE3ADFFFFE3AEFFB04900FF8D8975FF7F5B35FF9696
      83FF8D8D6AFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFFFFF
      F4FFFFFFF1FFFFF4D2FFDFA15FFFFFFBE0FFFFFBDEFFFFFBDEFFDEA15BFFFFFF
      E2FFCDCC9AFF9D6F22FF0000000000000000000000000000000000000000B952
      00FFFFECBDFFFFEBBDFFFFEBBEFFFFECBEFFB95200FFFFE0A7FFFFE0A7FFFFE1
      A8FF79785BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFFFFF
      F7FFFFFFF5FFFFFADFFFFFFADEFFFFFADDFFFFFADCFFFFFFEAFFFFFFE5FFF9F8
      DBFFCDCC9AFF9D7327FF0000000000000000000000000000000000000000C35C
      00FFFFF3CDFFFFF3CDFFFFF4CDFFFFF3CDFFC35C00FFFFE7B6FFFFE8B5FFFFE7
      B6FF79785BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFFFFF
      F9FFFFFFF8FFE0A362FFE0A362FFE0A360FFE0A360FFFFFFEDFFF9F8DBFFE6E6
      C0FFCDCC9AFFA07529FF0000000000000000000000000000000000000000C964
      00FFFFF9D8FFFFF9D8FFFFF9D8FFFFF9D8FFC96400FFFFEFC5FFFFEFC5FFFFF0
      C5FF79785BFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFFFFF
      FBFFFFFFFAFFFFFFF8FFFFFFF6FFFFFFF5FFFFFFF2FFFFFFF0FF666666FF6666
      66FF666666FFBC882CFF0000000000000000000000000000000000000000CC66
      00FFCC6600FFCC6600FFCC6600FFCC6600FFCC6600FFFFF6D4FFFFF7D4FFFFF7
      D4FF3C3C3CFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000292929FFFFFFFFFFFFFF
      FDFFFFFFFCFFFFFFFAFFFFFFF9FFFFFFF7FFFFFFF5FFFFFFF3FFFFFFFFFF689A
      9AFFBEA974FF0000000000000000000000000000000000000000000000000000
      000000000000FFEFC5FFFFEFC5FFFFF9D8FFFFF9D8FFFFF9D8FFFFF9D8FFFFF9
      D8FF837550FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8B8B7FFFFFFFFFFFFFF
      FEFFFFFFFEFFFFFFFDFFFFFFFBFFFFFFFAFFFFFFF8FFFFFFF6FF689A9AFF2E2E
      2EFF000000000000000000000000000000000000000000000000000000000000
      000000000000FFF7D4FFFFF6D4FFFFF6D4FFFFF7D4FFFFF7D4FF3D5B5BFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F3F3F3FFCC9A66FFC796
      64FFC39361FFBF8F5CFFBC8B58FFB88653FFB4824EFFB17F4BFFB9B9B9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFF9D8FFFFF9D8FFFFF9D8FFFFF9D8FFFFF9D8FF808080FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E5E5E5FFE5E5E5FFE5E5
      E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FF000000000000
      00000000000000000000000000000000000000000000958B86FF74412AFF7441
      2AFF74412AFF74412AFF74412AFF74412AFF74412AFF74412AFF74412AFF7441
      2AFF74412AFF774D3AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000512D1DFF512D1DFF512D1DFF512D1DFF512D1DFF512D
      1DFF00000000000000000000000000000000A23B00FFA23B00FFA23B00FFA23B
      00FFA23B00FFA23B00FFA23B00FFA23B00FFA23B00FFE5E5E5FF000000000000
      0000000000000000000000000000000000000000000079360BFFC5A87EFFE7E5
      C0FFCAC796FFCAC796FFCAC796FFCAC796FFCAC796FFCAC796FFCAC796FFCAC7
      96FFC2B98AFF89593FFF00000000000000000000000000000000000000000000
      000000000000888665FF8E8C69FFABA97FFF000000000000000053DB81FF42BA
      69FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFE0A7FFFFE1A8FFFFE0A7FFFFE0A7FFFFE1A8FF2E82
      49FF00000000000000000000000000000000A63F00FFFFDFA7FFFFDFA7FFFFE0
      A7FFFFDFA7FFFFDFA7FFFFDFA7FFFFDFA7FFA63F00FFE5E5E5FF000000000000
      00000000000000000000000000000000000000000000AD9168FFCBAF8FFFFDFD
      F0FFFBFBDCFFFBFBDAFFFBFBD8FFFBFBD7FFFBFBD5FFFBFBD5FFFBFBD5FFF4F4
      CCFFC5BD8DFF8E5F41FF00000000000000000000000000000000000000000000
      0000B2A06EFFE8BE62FFCE9930FFD09A32FF8C9D52FF5FF792FF58F18BFF53ED
      86FF3DB966FF0000000000000000000000000000000000000000000000000000
      00000000000000000000FFE8B5FFFFE7B6FFFFE7B6FFF2C775FFF2C775FFA942
      00FFA84100FFA84200FFA84200FF00000000AA4300FFFFE3ADFFFFE3AEFFFFE2
      ADFFFFE2AEFFFFE2ADFFFFE2ADFFFFE2ADFFAA4300FFB2B2B2FFB2B2B2FFB2B2
      B2FFB2B2B2FFB2B2B2FFB2B2B2FFE5E5E5FF00000000AE956CFFCDB092FFF3E4
      D3FFE1BC92FFE1BC90FFE1BC8FFFE9CEA3FFFFFFDCFFFFFFDAFFFFFFD9FFF7F7
      CFFFC6BE8DFF8A5D3AFF0000000000000000000000000000000000000000B097
      69FFEEC56CFFE9BF64FFD09C33FF9B8721FF5EF794FF56F28AFF55EE88FF50E9
      83FF4BE47DFF39B863FF0000000000000000A94200FF9C8661FFB39A80FF9A84
      5CFFD0AC5EFFCCA757FFFFEFC5FFFFEFC5FFFFF0C5FFF2C775FFFFF0C5FFFFE3
      AEFFFFE3ADFFFFE3AEFFB04900FF00000000B04900FFFFE7B5FFFFE7B5FFFFE6
      B6FFFFE6B6FFFFE7B6FFF2C775FFF2C775FFB04900FFA33C00FFA33C00FFA33C
      00FFA33C00FFA33C00FFA33C00FFE5E5E5FF00000000AF9771FFCFB294FFF3E3
      D1FFEBCCA2FFFBECC7FFF3DDB4FFE2BA8BFFE2BE91FFE2BE90FFE7CA9CFFF7F7
      CFFFC6BE8DFF8A5429FF00000000000000000000000000000000A5834CFFEEC7
      6FFFEEC76DFFE9C066FF988B23FF74FAA6FF8DFBB3FF9AF6B7FF50EA83FF4DE6
      80FF46DA77FF47DF7DFF38BB66FF0000000071380FFF333333FF333333FF3333
      33FF333333FF717171FFFFF7D4FFF2C775FFF2C775FFF2C775FFF2C775FFDF96
      3AFFDF963AFFFFEBBDFFB95200FF00000000B75100FFFFEBBEFFFFECBEFFFFEB
      BEFFFFEBBEFFFFECBEFFF2C775FFFFECBEFFB75100FFFFE1AAFFFFE0AAFFFFE1
      AAFFFFE1AAFFFFE1AAFFA84100FFE5E5E5FF00000000AF9A76FFD1B496FFF5E5
      D2FFEFD4ADFFFFFAE0FFF7E8C5FFECCA9BFFFAEAC4FFF5E0B6FFE7C696FFF7F7
      D3FFC6BF8DFF946639FF000000000000000000000000987A41FFF0CB75FFEFC9
      73FFEFC971FFE9C26CFFD8A33CFFD5A23AFF5F951CFFABFAC4FF4BE67FFF49E2
      7CFF44D376FFC28F2EFF0000000000000000BEBEBDFFE3E3E2FFE3E3E2FFE3E3
      E2FFE3E3E2FFEBEBEBFFFFF9D8FFF2C775FFFFF9D8FFF2C775FFFFF9D8FFFFF3
      CDFFDF963AFFFFF4CEFFC35C00FF00000000BB5600FFFFF0C8FFFFF0C7FFFFF1
      C7FFFFF0C8FFFFF0C7FFF2C775FFFFF1C8FFBB5600FFFFE5B1FFFFE5B1FFFFE4
      B2FFFFE4B2FFFFE5B1FFAB4500FFE5E5E5FF00000000B09E7DFFD2B597FFF6E6
      D3FFEBC596FFEECC9FFFEDC999FFEDC895FFF6E2B7FFF9EDCAFFEBC998FFF7F7
      D7FFC6BF8DFF956A3AFF0000000000000000843D00FFECC671FFF1CF7CFFF1CD
      79FFF0CB76FFEBC574FFDCA942FFDAA741FF659722FFB5F9C9FF47E27AFF46DF
      79FF40CF72FFC7922CFF0000000000000000E3E3E2FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFB95200FFFFECBDFFC96400FFFFF9D8FFFFF9
      D8FFDF963AFFFFF9D8FFC96400FF00000000C25C00FFFFF4CFFFF2C775FFF2C7
      75FFF2C775FFF2C775FFF2C775FFF2C775FFC25C00FFDF963AFFDF963AFFFFEA
      BAFFFFE9BAFFFFE9BAFFB34B00FFE5E5E5FF00000000B0A081FFD2B597FFFDF9
      F3FFF2DEC5FFECCBA5FFF9E6C2FFF3D9ACFFEDC896FFEECB9BFFEECC9CFFF7F7
      DDFFC6BF8DFF956A3BFF0000000000000000B05300FFF6DA8FFFF3D384FFF2D1
      82FFF2CF7DFFEDCA7EFFE0AF4BFFDEAD4BFF679724FFBFFACFFF43DE77FF42DB
      75FF3DCE6FFFC7922EFF0000000000000000E3E3E2FF333333FFAA916CFFAA91
      6CFFAA906BFFAA906CFFAA906CFFC35C00FFFFF3CDFFCC6600FFCC6600FFCC66
      00FFCC6600FFCC6600FFCC6600FF00000000C86200FFFFF7D5FFF2C775FFFFF8
      D6FFFFF8D6FFFFF7D6FFF2C775FFFFF7D6FFC86200FFFFEEC3FFDF963AFFFFEE
      C3FFFFEEC3FFFFEEC3FFB95300FFE5E5E5FF00000000B0A284FFD2B597FFFFFF
      FCFFF5E7D5FFEED2B0FFFEF9E3FFF8E8C9FFECCBA2FFFAF0D7FFF7EFD2FFE7E7
      C3FFC6BF8DFF956A3BFF000000000000000000000000F9DF9BFFF5D88EFFF4D6
      8BFFF4D486FFEECE88FFE5B758FFE4B659FF6A9629FFD1FEDBFF7BE69CFF61E0
      89FF3DCB6FFFC6902FFF0000000000000000E3E3E2FF333333FFA18565FFA285
      66FFE0D6CCFFE6DED5FFEDE8E2FFC96400FFFFF9D8FFFFF9D8FFFFF9D8FFFFF9
      D8FFC96400FF000000000000000000000000CB6400FFCB6400FFCB6400FFCB64
      00FFCB6400FFCB6400FFCB6400FFCB6400FFCB6400FFFFF2CCFFDF963AFFFFF2
      CCFFFFF2CCFFFFF3CCFFBE5700FFE5E5E5FF00000000935110FFD4B79AFFFFFF
      FEFFF7E8D8FFECC69EFFF0D1ADFFEECDA5FFEFD0AAFFFBFBE9FFE8E9C6FFD5D7
      ABFFC6BF8DFF956B3CFF000000000000000000000000FBE6A8FFF7DF9CFFF6DD
      97FFF6DA94FFF0D392FFE9BF66FFEAC26BFF829D37FF42AC46FF3CA63DFF3DA2
      3DFF40A23DFFC1892AFF0000000000000000E3E3E2FF333333FF96775CFFC0AC
      9DFFB6A08EFF96775DFF97775CFFCC6600FFCC6600FFCC6600FFCC6600FFCC66
      00FFCC6600FF0000000000000000000000000000000000000000B04900FFFFE7
      B6FFFFE7B6FFFFE7B5FFC55E00FFFFF6D3FFFFF6D3FFFFF6D3FFDF963AFFFFF7
      D2FFFFF6D3FFFFF6D3FFC55E00FFE5E5E5FF00000000B2A89EFFD8BC9FFFFFFF
      FEFFFCF8F3FFF8ECDFFFF8ECDDFFF8ECDCFFE0D7C9FF92928CFF8B8B7FFF8687
      79FF838171FF786B5AFF000000000000000000000000FEECB6FFFAE6ABFFF9E4
      A8FFF7E1A7FFF2D99DFFE9C169FFEECA79FFEBC571FFE7BE65FFE3B75AFFD8A9
      4CFFD1A144FFC18E30FF0000000000000000E3E3E2FF333333FF8A6753FFC3B1
      A7FF957462FF8A6754FFBAA599FFFBFAFAFF8B6754FF8A6854FFE3E3E2FF3333
      33FFB78D3BFF0000000000000000000000000000000000000000B75100FFFFEB
      BEFFFFEBBFFFFFECBFFFCA6300FFFFF9D8FFFFF9D8FFFFF9D8FFDF963AFFFFF9
      D8FFFFF9D8FFFFF9D8FFCA6300FFE5E5E5FF00000000B3A99FFFDBBFA2FFFFFF
      FFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFDFFE4DCD2FF9E8468FFC0C6C6FF85A1
      A1FF6A6A67FFBBB7A0FF000000000000000000000000FFF5CAFFFBECC0FFFAE7
      B4FFFDE9B8FFFFFEF1FFFAECC7FFF1D38DFFECC470FFEAC36FFFE7BF67FFE4BA
      5FFFE0B454FFC59033FF0000000000000000E3E3E2FF333333FF80594BFF9777
      6BFFB69F97FF896558FFFFFFFFFFFFFFFFFF80594BFF80594BFFE3E3E2FF3333
      33FFC49D49FF0000000000000000000000000000000000000000BB5600FFFFF0
      C7FFFFF0C7FFFFF0C7FFCC6600FFCC6600FFCC6600FFCC6600FFCC6600FFCC66
      00FFCC6600FFCC6600FFCC6600FF0000000000000000B4AA9FFFDDC1A4FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFE9DDD0FFAD8C63FFB3D1D1FF7679
      6FFF95500AFF00000000000000000000000000000000FFFCDEFFFEE3A6FFFFF8
      E4FFFFFCEFFFFFFCEEFFFFFBEBFFFFFCEBFFFFFBE9FFF7E5B7FFECCA80FFE6BE
      65FFE4BA5FFFC58F2EFF0000000000000000E3E3E2FF333333FF774E44FF764E
      45FF8D6A62FFA98F89FFFFFFFFFFFFFFFFFF774E44FF774E44FFE3E3E2FF3333
      33FFC7A353FF0000000000000000000000000000000000000000C25C00FFFFF4
      CFFFFFF4D0FFFFF4D0FFFFF5D0FFFFF5D0FFFFF5CFFFFFF5CFFFC25C00FFB2B2
      B2FF0000000000000000000000000000000000000000B4AAA0FFDFC3A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9DDD1FF9E7B52FF75776DFF8282
      82FF0000000000000000000000000000000000000000FFEDBDFFFFFEF3FFFFFC
      EEFFFFFCEDFFFFFBE9FFFFFAE2FFFFF8D9FFFFF5CFFFFFF3C5FFFFF2BFFFFFF1
      C4FFEFD592FFD2A34AFF0000000000000000E3E3E2FF333333FF333333FF3333
      33FF333333FF333333FF333333FF333333FF333333FF333333FFE3E3E2FF3333
      33FFD1BA80FF0000000000000000000000000000000000000000C86200FFFFF8
      D5FFFFF8D6FFFFF8D5FFFFF7D6FFFFF8D6FFFFF8D6FFFFF8D5FFC86200FFB2B2
      B2FF0000000000000000000000000000000000000000B5ABA0FFD3AA81FFDEC2
      A5FFDBC0A3FFD9BDA0FFD7BA9DFFD4B89AFFC9A784FF9D7A52FF8F4C0CFF0000
      00000000000000000000000000000000000000000000DEBC73FFE2BC6FFFEDD6
      A2FFFBF2D6FFFFFBE2FFFFFBDCFFFFF5CDFFFFF6C9FFFBE9ADFFE3BC6AFFDFBC
      6FFF00000000000000000000000000000000E3E3E2FFE3E3E2FFE3E3E2FFE3E3
      E2FFE3E3E2FFE3E3E2FFE3E3E2FFE3E3E2FFE3E3E2FFE3E3E2FFE3E3E2FF3333
      33FFE5E5E5FF0000000000000000000000000000000000000000CB6400FFCB64
      00FFCB6400FFCB6400FFCB6400FFCB6400FFCB6400FFCB6400FFCB6400FFB2B2
      B2FF0000000000000000000000000000000000000000D3D1CFFF985614FF9755
      14FF965413FF955312FF945211FF935110FF93510FFF994F09FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DFB96BFFDFBB6CFF000000009A520BFF000000000000
      000000000000000000000000000000000000333333FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCBCBCBFF7272
      72FFFDFDFDFF000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF81FFFF00000000C001000000000000
      8001000000000000800100000000000080010000000000008001000000000000
      800300000000000080030000000000008003E007000000008003E00700000000
      8003E007000000008003E007000000008003E007000000008007F80700000000
      800FF81F00000000801FF81F00000000803F8003FFFFFC0F003F8003F8CFFC0F
      003F8003F007FC0100008003E003000100008003C00100010000800380030001
      0000800300030001000080030003000100008003800300070000800380030007
      C000800380030007C000800380030007C001800780030007C00F800F80030007
      C00F801F800F0007C00F803FFCBF000700000000000000000000000000000000
      000000000000}
  end
end
