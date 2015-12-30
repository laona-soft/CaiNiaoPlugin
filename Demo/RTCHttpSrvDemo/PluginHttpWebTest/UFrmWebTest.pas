UNIT UFrmWebTest;

INTERFACE

USES
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  rtcInfo,
  rtcDB,
  ShellAPI,
  Intf,
  WisdomCoreInterfaceForD,
  WisdomFramework,
  pluginConst,
  pluginFun,
  Forms,
  Dialogs,
  Grids,
  DBGrids,
  DB,
  RzTabs,
  RzPanel,
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  Menus,
  DBClient,
  OleCtrls,
  SHDocVw;

TYPE
  TFrmWebTest = CLASS(TForm)
    wb: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
  END;
  IHttpWebTest = INTERFACE(IBusPlugInExt)
    [IID_HttpWebTest]
  END;

  THttpWebTest = CLASS(TPluginInterfacedObject, IBusPlugInExt, IHttpWebTest)
  private
    FFrmWebTest: TFrmWebTest;
  public
    CONSTRUCTOR Create; override;
    DESTRUCTOR Destroy; override;
    FUNCTION GetMenuCaption(): STRING;
    FUNCTION GetMenuImageIndex(): integer;
    PROCEDURE OnMessageEvent(VAR Msg: TMsg; VAR Handled: Boolean);
    FUNCTION ShowUI(CONST parentHWND: HWND): HWND;
    FUNCTION GetCaption(): STRING;
  END;

IMPLEMENTATION

{$R *.dfm}

{ THttpSrv }
USES
  ExportFunc;

CONSTRUCTOR THttpWebTest.Create;
BEGIN
  INHERITED;
  FFrmWebTest := NIL;
END;

DESTRUCTOR THttpWebTest.Destroy;
BEGIN
  IF Assigned(FFrmWebTest) THEN
    FreeAndNil(FFrmWebTest);
  INHERITED;
END;

FUNCTION THttpWebTest.GetCaption: STRING;
BEGIN
  result := PluginCaption;
END;

FUNCTION THttpWebTest.GetMenuCaption: STRING;
BEGIN
  result := PluginMenu;
END;

FUNCTION THttpWebTest.GetMenuImageIndex: integer;
BEGIN
  result := 3;
END;

PROCEDURE THttpWebTest.OnMessageEvent(VAR Msg: TMsg; VAR Handled: Boolean);
VAR
  keyState: TKeyboardState;
  key: Word;
  cp: HWND;
BEGIN
  IF Msg.message = WM_KEYDOWN THEN
    BEGIN
      IF Assigned(FFrmWebTest) THEN
        BEGIN
          {if Msg.hwnd = FFrmHttpSrvTest.ParentWindow then begin
            PostMessage(FFrmHttpSrvTest.Handle, WM_KEYDOWN, VK_TAB, 0);
            Handled := True;
          end;}
          cp := Msg.hwnd;
          WHILE cp <> 0 DO
            BEGIN
              IF cp = FFrmWebTest.Handle THEN
                BEGIN
                  key := Msg.wParam;
                  GetKeyboardState(keyState);
                  FFrmWebTest.KeyDown(key, KeyboardStateToShiftState(keyState));
                  IF ((key = VK_Tab) OR (key = VK_RETURN)) THEN
                    Handled := True;
                  Break;
                END;
            END;
        END
    END;
END;

FUNCTION THttpWebTest.ShowUI(CONST parentHWND: HWND): HWND;
BEGIN
  FreeAndNil(FFrmWebTest);

  FFrmWebTest := TFrmWebTest.CreateParented(parentHWND);
  WITH FFrmWebTest DO
    BEGIN
      ParentWindow := parentHWND;
      BorderStyle := bsNone;
      Visible := true;
      Result := Handle;
      wb.Navigate('about:blank');
      wb.Navigate(getServer());
    END;
END;

END.

