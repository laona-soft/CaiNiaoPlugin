unit CaiNiaoInterface;

interface

uses
  System.SyncObjs;

const
  VER = '1.6';
  PLUGIN_MANAGER_ID = '{08B9E9B8-87EE-4850-B289-FD45D6442CEE}';
  CONFIG_ID = '{3940A661-9789-4FBA-8251-326753FCACC4}';
  SERVICE_INFO_ID = '{F1E194D5-5FBC-4C0B-A5DF-5738A4A27C3F}';
  PLUGIN_INFO_ID = '{1621AC08-9CA7-4D2A-9E28-BDA7DB506727}';
  PLUGIN_LOADER = '{FD909E4A-7E16-4B27-9DA6-9994DBC602FA}';
  MEMORY_FILE: AnsiString = 'MEMORY_FILE@';

  PLUGIN_LOAD_ALWAYS = $0100;
  PLUGIN_LOAD_WHEN_USED = $0200;
  PLUGIN_LOAD_AUTO = $0400;

type
  //��Delphi���Ĳ�������е��ཨ����������������Ϊ���ϵͳ������Delphi���Ĳ������
  //�Ǹ������������ģ�������Ӵ�������������ִ�������е�Create��Destroy������
  TPluginInterfacedObject = class(TInterfacedObject)
  protected
    FObjFree: Boolean;
    function _Release: Integer; stdcall;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    property ObjFree: Boolean read FObjFree write FObjFree;
  end;

  TPluginClass = class of TPluginInterfacedObject;

  IServiceInfo = interface;
  IPluginInfo = interface;
  IServiceManager = interface;
  IPluginLoader = interface;
  IPluginManager = interface;

  TCreateObjectFunc = function (const serviceM: IServiceManager; sv: IServiceInfo): IInterface;
  IServiceInfo = interface(IInterface)
    [SERVICE_INFO_ID]
    procedure AddExtendPointImpService(const service: IServiceInfo);
    function GetAuthor: string;
    function GetBelongToPlugin: IPluginInfo;
    function GetComment: string;
    function GetCreateObjectFunc: TCreateObjectFunc;
    function GetExtendPointImpService(idx: Integer): IServiceInfo;
    function GetExtendPointImpServiceCount: Integer;
    function GetImplementServiceID: string;
    function GetSelfObject: TObject;
    function GetServiceClass: TPluginClass;
    function GetServiceID: string;
    function GetServiceIntf: IInterface;
    function GetServiceName: string;
    function GetVersion: string;
    function IsActive: Boolean;
    function IsExtendPoint: Boolean;
    function IsSingleton: Boolean;
    procedure RemoveExtendPointImpService(const sid: string);
    procedure SetActive(act: Boolean);
    procedure SetAuthor(const author: string);
    procedure SetBelongToPlugin(const ipf: IPluginInfo);
    procedure SetComment(const comment: string);
    procedure SetCreateObjectFunc(const func: TCreateObjectFunc);
    procedure SetImplementServiceID(const impID: string);
    procedure SetIsExtendPoint(isExtPoint: Boolean);
    procedure SetReadOnly;
    procedure SetServiceClass(const intClass: TPluginClass);
    procedure SetServiceID(const id: string);
    procedure SetServiceIntf(const sv: IInterface);
    procedure SetServiceName(const sName: string);
    procedure SetSingleton(isSingleton: Boolean);
    procedure SetVersion(const ver: string);
  end;


  IPluginInfo = interface(IInterface)
    [PLUGIN_INFO_ID]
    function AppendServiceInfo(const sid: string): IServiceInfo;
    function GetAuthor: string;
    function GetComment: string;
    function GetDllName: string;
    function GetPluginID: string;
    function GetPluginLoader: IPluginLoader;
    function GetPluginName: string;
    function GetSelfObject: TObject;
    function GetServiceCount: Integer;
    function GetServiceInfo(idx: Integer): IServiceInfo;
    function GetUpdateHistory: string;
    function GetVersion: string;
    function IsActive: Boolean;
    function IsLoadedThroughConfig: Boolean;
    procedure SetActive(act: Boolean);
    procedure SetAuthor(const author: string);
    procedure SetComment(const comment: string);
    procedure SetIsLoadedThroughConfig(ltFormCfg: Boolean);
    procedure SetPluginID(const id: string);
    procedure SetPluginLoader(const loader: IPluginLoader);
    procedure SetPluginName(const theName: string);
    procedure SetReadOnly;
    procedure SetUpdateHistory(const memo: string);
    procedure SetVersion(const ver: string);
  end;

  IServiceManager = interface(IInterface)
    ['{3EC087DE-1A1A-418F-A058-A28969F7FEA5}']
    function AddServiceQuick(const serviceID, impServiceID: string; const func:
        TCreateObjectFunc; active: Boolean = True; isSingleton: Boolean = False;
        isExtendPoint: Boolean = False): Boolean; overload;
    function AddServiceQuick(const serviceID, impServiceID: string; const
        serviceClass: TPluginClass=nil; active: Boolean=True; isSingleton:
        Boolean=False; isExtendPoint: Boolean=False): Boolean; overload;
    function Count: Integer;
    function ExistService(const serviceID: string): Boolean;
    function GetExtService(const serviceID: string; idx: Integer): IInterface;
    function GetExtServiceCount(const serviceID: string): Integer;
    function GetExtServiceInfo(const serviceID: string; idx: Integer): IServiceInfo;
    function GetSelfObject: TObject;
    function GetService(const serviceID: string): IInterface;
    function GetServiceInfo(const serviceID: string): IServiceInfo; overload;
    function GetServiceInfo(idx: Integer): IServiceInfo; overload;
    function RegService(const sv: IServiceInfo): Integer;
    function ServiceIsActive(const serviceID: string): Boolean;
    function StartService(const serviceID: string): Boolean;
    function StopService(const serviceID: string): Boolean;
    function UnRegService(const serviceID: string): Integer;
  end;

  IPluginLoader = interface(IInterface)
    [PLUGIN_LOADER]
    function DLLGetObject(const serviceID: string): IInterface;
    function DLLGetPluginInfo(const im: IPluginInfo): Integer;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager);
    procedure DLLServiceStart(const serviceID: string);
    procedure DLLServiceStop(const serviceID: string);
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager);
    function GetLoadedPluginFile: string;
    function GetSelfObject: TObject;
    function LoadPlugin(const pluginFile: string): Integer;
    function UnLoadPlugin: Integer;
  end;

  IPluginManager = interface(IInterface)
    [PLUGIN_MANAGER_ID]
    function CfgLoadPluginByPluginID(const pluginID: string): Integer;
    function CfgLoadPluginByServiceID(const serviceID: string): Integer;
    function CfgReLoadPlugins: Integer;
    function GetPluginInfoByIndex(idx: Integer): IPluginInfo;
    function GetPluginInfoByPluginID(const pluginID: string): IPluginInfo;
    function GetPluginsCount: Integer;
    function GetSelfObject: TObject;
    function LoadPluginDirect(const pluginFile: string; const useLoader:
        string=''): Integer;
    function SetPluginActiveByIndex(idx: Integer): Integer;
    function SetPluginActiveByPluginID(const pluginID: string): Integer;
    function SetPluginDeActiveByIndex(idx: Integer): Integer;
    function SetPluginDeActiveByPluginID(const pluginID: string): Integer;
    function UnLoadPluginByIndex(idx: Integer): Integer;
    function UnLoadPluginByPluginID(const pluginID: string): Integer;
    function UpdatePluginDirect(const pluginFile: string; const useLoader:
        string=''): Integer;
  end;

  INotifyClient = interface(IInterface)
    ['{5A580F9A-8657-497A-8629-AC1CC49C5CF4}']
    procedure Update(const sender: Pointer; flag: Integer; const msg: string;
        const data: Pointer);
  end;

  IConfig = interface(IInterface)
    [CONFIG_ID]
    procedure AddExtendPoint(const sv: IServiceInfo);
    procedure AddPlugin(const dllFile: string);
    procedure AddService(const sv: IServiceInfo);
    procedure DisableExtendPoint(const sid: string);
    procedure DisablePlugin(const pid: string);
    procedure DisableService(const serviceID: string);
    procedure EnabledExtendPoint(const sid: string);
    procedure EnabledPlugin(const pid: string);
    procedure EnabledService(const serviceID: string);
    function ExistExtPoint(const sid: string): Boolean;
    function ExistPlugin(const pid: string): Boolean;
    function ExistService(const sid: string): Boolean;
    function ExtPointIsDisable(const sid: string): Boolean;
    function GetExtImpServiceCount(const extSid: string): Integer;
    function GetExtImpServiceID(const extSid: string; idx: Integer): string;
    function GetPluginCount: Integer;
    function GetPluginLoaderID(const pid: string): string;
    function GetPluginLoadState(const pid: string): string;
    procedure Open(const xmlFile: string);
    function PluginDLL(const pid: string): string;
    function PluginIDFromExtSid(const extSID: string): string;
    function PluginIDFromIdx(idx: Integer): string;
    function PluginIDFromSid(const sid: string): string;
    function PluginIsDisable(const pid: string): Boolean;
    procedure Reload;
    procedure RemoveExtendPoint(const sid: string);
    procedure RemovePlugin(const pid: string);
    procedure RemoveService(const serviceID: string);
    procedure Save;
    function ServiceIsDisable(const sid: string): Boolean;
    function ServiceIsSingleton(const sid: string): Boolean;
    procedure SetExtendPointSingleton(const sid: string; setSingleton: Boolean);
    procedure SetPluginLoaderID(const pid, lid: string);
    procedure SetPluginLoadState(const pid, state: string);
    procedure SetServiceSingleton(const serviceID: string; setSingleton:
        Boolean);
  end;

  ICommunicateManager = interface(IInterface)
    ['{DEF67732-DCB6-463F-AB49-CFC3E02EF57F}']
    procedure Broadcast(const sender: Pointer; flag: Integer; const msg: string;
        const data: Pointer);
    procedure Notify(const sender: Pointer; flag: Integer; const msg: string;
        const data: Pointer);
    procedure RegNotifyClient(const serviceID: string; const client:
        INotifyClient);
  end;

var
  GServiceManager: IServiceManager = nil;

implementation

{ TPluginInterfacedObject }

{
*************************** TPluginInterfacedObject ****************************
}
constructor TPluginInterfacedObject.Create;
begin
  inherited;
  FObjFree := False;
end;

destructor TPluginInterfacedObject.Destroy;
begin

  inherited;
end;

procedure TPluginInterfacedObject.BeforeDestruction;
begin
  if not FObjFree then
    inherited;
end;

function TPluginInterfacedObject._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  if not FObjFree then //����ɶ������ͷţ����ü�������0ʱ������Destroy
    if Result = 0 then
      Destroy;
end;

end.
