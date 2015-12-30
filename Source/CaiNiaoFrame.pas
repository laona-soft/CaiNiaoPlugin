unit CaiNiaoFrame;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.StrUtils, System.IniFiles,
  ResultCode, XmlConfig, CaiNiaoInterface;

type
  TCaiNiaoFrame = class(TObject)
  public
    class procedure FinalFramwork;
    class procedure InitFramwork;
    class procedure Run;
    class procedure Stop;
  end;

  TServiceInfo = class(TPluginInterfacedObject, IServiceInfo)
  protected
    FAuthor: string;
    FBelongToPlugin: ^IPluginInfo;
    FComment: string;
    FCreateObjFunc: TCreateObjectFunc;
    FExtServiceList: THashedStringList;
    FImpServiceID: string;
    FIsActive: Boolean;
    FIsExtendPoint: Boolean;
    FIsSingleton: Boolean;
    FReadOnly: Boolean;
    FServiceClass: TPluginClass;
    FServiceIntf: IInterface;
    FServiceName: string;
    Fsid: string;
    FVersion: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure AddExtendPointImpService(const service: IServiceInfo); virtual;
    function GetAuthor: string; virtual;
    function GetBelongToPlugin: IPluginInfo; virtual;
    function GetComment: string; virtual;
    function GetCreateObjectFunc: TCreateObjectFunc; virtual;
    function GetExtendPointImpService(idx: Integer): IServiceInfo; virtual;
    function GetExtendPointImpServiceCount: Integer; virtual;
    function GetImplementServiceID: string; virtual;
    function GetSelfObject: TObject; virtual;
    function GetServiceClass: TPluginClass; virtual;
    function GetServiceID: string; virtual;
    function GetServiceIntf: IInterface; virtual;
    function GetServiceName: string; virtual;
    function GetVersion: string; virtual;
    function IsActive: Boolean; virtual;
    function IsExtendPoint: Boolean; virtual;
    function IsSingleton: Boolean; virtual;
    procedure RemoveExtendPointImpService(const sid: string); virtual;
    procedure SetActive(act: Boolean); virtual;
    procedure SetAuthor(const author: string); virtual;
    procedure SetBelongToPlugin(const ipf: IPluginInfo); virtual;
    procedure SetComment(const comment: string); virtual;
    procedure SetCreateObjectFunc(const func: TCreateObjectFunc); virtual;
    procedure SetImplementServiceID(const impID: string); virtual;
    procedure SetIsExtendPoint(isExtPoint: Boolean); virtual;
    procedure SetReadOnly; virtual;
    procedure SetServiceClass(const intClass: TPluginClass); virtual;
    procedure SetServiceID(const id: string); virtual;
    procedure SetServiceIntf(const sv: IInterface); virtual;
    procedure SetServiceName(const sName: string); virtual;
    procedure SetSingleton(isSingleton: Boolean); virtual;
    procedure SetVersion(const ver: string); virtual;
  end;

  TPluginInfo = class(TPluginInterfacedObject, IPluginInfo)
  protected
    FActived: Boolean;
    FAuthor: string;
    FComment: string;
    FLoadedThroughConfig: Boolean;
    FPluginID: string;
    FPluginLoader: IPluginLoader;
    FPluginName: string;
    FReadOnly: Boolean;
    FServiceList: THashedStringList;
    FUpdateHistory: string;
    FVersion: string;
  public
    constructor Create; override;
    destructor Destroy; override;
    function AppendServiceInfo(const sid: string): IServiceInfo; virtual;
    function GetAuthor: string; virtual;
    function GetComment: string; virtual;
    function GetDllName: string; virtual;
    function GetPluginID: string; virtual;
    function GetPluginLoader: IPluginLoader; virtual;
    function GetPluginName: string; virtual;
    function GetSelfObject: TObject; virtual;
    function GetServiceCount: Integer; virtual;
    function GetServiceInfo(idx: Integer): IServiceInfo; virtual;
    function GetUpdateHistory: string; virtual;
    function GetVersion: string; virtual;
    function IsActive: Boolean; virtual;
    function IsLoadedThroughConfig: Boolean; virtual;
    procedure SetActive(act: Boolean); virtual;
    procedure SetAuthor(const author: string); virtual;
    procedure SetComment(const comment: string); virtual;
    procedure SetIsLoadedThroughConfig(ltFormCfg: Boolean); virtual;
    procedure SetPluginID(const id: string); virtual;
    procedure SetPluginLoader(const loader: IPluginLoader); virtual;
    procedure SetPluginName(const theName: string); virtual;
    procedure SetReadOnly; virtual;
    procedure SetUpdateHistory(const memo: string); virtual;
    procedure SetVersion(const ver: string); virtual;
  end;

  TPluginLoader = class(TPluginInterfacedObject, IPluginLoader)
  protected
    FDLLFile: string;
    FDllHandle: THandle;
  public
    constructor Create; override;
    destructor Destroy; override;
    function DLLGetObject(const serviceID: string): IInterface; virtual;
    function DLLGetPluginInfo(const im: IPluginInfo): Integer; virtual;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); virtual;
    procedure DLLServiceStart(const serviceID: string); virtual;
    procedure DLLServiceStop(const serviceID: string); virtual;
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); virtual;
    function GetLoadedPluginFile: string; virtual;
    function GetSelfObject: TObject; virtual;
    function LoadPlugin(const pluginFile: string): Integer; virtual;
    function UnLoadPlugin: Integer; virtual;
  end;

  TPluginManager = class(TPluginInterfacedObject, IPluginManager)
  protected
    FPluginList: THashedStringList;
  public
    constructor Create; override;
    destructor Destroy; override;
    function CfgLoadPluginByPluginID(const pluginID: string): Integer; virtual;
    function CfgLoadPluginByServiceID(const serviceID: string): Integer; virtual;
    function CfgReLoadPlugins: Integer; virtual;
    function GetPluginInfoByIndex(idx: Integer): IPluginInfo; virtual;
    function GetPluginInfoByPluginID(const pluginID: string): IPluginInfo; virtual;
    function GetPluginsCount: Integer; virtual;
    function GetSelfObject: TObject; virtual;
    function LoadPluginDirect(const pluginFile: string; const useLoader:
        string=''): Integer; virtual;
    function SetPluginActiveByIndex(idx: Integer): Integer; virtual;
    function SetPluginActiveByPluginID(const pluginID: string): Integer; virtual;
    function SetPluginDeActiveByIndex(idx: Integer): Integer; virtual;
    function SetPluginDeActiveByPluginID(const pluginID: string): Integer; virtual;
    function UnLoadPluginByIndex(idx: Integer): Integer; virtual;
    function UnLoadPluginByPluginID(const pluginID: string): Integer; virtual;
    function UpdatePluginDirect(const pluginFile: string; const useLoader:
        string=''): Integer; virtual;
  end;

  TServiceManager = class(TPluginInterfacedObject, IServiceManager)
  protected
    FServiceList: THashedStringList;
    function GetServiceIdx(const serviceID: string): Integer;
    function RegExtService(const sv: IServiceInfo): Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    function AddServiceQuick(const serviceID, impServiceID: string; const func:
        TCreateObjectFunc; active: Boolean = True; isSingleton: Boolean = False;
        isExtendPoint: Boolean = False): Boolean; overload; virtual;
    function AddServiceQuick(const serviceID, impServiceID: string; const
        serviceClass: TPluginClass=nil; active: Boolean=True; isSingleton:
        Boolean=False; isExtendPoint: Boolean=False): Boolean; overload; virtual;
    function Count: Integer; virtual;
    function ExistService(const serviceID: string): Boolean; virtual;
    function GetExtService(const serviceID: string; idx: Integer): IInterface; virtual;
    function GetExtServiceCount(const serviceID: string): Integer; virtual;
    function GetExtServiceInfo(const serviceID: string; idx: Integer): IServiceInfo; virtual;
    function GetSelfObject: TObject; virtual;
    function GetService(const serviceID: string): IInterface; virtual;
    function GetServiceInfo(const serviceID: string): IServiceInfo; overload; virtual;
    function GetServiceInfo(idx: Integer): IServiceInfo; overload; virtual;
    function RegService(const sv: IServiceInfo): Integer; virtual;
    function ServiceIsActive(const serviceID: string): Boolean; virtual;
    function StartService(const serviceID: string): Boolean; virtual;
    function StopService(const serviceID: string): Boolean; virtual;
    function UnRegService(const serviceID: string): Integer; virtual;
  end;

  function GetObjFromIntf(AClass: TClass; const Intf: IInterface): TObject;
var
  GServiceManagerObj: TServiceManager = nil;

implementation

function GetObjFromIntf(AClass: TClass; const Intf: IInterface): TObject;
var
  PIntfTable: PInterfaceTable;
  IntfEntry: TInterfaceEntry;
  i: Integer;
begin
  Result := nil;
  //取得接口表结构
  PIntfTable := AClass.GetInterfaceTable;
  if PIntfTable = nil then
    Exit;
  while AClass <> nil do
  begin
    for i := 0 to PIntfTable^.EntryCount - 1 do
    begin
      IntfEntry := PIntfTable^.Entries[i];
      //判断接口表指向的地址是否和传入接口指向的地址相同
      if PPointer(Intf)^ = IntfEntry.VTable then
      begin
        //偏移到对象首地址
        Result := TObject(Integer(Pointer(Intf)) - IntfEntry.IOffset);
        Exit;
      end;
    end;
    //继续在父类中找
    AClass := AClass.ClassParent;
  end;
end;

constructor TServiceInfo.Create;
begin
  inherited;
  FAuthor := '';
  FComment := '';
  FImpServiceID := '';
  FIsExtendPoint := False;
  FIsActive := False;
  FIsSingleton := False;
  FServiceClass := nil;
  FServiceName := '';
  FServiceIntf := nil;
  Fsid := '';
  FVersion := '';
  FBelongToPlugin := nil;
  FReadOnly := False;
  FCreateObjFunc := nil;

  FExtServiceList := THashedStringList.Create;
end;

destructor TServiceInfo.Destroy;
var
  i: Integer;
begin
  FServiceIntf := nil;
  FBelongToPlugin := nil;

  //保险点，如果有人忘记调用UnRegsvice释放扩展实用的引用，则列表中就可能还会有
  //IServiceInfo接口的引用，释放它
  for i:=FExtServiceList.Count-1 downto 0 do
    IServiceInfo(Pointer(FExtServiceList.Objects[i]))._Release;
  FExtServiceList.Free;
  inherited;
end;

procedure TServiceInfo.AddExtendPointImpService(const service: IServiceInfo);
begin
  if Assigned(service) then
  begin
    if FExtServiceList.IndexOf(service.GetServiceID) > -1 then
      Exit;
    if IsSingleton and (GetExtendPointImpServiceCount>0) then begin
          IServiceInfo(Pointer(FExtServiceList.Objects[0]))._Release;
          FExtServiceList.Delete(0);
        end;
    service._AddRef;
    FExtServiceList.AddObject(service.GetServiceID, Pointer(service));
  end;
end;

function TServiceInfo.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TServiceInfo.GetBelongToPlugin: IPluginInfo;
begin
  Result := IPluginInfo(FBelongToPlugin);
end;

function TServiceInfo.GetComment: string;
begin
  Result := FComment;
end;

function TServiceInfo.GetCreateObjectFunc: TCreateObjectFunc;
begin
  Result := FCreateObjFunc;
end;

function TServiceInfo.GetExtendPointImpService(idx: Integer): IServiceInfo;
begin
  Result := nil;
  if (idx < 0) or (idx >= FExtServiceList.Count) then
    Exit;
  Result := IServiceInfo(Pointer(FExtServiceList.Objects[idx]));
end;

function TServiceInfo.GetExtendPointImpServiceCount: Integer;
begin
  Result := FExtServiceList.Count;
end;

function TServiceInfo.GetImplementServiceID: string;
begin
  Result := FImpServiceID;
end;

function TServiceInfo.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TServiceInfo.GetServiceClass: TPluginClass;
begin
  Result := FServiceClass;
end;

function TServiceInfo.GetServiceID: string;
begin
  Result := Fsid;
end;

function TServiceInfo.GetServiceIntf: IInterface;
begin
  Result := FServiceIntf;
end;

function TServiceInfo.GetServiceName: string;
begin
  Result := FServiceName
end;

function TServiceInfo.GetVersion: string;
begin
  Result := FVersion;
end;

function TServiceInfo.IsActive: Boolean;
begin
  Result := FIsActive;
end;

function TServiceInfo.IsExtendPoint: Boolean;
begin
  Result := FIsExtendPoint;
end;

function TServiceInfo.IsSingleton: Boolean;
begin
  Result := FIsSingleton;
end;

procedure TServiceInfo.RemoveExtendPointImpService(const sid: string);
var
  idx: Integer;
begin
  idx := FExtServiceList.IndexOf(sid);
  if idx = -1 then
    Exit;
  //非线程安全
  IServiceInfo(Pointer(FExtServiceList.Objects[idx]))._Release;
  FExtServiceList.Delete(idx);
end;

procedure TServiceInfo.SetActive(act: Boolean);
begin
  FIsActive := act;
end;

procedure TServiceInfo.SetAuthor(const author: string);
begin
  if not FReadOnly then
    FAuthor := author;
end;

procedure TServiceInfo.SetBelongToPlugin(const ipf: IPluginInfo);
begin
  if not FReadOnly then
    FBelongToPlugin := Pointer(ipf);
end;

procedure TServiceInfo.SetComment(const comment: string);
begin
  if not FReadOnly then
    FComment := comment;
end;

procedure TServiceInfo.SetCreateObjectFunc(const func: TCreateObjectFunc);
begin
  FCreateObjFunc := func;
end;

procedure TServiceInfo.SetImplementServiceID(const impID: string);
begin
  if not FReadOnly then
    FImpServiceID := impID;
end;

procedure TServiceInfo.SetIsExtendPoint(isExtPoint: Boolean);
begin
  if not FReadOnly then
    FIsExtendPoint := isExtPoint;
end;

procedure TServiceInfo.SetReadOnly;
begin
  FReadOnly := True;
end;

procedure TServiceInfo.SetServiceClass(const intClass: TPluginClass);
begin
  if not FReadOnly then
    FServiceClass := intClass;
end;

procedure TServiceInfo.SetServiceID(const id: string);
begin
  if not FReadOnly then
    Fsid := id;
end;

procedure TServiceInfo.SetServiceIntf(const sv: IInterface);
begin
  FServiceIntf := sv;
end;

procedure TServiceInfo.SetServiceName(const sName: string);
begin
  if not FReadOnly then
    FServiceName := sName;
end;

procedure TServiceInfo.SetSingleton(isSingleton: Boolean);
begin
  if not FReadOnly then
    FIsSingleton := isSingleton;
end;

procedure TServiceInfo.SetVersion(const ver: string);
begin
  if not FReadOnly then
    FVersion := ver;
end;

{ TPluginInfo }

{
********************************* TPluginInfo **********************************
}
constructor TPluginInfo.Create;
begin
  inherited;
  FAuthor := '';
  FComment := '';
  FPluginID := '';
  FPluginName := '';
  FUpdateHistory := '';
  FVersion := '';
  FActived := false;
  FLoadedThroughConfig := False;
  FReadOnly := False;
  if GServiceManagerObj.ServiceIsActive(PLUGIN_LOADER) then
    FPluginLoader := GServiceManagerObj.GetService(PLUGIN_LOADER) as IPluginLoader
  else
    FPluginLoader := TPluginLoader.Create;
  FServiceList := THashedStringList.Create;
end;

destructor TPluginInfo.Destroy;
var
  i: Integer;
  //sv: IServiceInfo;
begin
{  for i := FServiceList.Count - 1 downto 0 do begin
    sv := IServiceInfo(Pointer(FServiceList.Objects[i]));
    sv._Release;
    sv := nil;
  end;
}
  for i := FServiceList.Count - 1 downto 0 do
    IServiceInfo(Pointer(FServiceList.Objects[i]))._Release;
  FServiceList.Free;
  FPluginLoader := nil;
  inherited;
end;

function TPluginInfo.AppendServiceInfo(const sid: string): IServiceInfo;
var
  i: Integer;
begin
  //如果该id的已存在，则删除原来的，覆盖。
  i := FServiceList.IndexOf(sid);
  if i > -1 then
  begin
    Result := IServiceInfo(Pointer(FServiceList.Objects[i]));
    Result._Release;
    Result := nil;
    FServiceList.Delete(i);
  end;

  Result := TServiceInfo.Create;
  Result.SetServiceID(sid);
  Result.SetBelongToPlugin(Self);
  Result._AddRef;
  FServiceList.AddObject(sid, Pointer(Result));
end;

function TPluginInfo.GetAuthor: string;
begin
  Result := FAuthor;
end;

function TPluginInfo.GetComment: string;
begin
  Result := FComment;
end;

function TPluginInfo.GetDllName: string;
begin
  Result := FPluginLoader.GetLoadedPluginFile;
end;

function TPluginInfo.GetPluginID: string;
begin
  Result := FPluginID;
end;

function TPluginInfo.GetPluginLoader: IPluginLoader;
begin
  Result := FPluginLoader;
end;

function TPluginInfo.GetPluginName: string;
begin
  Result := FPluginName;
end;

function TPluginInfo.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TPluginInfo.GetServiceCount: Integer;
begin
  Result := FServiceList.Count;
end;

function TPluginInfo.GetServiceInfo(idx: Integer): IServiceInfo;
begin
  if (idx > -1) and (idx < FServiceList.Count) then
    Result := IServiceInfo(Pointer(FServiceList.Objects[idx]))
  else
    Result := nil;
end;

function TPluginInfo.GetUpdateHistory: string;
begin
  Result := FUpdateHistory;
end;

function TPluginInfo.GetVersion: string;
begin
  Result := FVersion;
end;

function TPluginInfo.IsActive: Boolean;
begin
  Result := FActived;
end;

function TPluginInfo.IsLoadedThroughConfig: Boolean;
begin
  Result := FLoadedThroughConfig;
end;

procedure TPluginInfo.SetActive(act: Boolean);
begin
  FActived := act;
end;

procedure TPluginInfo.SetAuthor(const author: string);
begin
  if not FReadOnly then
    FAuthor := author;
end;

procedure TPluginInfo.SetComment(const comment: string);
begin
  if not FReadOnly then
    FComment := comment;
end;

procedure TPluginInfo.SetIsLoadedThroughConfig(ltFormCfg: Boolean);
begin
  FLoadedThroughConfig := ltFormCfg;
end;

procedure TPluginInfo.SetPluginID(const id: string);
begin
  if not FReadOnly then
    FPluginID := id;
end;

procedure TPluginInfo.SetPluginLoader(const loader: IPluginLoader);
begin
  FPluginLoader := nil;
  FPluginLoader := loader;
end;

procedure TPluginInfo.SetPluginName(const theName: string);
begin
  if not FReadOnly then
    FPluginName := theName;
end;

procedure TPluginInfo.SetReadOnly;
begin
  FReadOnly := True;
end;

procedure TPluginInfo.SetUpdateHistory(const memo: string);
begin
  if not FReadOnly then
    FUpdateHistory := memo;
end;

procedure TPluginInfo.SetVersion(const ver: string);
begin
  if not FReadOnly then
    FVersion := ver;
end;

{ TServiceManager }

{
******************************* TServiceManager ********************************
}
constructor TServiceManager.Create;
var
  sv: TServiceInfo;
begin
  inherited;
  ObjFree := True;
  FServiceList := THashedStringList.Create;

  //把配置读取器作为服务加到服务列表中
  sv := TServiceInfo.Create;
  sv.SetServiceID(CONFIG_ID);
  sv.SetServiceClass(TXmlConfig);
  sv.SetServiceName('IConfig');
  sv.SetSingleton(true);
  sv.SetVersion(VER);
  sv.SetActive(True);
  sv.SetReadOnly;
  RegService(sv);

  //插件加载器也是服务，可以动态替换加载器即实现在Linux下加载库文件
  sv := TServiceInfo.Create;
  sv.SetServiceID(PLUGIN_LOADER);
  sv.SetServiceClass(TPluginLoader);
  sv.SetServiceName('IPluginLoader');
  sv.SetVersion(VER);
  sv.SetActive(True);
  sv.SetReadOnly;
  RegService(sv);

  //插件管理器也作为服务加到服务列表中
  sv := TServiceInfo.Create;
  sv.SetServiceID(PLUGIN_MANAGER_ID);
  sv.SetServiceClass(TPluginManager);
  sv.SetServiceName('IPluginManager');
  sv.SetSingleton(true);
  sv.SetVersion(VER);
  sv.SetActive(True);
  sv.SetReadOnly;
  RegService(sv);

  //把服务信息对象也加到列表中，用于有需要手动动态增减服务对象的用户使用
  sv := TServiceInfo.Create;
  sv.SetServiceID(SERVICE_INFO_ID);
  sv.SetServiceClass(TServiceInfo);
  sv.SetServiceName('IServiceInfo');
  sv.SetVersion(VER);
  sv.SetActive(True);
  sv.SetReadOnly;
  RegService(sv);

  sv := TServiceInfo.Create;
  sv.SetServiceID(PLUGIN_INFO_ID);
  sv.SetServiceClass(TPluginInfo);
  sv.SetServiceName('IPluginInfo');
  sv.SetVersion(VER);
  sv.SetActive(True);
  sv.SetReadOnly;
  RegService(sv);
end;

destructor TServiceManager.Destroy;
var
  idx: Integer;
  sv: IServiceInfo;
  pm: IPluginManager;
begin
  //销毁插件信息对象
  if ServiceIsActive(PLUGIN_INFO_ID) then
    UnRegService(PLUGIN_INFO_ID);
  //销毁服务信息对象
  if ServiceIsActive(SERVICE_INFO_ID) then
    UnRegService(SERVICE_INFO_ID);
  //销毁加载器对象
  if ServiceIsActive(PLUGIN_LOADER) then
    UnRegService(PLUGIN_LOADER);
  //销毁配置器对象
  if ServiceIsActive(CONFIG_ID) then
    UnRegService(CONFIG_ID);
  //销毁插件管理器
  if ServiceIsActive(PLUGIN_MANAGER_ID) then begin
    pm := GetService(PLUGIN_MANAGER_ID) as IPluginManager;
    for idx:=pm.GetPluginsCount-1 downto 0 do
      pm.UnLoadPluginByIndex(idx);
    pm := nil;
    UnRegService(PLUGIN_MANAGER_ID);
  end;

  for idx:=FServiceList.Count-1 downto 0 do begin
    sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
    sv._Release;
    sv := nil;
  end;
  FServiceList.Free;
  inherited;
end;

function TServiceManager.AddServiceQuick(const serviceID, impServiceID: string;
    const func: TCreateObjectFunc; active: Boolean = True; isSingleton: Boolean
    = False; isExtendPoint: Boolean = False): Boolean;
var
  sv: IServiceInfo;
begin
  sv := TServiceInfo.Create;
  sv.SetServiceID(serviceID);
  sv.SetImplementServiceID(impServiceID);
  sv.SetCreateObjectFunc(func);
  sv.SetIsExtendPoint(isExtendPoint);
  sv.SetSingleton(isSingleton);  //在ExtendPoint模式下，设单例为真则扩展点只总是只保存一个实现者
  sv.SetActive(active);
  Result := RegService(sv) = ERROR_SUCCESS;
end;

function TServiceManager.AddServiceQuick(const serviceID, impServiceID: string;
    const serviceClass: TPluginClass=nil; active: Boolean=True; isSingleton:
    Boolean=False; isExtendPoint: Boolean=False): Boolean;
var
  sv: IServiceInfo;
begin
  sv := TServiceInfo.Create;
  sv.SetServiceID(serviceID);
  sv.SetImplementServiceID(impServiceID);
  sv.SetServiceClass(serviceClass);
  sv.SetIsExtendPoint(isExtendPoint);
  sv.SetSingleton(isSingleton);  //在ExtendPoint模式下，设单例为真则扩展点只总是只保存一个实现者
  sv.SetActive(active);
  Result := RegService(sv) = ERROR_SUCCESS;
end;

function TServiceManager.Count: Integer;
begin
  Result := FServiceList.Count;
end;

function TServiceManager.ExistService(const serviceID: string): Boolean;
begin
  //Result := FServiceList.IndexOf(serviceID) > -1;
  Result := GetServiceIdx(serviceID) > -1;
end;

function TServiceManager.GetExtService(const serviceID: string; idx: Integer):
    IInterface;
var
  i, j: Integer;
  sv: IServiceInfo;
begin
  Result := nil;
  i := GetServiceIdx(serviceID);
  if i = -1 then
    Exit;
  j := GetExtServiceCount(serviceID);
  if (idx < 0) or (idx>=j) then
    Exit;

  sv := IServiceInfo(Pointer(FServiceList.Objects[i]));
  if sv.IsActive then begin
    if sv.IsExtendPoint then begin
      if sv.IsSingleton then
        idx := 0;
      sv := sv.GetExtendPointImpService(idx);
      Result := GetService(sv.GetServiceID);
    end else
      Result := GetService(serviceID);
  end;
end;

function TServiceManager.GetExtServiceInfo(const serviceID: string; idx: Integer): IServiceInfo;
var
  i, j: Integer;
  sv: IServiceInfo;
begin
  Result := nil;
  i := GetServiceIdx(serviceID);
  if i = -1 then
    Exit;
  j := GetExtServiceCount(serviceID);
  if (idx < 0) or (idx>=j) then
    Exit;

  sv := IServiceInfo(Pointer(FServiceList.Objects[i]));
  if sv.IsActive then begin
    if sv.IsExtendPoint then begin
      if sv.IsSingleton then
        idx := 0;
      Result := sv.GetExtendPointImpService(idx);
    end;
  end;
end;

//function TServiceManager.GetExtServiceCount(const serviceID: string): Integer;
//var
//  sv: IServiceInfo;
//begin
//  Result := GetServiceIdx(serviceID);
//  if Result = -1 then
//    Result := 0
//  else begin
//    sv := IServiceInfo(Pointer(FServiceList.Objects[Result]));
//    Result := sv.GetExtendPointImpServiceCount;
//  end;
//end;

function TServiceManager.GetExtServiceCount(const serviceID: string): Integer;
var
  i, j: Integer;
  sv: IServiceInfo;
begin
  Result := 0;
  if GetServiceIdx(serviceID) = -1 then
    Exit;

  if ServiceIsActive(CONFIG_ID) and ServiceIsActive(PLUGIN_MANAGER_ID) then
    with GetService(CONFIG_ID) as IConfig, GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
      j := GetExtImpServiceCount(serviceID);
      if j>0 then
        for i:=0 to j-1 do begin
          CfgLoadPluginByServiceID(GetExtImpServiceID(serviceID, i));
        end;
    end;

  sv := IServiceInfo(Pointer(FServiceList.Objects[GetServiceIdx(serviceID)]));
  Result := sv.GetExtendPointImpServiceCount;
end;

function TServiceManager.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TServiceManager.GetService(const serviceID: string): IInterface;
  function GetServiceIdx: Integer;
  begin
    Result := FServiceList.IndexOf(serviceID);
    if Result = -1 then
    begin
      //如果没有找到服务，可能是没有加载，先试加载一下，再检查一次。
      if ServiceIsActive(PLUGIN_MANAGER_ID) then
        with GetService(PLUGIN_MANAGER_ID) as IPluginManager do
          CfgLoadPluginByServiceID(serviceID);
      Result := FServiceList.IndexOf(serviceID);
    end;
  end;
var
  idx: Integer;
  sv: IServiceInfo;
begin
  Result := nil;
  idx := GetServiceIdx;
  if idx = -1 then
    Exit;

  sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
  //如果服务是暂停状态，返回NULL。
  if not sv.IsActive then
    Exit;
  if sv.IsExtendPoint then begin
    GetExtService(serviceID, 0);
    Exit;
  end;

  //检查是否是单例（IsSingleton），如果是，检查IService.ServiceObj是否为空，
  if sv.IsSingleton then begin
    if sv.GetServiceIntf = nil then
      if sv.GetServiceClass <> nil then
        //Delphi开发的插件特有，其它的使用DLLGetObject
        sv.SetServiceIntf(TPluginInterfacedObject(sv.GetServiceClass.NewInstance).Create)
      else if Assigned(sv.GetCreateObjectFunc) then
        sv.SetServiceIntf(sv.GetCreateObjectFunc()(GServiceManagerObj, sv))
      else if Assigned(sv.GetBelongToPlugin) then
        sv.SetServiceIntf(sv.GetBelongToPlugin.GetPluginLoader.DLLGetObject(serviceID));

    Result := sv.GetServiceIntf;
  end else begin
    if sv.GetServiceClass <> nil then
      //Delphi开发的插件特有，其它的使用DLLGetObject
      Result := TPluginInterfacedObject(sv.GetServiceClass.NewInstance).Create
    else if Assigned(sv.GetCreateObjectFunc) then
      Result := sv.GetCreateObjectFunc()(GServiceManagerObj, sv)
    else if Assigned(sv.GetBelongToPlugin) then
      Result := sv.GetBelongToPlugin.GetPluginLoader.DLLGetObject(serviceID);
  end;
end;

function TServiceManager.GetServiceIdx(const serviceID: string): Integer;
begin
  Result := FServiceList.IndexOf(serviceID);
  if Result = -1 then
  begin
    //如果没有找到服务，可能是没有加载，先试加载一下，再检查一次。
    if ServiceIsActive(PLUGIN_MANAGER_ID) then
      with GetService(PLUGIN_MANAGER_ID) as IPluginManager do
        CfgLoadPluginByServiceID(serviceID);
    Result := FServiceList.IndexOf(serviceID);
  end;
end;

function TServiceManager.GetServiceInfo(const serviceID: string): IServiceInfo;
var
  idx: Integer;
begin
  idx := GetServiceIdx(serviceID);
  if idx > -1 then
    Result := IServiceInfo(Pointer(FServiceList.Objects[idx]))
  else
    Result := nil;
end;

function TServiceManager.GetServiceInfo(idx: Integer): IServiceInfo;
begin
  Result := nil;
  if (idx<0) or (idx>=Count) then
    Exit;
  Result := IServiceInfo(Pointer(FServiceList.Objects[idx]));
end;

function TServiceManager.RegExtService(const sv: IServiceInfo): Integer;
var
  i: Integer;
  temSV: IServiceInfo;
begin
  //该函数只被RegService内部调用，因此不再检查以下这些项
{  if not Assigned(sv) then begin
    Result := ERROR_INTERFACE_IS_NULL;
    Exit;
  end;

  Result := FServiceList.IndexOf(sv.GetServiceID);
  if Result > -1 then begin
    Result := ERROR_SERVICE_EXIST;
    Exit;
  end;
  }

  sv._AddRef;
  FServiceList.AddObject(sv.GetServiceID, Pointer(sv));
  //寻找服务列表中所有声明实现该服务接口的扩展服务
  for i := FServiceList.Count - 1 downto 0 do begin
    temSV := IServiceInfo(Pointer(FServiceList.Objects[i]));
    if temSV.GetImplementServiceID = sv.GetServiceID then
      sv.AddExtendPointImpService(temSV);
  end;
  Result := ERROR_SUCCESS;
end;

function TServiceManager.RegService(const sv: IServiceInfo): Integer;
begin
  if not Assigned(sv) then begin
    Result := ERROR_INTERFACE_IS_NULL;
    Exit;
  end;

  Result := FServiceList.IndexOf(sv.GetServiceID);
  if Result > -1 then begin
    Result := ERROR_SERVICE_EXIST;
    Exit;
  end;

  if sv.IsExtendPoint then begin
    Result := RegExtService(sv);
  end else begin
    sv._AddRef;
    FServiceList.AddObject(sv.GetServiceID, Pointer(sv));
    if sv.GetImplementServiceID <> '' then begin
      Result := FServiceList.IndexOf(sv.GetImplementServiceID);
      if Result > -1 then
        IServiceInfo(Pointer(FServiceList.Objects[Result])).AddExtendPointImpService(sv);
    end;
    Result := ERROR_SUCCESS;
  end;
end;

function TServiceManager.ServiceIsActive(const serviceID: string): Boolean;
var
  idx: Integer;
  sv: IServiceInfo;
begin
  Result := False;
  idx := FServiceList.IndexOf(serviceID);
  //idx := GetServiceIdx(serviceID);
  if idx = -1 then
    Exit;
  sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
  Result := sv.IsActive;
end;

function TServiceManager.StartService(const serviceID: string): Boolean;
var
  idx: Integer;
  sv: IServiceInfo;
  pv: IPluginInfo;
begin
   idx := GetServiceIdx(serviceID);
   if idx > -1 then begin
     sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
     if not sv.IsActive then begin
       sv.SetActive(True);
       if ServiceIsActive(PLUGIN_MANAGER_ID) then
         with GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
           for idx:=0 to GetPluginsCount-1 do begin
             pv := GetPluginInfoByIndex(idx);
             pv.GetPluginLoader.DLLServiceStart(serviceID);
           end;
         end;
     end;

     Result := True;
   end else
     Result := False;
end;

function TServiceManager.StopService(const serviceID: string): Boolean;
var
  idx: Integer;
  sv: IServiceInfo;
  pv: IPluginInfo;
begin
   idx := GetServiceIdx(serviceID);
   if idx > -1 then begin
     sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
     if sv.IsActive then begin
       if ServiceIsActive(PLUGIN_MANAGER_ID) then
         with GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
           for idx:=0 to GetPluginsCount-1 do begin  //向所有的插件DLL通告有某个Service要停止，在模块中使用了该Service的都必须在导出函数DLLServiceStop中进行释放处理，这是需共同遵守的规则。
             pv := GetPluginInfoByIndex(idx);
             pv.GetPluginLoader.DLLServiceStop(serviceID);
           end;
           sv.SetActive(False);
         end;
     end;

     Result := True;
   end else
     Result := False;
end;

function TServiceManager.UnRegService(const serviceID: string): Integer;
var
  idx, idx2: Integer;
  sv, svTem: IServiceInfo;
begin
  idx := FServiceList.IndexOf(serviceID);
  if idx = -1 then begin
    Result := ERROR_SERVICE_DONT_NOT_EXIST;
    Exit;
  end;

  StopService(serviceID);
  sv := IServiceInfo(Pointer(FServiceList.Objects[idx]));
  if sv.GetImplementServiceID <> '' then begin
    idx2 := FServiceList.IndexOf(sv.GetImplementServiceID);
    if idx2>-1 then begin
      svTem := IServiceInfo(Pointer(FServiceList.Objects[idx2]));
      svTem.RemoveExtendPointImpService(serviceID);
    end;
  end;
  FServiceList.Delete(idx);
  sv._Release;
  Result := ERROR_SUCCESS;
end;

{ TPluginManager }

{
******************************** TPluginManager ********************************
}
constructor TPluginManager.Create;
begin
  inherited;
  FPluginList := THashedStringList.Create;
end;

destructor TPluginManager.Destroy;
var
  i: Integer;
begin
  for i:=FPluginList.Count-1 downto 0 do
    UnLoadPluginByIndex(i);
  FPluginList.Free;
  inherited;
end;

function TPluginManager.CfgLoadPluginByPluginID(const pluginID: string):
    Integer;
var
  idx: Integer;
  sInfo: IServiceInfo;
  pInfo: IPluginInfo;
  lid: string;
begin
  //先检查plugin是否已加载，否则进行加载
  idx := FPluginList.IndexOf(pluginID);
  if idx > -1 then begin
    Result := ERROR_SUCCESS;
    Exit;
  end;

  if not GServiceManagerObj.ServiceIsActive(CONFIG_ID) then begin
    Result := ERROR_SERVICE_NOT_ACTIVE;
    Exit;
  end;

  with GServiceManagerObj.GetService(CONFIG_ID) as IConfig do
    if ExistPlugin(pluginID) then
    begin
      if not PluginIsDisable(pluginID) then
      begin
        if not GServiceManagerObj.ServiceIsActive(PLUGIN_INFO_ID) then begin
          Result := ERROR_SERVICE_NOT_ACTIVE;
          Exit;
        end;

        pInfo := GServiceManagerObj.GetService(PLUGIN_INFO_ID) as IPluginInfo;
        lid := GetPluginLoaderID(pluginID);
        if (lid<>'') and GServiceManagerObj.ServiceIsActive(lid) then
          pInfo.SetPluginLoader(GServiceManagerObj.GetService(lid) as IPluginLoader);
        Result := pInfo.GetPluginLoader.LoadPlugin(PluginDLL(pluginID));
        if Result <> ERROR_SUCCESS then
        begin
          pInfo := nil;
          Exit;
        end;

        Result := pInfo.GetPluginLoader.DLLGetPluginInfo(pInfo);
        if Result <> ERROR_SUCCESS then
        begin
          pInfo := nil;
          Exit;
        end;

        //记录到PluginManager的Hash列表中（以插件的id为key）
        pInfo.SetIsLoadedThroughConfig(True);
        pInfo._AddRef;
        FPluginList.AddObject(pInfo.GetPluginID, Pointer(pInfo));
        //对pInfo中的每个服务对象，只注册配置文件中明确可用的服务到服务管理器，并设置服务工作模式（单例、按需创建）
        for idx := pInfo.GetServiceCount - 1 downto 0 do
        begin
          sInfo := pInfo.GetServiceInfo(idx);
          sInfo.SetSingleton(ServiceIsSingleton(sInfo.GetServiceID)); //以配置文件指定的为准，忽略DLL中的设置
          if sInfo.IsExtendPoint then begin
            if not ExistExtPoint(sInfo.GetServiceID) or ExtPointIsDisable(sInfo.GetServiceID) then
              Continue
          end else if not ExistService(sInfo.GetServiceID) or ServiceIsDisable(sInfo.GetServiceID) then
            Continue
          else if (sInfo.GetImplementServiceID<>'') and not GServiceManagerObj.ExistService(sInfo.GetImplementServiceID) then
            Continue;

          GServiceManagerObj.RegService(sinfo);
          sInfo.SetReadOnly;
        end;
        //启用插件
        SetPluginActiveByPluginID(pInfo.GetPluginID);
      end else
        Result := ERROR_PLUGIN_DISABLED;
    end else
      Result := ERROR_PLUGIN_CONFIG_DOES_NOT_EXIST;
end;

function TPluginManager.CfgLoadPluginByServiceID(const serviceID: string):
    Integer;
begin
  if not GServiceManagerObj.ExistService(CONFIG_ID) then begin
    Result := ERROR_SERVICE_DONT_NOT_EXIST;
    Exit;
  end;
  //只有在服务存在 且 服务不被禁用才返回所在插件ID
  with GServiceManagerObj.GetService(CONFIG_ID) as IConfig do
    if ExistService(serviceID) then begin
      if not ServiceIsDisable(serviceID) then begin
        Result := CfgLoadPluginByPluginID(PluginIDFromSid(serviceID));
      end else
        Result := ERROR_SERVICE_DISABLED;
    end else
      Result := ERROR_SERVICE_DOES_NOT_EXIST;
end;

function TPluginManager.CfgReLoadPlugins: Integer;
var
  idx: Integer;
  cfg: IConfig;
  plg: IPluginInfo;
  temS: string;
begin
  if not GServiceManagerObj.ServiceIsActive(CONFIG_ID) then begin
    Result := ERROR_SERVICE_DONT_NOT_EXIST;
    Exit;
  end;

  cfg := GServiceManagerObj.GetService(CONFIG_ID) as IConfig;
  //先卸载已载入但新的配置文件里已没有的插件
  for idx := FPluginList.Count-1 downto 0 do begin
    plg := IPluginInfo(Pointer(FPluginList.Objects[idx]));
    if plg.IsLoadedThroughConfig and (not cfg.ExistPlugin(plg.GetPluginID)) then
      UnLoadPluginByIndex(idx);
  end;

  //再载入配置文件里有而已载入的没有的插件
  for idx := 0 to cfg.GetPluginCount-1 do begin
    temS := cfg.PluginIDFromIdx(idx);
    if FPluginList.IndexOf(temS) = -1 then
      if cfg.GetPluginLoadState(temS) = 'always' then
        CfgLoadPluginByPluginID(temS);
  end;

  Result := ERROR_SUCCESS;
end;

function TPluginManager.GetPluginInfoByIndex(idx: Integer): IPluginInfo;
begin
  Result := nil;
  if (idx<0) or (idx>=FPluginList.Count) then
    Exit;
  Result := IPluginInfo(Pointer(FPluginList.Objects[idx]));
end;

function TPluginManager.GetPluginInfoByPluginID(const pluginID: string):
    IPluginInfo;
begin
  Result := GetPluginInfoByIndex(FPluginList.IndexOf(pluginID));
end;

function TPluginManager.GetPluginsCount: Integer;
begin
  Result := FPluginList.Count;
end;

function TPluginManager.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TPluginManager.LoadPluginDirect(const pluginFile: string; const
    useLoader: string=''): Integer;
var
  idx, count: Integer;
  sInfo: IServiceInfo;
  pInfo: IPluginInfo;
begin
  if AnsiLeftStr(AnsiString(pluginFile), Length(MEMORY_FILE)) <> MEMORY_FILE then
    if not FileExists(pluginFile) then
    begin
      Result := ERROR_FILE_NOT_FOUND;
      Exit;
    end;

  if not GServiceManagerObj.ServiceIsActive(PLUGIN_INFO_ID) then begin
    Result := ERROR_SERVICE_NOT_ACTIVE;
    Exit;
  end;

  pInfo := GServiceManagerObj.GetService(PLUGIN_INFO_ID) as IPluginInfo;
  if (useLoader<>'')
    and GServiceManagerObj.ExistService(useLoader)
      and GServiceManagerObj.ServiceIsActive(useLoader) then
    pInfo.SetPluginLoader(GServiceManagerObj.GetService(useLoader) as IPluginLoader);
  Result := pInfo.GetPluginLoader.LoadPlugin(pluginFile);
  if Result <> ERROR_SUCCESS then
  begin
    pInfo := nil;
    Exit;
  end;

  Result := pInfo.GetPluginLoader.DLLGetPluginInfo(pInfo);
  if Result <> ERROR_SUCCESS then
  begin
    pInfo := nil;
    Exit;
  end;

  //先检查plugin是否已加载，否则进行加载
  idx := FPluginList.IndexOf(pInfo.GetPluginID);
  if idx > -1 then begin
    pInfo := nil;
    Result := ERROR_SUCCESS;
    Exit;
  end;

  //记录到PluginManager的Hash列表中（以插件的id为key）
  pInfo._AddRef;
  pInfo.SetReadOnly;
  FPluginList.AddObject(pInfo.GetPluginID, Pointer(pInfo));
  //for idx := pInfo.GetServiceCount - 1 downto 0 do
  count:=pInfo.GetServiceCount-1;
  for idx := 0 to count do
  begin
    sInfo := pInfo.GetServiceInfo(idx);
    if (sInfo.GetImplementServiceID<>'') and not GServiceManagerObj.ExistService(sInfo.GetImplementServiceID) then
      Continue;
    GServiceManagerObj.RegService(sinfo);
    sInfo.SetReadOnly;
  end;
  //启用插件
  SetPluginActiveByPluginID(pInfo.GetPluginID);
end;

function TPluginManager.SetPluginActiveByIndex(idx: Integer): Integer;
var
  i: Integer;
  p: IPluginInfo;
begin
  if (idx<0) or (idx>=FPluginList.Count) then begin
    Result := ERROR_OUT_BOUND;
    Exit;
  end;
  //调用DLL中插件初始化函数
  p := IPluginInfo(Pointer(FPluginList.Objects[idx]));
  p.GetPluginLoader.DLLInitializePlugin(GServiceManagerObj);
  //把插件里的所有服务置为运行状态，每个服务启动时，调用DLL中服务开始函数
  for i:=0 to p.GetServiceCount-1 do
    GServiceManagerObj.StartService(p.GetServiceInfo(i).GetServiceID);
  //插件置为激活状态
  p.SetActive(True);
  Result := ERROR_SUCCESS;
end;

function TPluginManager.SetPluginActiveByPluginID(const pluginID: string):
    Integer;
begin
  Result := FPluginList.IndexOf(pluginID);
  if Result>-1 then
    Result := SetPluginActiveByIndex(Result)
  else
    Result := ERROR_PLUGIN_DONT_NOT_EXIST;
end;

function TPluginManager.SetPluginDeActiveByIndex(idx: Integer): Integer;
var
  i: Integer;
  p: IPluginInfo;
begin
  if (idx<0) or (idx>=FPluginList.Count) then begin
    Result := ERROR_OUT_BOUND;
    Exit;
  end;

  p := IPluginInfo(Pointer(FPluginList.Objects[idx]));
  //把插件里的所有服务置为停止状态，每个服务停止时，调用DLL中服务停止通知函数
  for i:=0 to p.GetServiceCount-1 do
    GServiceManagerObj.StopService(p.GetServiceInfo(i).GetServiceID);
  //调用DLL中的DLLUninitializePlugin函数
  p.GetPluginLoader.DLLUninitializePlugin(GServiceManagerObj);
  //插件置为非激活状态
  p.SetActive(False);
  Result := ERROR_SUCCESS;
end;

function TPluginManager.SetPluginDeActiveByPluginID(const pluginID: string):
    Integer;
begin
  Result := FPluginList.IndexOf(pluginID);
  if Result>-1 then
    Result := SetPluginDeActiveByIndex(Result)
  else
    Result := ERROR_PLUGIN_DONT_NOT_EXIST;
end;

function TPluginManager.UnLoadPluginByIndex(idx: Integer): Integer;
var
  i: Integer;
  p: IPluginInfo;
begin
  if (idx<0) or (idx>=FPluginList.Count) then begin
    Result := ERROR_OUT_BOUND;
    Exit;
  end;

  Result := SetPluginDeActiveByIndex(idx);
  if Result = ERROR_SUCCESS then begin
    p := IPluginInfo(Pointer(FPluginList.Objects[idx]));
    //卸载插件DLL中包括的所有服务。
    for i:=p.GetServiceCount-1 downto 0 do
      GServiceManagerObj.UnRegService(p.GetServiceInfo(i).GetServiceID);
    //调用DLL中插件DLLUninitializePlugin函数
    //p.GetPluginLoader.DLLUninitializePlugin(GServiceManagerObj);
    FPluginList.Delete(idx);
    p._Release;
    Result := ERROR_SUCCESS;
  end;
end;

function TPluginManager.UnLoadPluginByPluginID(const pluginID: string): Integer;
begin
  Result := FPluginList.IndexOf(pluginID);
  if Result>-1 then
    Result := UnLoadPluginByIndex(Result)
  else
    Result := ERROR_PLUGIN_DONT_NOT_EXIST;
end;

function TPluginManager.UpdatePluginDirect(const pluginFile: string; const
    useLoader: string=''): Integer;
var
  idx: Integer;
  temS, pid: string;
  pInfo: IPluginInfo;
  reLoad: Boolean;
begin
  if not FileExists(pluginFile) then
  begin
    Result := ERROR_FILE_NOT_FOUND;
    Exit;
  end;

  if not GServiceManagerObj.ServiceIsActive(CONFIG_ID) then begin
    Result := ERROR_SERVICE_NOT_ACTIVE;
    Exit;
  end;

  //先获取插件信息
  if not GServiceManagerObj.ServiceIsActive(PLUGIN_INFO_ID) then begin
    Result := ERROR_SERVICE_NOT_ACTIVE;
    Exit;
  end;

  pInfo := GServiceManagerObj.GetService(PLUGIN_INFO_ID) as IPluginInfo;
  Result := pInfo.GetPluginLoader.LoadPlugin(pluginFile);
  if Result <> ERROR_SUCCESS then
  begin
    pInfo := nil;
    Exit;
  end;

  Result := pInfo.GetPluginLoader.DLLGetPluginInfo(pInfo);
  if Result <> ERROR_SUCCESS then
  begin
    pInfo := nil;
    Exit;
  end;

  //先检查plugin是否已加载
  reLoad := False;
  pid := pInfo.GetPluginID;
  idx := FPluginList.IndexOf(pid);
  if idx > -1 then begin
    pInfo := IPluginInfo(Pointer(FPluginList.Objects[idx]));
    temS := pInfo.GetDllName;
    //卸载同ID插件
    Result := UnLoadPluginByPluginID(pid);
    if Result <> ERROR_SUCCESS then
      Exit;
    reLoad := True;
  end else
  with GServiceManagerObj.GetService(CONFIG_ID) as IConfig do
    if ExistPlugin(pid) then
      temS := PluginDLL(pid)
    else begin
      Result := ERROR_FILE_NOT_FOUND;
      Exit;
    end;

  if FileExists(temS) then begin
    //覆盖插件
    DeleteFile(temS);
    MoveFileA(PAnsiChar(AnsiString(pluginFile)), PAnsiChar(AnsiString(temS)));
    if reLoad then
      with GServiceManagerObj.GetService(CONFIG_ID) as IConfig do
        if ExistPlugin(pid) then
          CfgLoadPluginByPluginID(pid)
        else
          LoadPluginDirect(temS);
  end;
end;

{ TPluginLoader }

{
******************************** TPluginLoader *********************************
}
constructor TPluginLoader.Create;
begin
  inherited;
  FDllHandle := 0;
end;

destructor TPluginLoader.Destroy;
begin
  FreeLibrary(FDllHandle);
  inherited;
end;

function TPluginLoader.DLLGetObject(const serviceID: string): IInterface;
type
  TDLLGetObject = function(const serviceID: PAnsiChar): IInterface; stdcall;
  TDLLGetObjectForC = function(const serviceID: PAnsiChar): Pointer; stdcall;
var
  DLLGetObject: TDLLGetObject;
begin
  Result := nil;
  if FDllHandle = 0 then
    Exit;

  DLLGetObject := GetProcAddress(FDllHandle, 'DLLGetObject');
  if Assigned(DLLGetObject) then
    Result := DLLGetObject(PAnsiChar(AnsiString(serviceID)))
end;

function TPluginLoader.DLLGetPluginInfo(const im: IPluginInfo): Integer;
type
  TDLLGetPluginInfo = procedure(const im: IPluginInfo); stdcall;
var
  DLLGetPluginInfo: TDLLGetPluginInfo;
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

  DLLGetPluginInfo := GetProcAddress(FDllHandle, 'DLLGetPluginInfo');

  if Assigned(DLLGetPluginInfo) then
    DLLGetPluginInfo(TPluginInfo(im.GetSelfObject))
  else begin
    Result := ERROR_NOT_PLUGIN_DLL;
    Exit;
  end;

  if im.GetPluginID = '' then
    Result := ERROR_SERVICE_DONT_NOT_EXIST
  else
    Result := ERROR_SUCCESS;
end;

procedure TPluginLoader.DLLInitializePlugin(const IServiceMgr: IServiceManager);
type
  TDLLInitializePlugin = procedure(const IServiceMgr: IServiceManager); stdcall;
var
  DLLInitializePlugin: TDLLInitializePlugin;
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLInitializePlugin := GetProcAddress(FDllHandle, 'DLLInitializePlugin');
  if Assigned(DLLInitializePlugin) then
    //DLLInitializePlugin(IServiceMgr);
    DLLInitializePlugin(TServiceManager(IServiceMgr.GetSelfObject))
end;

procedure TPluginLoader.DLLServiceStart(const serviceID: string);
type
  TDLLServiceStart = procedure(const serviceID: PAnsiChar); stdcall;
var
  DLLServiceStart: TDLLServiceStart;
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLServiceStart := GetProcAddress(FDllHandle, 'DLLServiceStart');
  if Assigned(DLLServiceStart) then
    DLLServiceStart(PAnsiChar(AnsiString(serviceID)))
end;

procedure TPluginLoader.DLLServiceStop(const serviceID: string);
type
  TDLLServiceStop = procedure(const serviceID: PAnsiChar); stdcall;
var
  DLLServiceStop: TDLLServiceStop;
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLServiceStop := GetProcAddress(FDllHandle, 'DLLServiceStop');
  if Assigned(DLLServiceStop) then
    DLLServiceStop(PAnsiChar(AnsiString(serviceID)))
end;

procedure TPluginLoader.DLLUninitializePlugin(const IServiceMgr:
    IServiceManager);
type
  TDLLUninitializePlugin = procedure(const IServiceMgr: IServiceManager); stdcall;
var
  DLLUninitializePlugin: TDLLUninitializePlugin;
begin
  if FDllHandle = 0 then begin
    Exit;
  end;

  DLLUninitializePlugin := GetProcAddress(FDllHandle, 'DLLUninitializePlugin');
  if Assigned(DLLUninitializePlugin) then
    //DLLUninitializePlugin(IServiceMgr);
    DLLUninitializePlugin(TServiceManager(IServiceMgr.GetSelfObject))
end;

function TPluginLoader.GetLoadedPluginFile: string;
begin
  Result := FDLLFile;
end;

function TPluginLoader.GetSelfObject: TObject;
begin
  Result := Self;
end;

function TPluginLoader.LoadPlugin(const pluginFile: string): Integer;
begin
  if not FileExists(pluginFile) then
  begin
    Result := ERROR_FILE_NOT_FOUND;
    Exit;
  end;

  if LowerCase(ExtractFileExt(pluginFile)) = '.bpl' then
    FDllHandle := LoadPackage(pluginFile)
  else
    FDllHandle := LoadLibraryA(PAnsiChar(AnsiString(pluginFile)));
  if FDllHandle = 0 then
  begin
    Result := ERROR_NOT_PLUGIN_DLL;
    Exit;
  end;
  FDLLFile := pluginFile;

  Result := ERROR_SUCCESS;
end;

//  procedure DoUnloadPackage(Module: HModule);
//  var
//    i: Integer;
//    M: TMemoryBasicInformation;
//  begin
//    for i := Application.ComponentCount - 1 downto 0 do
//    begin
//      VirtualQuery(GetClass(Application.Components[i].ClassName), M, Sizeof(M));
//      if (Module = 0) or (HMODULE(M.AllocationBase) = Module) then
//        Application.Components[i].Free;
//    end;
//    UnregisterModuleClasses(Module);
//    UnloadPackage(Module);
//  end;

function TPluginLoader.UnLoadPlugin: Integer;
begin
   Result := ERROR_SUCCESS;
  if LowerCase(ExtractFileExt(PChar(string(FDLLFile)))) = '.bpl' then begin
    //UnregisterModuleClasses(FDllHandle);
    UnloadPackage(FDllHandle);
  end;// else
  if not FreeLibrary(FDllHandle) then
    Result := ERROR_UNLOAD_PLUGIN_FAIL;
  FDllHandle := 0;
  FDLLFile := '';
end;

{
******************************* TCaiNiaoFrame *******************************
}
class procedure TCaiNiaoFrame.FinalFramwork;
begin
  GServiceManager := nil;
  GServiceManagerObj.Free;
end;

class procedure TCaiNiaoFrame.InitFramwork;
begin
  if not Assigned(GServiceManagerObj) then begin
    GServiceManagerObj := TServiceManager.Create;
    GServiceManager := GServiceManagerObj;
  end;
end;

class procedure TCaiNiaoFrame.Run;
begin
  if not Assigned(GServiceManager) then
    raise Exception.Create('框架未进行初始化！请调用InitFramwork初始化框架。');

  if GServiceManager.ServiceIsActive(PLUGIN_MANAGER_ID) then
    with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do
      CfgReLoadPlugins;
end;

class procedure TCaiNiaoFrame.Stop;
var
  i: Integer;
begin
  if Assigned(GServiceManager) and GServiceManager.ServiceIsActive(PLUGIN_MANAGER_ID) then
    with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
      for i:=GetPluginsCount-1 downto 0 do
        UnLoadPluginByIndex(i);
    end;
end;

initialization
  TCaiNiaoFrame.InitFramwork;

finalization
  if Assigned(GServiceManager) then begin
    TCaiNiaoFrame.Stop;
    TCaiNiaoFrame.FinalFramwork;
  end;



end.

