UNIT UFrmMain;

INTERFACE

USES
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  WisdomFramework,
  WisdomCoreInterfaceForD,
  Intf,
  StdCtrls,
  RzTabs,
  RzPanel,
  UGlobeSrv,
  Menus,
  ImgList;

TYPE
  TFrmMain = CLASS(TForm)
    Rzsb: TRzStatusBar;
    Rztb: TRzToolbar;
    RzPc: TRzPageControl;
    mm: TMainMenu;
    e1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    il: TImageList;
    u1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    PROCEDURE N4Click(Sender: TObject);
    PROCEDURE RzPcClose(Sender: TObject; VAR AllowClose: Boolean);
    PROCEDURE FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PROCEDURE BusMenuClick(Sender: TObject);
    PROCEDURE SysMenuClick(Sender: TObject);
  END;

VAR
  FrmMain           : TFrmMain;

IMPLEMENTATION

{$R *.dfm}

{ TAppInfo }

PROCEDURE TFrmMain.BusMenuClick(Sender: TObject);
VAR
  sht               : TRzTabSheet;
  j                 : integer;
  finded            : boolean;
  bus               : IBusPlugInExt;
BEGIN
  bus := GServiceManager.GetExtService(TmenuItem(sender).Hint, TmenuItem(sender).tag) AS IBusPlugInExt;
  finded := false;
  IF Assigned(bus) THEN
    BEGIN
      FOR j := 0 TO RzPc.PageCount - 1 DO
        IF rzpc.Pages[j].Caption = bus.GetCaption THEN
          BEGIN
            rzpc.ActivePageIndex := j;
            finded := true;
          END;

      IF NOT finded THEN
        TRY
          sht := TRzTabSheet.Create(NIL);
          sht.Parent := RzPc;
          sht.PageControl := RzPc;
          sht.tag := bus.ShowUI(sht.Handle);
          postmessage(sht.tag, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
          IF sht.ControlCount = 1 THEN
            sht.Controls[0].Align := alClient;
          sht.Caption := bus.GetCaption;
          RzPc.ActivePageIndex := RzPc.PageCount - 1;
        EXCEPT
          ON e: exception DO
            showmessage(e.Message);
        END;
    END;
END;

PROCEDURE TFrmMain.N4Click(Sender: TObject);
BEGIN
  close;
END;

PROCEDURE TFrmMain.RzPcClose(Sender: TObject; VAR AllowClose: Boolean);
BEGIN
  AllowClose := True;
END;

PROCEDURE TFrmMain.SysMenuClick(Sender: TObject);
VAR
  plugin            : ISysPlugInExt;
BEGIN
  plugin := GServiceManager.GetExtService(TmenuItem(sender).Parent.Hint, TmenuItem(sender).Parent.tag) AS ISysPlugInExt;
  IF Assigned(plugin) THEN
    CASE TMenuItem(Sender).Tag OF
      1: plugin.StartSrv;
      2: plugin.StopSrv;
      3: plugin.ShowConfig();
    END;
END;

PROCEDURE TFrmMain.FormResize(Sender: TObject);
VAR
  i                 : Integer;
BEGIN
  FOR i := 0 TO RzPc.PageCount - 1 DO
    SetWindowPos(RzPc.Pages[i].Tag, HWND_TOP, 0, 0, RzPc.Pages[i].Width - 2, RzPc.Pages[i].height - 2, SWP_SHOWWINDOW);
END;

END.

