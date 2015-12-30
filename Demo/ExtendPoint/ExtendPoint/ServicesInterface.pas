unit ServicesInterface;
{$include Def.inc}

interface

uses
  {$IFDEF IDE_XE4up}
  winapi.Windows, System.Classes, Vcl.Forms, Vcl.Graphics;
  {$ELSE}
  Windows, Classes, Forms, Graphics;
  {$ENDIF}

const
  IID_ToolBarExt = '{4E33E8F9-6B66-4836-B55C-C76273227718}';
  IID_AppInfo = '{AFBF4CC7-59FB-414E-80E3-A4824C80C96A}';
  IID_ExtToolButton = '{5CF3E742-3969-4E9D-ABB3-97F51EF6F628}';

{$include MyString.inc}

type
  IAppInfo = interface(IInterface)
  [IID_AppInfo]
    function GetApplication: TApplication;
    function GetMainForm: TForm;
    function GetMainFormHandle: THandle;
  end;

  IToolBarExt = interface(IInterface)
    [IID_ToolBarExt]
    function GetCaption: MyString;
    procedure GetBitmap(bmp: HDC);
    function GetClickEvent: TNotifyEvent;
  end;

  IExtToolButton = interface(IToolBarExt)
    [IID_ExtToolButton]
  end;


implementation

end.

