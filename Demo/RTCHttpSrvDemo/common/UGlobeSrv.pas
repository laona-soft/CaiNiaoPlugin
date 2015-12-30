UNIT UGlobeSrv;

INTERFACE
USES
  windows,
  classes,
  sysutils,
  forms,
  Menus,
  dialogs,
  ShlObj,
  ResultCode,
  WisdomFramework,
  WisdomCoreInterfaceForD,
  Intf,
  db,
  rtcdb,
  rtcInfo,
  ActiveX;

TYPE
  TFindCallBack = PROCEDURE(CONST filename: STRING; CONST info: TSearchRec; VAR bQuit, bSub: boolean);

  TAppInfo = CLASS(TPluginInterfacedObject, IAppInfo)

  public
    FUNCTION GetApplication: TApplication;
    FUNCTION GetMainForm: TForm;
    FUNCTION GetMainFormHandle: THandle;
    PROCEDURE CloseCurTab;
  END;

VAR
  GAppPath, GPlugInPath: STRING;
  GConfig           : IConfig;
  GpluginManager    : IPluginManager;

PROCEDURE FindFile(VAR quit: boolean; CONST path: STRING; CONST filename: STRING = '*.*';
  proc: TFindCallBack = NIL; bSub: boolean = true; CONST bMsg: boolean = true);

PROCEDURE InstallBusMenu(CONST menucaption, id: STRING; index: Integer; CONST imageIndex: Integer = -1; CONST menuIndex: Integer = 1);
PROCEDURE InstallSysMenu(CONST menucaption, id: STRING; index: Integer);

IMPLEMENTATION

USES
  UFrmMain;

PROCEDURE TAppInfo.CloseCurTab;
BEGIN
  FrmMain.RzPc.CloseActiveTab;
END;

FUNCTION TAppInfo.GetApplication: TApplication;
BEGIN
  Result := Application;
END;

FUNCTION TAppInfo.GetMainForm: TForm;
BEGIN
  Result := FrmMain;
END;

FUNCTION TAppInfo.GetMainFormHandle: THandle;
BEGIN
  Result := FrmMain.Handle;
END;

PROCEDURE FindFile(VAR quit: boolean; CONST path: STRING; CONST filename: STRING = '*.*';
  proc: TFindCallBack = NIL; bSub: boolean = true; CONST bMsg: boolean = true);
VAR
  fpath             : STRING;
  info              : TsearchRec;

  PROCEDURE ProcessAFile;
  BEGIN
    IF (info.Name <> '.') AND (info.Name <> '..') AND ((info.Attr AND faDirectory) <> faDirectory) THEN
      BEGIN
        IF assigned(proc) THEN
          proc(fpath + info.FindData.cFileName, info, quit, bsub);
      END;
  END;

  PROCEDURE ProcessADirectory;
  BEGIN
    IF (info.Name <> '.') AND (info.Name <> '..') AND ((info.attr AND fadirectory) = fadirectory) THEN
      findfile(quit, fpath + info.Name, filename, proc, bsub, bmsg);
  END;

BEGIN
  IF path[length(path)] <> '\' THEN
    fpath := path + '\'
  ELSE
    fpath := path;
  TRY
    IF 0 = findfirst(fpath + filename, faanyfile AND (NOT fadirectory), info) THEN
      BEGIN
        ProcessAFile;
        WHILE 0 = findnext(info) DO
          BEGIN
            ProcessAFile;
            IF bmsg THEN
              application.ProcessMessages;
            IF quit THEN
              BEGIN
                findclose(info);
                exit;
              END;
          END;
      END;
  FINALLY
    findclose(info);
  END;
  TRY
    IF bsub AND (0 = findfirst(fpath + '*', faanyfile, info)) THEN
      BEGIN
        ProcessADirectory;
        WHILE findnext(info) = 0 DO
          ProcessADirectory;
      END;
  FINALLY
    findclose(info);
  END;
END;

PROCEDURE InstallBusMenu(CONST menucaption, id: STRING; index: Integer; CONST imageIndex: Integer = -1; CONST menuIndex: Integer = 1);
VAR
  MenuList          : Tstrings;
  m1, m2, m3, m4, m5: Tmenuitem;
BEGIN
  m1 := NIL;
  m2 := NIL;
  m3 := NIL;
  m4 := NIL;
  MenuList := TstringList.Create;
  WITH FrmMain, mm.Items, MenuList DO
    BEGIN
      Delimiter := '_';
      DelimitedText := menucaption;

      IF (MenuList.Count > 0) THEN
        IF (Find(Strings[0]) = NIL) THEN
          BEGIN
            m1 := NewItem(Strings[0], 0, False, True, NIL, 0, Format('Menu_%d', [GetTickCount]));
            mm.Items.Insert(menuIndex + 2, m1);
          END
        ELSE
          m1 := mm.Items.Find(Strings[0]);

      IF (MenuList.Count > 1) THEN
        IF (m1.Find(Strings[1]) = NIL) THEN
          BEGIN
            m2 := NewItem(Strings[1], 0, False, True, NIL, 0, Format('Menu_%d', [GetTickCount]));
            IF (MenuList.Count = 2) THEN
              BEGIN
                m2.Hint := id;
                m2.tag := index;
                m2.onClick := BusMenuClick;
                m2.ImageIndex := ImageIndex;
              END;
            m1.Add(m2);
          END
        ELSE
          m2 := m1.Find(Strings[1]);

      IF (MenuList.Count > 2) THEN
        IF (m2.Find(Strings[2]) = NIL) THEN
          BEGIN
            m3 := NewItem(Strings[2], 0, False, True, NIL, 0, Format('Menu_%d', [GetTickCount]));
            IF (MenuList.Count = 3) THEN
              BEGIN
                m3.Hint := id;
                m3.tag := index;
                m3.onClick := BusMenuClick;
                m3.ImageIndex := ImageIndex;
              END;
            m2.Add(m3);
          END
        ELSE
          m3 := m2.Find(Strings[2]);

      IF (MenuList.Count > 3) THEN
        IF (m3.Find(Strings[3]) = NIL) THEN
          BEGIN
            m4 := NewItem(Strings[3], 0, False, True, NIL, 0, Format('Menu_%d', [GetTickCount]));
            IF (MenuList.Count = 4) THEN
              BEGIN
                m4.Hint := id;
                m4.tag := index;
                m4.onClick := BusMenuClick;
                m4.ImageIndex := ImageIndex;
              END;
            m3.Add(m4);
          END
        ELSE
          m4 := m3.Find(Strings[3]);

      IF (MenuList.Count > 4) THEN
        IF (m4.Find(Strings[4]) = NIL) THEN
          BEGIN
            m5 := NewItem(Strings[4], 0, False, True, NIL, 0, Format('Menu_%d', [GetTickCount]));
            IF (MenuList.Count = 5) THEN
              BEGIN
                m5.Hint := id;
                m5.tag := index;
                m5.onClick := BusMenuClick;
                m5.ImageIndex := ImageIndex;
              END;
            m4.Add(m5);
          END;
    END;
END;

PROCEDURE InstallSysMenu(CONST menucaption, id: STRING; index: Integer);
VAR
  menusrv, menusub1, menusub2, menusub3, menusub4, menusub5: TMenuItem;
BEGIN
  WITH FrmMain, mm.Items, Find('服务管理') DO
    BEGIN
      menusrv := TMenuItem.Create(NIL);
      menusrv.Caption := menucaption;
      menusrv.Hint := id;
      menusrv.tag := index;
      Add(menusrv);

      menusub1 := TMenuItem.Create(menusrv);
      menusub1.Caption := '启动服务';
      menusub1.onClick := SysMenuClick;
      menusub1.Tag := 1;
      menusrv.Add(menusub1);

      menusub2 := TMenuItem.Create(menusrv);
      menusub2.Caption := '关闭服务';
      menusub2.onClick := SysMenuClick;
      menusub2.Tag := 2;
      menusrv.Add(menusub2);

      menusub3 := TMenuItem.Create(menusrv);
      menusub3.Caption := '-';
      menusrv.Add(menusub3);

      menusub4 := TMenuItem.Create(menusrv);
      menusub4.Caption := '服务设置';
      menusub4.onClick := SysMenuClick;
      menusub4.Tag := 3;
      menusrv.Add(menusub4);

      menusub5 := TMenuItem.Create(menusrv);
      menusub5.Caption := '-';
      menusrv.Add(menusub5);
    END;
END;

INITIALIZATION
  //初始化全局管理接口
  GConfig := GServiceManager.GetService(CONFIG_ID) AS IConfig;
  GpluginManager := GServiceManager.GetService(PLUGIN_MANAGER_ID) AS IPluginManager;

FINALIZATION

END.

