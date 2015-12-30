UNIT UFrmClientTest;

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
  DBClient;

TYPE
  TFrmClientTest = CLASS(TForm)
    pnl: TPanel;
    ds: TDataSource;
    dbgrd: TDBGrid;
    pgc: TPageControl;
    ts: TTabSheet;
    ts_log: TTabSheet;
    lbl_tablelist: TLabel;
    cbb_tableList: TComboBox;
    btn_Qry: TButton;
    btn_exit: TButton;
    mmo_sql: TMemo;
    lbl_Sql: TLabel;
    mmo_log: TMemo;
    btn_load: TButton;
    pm_log: TPopupMenu;
    N1: TMenuItem;
    spl1: TSplitter;
    Cds: TClientDataSet;
    pm_sql: TPopupMenu;
    N_stress: TMenuItem;
    N11: TMenuItem;
    N51: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N52: TMenuItem;
    N_NoGrid: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    PROCEDURE btn_loadClick(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE N1Click(Sender: TObject);
    PROCEDURE btn_exitClick(Sender: TObject);
    PROCEDURE btn_QryClick(Sender: TObject);
    PROCEDURE N11Click(Sender: TObject);
    PROCEDURE N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PROCEDURE dolog(CONST msg: STRING);
  END;

  IHttpClientTest = INTERFACE(IBusPlugInExt)
    [IID_HttpClientTest]
  END;

  THttpClientTest = CLASS(TPluginInterfacedObject, IBusPlugInExt, IHttpClientTest)
  private
    FFrmClientTest: TFrmClientTest;
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
  ExportFunc,
  UGlobeClient;

CONSTRUCTOR THttpClientTest.Create;
BEGIN
  INHERITED;
  FFrmClientTest := NIL;
END;

DESTRUCTOR THttpClientTest.Destroy;
BEGIN
  IF Assigned(FFrmClientTest) THEN
    FreeAndNil(FFrmClientTest);
  INHERITED;
END;

FUNCTION THttpClientTest.GetCaption: STRING;
BEGIN
  result := PluginCaption;
END;

FUNCTION THttpClientTest.GetMenuCaption: STRING;
BEGIN
  result := PluginMenu;
END;

FUNCTION THttpClientTest.GetMenuImageIndex: integer;
BEGIN
  result := 3;
END;

PROCEDURE THttpClientTest.OnMessageEvent(VAR Msg: TMsg; VAR Handled: Boolean);
VAR
  keyState          : TKeyboardState;
  key               : Word;
  cp                : HWND;
BEGIN
  IF Msg.message = WM_KEYDOWN THEN
    BEGIN
      IF Assigned(FFrmClientTest) THEN
        BEGIN
          {if Msg.hwnd = FFrmClientTest.ParentWindow then begin
            PostMessage(FFrmClientTest.Handle, WM_KEYDOWN, VK_TAB, 0);
            Handled := True;
          end;}
          cp := Msg.hwnd;
          WHILE cp <> 0 DO
            BEGIN
              IF cp = FFrmClientTest.Handle THEN
                BEGIN
                  key := Msg.wParam;
                  GetKeyboardState(keyState);
                  FFrmClientTest.KeyDown(key, KeyboardStateToShiftState(keyState));
                  IF ((key = VK_Tab) OR (key = VK_RETURN)) THEN
                    Handled := True;
                  Break;
                END;
            END;
        END
    END;
END;

FUNCTION THttpClientTest.ShowUI(CONST parentHWND: HWND): HWND;
BEGIN
  FreeAndNil(FFrmClientTest);

  FFrmClientTest := TFrmClientTest.CreateParented(parentHWND);
  WITH FFrmClientTest DO
    BEGIN
      ParentWindow := parentHWND;
      BorderStyle := bsNone;
      Visible := true;
      Result := Handle;
    END;
END;

{ TFrmClientTest }

PROCEDURE TFrmClientTest.dolog(CONST msg: STRING);
BEGIN
  mmo_log.Lines.Add(Format('%s %s', [FormatDateTime('HH:NN:SS zzz', Now()), msg]));
END;

PROCEDURE TFrmClientTest.btn_loadClick(Sender: TObject);
VAR
  ts                : TStrings;
BEGIN
  IF NOT Gclient.OpenServer('127.0.0.1', '80') THEN
    BEGIN
      ShowMessage('服务器连接失败');
      exit;
    END;

  btn_Qry.Enabled := true;
  dolog('开始加载表名');
  ts := TStringList.Create;
  TRY
    Gclient.getTables(ts);
    cbb_tableList.Items.AddStrings(ts);
  FINALLY
    FreeAndNil(ts);
  END;
  dolog('表名加载成功');

END;

PROCEDURE TFrmClientTest.FormShow(Sender: TObject);
BEGIN
  postmessage(handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
END;

PROCEDURE TFrmClientTest.N1Click(Sender: TObject);
BEGIN
  CASE tmenuitem(sender).Tag OF
    1: mmo_log.Clear;
  END;
END;

PROCEDURE TFrmClientTest.btn_exitClick(Sender: TObject);
BEGIN
  IF assigned(Gclient) THEN
    Gapp.CloseCurTab;
END;

PROCEDURE TFrmClientTest.btn_QryClick(Sender: TObject);
BEGIN
  IF NOT Gclient.ServerRun() THEN
    BEGIN
      ShowMessage('服务器连接失败');
      exit;
    END;
  dolog('开始执行SQL');
  Gclient.ExecQry(mmo_sql.Text, cds);
  IF cds.Active THEN
    dbgrd.DataSource.DataSet := cds;
  dolog('SQL执行成功');
END;

PROCEDURE TFrmClientTest.N11Click(Sender: TObject);
VAR
  times, i          : Integer;
  tc                : Int64;
BEGIN
  IF NOT Gclient.ServerRun() THEN
    BEGIN
      ShowMessage('服务器连接失败');
      exit;
    END;

  IF tmenuitem(sender).tag = 0 THEN
    BEGIN
      TryStrToInt(inputbox('请指定测试次数', '', '100'), times);
    END
  ELSE
    times := tmenuitem(sender).tag;

  dolog('开始执行压力测试');
  tc := GetTickCount;
  FOR i := 0 TO times - 1 DO
    BEGIN
      application.ProcessMessages;
      IF NOT N_NoGrid.Checked THEN
        BEGIN
          Gclient.ExecQry(mmo_sql.Text, cds);
          IF cds.Active THEN
            dbgrd.DataSource.DataSet := cds;
          dbgrd.DataSource.DataSet := cds;
        END
      ELSE
        Gclient.ExecQry(mmo_sql.Text, cds);
    END;
  dolog(format('执行压力测试结束,%d次%dms', [times, gettickcount - tc]));
END;

PROCEDURE TFrmClientTest.N5Click(Sender: TObject);
VAR
  ts                : TStrings;
BEGIN
  IF NOT Gclient.ServerRun() THEN
    BEGIN
      ShowMessage('服务器连接失败');
      exit;
    END;
  CASE tmenuitem(sender).tag OF
    1:
      BEGIN
        dolog('检测服务器状态');
        ts := TStringList.Create;
        TRY
          Gclient.getUpdateFiles(ts);
          dolog(ts.Text);
        FINALLY
          FreeAndNil(ts);
        END;
      END;
    2:
      BEGIN
        dolog('检测服务器状态');
        ts := TStringList.Create;
        TRY
          Gclient.getSystemInfo(ts);
          dolog(ts.Text);
        FINALLY
          FreeAndNil(ts);
        END;
      END;
  END;
END;

END.

