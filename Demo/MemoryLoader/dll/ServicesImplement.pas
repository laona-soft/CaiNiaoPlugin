unit ServicesImplement;

interface

uses
  SysUtils, StrUtils, 
  {$IFDEF _USE_FOR_CPP}
  WisdomCoreInterfaceForC,
  {$ENDIF}
  WisdomCoreInterfaceForD, ServicesInterface, MemoryModule, ResultCode;
                        {.$UNDEF _USE_FOR_CPP}
type
  {$IFDEF _USE_FOR_CPP}
  TMemoryLoader = class(TPluginInterfacedObject, IPluginLoader, IPluginLoaderForC, IMemoryLoader)
  protected
    FDLLFile: MyString;
    FDllHandle: THandle;
  public
    //function IPluginLoaderForC.DLLGetObject = DLLGetObject2;
    procedure IPluginLoaderForC.DLLGetObject = DLLGetObject2;
    function IPluginLoaderForC.DLLGetPluginInfo = DLLGetPluginInfo2;
    procedure IPluginLoaderForC.DLLInitializePlugin = DLLInitializePlugin2;
    procedure IPluginLoaderForC.DLLServiceStart = DLLServiceStart2;
    procedure IPluginLoaderForC.DLLServiceStop = DLLServiceStop2;
    procedure IPluginLoaderForC.DLLUninitializePlugin = DLLUninitializePlugin2;
    function IPluginLoaderForC.GetLoadedPluginFile = GetLoadedPluginFile2;
    function IPluginLoaderForC.LoadPlugin = LoadPlugin2;
    function IPluginLoaderForC.UnLoadPlugin = UnLoadPlugin2;
    constructor Create; override;
    destructor Destroy; override;
    function DLLGetObject(const serviceID: MyString): IInterface; virtual;
    //function DLLGetObject2(const serviceID: PMyChar): IInterface; stdcall;
    procedure DLLGetObject2(const serviceID: PMyChar; out intf: IInterface); virtual; stdcall; 
    function DLLGetPluginInfo(const im: IPluginInfo): Integer; virtual;
    function DLLGetPluginInfo2(const im: IPluginInfoForC): Integer; virtual; stdcall; 
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); virtual;
    procedure DLLInitializePlugin2(const IServiceMgr: IServiceManagerForC); virtual; stdcall; 
    procedure DLLServiceStart(const serviceID: MyString); virtual;
    procedure DLLServiceStart2(const serviceID: PMyChar); virtual; stdcall; 
    procedure DLLServiceStop(const serviceID: MyString); virtual;
    procedure DLLServiceStop2(const serviceID: PMyChar); virtual; stdcall; 
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); virtual;
    procedure DLLUninitializePlugin2(const IServiceMgr: IServiceManagerForC); virtual; stdcall; 
    function GetLoadedPluginFile: MyString; virtual;
    function GetLoadedPluginFile2: PMyChar; virtual; stdcall; 
    function GetSelfObject: TObject; virtual;
    function LoadPlugin(const pluginFile: MyString): Integer; virtual;
    function LoadPlugin2(const pluginFile: PMyChar): Integer; virtual; stdcall; 
    function UnLoadPlugin: Integer; virtual;
    function UnLoadPlugin2: Integer; virtual; stdcall;
  end;
  {$ELSE}
  TMemoryLoader = class(TPluginInterfacedObject, IPluginLoader, IMemoryLoader)
  protected
    FDLLFile: MyString;
    FDllHandle: THandle;
  public
    constructor Create; override;
    destructor Destroy; override;
    function DLLGetObject(const serviceID: MyString): IInterface; virtual;
    function DLLGetPluginInfo(const im: IPluginInfo): Integer; virtual;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); virtual;
    procedure DLLServiceStart(const serviceID: MyString); virtual;
    procedure DLLServiceStop(const serviceID: MyString); virtual;
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); virtual;
    function GetLoadedPluginFile: MyString; virtual;
    function GetSelfObject: TObject; virtual;
    function LoadPlugin(const pluginFile: MyString): Integer; virtual;
    function UnLoadPlugin: Integer; virtual;
  end;
  {$ENDIF}

implementation

uses WisdomFramework;

{ TMemoryLoader}

{
******************************** TPluginLoader *********************************
}

constructor TMemoryLoader.Create;
begin
  inherited;
  FDllHandle := 0;
end;

destructor TMemoryLoader.Destroy;
begin
  MemFreeLibrary(FDllHandle);
  inherited;
end;

function TMemoryLoader.DLLGetObject(const serviceID: MyString): IInterface;
type
  TDLLGetObject = function(const serviceID: PAnsiChar): IInterface; stdcall;
  TDLLGetObjectForC = function(const serviceID: PAnsiChar): Pointer; stdcall;
var
  DLLGetObject: TDLLGetObject;
{$IFDEF _USE_FOR_CPP}
  //DLLGetObjectForC: TDLLGetObjectForC;
  DLLGetObjectForC: Pointer;
{$ENDIF}
begin
  Result := nil;
  if FDllHandle = 0 then
    Exit;

  DLLGetObject := MemGetProcAddress(FDllHandle, 'DLLGetObject');
  {$IFDEF _USE_FOR_CPP}
  DLLGetObjectForC := MemGetProcAddress(FDllHandle, 'GetCppObject');
  {$ENDIF}
  if Assigned(DLLGetObject) then
    Result := DLLGetObject(PAnsiChar(AnsiString(serviceID)))
  {$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLGetObjectForC) then begin
    Result := IInterface(TDLLGetObjectForC(DLLGetObjectForC)(PAnsiChar(AnsiString(serviceID))));
    Result._AddRef;
  end;
  {$ENDIF}
end;

function TMemoryLoader.DLLGetPluginInfo(const im: IPluginInfo): Integer;
type
  TDLLGetPluginInfo = procedure(const im: IPluginInfo); stdcall;
{$IFDEF _USE_FOR_CPP}
  TDLLGetPluginInfoForC = procedure(const im: IPluginInfoForC); stdcall;
{$ENDIF}
var
  DLLGetPluginInfo: TDLLGetPluginInfo;
{$IFDEF _USE_FOR_CPP}
  DLLGetPluginInfoForC: TDLLGetPluginInfoForC;
{$ENDIF}
begin
  if not Assigned(im) then
  begin
    Result := ERROR_INTERFACE_IS_NULL;
    Exit;
  end;

  if FDllHandle = 0 then begin
    Result := ERROR_NOT_LOAD_PLUGIN_DLL;
    Exit;
  end;

  DLLGetPluginInfo := MemGetProcAddress(FDllHandle, 'DLLGetPluginInfo');
{$IFDEF _USE_FOR_CPP}
  DLLGetPluginInfoForC := MemGetProcAddress(FDllHandle, 'GetPluginInfo');
{$ENDIF}

  if Assigned(DLLGetPluginInfo) then
    DLLGetPluginInfo(TPluginInfo(im.GetSelfObject))
{$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLGetPluginInfoForC) then
    DLLGetPluginInfoForC(TPluginInfo(im.GetSelfObject))
{$ENDIF}
  else begin
    Result := ERROR_NOT_PLUGIN_DLL;
    Exit;
  end;

  if im.GetPluginID = '' then
    Result := ERROR_SERVICE_DONT_NOT_EXIST
  else
    Result := ERROR_SUCCESS;
end;

procedure TMemoryLoader.DLLInitializePlugin(const IServiceMgr: IServiceManager);
type
  TDLLInitializePlugin = procedure(const IServiceMgr: IServiceManager); stdcall;
{$IFDEF _USE_FOR_CPP}
  TDLLInitializePluginForC = procedure(const IServiceMgr: IServiceManagerForC); stdcall;
{$ENDIF}
var
  DLLInitializePlugin: TDLLInitializePlugin;
{$IFDEF _USE_FOR_CPP}
  DLLInitializePluginForC: TDLLInitializePluginForC;
{$ENDIF}
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLInitializePlugin := MemGetProcAddress(FDllHandle, 'DLLInitializePlugin');
{$IFDEF _USE_FOR_CPP}
  DLLInitializePluginForC := MemGetProcAddress(FDllHandle, 'InitializePlugin');
{$ENDIF}
  if Assigned(DLLInitializePlugin) then
    //DLLInitializePlugin(IServiceMgr);
    DLLInitializePlugin(TServiceManager(IServiceMgr.GetSelfObject))
{$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLInitializePluginForC) then
    DLLInitializePluginForC(TServiceManager(IServiceMgr.GetSelfObject));
{$ENDIF}
end;

procedure TMemoryLoader.DLLServiceStart(const serviceID: MyString);
type
  TDLLServiceStart = procedure(const serviceID: PAnsiChar); stdcall;
{$IFDEF _USE_FOR_CPP}
  TDLLServiceStartForC = procedure(const serviceID: PAnsiChar); stdcall;
{$ENDIF}
var
  DLLServiceStart: TDLLServiceStart;
{$IFDEF _USE_FOR_CPP}
  DLLServiceStartForC: TDLLServiceStartForC;
{$ENDIF}
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLServiceStart := MemGetProcAddress(FDllHandle, 'DLLServiceStart');
{$IFDEF _USE_FOR_CPP}
  DLLServiceStartForC := MemGetProcAddress(FDllHandle, 'ServiceStart');
{$ENDIF}
  if Assigned(DLLServiceStart) then
    DLLServiceStart(PAnsiChar(AnsiString(serviceID)))
{$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLServiceStartForC) then
    DLLServiceStartForC(PAnsiChar(AnsiString(serviceID)));
{$ENDIF}
end;

procedure TMemoryLoader.DLLServiceStop(const serviceID: MyString);
type
  TDLLServiceStop = procedure(const serviceID: PAnsiChar); stdcall;
{$IFDEF _USE_FOR_CPP}
  TDLLServiceStopForC = procedure(const serviceID: PAnsiChar); stdcall;
{$ENDIF}
var
  DLLServiceStop: TDLLServiceStop;
{$IFDEF _USE_FOR_CPP}
  DLLServiceStopForC: TDLLServiceStopForC;
{$ENDIF}
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLServiceStop := MemGetProcAddress(FDllHandle, 'DLLServiceStop');
{$IFDEF _USE_FOR_CPP}
  DLLServiceStopForC := MemGetProcAddress(FDllHandle, 'ServiceStop');
{$ENDIF}
  if Assigned(DLLServiceStop) then
    DLLServiceStop(PAnsiChar(AnsiString(serviceID)))
{$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLServiceStopForC) then
    DLLServiceStopForC(PAnsiChar(AnsiString(serviceID)));
{$ENDIF}
end;

procedure TMemoryLoader.DLLUninitializePlugin(const IServiceMgr:
    IServiceManager);
type
  TDLLUninitializePlugin = procedure(const IServiceMgr: IServiceManager); stdcall;
{$IFDEF _USE_FOR_CPP}
  TDLLUninitializePluginForC = procedure(const IServiceMgr: IServiceManagerForC); stdcall;
{$ENDIF}
var
  DLLUninitializePlugin: TDLLUninitializePlugin;
{$IFDEF _USE_FOR_CPP}
  DLLUninitializePluginForC: TDLLUninitializePluginForC;
{$ENDIF}
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLUninitializePlugin := MemGetProcAddress(FDllHandle, 'DLLUninitializePlugin');
{$IFDEF _USE_FOR_CPP}
  DLLUninitializePluginForC := MemGetProcAddress(FDllHandle, 'UninitializePlugin');
{$ENDIF}
  if Assigned(DLLUninitializePlugin) then
    //DLLUninitializePlugin(IServiceMgr);
    DLLUninitializePlugin(TServiceManager(IServiceMgr.GetSelfObject))
{$IFDEF _USE_FOR_CPP}
  else if Assigned(DLLUninitializePluginForC) then
    DLLUninitializePluginForC(TServiceManager(IServiceMgr.GetSelfObject));
{$ENDIF}
end;

function TMemoryLoader.GetLoadedPluginFile: MyString;
begin
  Result := FDLLFile;
end;

function TMemoryLoader.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TMemoryLoader.LoadPlugin(const pluginFile: MyString): Integer;
var
  p: Pointer;
  f: AnsiString;
begin
  f := AnsiString(pluginFile);
  if (Length(f)<=Length(MEMORY_FILE))
    or (AnsiLeftStr(f, Length(MEMORY_FILE)) <> MEMORY_FILE) then
  begin
    Result := ERROR_FILE_NOT_FOUND;
    Exit;
  end;

  p := Pointer(StrToInt(AnsiReplaceStr(f, MEMORY_FILE, '')));
  FDllHandle := MemLoadLibrary(p);
  if FDllHandle = 0 then
  begin
    Result := ERROR_NOT_PLUGIN_DLL;
    Exit;
  end;
  FDLLFile := pluginFile;
  Result := ERROR_SUCCESS;
end;

function TMemoryLoader.UnLoadPlugin: Integer;
begin
  Result := ERROR_SUCCESS;
  if not MemFreeLibrary(FDllHandle) then
    Result := ERROR_UNLOAD_PLUGIN_FAIL;
  FDllHandle := 0;
  FDLLFile := '';
end;

{$IFDEF _USE_FOR_CPP}
procedure TMemoryLoader.DLLGetObject2(const serviceID: PMyChar; out intf: IInterface);
begin
  intf := DLLGetObject(serviceID);
end;

function TMemoryLoader.DLLGetPluginInfo2(const im: IPluginInfoForC): Integer;
begin
  Result := DLLGetPluginInfo(im as IPluginInfo);
end;

procedure TMemoryLoader.DLLInitializePlugin2(const IServiceMgr:
    IServiceManagerForC);
begin
  DLLInitializePlugin(IServiceMgr as IServiceManager);
end;

procedure TMemoryLoader.DLLServiceStart2(const serviceID: PMyChar);
begin
  DLLServiceStart(serviceID);
end;

procedure TMemoryLoader.DLLServiceStop2(const serviceID: PMyChar);
begin
  DLLServiceStop(serviceID);
end;

procedure TMemoryLoader.DLLUninitializePlugin2(const IServiceMgr:
    IServiceManagerForC);
begin
  DLLUninitializePlugin(IServiceMgr as IServiceManager);
end;

function TMemoryLoader.GetLoadedPluginFile2: PMyChar;
begin
  Result := PMyChar(GetLoadedPluginFile);
end;

function TMemoryLoader.LoadPlugin2(const pluginFile: PMyChar): Integer;
begin
  Result := LoadPlugin(pluginFile);
end;

function TMemoryLoader.UnLoadPlugin2: Integer;
begin
  Result := UnLoadPlugin;
end;
{$ENDIF}

end.

