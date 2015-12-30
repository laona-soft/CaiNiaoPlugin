

{
********************************* TServiceInfo *********************************
}
procedure TServiceInfo.AddExtendPointImpService2(const service:
    IServiceInfoForC);
begin
  AddExtendPointImpService(service as IServiceInfo);
end;

function TServiceInfo.GetAuthor2: PMyChar;
begin
  Result := PMyChar(GetAuthor);
end;

{
function TServiceInfo.GetBelongToPlugin2: IPluginInfoForC;
begin
  Result := GetBelongToPlugin as IPluginInfoForC
end;
}

procedure TServiceInfo.GetBelongToPlugin2(out intf: IPluginInfoForC) stdcall;
begin
  intf := GetBelongToPlugin as IPluginInfoForC;
end;

function TServiceInfo.GetComment2: PMyChar;
begin
  Result := PMyChar(GetComment);
end;

function TServiceInfo.GetCreateObjectFunc2: TCreateObjectFunc2;
var
  func: Pointer;
begin
  func := Pointer(GetCreateObjectFunc);
  Result := TCreateObjectFunc2(func);
end;

{
function TServiceInfo.GetExtendPointImpService2(idx: Integer): IServiceInfoForC;
begin
  Result := GetExtendPointImpService(idx) as IServiceInfoForC;
end;
}
procedure TServiceInfo.GetExtendPointImpService2(idx: Integer; out intf: IServiceInfoForC);stdcall;
begin
  intf := GetExtendPointImpService(idx) as IServiceInfoForC;
end;

function TServiceInfo.GetExtendPointImpServiceCount2: Integer;
begin
  Result := GetExtendPointImpServiceCount;
end;

function TServiceInfo.GetImplementServiceID2: PMyChar;
begin
  Result := PMyChar(GetImplementServiceID);
end;

function TServiceInfo.GetServiceID2: PMyChar;
begin
  Result := PMyChar(GetServiceID);
end;

{
function TServiceInfo.GetServiceIntf2: IInterface;
begin
  Result := GetServiceIntf;
end;
}

procedure  TServiceInfo.GetServiceIntf2(out intf: IInterface);stdcall;
begin
  intf := GetServiceIntf;
end;

function TServiceInfo.GetServiceName2: PMyChar;
begin
  Result := PMyChar(GetServiceName);
end;

function TServiceInfo.GetVersion2: PMyChar;
begin
  Result := PMyChar(GetVersion2);
end;

function TServiceInfo.IsActive2: Boolean;
begin
  Result := IsActive;
end;

function TServiceInfo.IsExtendPoint2: Boolean;
begin
  Result := IsExtendPoint;
end;

function TServiceInfo.IsSingleton2: Boolean;
begin
  Result := IsSingleton;
end;

procedure TServiceInfo.RemoveExtendPointImpService2(const sid: PMyChar);
begin
  RemoveExtendPointImpService(sid);
end;

procedure TServiceInfo.SetActive2(act: Boolean);
begin
  SetActive(act);
end;

procedure TServiceInfo.SetAuthor2(const author: PMyChar);
begin
  SetAuthor(author);
end;

procedure TServiceInfo.SetBelongToPlugin2(const ipf: IPluginInfoForC);
begin
  SetBelongToPlugin(ipf as IPluginInfo);
end;

procedure TServiceInfo.SetComment2(const comment: PMyChar);
begin
  SetComment(comment);
end;

procedure TServiceInfo.SetCreateObjectFunc2(const func: TCreateObjectFunc2);
var
  p: Pointer;
  f2: TCreateObjectFunc;
begin
  p := @func;
  f2 := TCreateObjectFunc(p^);
  SetCreateObjectFunc(f2);
end;

procedure TServiceInfo.SetImplementServiceID2(const impID: PMyChar);
begin
  SetImplementServiceID(impID);
end;

procedure TServiceInfo.SetIsExtendPoint2(isExtPoint: Boolean);
begin
  SetIsExtendPoint(isExtPoint);
end;

procedure TServiceInfo.SetReadOnly2;
begin
  SetReadOnly;
end;

procedure TServiceInfo.SetServiceID2(const id: PMyChar);
begin
  SetServiceID(id);
end;

procedure TServiceInfo.SetServiceIntf2(const sv: IInterface);
begin
  SetServiceIntf(sv);
end;

procedure TServiceInfo.SetServiceName2(const sName: PMyChar);
begin
  SetServiceName(sName);
end;

procedure TServiceInfo.SetSingleton2(isSingleton: Boolean);
begin
  SetSingleton(isSingleton);
end;

procedure TServiceInfo.SetVersion2(const ver: PMyChar);
begin
  SetVersion(ver);
end;

{
********************************* TPluginInfo **********************************
}
{
function TPluginInfo.AppendServiceInfo2(const sid: PMyChar): IServiceInfoForC;
begin
  Result := AppendServiceInfo(sid) as IServiceInfoForC;
end;
}
procedure TPluginInfo.AppendServiceInfo2(const sid: PMyChar; out intf: IServiceInfoForC);
begin
  intf := AppendServiceInfo(sid) as IServiceInfoForC;
end;

function TPluginInfo.GetAuthor2: PMyChar;
begin
  Result := PMyChar(GetAuthor);
end;

function TPluginInfo.GetComment2: PMyChar;
begin
  Result := PMyChar(GetComment);
end;

function TPluginInfo.GetDllName2: PMyChar;
begin
  Result := PMyChar(GetDllName);
end;

function TPluginInfo.GetPluginID2: PMyChar;
begin
  Result := PMyChar(GetPluginID);
end;

//function TPluginInfo.GetPluginLoader2: IPluginLoaderForC;
//begin
//  Result := GetPluginLoader as IPluginLoaderForC;
//end;

procedure TPluginInfo.GetPluginLoader2(out intf: IPluginLoaderForC); stdcall;
begin
  intf := GetPluginLoader as IPluginLoaderForC;
end;

function TPluginInfo.GetPluginName2: PMyChar;
begin
  Result := PMyChar(GetPluginName);
end;

function TPluginInfo.GetServiceCount2: Integer;
begin
  Result := GetServiceCount;
end;

//function TPluginInfo.GetServiceInfo2(idx: Integer): IServiceInfoForC;
//begin
//  Result := GetServiceInfo(idx) as IServiceInfoForC;
//end;

procedure TPluginInfo.GetServiceInfo2(idx: Integer; out intf: IServiceInfoForC); stdcall;
begin
  intf := GetServiceInfo(idx) as IServiceInfoForC;
end;

function TPluginInfo.GetUpdateHistory2: PMyChar;
begin
  Result := PMyChar(GetUpdateHistory);
end;

function TPluginInfo.GetVersion2: PMyChar;
begin
  Result := PMyChar(GetVersion);
end;

function TPluginInfo.IsActive2: Boolean;
begin
  Result := IsActive;
end;

function TPluginInfo.IsLoadedThroughConfig2: Boolean;
begin
  Result := IsLoadedThroughConfig;
end;

procedure TPluginInfo.SetActive2(act: Boolean);
begin
  SetActive(act);
end;

procedure TPluginInfo.SetAuthor2(const author: PMyChar);
begin
  SetAuthor(author);
end;

procedure TPluginInfo.SetComment2(const comment: PMyChar);
begin
  SetComment(comment);
end;

procedure TPluginInfo.SetIsLoadedThroughConfig2(ltFormCfg: Boolean);
begin
  SetIsLoadedThroughConfig(ltFormCfg);
end;

procedure TPluginInfo.SetPluginID2(const id: PMyChar);
begin
  SetPluginID(id);
end;

procedure TPluginInfo.SetPluginLoader2(const loader: IPluginLoaderForC);
begin
  SetPluginLoader(loader as IPluginLoader);
end;

procedure TPluginInfo.SetPluginName2(const theName: PMyChar);
begin
  SetPluginName(theName);
end;

procedure TPluginInfo.SetReadOnly2;
begin
  SetReadOnly;
end;

procedure TPluginInfo.SetUpdateHistory2(const memo: PMyChar);
begin
  SetUpdateHistory(memo);
end;

procedure TPluginInfo.SetVersion2(const ver: PMyChar);
begin
  SetVersion(ver);
end;

{
******************************** TPluginLoader *********************************
}
//function TPluginLoader.DLLGetObject2(const serviceID: PMyChar): IInterface;
//begin
//  Result := DLLGetObject(serviceID);
//end;

procedure TPluginLoader.DLLGetObject2(const serviceID: PMyChar; out intf: IInterface);
begin
  intf := DLLGetObject(serviceID);
end;

function TPluginLoader.DLLGetPluginInfo2(const im: IPluginInfoForC): Integer;
begin
  Result := DLLGetPluginInfo(im as IPluginInfo);
end;

procedure TPluginLoader.DLLInitializePlugin2(const IServiceMgr:
    IServiceManagerForC);
begin
  DLLInitializePlugin(IServiceMgr as IServiceManager);
end;

procedure TPluginLoader.DLLServiceStart2(const serviceID: PMyChar);
begin
  DLLServiceStart(serviceID);
end;

procedure TPluginLoader.DLLServiceStop2(const serviceID: PMyChar);
begin
  DLLServiceStop(serviceID);
end;

procedure TPluginLoader.DLLUninitializePlugin2(const IServiceMgr:
    IServiceManagerForC);
begin
  DLLUninitializePlugin(IServiceMgr as IServiceManager);
end;

function TPluginLoader.GetLoadedPluginFile2: PMyChar;
begin
  Result := PMyChar(GetLoadedPluginFile);
end;

function TPluginLoader.LoadPlugin2(const pluginFile: PMyChar): Integer;
begin
  Result := LoadPlugin(pluginFile);
end;

function TPluginLoader.UnLoadPlugin2: Integer;
begin
  Result := UnLoadPlugin;
end;

{
******************************** TPluginManager ********************************
}
function TPluginManager.CfgLoadPluginByPluginID2(const pluginID: PMyChar):
    Integer;
begin
  Result := CfgLoadPluginByPluginID(pluginID);
end;

function TPluginManager.CfgLoadPluginByServiceID2(const serviceID: PMyChar):
    Integer;
begin
  Result := CfgLoadPluginByServiceID(serviceID);
end;

function TPluginManager.CfgReLoadPlugins2: Integer;
begin
  Result := CfgReLoadPlugins;
end;

//function TPluginManager.GetPluginInfoByIndex2(idx: Integer): IPluginInfoForC;
//begin
//  Result := GetPluginInfoByIndex(idx) as IPluginInfoForC;
//end;

procedure TPluginManager.GetPluginInfoByIndex2(idx: Integer; out intf: IPluginInfoForC);
begin
  intf := GetPluginInfoByIndex(idx) as IPluginInfoForC;
end;

//function TPluginManager.GetPluginInfoByPluginID2(const pluginID: PMyChar):IPluginInfoForC;
//begin
//  Result := GetPluginInfoByPluginID(pluginID) as IPluginInfoForC;
//end;

procedure TPluginManager.GetPluginInfoByPluginID2(const pluginID: PMyChar; out intf: IPluginInfoForC);
begin
  intf := GetPluginInfoByPluginID(pluginID) as IPluginInfoForC;
end;

function TPluginManager.GetPluginsCount2: Integer;
begin
  Result := GetPluginsCount;
end;

function TPluginManager.LoadPluginDirect2(const pluginFile: PMyChar; const
    useLoader: PMyChar=nil): Integer;
var
  s: String;
begin
  s := useLoader;
  Result := LoadPluginDirect(pluginFile, s);
end;

function TPluginManager.SetPluginActiveByIndex2(idx: Integer): Integer;
begin
  Result := SetPluginActiveByIndex(idx);
end;

function TPluginManager.SetPluginActiveByPluginID2(const pluginID: PMyChar):
    Integer;
begin
  Result := SetPluginActiveByPluginID(pluginID);
end;

function TPluginManager.SetPluginDeActiveByIndex2(idx: Integer): Integer;
begin
  Result := SetPluginDeActiveByIndex(idx);
end;

function TPluginManager.SetPluginDeActiveByPluginID2(const pluginID:
    PMyChar): Integer;
begin
  Result := SetPluginDeActiveByPluginID(pluginID);
end;

function TPluginManager.UnLoadPluginByIndex2(idx: Integer): Integer;
begin
  Result := UnLoadPluginByIndex(idx);
end;

function TPluginManager.UnLoadPluginByPluginID2(const pluginID: PMyChar):
    Integer;
begin
  Result := UnLoadPluginByPluginID(pluginID);
end;

function TPluginManager.UpdatePluginDirect2(const pluginFile: PMyChar; const
    useLoader:PMyChar=nil): Integer;
begin
  Result := UpdatePluginDirect(pluginFile, string(useLoader));
end;


{
******************************* TServiceManager ********************************
}
function TServiceManager.AddServiceQuick2(const serviceID, impServiceID: PMyChar;
    const func: TCreateObjectFunc2; active: Boolean = True; isSingleton:
    Boolean = False; isExtendPoint: Boolean = False): Boolean;

begin
  Result := AddServiceQuick(serviceID, impServiceID, TCreateObjectFunc(func), active, isSingleton, isExtendPoint);
end;

function TServiceManager.Count2: Integer;
begin
  Result := Count;
end;

function TServiceManager.ExistService2(const serviceID: PMyChar): Boolean;
begin
  Result := ExistService(serviceID);
end;

//function TServiceManager.GetExtService2(const serviceID: PMyChar; idx:
//    Integer): IInterface;
//begin
//  Result := GetExtService(serviceID, idx);
//end;

procedure TServiceManager.GetExtService2(const serviceID: PMyChar; idx: Integer; out intf: IInterface); stdcall;
begin
  intf := GetExtService(serviceID, idx);
end;

function TServiceManager.GetExtServiceCount2(const serviceID: PMyChar):
    Integer;
begin
  Result := GetExtServiceCount(serviceID);
end;


procedure TServiceManager.GetExtServiceInfo2(const serviceID: PMyChar; idx: Integer; out intf: IServiceInfoForC);
begin
  intf := GetExtServiceInfo(serviceID, idx) as IServiceInfoForC;
end;
//function TServiceManager.GetService2(const serviceID: PMyChar): IInterface;
//begin
//  Result := GetService(serviceID);
//end;

procedure TServiceManager.GetService2(const serviceID: PMyChar; out intf: IInterface); 
begin
  intf := GetService(serviceID);
end;

//function TServiceManager.GetServiceInfo2(const serviceID: PMyChar):
//    IServiceInfoForC;
//begin
//  Result := GetServiceInfo(serviceID) as IServiceInfoForC;
//end;

procedure TServiceManager.GetServiceInfoByID2(const serviceID: PMyChar; out intf: IServiceInfoForC);
begin
  intf := GetServiceInfo(serviceID) as IServiceInfoForC;
end;

procedure TServiceManager.GetServiceInfoByIndex2(idx: Integer; out intf: IServiceInfoForC);
begin
  intf := GetServiceInfo(idx) as IServiceInfoForC;
end;

function TServiceManager.RegService2(const sv: IServiceInfoForC): Integer;
begin
  Result := RegService(sv as IServiceInfo);
end;

function TServiceManager.ServiceIsActive2(const serviceID: PMyChar): Boolean;
begin
  Result := ServiceIsActive(serviceID);
end;

function TServiceManager.StartService2(const serviceID: PMyChar): Boolean;
begin
  Result := StartService(serviceID);
end;

function TServiceManager.StopService2(const serviceID: PMyChar): Boolean;
begin
  Result := StopService(serviceID);
end;

function TServiceManager.UnRegService2(const serviceID: PMyChar): Integer;
begin
  Result := UnRegService(serviceID);
end;

