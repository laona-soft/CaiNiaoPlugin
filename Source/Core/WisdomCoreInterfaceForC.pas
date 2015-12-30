{*******************************************************}
{                                                       }
{       WisdomPluginFramework                           }
{       2014 IceAir                                     }
{       ice.air@126.com  QQ: 3216343                    }
{                                                       }
{*******************************************************}

//////////////////////////////////////////////////////////////////
//                        使用说明                              //
//   你可以自由复制、分发、使用、扩展本框架代码，但各单元中需   //
//   保留作者大名，如果你有好的修改，请反馈作者，以便作者整合   //
//   后为大家提供更尽善尽美的开发框架。                         //
//                                                              //
//   本框架命名Wisdom，实期望能合集众人之能量，闪耀智慧之光芒   //
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

unit WisdomCoreInterfaceForC;

{$INCLUDE Def.inc}

interface

uses
  {$IFDEF IDE_XE4up}
     System.SyncObjs;
  {$ELSE}
     Windows;
  {$ENDIF}

const
  VER = '1.5';
  PLUGIN_MANAGER_ID = '{D647EB39-65A8-48F4-AC6B-995B624CC825}';
  CONFIG_ID = '{B95F4304-B45E-4285-A2EC-FAD1A483541F}';
  SERVICE_INFO_ID = '{983679B1-A622-4AC3-9749-0B170C025ED6}';
  PLUGIN_INFO_ID = '{B152682C-319C-4F13-B6B8-646D7F915FAF}';
  PLUGIN_LOADER = '{362F7327-068C-4152-8EE1-EFDB6A7A2001}';
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

  IPluginInfo = interface;
  IServiceInfo = interface;
  IServiceManager = interface;
  IPluginLoader = interface;
  IPluginManager = interface;
  IConfig = interface;

  IPluginInfoForC = IPluginInfo;
  IServiceInfoForC = IServiceInfo;
  IServiceManagerForC = IServiceManager;
  IPluginLoaderForC = IPluginLoader;
  IPluginManagerForC = IPluginManager;
  IConfigForC = IConfig;

  TCreateObjectFunc = function (const serviceM: IServiceManagerForC; sv: IServiceInfoForC): IInterface; stdcall;
  TCreateObjectFunc2 = TCreateObjectFunc;
  IServiceInfo = interface(IInterface)
    [SERVICE_INFO_ID]
    procedure AddExtendPointImpService(const service: IServiceInfoForC); stdcall;
    function GetAuthor: PMyChar; stdcall;
    //function GetBelongToPlugin: IPluginInfo; stdcall;
    procedure GetBelongToPlugin(out intf: IPluginInfoForC) stdcall;
    function GetComment: PMyChar; stdcall;
    function GetCreateObjectFunc: TCreateObjectFunc; stdcall;
    //function GetExtendPointImpService(idx: Integer): IServiceInfo; stdcall;
    procedure GetExtendPointImpService(idx: Integer; out intf: IServiceInfoForC);stdcall;
    function GetExtendPointImpServiceCount: Integer; stdcall;
    function GetImplementServiceID: PMyChar; stdcall;
    function GetServiceID: PMyChar; stdcall;
    //function GetServiceIntf: IInterface; stdcall;
    procedure  GetServiceIntf(out intf: IInterface);stdcall;
    function GetServiceName: PMyChar; stdcall;
    function GetVersion: PMyChar; stdcall;
    function IsActive: Boolean; stdcall;
    function IsExtendPoint: Boolean; stdcall;
    function IsSingleton: Boolean; stdcall;
    procedure RemoveExtendPointImpService(const sid: PMyChar); stdcall;
    procedure SetActive(act: Boolean); stdcall;
    procedure SetAuthor(const author: PMyChar); stdcall;
    procedure SetBelongToPlugin(const ipf: IPluginInfoForC); stdcall;
    procedure SetComment(const comment: PMyChar); stdcall;
    procedure SetCreateObjectFunc(const func: TCreateObjectFunc2); stdcall;
    procedure SetImplementServiceID(const impID: PMyChar); stdcall;
    procedure SetIsExtendPoint(isExtPoint: Boolean); stdcall;
    procedure SetReadOnly; stdcall;
    procedure SetServiceID(const id: PMyChar); stdcall;
    procedure SetServiceIntf(const sv: IInterface); stdcall;
    procedure SetServiceName(const sName: PMyChar); stdcall;
    procedure SetSingleton(isSingleton: Boolean); stdcall;
    procedure SetVersion(const ver: PMyChar); stdcall;
  end;

  IPluginInfo = interface(IInterface)
    [PLUGIN_INFO_ID]
    //function AppendServiceInfo(const sid: PMyChar): IServiceInfoForC; stdcall;
    procedure AppendServiceInfo(const sid: PMyChar; out intf: IServiceInfoForC) stdcall;
    function GetAuthor: PMyChar; stdcall;
    function GetComment: PMyChar; stdcall;
    function GetDllName: PMyChar; stdcall;
    function GetPluginID: PMyChar; stdcall;
    //function GetPluginLoader: IPluginLoader; stdcall;
    procedure GetPluginLoader(out intf: IPluginLoaderForC); stdcall;
    function GetPluginName: PMyChar; stdcall;
    function GetServiceCount: Integer; stdcall;
    //function GetServiceInfo(idx: Integer): IServiceInfoForC; stdcall;
    procedure GetServiceInfo(idx: Integer; out intf: IServiceInfoForC); stdcall;
    function GetUpdateHistory: PMyChar; stdcall;
    function GetVersion: PMyChar; stdcall;
    function IsActive: Boolean; stdcall;
    function IsLoadedThroughConfig: Boolean; stdcall;
    procedure SetActive(act: Boolean); stdcall;
    procedure SetAuthor(const author: PMyChar); stdcall;
    procedure SetComment(const comment: PMyChar); stdcall;
    procedure SetIsLoadedThroughConfig(ltFormCfg: Boolean); stdcall;
    procedure SetPluginID(const id: PMyChar); stdcall;
    procedure SetPluginLoader(const loader: IPluginLoaderForC); stdcall;
    procedure SetPluginName(const theName: PMyChar); stdcall;
    procedure SetReadOnly; stdcall;
    procedure SetUpdateHistory(const memo: PMyChar); stdcall;
    procedure SetVersion(const ver: PMyChar); stdcall;
  end;

  IServiceManager = interface(IInterface)
    ['{7A009246-485E-4C48-B56B-A78CBF053AA4}']
    function AddServiceQuick(const serviceID, impServiceID: PMyChar; const func:
        TCreateObjectFunc2; active: Boolean = True; isSingleton: Boolean =
        False; isExtendPoint: Boolean = False): Boolean; stdcall;
    function Count: Integer; stdcall;
    function ExistService(const serviceID: PMyChar): Boolean; stdcall;
    //function GetExtService(const serviceID: PMyChar; idx: Integer):
    //    IInterface; stdcall;
    procedure GetExtService(const serviceID: PMyChar; idx: Integer; out intf: IInterface); stdcall;
    function GetExtServiceCount(const serviceID: PMyChar): Integer; stdcall;
    procedure GetExtServiceInfo(const serviceID: PMyChar; idx: Integer; out intf: IServiceInfoForC); stdcall;
    //function GetService(const serviceID: PMyChar): IInterface; stdcall;
    procedure GetService(const serviceID: PMyChar; out intf: IInterface); stdcall;
    //function GetServiceInfo(const serviceID: PMyChar): IServiceInfoForC;stdcall;
    procedure GetServiceInfoByID(const serviceID: PMyChar; out intf: IServiceInfoForC);stdcall;
    procedure GetServiceInfoByIndex(idx: Integer; out intf: IServiceInfoForC); stdcall;
    function RegService(const sv: IServiceInfoForC): Integer; stdcall;
    function ServiceIsActive(const serviceID: PMyChar): Boolean; stdcall;
    function StartService(const serviceID: PMyChar): Boolean; stdcall;
    function StopService(const serviceID: PMyChar): Boolean; stdcall;
    function UnRegService(const serviceID: PMyChar): Integer; stdcall;
  end;

  IPluginLoader = interface(IInterface)
    [PLUGIN_LOADER]
    //function DLLGetObject(const serviceID: PMyChar): IInterface; stdcall;
    procedure DLLGetObject(const serviceID: PMyChar; out intf: IInterface); stdcall;
    function DLLGetPluginInfo(const im: IPluginInfoForC): Integer; stdcall;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
    procedure DLLServiceStart(const serviceID: PMyChar); stdcall;
    procedure DLLServiceStop(const serviceID: PMyChar); stdcall;
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager);stdcall;
    function GetLoadedPluginFile: PMyChar; stdcall;
    function LoadPlugin(const pluginFile: PMyChar): Integer; stdcall;
    function UnLoadPlugin: Integer; stdcall;
  end;

  IPluginManager = interface(IInterface)
    [PLUGIN_MANAGER_ID]
    function CfgLoadPluginByPluginID(const pluginID: PMyChar): Integer;
        stdcall;
    function CfgLoadPluginByServiceID(const serviceID: PMyChar): Integer;
        stdcall;
    function CfgReLoadPlugins: Integer; stdcall;
    //function GetPluginInfoByIndex(idx: Integer): IPluginInfo; stdcall;
    procedure GetPluginInfoByIndex(idx: Integer; out intf: IPluginInfoForC); stdcall;
    //function GetPluginInfoByPluginID(const pluginID: PMyChar): IPluginInfoForC;stdcall;
    procedure GetPluginInfoByPluginID(const pluginID: PMyChar; out intf: IPluginInfoForC);stdcall;
    function GetPluginsCount: Integer; stdcall;
    function LoadPluginDirect(const pluginFile: PMyChar; const useLoader:
        PMyChar=nil): Integer; stdcall;
    function SetPluginActiveByIndex(idx: Integer): Integer; stdcall;
    function SetPluginActiveByPluginID(const pluginID: PMyChar): Integer;
        stdcall;
    function SetPluginDeActiveByIndex(idx: Integer): Integer; stdcall;
    function SetPluginDeActiveByPluginID(const pluginID: PMyChar): Integer;
        stdcall;
    function UnLoadPluginByIndex(idx: Integer): Integer; stdcall;
    function UnLoadPluginByPluginID(const pluginID: PMyChar): Integer;
        stdcall;
    function UpdatePluginDirect(const pluginFile: PMyChar; const useLoader:
        PMyChar=nil): Integer; stdcall;
  end;

  IConfig = interface(IInterface)
    [CONFIG_ID]
    procedure AddExtendPoint(const sv: IServiceInfo); stdcall;
    procedure AddPlugin(const dllFile: PMyChar); stdcall;
    procedure AddService(const sv: IServiceInfo); stdcall;
    procedure DisableExtendPoint(const sid: PMyChar); stdcall;
    procedure DisablePlugin(const pid: PMyChar); stdcall;
    procedure DisableService(const serviceID: PMyChar); stdcall;
    procedure EnabledExtendPoint(const sid: PMyChar); stdcall;
    procedure EnabledPlugin(const pid: PMyChar); stdcall;
    procedure EnabledService(const serviceID: PMyChar); stdcall;
    function ExistExtPoint(const sid: PMyChar): Boolean; stdcall;
    function ExistPlugin(const pid: PMyChar): Boolean; stdcall;
    function ExistService(const sid: PMyChar): Boolean; stdcall;
    function ExtPointIsDisable(const sid: PMyChar): Boolean; stdcall;
    function GetExtImpServiceCount(const extSid: PMyChar): Integer; stdcall;
    function GetExtImpServiceID(const extSid: PMyChar; idx: Integer):
        PMyChar; stdcall;
    function GetPluginCount: Integer; stdcall;
    function GetPluginLoaderID(const pid: PMyChar): PMyChar; stdcall;
    function GetPluginLoadState(const pid: PMyChar): PMyChar; stdcall;
    procedure Open(const xmlFile: PMyChar); stdcall;
    function PluginDLL(const pid: PMyChar): PMyChar; stdcall;
    function PluginIDFromExtSid(const extSID: PMyChar): PMyChar; stdcall;
    function PluginIDFromIdx(idx: Integer): PMyChar; stdcall;
    function PluginIDFromSid(const sid: PMyChar): PMyChar; stdcall;
    function PluginIsDisable(const pid: PMyChar): Boolean; stdcall;
    procedure Reload; stdcall;
    procedure RemoveExtendPoint(const sid: PMyChar); stdcall;
    procedure RemovePlugin(const pid: PMyChar); stdcall;
    procedure RemoveService(const serviceID: PMyChar); stdcall;
    procedure Save; stdcall;
    function ServiceIsDisable(const sid: PMyChar): Boolean; stdcall;
    function ServiceIsSingleton(const sid: PMyChar): Boolean; stdcall;
    procedure SetExtendPointSingleton(const sid: PMyChar; setSingleton:
        Boolean); stdcall;
    procedure SetPluginLoaderID(const pid, lid: PMyChar); stdcall;
    procedure SetPluginLoadState(const pid, state: PMyChar); stdcall;
    procedure SetServiceSingleton(const serviceID: PMyChar; setSingleton:
        Boolean); stdcall;
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
