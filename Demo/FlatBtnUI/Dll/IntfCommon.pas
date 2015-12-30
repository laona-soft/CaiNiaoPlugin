unit IntfCommon;

interface

uses Windows, Classes, Forms, Controls;

const
  IID_ExtPoint = '{75D54660-B981-4BC0-B6ED-F7BF02F3A14B}';
  IID_AppInfo = '{94D0B945-BF06-4F86-A2E5-7A1B12FF859E}';
  IID_MyExtendPoint = '{B70E3F78-5960-4699-B613-DD727F189638}';

type
  IExtendPointTest = interface(IInterface)
  [IID_ExtPoint]
    procedure OnMessageEvent(var Msg: TMsg; var Handled: Boolean);
    function ShowUI(const parentHWND: HWND): HWND;
    function ShowUI2(const parent: TWinControl): HWND;
    function GetUIHandle: HWND;
  end;

  IAppInfo = interface(IInterface)
  [IID_AppInfo]
    function GetApplication: TApplication;
    function GetMainForm: TForm;
  end;

implementation

end.
 