unit IntfCommon;

interface

uses Winapi.Windows;

type
  IBPLTest = interface(IInterface)
  ['{C2098FCC-591A-49AA-B7D9-A8DBC89668E7}']
    function ShowUI(const parentHWND: HWND): HWND;
    procedure CloseUI(const uiHWND: HWND);
  end;

implementation

end.
 