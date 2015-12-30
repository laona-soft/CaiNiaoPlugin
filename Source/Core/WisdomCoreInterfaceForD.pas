{*******************************************************}
{                                                       }
{       WisdomPluginFramework                           }
{       2014 IceAir                                     }
{       ice.air@126.com  QQ: 3216343                    }
{                                                       }
{*******************************************************}

//////////////////////////////////////////////////////////////////
//                        使用说明                              //
//    你可以自由复制、分发、使用、扩展本框架代码，但各单元中需  //
//    保留作者大名，如果你有好的修改，请反馈作者，以便作者整合  //
//    后为大家提供更好的开发框架。                              //
//                                                              //
//    本框架的命名Wisdom，实指的是众人智慧集合的结晶。          //
//                                                              //
//////////////////////////////////////////////////////////////////

{--------------------------------------------------------
                           框架用途
      WisdomPluginFramework是融合OSGI微内核理念 + Eclipse的
  扩展点概念而精心设计的轻量级插件框架，由Delphi实现，但可以
  使用于Delphi、BCB、VC++中，提供非常强大灵活的插件调度能力，
  让你充分享受插件式编程的乐趣。
 --------------------------------------------------------
}
 
unit WisdomCoreInterfaceForD;

{$INCLUDE Def.inc}

interface

uses
  {$IFDEF IDE_XE4up}
     System.SyncObjs;
  {$ELSE}
     Windows;
  {$ENDIF}   

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
                    
{$INCLUDE MyString.inc}

type
  //用Delphi做的插件，所有的类建议从这个类派生，因为插件系统对于用Delphi做的插件对象，
  //是根据类名创建的，如果不从此类派生，则不能执行子类中的Create和Destroy函数。
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
    function GetAuthor: MyString;
    function GetBelongToPlugin: IPluginInfo;
    function GetComment: MyString;
    function GetCreateObjectFunc: TCreateObjectFunc;
    function GetExtendPointImpService(idx: Integer): IServiceInfo;
    function GetExtendPointImpServiceCount: Integer;
    function GetImplementServiceID: MyString;
    function GetSelfObject: TObject;
    function GetServiceClass: TPluginClass;
    function GetServiceID: MyString;
    function GetServiceIntf: IInterface;
    function GetServiceName: MyString;
    function GetVersion: MyString;
    function IsActive: Boolean;
    function IsExtendPoint: Boolean;
    function IsSingleton: Boolean;
    procedure RemoveExtendPointImpService(const sid: MyString);
    procedure SetActive(act: Boolean);
    procedure SetAuthor(const author: MyString);
    procedure SetBelongToPlugin(const ipf: IPluginInfo);
    procedure SetComment(const comment: MyString);
    procedure SetCreateObjectFunc(const func: TCreateObjectFunc);
    procedure SetImplementServiceID(const impID: MyString);
    procedure SetIsExtendPoint(isExtPoint: Boolean);
    procedure SetReadOnly;
    procedure SetServiceClass(const intClass: TPluginClass);
    procedure SetServiceID(const id: MyString);
    procedure SetServiceIntf(const sv: IInterface);
    procedure SetServiceName(const sName: MyString);
    procedure SetSingleton(isSingleton: Boolean);
    procedure SetVersion(const ver: MyString);
  end;


  IPluginInfo = interface(IInterface)
    [PLUGIN_INFO_ID]
    function AppendServiceInfo(const sid: MyString): IServiceInfo;
    function GetAuthor: MyString;
    function GetComment: MyString;
    function GetDllName: MyString;
    function GetPluginID: MyString;
    function GetPluginLoader: IPluginLoader;
    function GetPluginName: MyString;
    function GetSelfObject: TObject;
    function GetServiceCount: Integer;
    function GetServiceInfo(idx: Integer): IServiceInfo;
    function GetUpdateHistory: MyString;
    function GetVersion: MyString;
    function IsActive: Boolean;
    function IsLoadedThroughConfig: Boolean;
    procedure SetActive(act: Boolean);
    procedure SetAuthor(const author: MyString);
    procedure SetComment(const comment: MyString);
    procedure SetIsLoadedThroughConfig(ltFormCfg: Boolean);
    procedure SetPluginID(const id: MyString);
    procedure SetPluginLoader(const loader: IPluginLoader);
    procedure SetPluginName(const theName: MyString);
    procedure SetReadOnly;
    procedure SetUpdateHistory(const memo: MyString);
    procedure SetVersion(const ver: MyString);
  end;

  IServiceManager = interface(IInterface)
    ['{3EC087DE-1A1A-418F-A058-A28969F7FEA5}']
    function AddServiceQuick(const serviceID, impServiceID: MyString; const func:
        TCreateObjectFunc; active: Boolean = True; isSingleton: Boolean = False;
        isExtendPoint: Boolean = False): Boolean; overload;
    function AddServiceQuick(const serviceID, impServiceID: MyString; const
        serviceClass: TPluginClass=nil; active: Boolean=True; isSingleton:
        Boolean=False; isExtendPoint: Boolean=False): Boolean; overload;
    function Count: Integer;
    function ExistService(const serviceID: MyString): Boolean;
    function GetExtService(const serviceID: MyString; idx: Integer): IInterface;
    function GetExtServiceCount(const serviceID: MyString): Integer;
    function GetExtServiceInfo(const serviceID: MyString; idx: Integer): IServiceInfo;
    function GetSelfObject: TObject;
    function GetService(const serviceID: MyString): IInterface;
    function GetServiceInfo(const serviceID: MyString): IServiceInfo; overload;
    function GetServiceInfo(idx: Integer): IServiceInfo; overload;
    function RegService(const sv: IServiceInfo): Integer;
    function ServiceIsActive(const serviceID: MyString): Boolean;
    function StartService(const serviceID: MyString): Boolean;
    function StopService(const serviceID: MyString): Boolean;
    function UnRegService(const serviceID: MyString): Integer;
  end;

  IPluginLoader = interface(IInterface)
    [PLUGIN_LOADER]
    function DLLGetObject(const serviceID: MyString): IInterface;
    function DLLGetPluginInfo(const im: IPluginInfo): Integer;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager);
    procedure DLLServiceStart(const serviceID: MyString);
    procedure DLLServiceStop(const serviceID: MyString);
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager);
    function GetLoadedPluginFile: MyString;
    function GetSelfObject: TObject;
    function LoadPlugin(const pluginFile: MyString): Integer;
    function UnLoadPlugin: Integer;
  end;

  IPluginManager = interface(IInterface)
    [PLUGIN_MANAGER_ID]
    function CfgLoadPluginByPluginID(const pluginID: MyString): Integer;
    function CfgLoadPluginByServiceID(const serviceID: MyString): Integer;
    function CfgReLoadPlugins: Integer;
    function GetPluginInfoByIndex(idx: Integer): IPluginInfo;
    function GetPluginInfoByPluginID(const pluginID: MyString): IPluginInfo;
    function GetPluginsCount: Integer;
    function GetSelfObject: TObject;
    function LoadPluginDirect(const pluginFile: MyString; const useLoader:
        MyString=''): Integer;
    function SetPluginActiveByIndex(idx: Integer): Integer;
    function SetPluginActiveByPluginID(const pluginID: MyString): Integer;
    function SetPluginDeActiveByIndex(idx: Integer): Integer;
    function SetPluginDeActiveByPluginID(const pluginID: MyString): Integer;
    function UnLoadPluginByIndex(idx: Integer): Integer;
    function UnLoadPluginByPluginID(const pluginID: MyString): Integer;
    function UpdatePluginDirect(const pluginFile: MyString; const useLoader:
        MyString=''): Integer;
  end;

  INotifyClient = interface(IInterface)
    ['{5A580F9A-8657-497A-8629-AC1CC49C5CF4}']
    procedure Update(const sender: Pointer; flag: Integer; const msg: MyString;
        const data: Pointer);
  end;

  IConfig = interface(IInterface)
    [CONFIG_ID]
    procedure AddExtendPoint(const sv: IServiceInfo);
    procedure AddPlugin(const dllFile: MyString);
    procedure AddService(const sv: IServiceInfo);
    procedure DisableExtendPoint(const sid: MyString);
    procedure DisablePlugin(const pid: MyString);
    procedure DisableService(const serviceID: MyString);
    procedure EnabledExtendPoint(const sid: MyString);
    procedure EnabledPlugin(const pid: MyString);
    procedure EnabledService(const serviceID: MyString);
    function ExistExtPoint(const sid: MyString): Boolean;
    function ExistPlugin(const pid: MyString): Boolean;
    function ExistService(const sid: MyString): Boolean;
    function ExtPointIsDisable(const sid: MyString): Boolean;
    function GetExtImpServiceCount(const extSid: MyString): Integer;
    function GetExtImpServiceID(const extSid: MyString; idx: Integer): MyString;
    function GetPluginCount: Integer;
    function GetPluginLoaderID(const pid: MyString): MyString;
    function GetPluginLoadState(const pid: MyString): MyString;
    procedure Open(const xmlFile: MyString);
    function PluginDLL(const pid: MyString): MyString;
    function PluginIDFromExtSid(const extSID: MyString): MyString;
    function PluginIDFromIdx(idx: Integer): MyString;
    function PluginIDFromSid(const sid: MyString): MyString;
    function PluginIsDisable(const pid: MyString): Boolean;
    procedure Reload;
    procedure RemoveExtendPoint(const sid: MyString);
    procedure RemovePlugin(const pid: MyString);
    procedure RemoveService(const serviceID: MyString);
    procedure Save;
    function ServiceIsDisable(const sid: MyString): Boolean;
    function ServiceIsSingleton(const sid: MyString): Boolean;
    procedure SetExtendPointSingleton(const sid: MyString; setSingleton: Boolean);
    procedure SetPluginLoaderID(const pid, lid: MyString);
    procedure SetPluginLoadState(const pid, state: MyString);
    procedure SetServiceSingleton(const serviceID: MyString; setSingleton:
        Boolean);
  end;

  ICommunicateManager = interface(IInterface)
    ['{DEF67732-DCB6-463F-AB49-CFC3E02EF57F}']
    procedure Broadcast(const sender: Pointer; flag: Integer; const msg: MyString;
        const data: Pointer);
    procedure Notify(const sender: Pointer; flag: Integer; const msg: MyString;
        const data: Pointer);
    procedure RegNotifyClient(const serviceID: MyString; const client:
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
  {$IFDEF IDE_XE4up}
  Result := TInterlocked.Decrement(FRefCount);
  {$ELSE}
  Result := InterlockedDecrement(FRefCount);
  {$ENDIF}
  if not FObjFree then //如果由对象来释放，引用计数器到0时不调用Destroy
    if Result = 0 then
      Destroy;
end;

end.
