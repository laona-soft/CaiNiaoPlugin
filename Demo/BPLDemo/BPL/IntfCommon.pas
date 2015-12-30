unit IntfCommon;

interface

uses Windows;

const
  IID_BPLTest = '{E5C20236-24A0-41D3-B65A-D8258CD6BCFA}';

type
  IBPLTest = interface(IInterface)
  [IID_BPLTest]
    function ShowUI(const parentHWND: HWND): HWND;
    procedure CloseUI(const uiHWND: HWND);
  end;

implementation

end.
 