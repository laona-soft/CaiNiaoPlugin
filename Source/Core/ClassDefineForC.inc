  TServiceInfo = class(TPluginInterfacedObject, IServiceInfo, IServiceInfoForC)
  protected
    FAuthor: MyString;
    FBelongToPlugin: ^IPluginInfo;
    FComment: MyString;
    FCreateObjFunc: TCreateObjectFunc;
    FExtServiceList: THashedStringList;
    FImpServiceID: MyString;
    FIsActive: Boolean;
    FIsExtendPoint: Boolean;
    FIsSingleton: Boolean;
    FReadOnly: Boolean;
    FServiceClass: TPluginClass;
    FServiceIntf: IInterface;
    FServiceName: MyString;
    Fsid: MyString;
    FVersion: MyString;
  public
    procedure IServiceInfoForC.AddExtendPointImpService =
        AddExtendPointImpService2;
    function IServiceInfoForC.GetAuthor = GetAuthor2;
    //function IServiceInfoForC.GetBelongToPlugin = GetBelongToPlugin2;
    procedure IServiceInfoForC.GetBelongToPlugin = GetBelongToPlugin2;
    function IServiceInfoForC.GetComment = GetComment2;
    function IServiceInfoForC.GetCreateObjectFunc = GetCreateObjectFunc2;
    //function IServiceInfoForC.GetExtendPointImpService = GetExtendPointImpService2;
    procedure IServiceInfoForC.GetExtendPointImpService = GetExtendPointImpService2;
    function IServiceInfoForC.GetExtendPointImpServiceCount = GetExtendPointImpServiceCount2;
    function IServiceInfoForC.GetImplementServiceID = GetImplementServiceID2;
    function IServiceInfoForC.GetServiceID = GetServiceID2;
    //function IServiceInfoForC.GetServiceIntf = GetServiceIntf2;
    procedure IServiceInfoForC.GetServiceIntf = GetServiceIntf2;
    function IServiceInfoForC.GetServiceName = GetServiceName2;
    function IServiceInfoForC.GetVersion = GetVersion2;
    function IServiceInfoForC.IsActive = IsActive2;
    function IServiceInfoForC.IsExtendPoint = IsExtendPoint2;
    function IServiceInfoForC.IsSingleton = IsSingleton2;
    procedure IServiceInfoForC.RemoveExtendPointImpService =
        RemoveExtendPointImpService2;
    procedure IServiceInfoForC.SetActive = SetActive2;
    procedure IServiceInfoForC.SetAuthor = SetAuthor2;
    procedure IServiceInfoForC.SetBelongToPlugin = SetBelongToPlugin2;
    procedure IServiceInfoForC.SetComment = SetComment2;
    procedure IServiceInfoForC.SetCreateObjectFunc = SetCreateObjectFunc2;
    procedure IServiceInfoForC.SetImplementServiceID = SetImplementServiceID2;
    procedure IServiceInfoForC.SetIsExtendPoint = SetIsExtendPoint2;
    procedure IServiceInfoForC.SetReadOnly = SetReadOnly2;
    procedure IServiceInfoForC.SetServiceID = SetServiceID2;
    procedure IServiceInfoForC.SetServiceIntf = SetServiceIntf2;
    procedure IServiceInfoForC.SetServiceName = SetServiceName2;
    procedure IServiceInfoForC.SetSingleton = SetSingleton2;
    procedure IServiceInfoForC.SetVersion = SetVersion2;
    constructor Create; override;
    destructor Destroy; override;
    procedure AddExtendPointImpService(const service: IServiceInfo); virtual;
    procedure AddExtendPointImpService2(const service: IServiceInfoForC); virtual;
        stdcall;
    function GetAuthor: MyString; virtual;
    function GetAuthor2: PMyChar; virtual; stdcall; 
    function GetBelongToPlugin: IPluginInfo; virtual;
    //function GetBelongToPlugin2: IPluginInfoForC; stdcall;
    procedure GetBelongToPlugin2(out intf: IPluginInfoForC); virtual; stdcall;
    function GetComment: MyString; virtual;
    function GetComment2: PMyChar; virtual; stdcall; 
    function GetCreateObjectFunc: TCreateObjectFunc; virtual;
    function GetCreateObjectFunc2: TCreateObjectFunc2; virtual; stdcall; 
    function GetExtendPointImpService(idx: Integer): IServiceInfo; virtual;
    //function GetExtendPointImpService2(idx: Integer): IServiceInfoForC; stdcall;
    procedure GetExtendPointImpService2(idx: Integer; out intf: IServiceInfoForC); virtual; stdcall;
    function GetExtendPointImpServiceCount: Integer; virtual;
    function GetExtendPointImpServiceCount2: Integer; virtual; stdcall; 
    function GetImplementServiceID: MyString; virtual;
    function GetImplementServiceID2: PMyChar; virtual; stdcall; 
    function GetSelfObject: TObject; virtual;
    function GetServiceClass: TPluginClass; virtual;
    function GetServiceID: MyString; virtual;
    function GetServiceID2: PMyChar; virtual; stdcall; 
    function GetServiceIntf: IInterface; virtual;
    //function GetServiceIntf2: IInterface; stdcall;
    procedure  GetServiceIntf2(out intf: IInterface); virtual; stdcall;
    function GetServiceName: MyString; virtual;
    function GetServiceName2: PMyChar; virtual; stdcall; 
    function GetVersion: MyString; virtual;
    function GetVersion2: PMyChar; virtual; stdcall; 
    function IsActive: Boolean; virtual;
    function IsActive2: Boolean; virtual; stdcall; 
    function IsExtendPoint: Boolean; virtual;
    function IsExtendPoint2: Boolean; virtual; stdcall; 
    function IsSingleton: Boolean; virtual;
    function IsSingleton2: Boolean; virtual; stdcall; 
    procedure RemoveExtendPointImpService(const sid: MyString); virtual;
    procedure RemoveExtendPointImpService2(const sid: PMyChar); virtual; stdcall; 
    procedure SetActive(act: Boolean); virtual;
    procedure SetActive2(act: Boolean); virtual; stdcall; 
    procedure SetAuthor(const author: MyString); virtual;
    procedure SetAuthor2(const author: PMyChar); virtual; stdcall; 
    procedure SetBelongToPlugin(const ipf: IPluginInfo); virtual;
    procedure SetBelongToPlugin2(const ipf: IPluginInfoForC); virtual; stdcall; 
    procedure SetComment(const comment: MyString); virtual;
    procedure SetComment2(const comment: PMyChar); virtual; stdcall; 
    procedure SetCreateObjectFunc(const func: TCreateObjectFunc); virtual;
    procedure SetCreateObjectFunc2(const func: TCreateObjectFunc2); virtual; stdcall; 
    procedure SetImplementServiceID(const impID: MyString); virtual;
    procedure SetImplementServiceID2(const impID: PMyChar); virtual; stdcall; 
    procedure SetIsExtendPoint(isExtPoint: Boolean); virtual;
    procedure SetIsExtendPoint2(isExtPoint: Boolean); virtual; stdcall; 
    procedure SetReadOnly; virtual;
    procedure SetReadOnly2; virtual; stdcall; 
    procedure SetServiceClass(const intClass: TPluginClass); virtual;
    procedure SetServiceID(const id: MyString); virtual;
    procedure SetServiceID2(const id: PMyChar); virtual; stdcall; 
    procedure SetServiceIntf(const sv: IInterface); virtual;
    procedure SetServiceIntf2(const sv: IInterface); virtual; stdcall; 
    procedure SetServiceName(const sName: MyString); virtual;
    procedure SetServiceName2(const sName: PMyChar); virtual; stdcall; 
    procedure SetSingleton(isSingleton: Boolean); virtual;
    procedure SetSingleton2(isSingleton: Boolean); virtual; stdcall; 
    procedure SetVersion(const ver: MyString); virtual;
    procedure SetVersion2(const ver: PMyChar); virtual; stdcall; 
  end;

  TPluginInfo = class(TPluginInterfacedObject, IPluginInfo, IPluginInfoForC)
  protected
    FActived: Boolean;
    FAuthor: MyString;
    FComment: MyString;
    FLoadedThroughConfig: Boolean;
    FPluginID: MyString;
    FPluginLoader: IPluginLoader;
    FPluginName: MyString;
    FReadOnly: Boolean;
    FServiceList: THashedStringList;
    FUpdateHistory: MyString;
    FVersion: MyString;
  public
    //function IPluginInfoForC.AppendServiceInfo = AppendServiceInfo2;
    procedure IPluginInfoForC.AppendServiceInfo = AppendServiceInfo2;
    function IPluginInfoForC.GetAuthor = GetAuthor2;
    function IPluginInfoForC.GetComment = GetComment2;
    function IPluginInfoForC.GetDllName = GetDllName2;
    function IPluginInfoForC.GetPluginID = GetPluginID2;
    //function IPluginInfoForC.GetPluginLoader = GetPluginLoader2;
    procedure IPluginInfoForC.GetPluginLoader = GetPluginLoader2;
    function IPluginInfoForC.GetPluginName = GetPluginName2;
    function IPluginInfoForC.GetServiceCount = GetServiceCount2;
    //function IPluginInfoForC.GetServiceInfo = GetServiceInfo2;
    procedure IPluginInfoForC.GetServiceInfo = GetServiceInfo2;
    function IPluginInfoForC.GetUpdateHistory = GetUpdateHistory2;
    function IPluginInfoForC.GetVersion = GetVersion2;
    function IPluginInfoForC.IsActive = IsActive2;
    function IPluginInfoForC.IsLoadedThroughConfig = IsLoadedThroughConfig2;
    procedure IPluginInfoForC.SetActive = SetActive2;
    procedure IPluginInfoForC.SetAuthor = SetAuthor2;
    procedure IPluginInfoForC.SetComment = SetComment2;
    procedure IPluginInfoForC.SetIsLoadedThroughConfig =
        SetIsLoadedThroughConfig2;
    procedure IPluginInfoForC.SetPluginID = SetPluginID2;
    procedure IPluginInfoForC.SetPluginLoader = SetPluginLoader2;
    procedure IPluginInfoForC.SetPluginName = SetPluginName2;
    procedure IPluginInfoForC.SetReadOnly = SetReadOnly2;
    procedure IPluginInfoForC.SetUpdateHistory = SetUpdateHistory2;
    procedure IPluginInfoForC.SetVersion = SetVersion2;
    constructor Create; override;
    destructor Destroy; override;
    function AppendServiceInfo(const sid: MyString): IServiceInfo; virtual;
    //function AppendServiceInfo2(const sid: PMyChar): IServiceInfoForC;stdcall;
    procedure AppendServiceInfo2(const sid: PMyChar; out intf: IServiceInfoForC); virtual; stdcall; 
    function GetAuthor: MyString; virtual;
    function GetAuthor2: PMyChar; virtual; stdcall; 
    function GetComment: MyString; virtual;
    function GetComment2: PMyChar; virtual; stdcall; 
    function GetDllName: MyString; virtual;
    function GetDllName2: PMyChar; virtual; stdcall; 
    function GetPluginID: MyString; virtual;
    function GetPluginID2: PMyChar; virtual; stdcall; 
    function GetPluginLoader: IPluginLoader; virtual;
    //function GetPluginLoader2: IPluginLoaderForC; stdcall;
    procedure GetPluginLoader2(out intf: IPluginLoaderForC); virtual; stdcall; 
    function GetPluginName: MyString; virtual;
    function GetPluginName2: PMyChar; virtual; stdcall; 
    function GetSelfObject: TObject; virtual;
    function GetServiceCount: Integer; virtual;
    function GetServiceCount2: Integer; virtual; stdcall; 
    function GetServiceInfo(idx: Integer): IServiceInfo; virtual;
    //function GetServiceInfo2(idx: Integer): IServiceInfoForC; stdcall;
    procedure GetServiceInfo2(idx: Integer; out intf: IServiceInfoForC); virtual; stdcall; 
    function GetUpdateHistory: MyString; virtual;
    function GetUpdateHistory2: PMyChar; virtual; stdcall; 
    function GetVersion: MyString; virtual;
    function GetVersion2: PMyChar; virtual; stdcall; 
    function IsActive: Boolean; virtual;
    function IsActive2: Boolean; virtual; stdcall; 
    function IsLoadedThroughConfig: Boolean; virtual;
    function IsLoadedThroughConfig2: Boolean; virtual; stdcall; 
    procedure SetActive(act: Boolean); virtual;
    procedure SetActive2(act: Boolean); virtual; stdcall; 
    procedure SetAuthor(const author: MyString); virtual;
    procedure SetAuthor2(const author: PMyChar); virtual; stdcall; 
    procedure SetComment(const comment: MyString); virtual;
    procedure SetComment2(const comment: PMyChar); virtual; stdcall; 
    procedure SetIsLoadedThroughConfig(ltFormCfg: Boolean); virtual;
    procedure SetIsLoadedThroughConfig2(ltFormCfg: Boolean); virtual; stdcall; 
    procedure SetPluginID(const id: MyString); virtual;
    procedure SetPluginID2(const id: PMyChar); virtual; stdcall; 
    procedure SetPluginLoader(const loader: IPluginLoader); virtual;
    procedure SetPluginLoader2(const loader: IPluginLoaderForC); virtual; stdcall; 
    procedure SetPluginName(const theName: MyString); virtual;
    procedure SetPluginName2(const theName: PMyChar); virtual; stdcall; 
    procedure SetReadOnly; virtual;
    procedure SetReadOnly2; virtual; stdcall; 
    procedure SetUpdateHistory(const memo: MyString); virtual;
    procedure SetUpdateHistory2(const memo: PMyChar); virtual; stdcall; 
    procedure SetVersion(const ver: MyString); virtual;
    procedure SetVersion2(const ver: PMyChar); virtual; stdcall; 
  end;

  TPluginLoader = class(TPluginInterfacedObject, IPluginLoader,
      IPluginLoaderForC)
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

  TPluginManager = class(TPluginInterfacedObject, IPluginManager, IPluginManagerForC)
  protected
    FPluginList: THashedStringList;
  public
    function IPluginManagerForC.CfgLoadPluginByPluginID =
        CfgLoadPluginByPluginID2;
    function IPluginManagerForC.CfgLoadPluginByServiceID =
        CfgLoadPluginByServiceID2;
    function IPluginManagerForC.CfgReLoadPlugins = CfgReLoadPlugins2;
    //function IPluginManagerForC.GetPluginInfoByIndex = GetPluginInfoByIndex2;
    procedure IPluginManagerForC.GetPluginInfoByIndex = GetPluginInfoByIndex2;
    //function IPluginManagerForC.GetPluginInfoByPluginID = GetPluginInfoByPluginID2;
    procedure IPluginManagerForC.GetPluginInfoByPluginID = GetPluginInfoByPluginID2;
    function IPluginManagerForC.GetPluginsCount = GetPluginsCount2;
    function IPluginManagerForC.LoadPluginDirect = LoadPluginDirect2;
    function IPluginManagerForC.SetPluginActiveByIndex =
        SetPluginActiveByIndex2;
    function IPluginManagerForC.SetPluginActiveByPluginID =
        SetPluginActiveByPluginID2;
    function IPluginManagerForC.SetPluginDeActiveByIndex =
        SetPluginDeActiveByIndex2;
    function IPluginManagerForC.SetPluginDeActiveByPluginID =
        SetPluginDeActiveByPluginID2;
    function IPluginManagerForC.UnLoadPluginByIndex = UnLoadPluginByIndex2;
    function IPluginManagerForC.UnLoadPluginByPluginID =
        UnLoadPluginByPluginID2;
    function IPluginManagerForC.UpdatePluginDirect = UpdatePluginDirect2;
    constructor Create; override;
    destructor Destroy; override;
    function CfgLoadPluginByPluginID(const pluginID: MyString): Integer; virtual;
    function CfgLoadPluginByPluginID2(const pluginID: PMyChar): Integer;
        virtual; stdcall; 
    function CfgLoadPluginByServiceID(const serviceID: MyString): Integer; virtual;
    function CfgLoadPluginByServiceID2(const serviceID: PMyChar): Integer;
        virtual; stdcall; 
    function CfgReLoadPlugins: Integer; virtual;
    function CfgReLoadPlugins2: Integer; virtual; stdcall; 
    function GetPluginInfoByIndex(idx: Integer): IPluginInfo; virtual;
    //function GetPluginInfoByIndex2(idx: Integer): IPluginInfoForC; stdcall;
    procedure GetPluginInfoByIndex2(idx: Integer; out intf: IPluginInfoForC); virtual; stdcall; 
    function GetPluginInfoByPluginID(const pluginID: MyString): IPluginInfo; virtual;
    //function GetPluginInfoByPluginID2(const pluginID: PMyChar): IPluginInfoForC; stdcall;
    procedure GetPluginInfoByPluginID2(const pluginID: PMyChar; out intf: IPluginInfoForC); virtual; stdcall; 
    function GetPluginsCount: Integer; virtual;
    function GetPluginsCount2: Integer; virtual; stdcall; 
    function GetSelfObject: TObject; virtual;
    function LoadPluginDirect(const pluginFile: MyString; const useLoader:
        MyString=''): Integer; virtual;
    function LoadPluginDirect2(const pluginFile: PMyChar; const useLoader:
        PMyChar=nil): Integer; virtual; stdcall; 
    function SetPluginActiveByIndex(idx: Integer): Integer; virtual;
    function SetPluginActiveByIndex2(idx: Integer): Integer; virtual; stdcall; 
    function SetPluginActiveByPluginID(const pluginID: MyString): Integer; virtual;
    function SetPluginActiveByPluginID2(const pluginID: PMyChar): Integer;
        virtual; stdcall; 
    function SetPluginDeActiveByIndex(idx: Integer): Integer; virtual;
    function SetPluginDeActiveByIndex2(idx: Integer): Integer; virtual; stdcall; 
    function SetPluginDeActiveByPluginID(const pluginID: MyString): Integer; virtual;
    function SetPluginDeActiveByPluginID2(const pluginID: PMyChar): Integer;
        virtual; stdcall; 
    function UnLoadPluginByIndex(idx: Integer): Integer; virtual;
    function UnLoadPluginByIndex2(idx: Integer): Integer; virtual; stdcall; 
    function UnLoadPluginByPluginID(const pluginID: MyString): Integer; virtual;
    function UnLoadPluginByPluginID2(const pluginID: PMyChar): Integer;
        virtual; stdcall; 
    function UpdatePluginDirect(const pluginFile: MyString; const useLoader:
        MyString=''): Integer; virtual;
    function UpdatePluginDirect2(const pluginFile: PMyChar; const
        useLoader:PMyChar=nil): Integer; virtual; stdcall; 
  end;

  TServiceManager = class(TPluginInterfacedObject, IServiceManager,
      IServiceManagerForC)
  protected
    FServiceList: THashedStringList;
    function GetServiceIdx(const serviceID: MyString): Integer;
    function RegExtService(const sv: IServiceInfo): Integer;
  public
    function IServiceManagerForC.AddServiceQuick = AddServiceQuick2;
    function IServiceManagerForC.Count = Count2;
    function IServiceManagerForC.ExistService = ExistService2;
    //function IServiceManagerForC.GetExtService = GetExtService2;
    procedure IServiceManagerForC.GetExtService = GetExtService2;
    function IServiceManagerForC.GetExtServiceCount = GetExtServiceCount2;
    procedure IServiceManagerForC.GetExtServiceInfo = GetExtServiceInfo2;
    //function IServiceManagerForC.GetService = GetService2;
    procedure IServiceManagerForC.GetService = GetService2;
    //function IServiceManagerForC.GetServiceInfo = GetServiceInfo2;
    procedure IServiceManagerForC.GetServiceInfoByID = GetServiceInfoByID2;
    procedure IServiceManagerForC.GetServiceInfoByIndex = GetServiceInfoByIndex2;
    function IServiceManagerForC.RegService = RegService2;
    function IServiceManagerForC.ServiceIsActive = ServiceIsActive2;
    function IServiceManagerForC.StartService = StartService2;
    function IServiceManagerForC.StopService = StopService2;
    function IServiceManagerForC.UnRegService = UnRegService2;
    constructor Create; override;
    destructor Destroy; override;
    function AddServiceQuick(const serviceID, impServiceID: MyString; const func:
        TCreateObjectFunc; active: Boolean = True; isSingleton: Boolean = False;
        isExtendPoint: Boolean = False): Boolean; overload; virtual;
    function AddServiceQuick(const serviceID, impServiceID: MyString; const
        serviceClass: TPluginClass=nil; active: Boolean=True; isSingleton:
        Boolean=False; isExtendPoint: Boolean=False): Boolean; overload; virtual;
    function AddServiceQuick2(const serviceID, impServiceID: PMyChar; const
        func: TCreateObjectFunc2; active: Boolean = True; isSingleton: Boolean
        = False; isExtendPoint: Boolean = False): Boolean; virtual; stdcall; 
    function Count: Integer; virtual;
    function Count2: Integer; virtual; stdcall; 
    function ExistService(const serviceID: MyString): Boolean; virtual;
    function ExistService2(const serviceID: PMyChar): Boolean; virtual; stdcall; 
    function GetExtService(const serviceID: MyString; idx: Integer): IInterface; virtual;
    //function GetExtService2(const serviceID: PMyChar; idx: Integer): IInterface; stdcall;
    procedure GetExtService2(const serviceID: PMyChar; idx: Integer; out intf: IInterface); virtual; stdcall; 
    function GetExtServiceCount(const serviceID: MyString): Integer; virtual;
    function GetExtServiceCount2(const serviceID: PMyChar): Integer; virtual; stdcall;
    function GetExtServiceInfo(const serviceID: MyString; idx: Integer): IServiceInfo; virtual;
    procedure GetExtServiceInfo2(const serviceID: PMyChar; idx: Integer; out intf: IServiceInfoForC); virtual; stdcall;
    function GetSelfObject: TObject; virtual;
    function GetService(const serviceID: MyString): IInterface; virtual;
    //function GetService2(const serviceID: PMyChar): IInterface; stdcall;
    procedure GetService2(const serviceID: PMyChar; out intf: IInterface); virtual; stdcall; 
    function GetServiceInfo(const serviceID: MyString): IServiceInfo; overload; virtual;
    //function GetServiceInfo2(const serviceID: PMyChar): IServiceInfoForC; stdcall;
    procedure GetServiceInfoByID2(const serviceID: PMyChar; out intf: IServiceInfoForC); virtual; stdcall;
    function GetServiceInfo(idx: Integer): IServiceInfo; overload; virtual;
    procedure GetServiceInfoByIndex2(idx: Integer; out intf: IServiceInfoForC); virtual; stdcall;
    function RegService(const sv: IServiceInfo): Integer; virtual;
    function RegService2(const sv: IServiceInfoForC): Integer; virtual; stdcall;
    function ServiceIsActive(const serviceID: MyString): Boolean; virtual;
    function ServiceIsActive2(const serviceID: PMyChar): Boolean; virtual; stdcall;
    function StartService(const serviceID: MyString): Boolean; virtual;
    function StartService2(const serviceID: PMyChar): Boolean; virtual; stdcall; 
    function StopService(const serviceID: MyString): Boolean; virtual;
    function StopService2(const serviceID: PMyChar): Boolean; virtual; stdcall; 
    function UnRegService(const serviceID: MyString): Integer; virtual;
    function UnRegService2(const serviceID: PMyChar): Integer; virtual; stdcall;
  end;

