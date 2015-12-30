unit ExportFunc;

interface

uses WisdomCoreInterfaceForD, ServicesInterface, ServicesImplement;

    function  DLLGetObject(const serviceID: PAnsiChar): IInterface; stdcall;
    procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;
    procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
    procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
    procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
    procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;

exports
   DLLGetObject,
   DLLGetPluginInfo,
   DLLInitializePlugin,
   DLLUninitializePlugin,
   DLLServiceStart,
   DLLServiceStop;


implementation

uses SplashForm;

//如果在DLLGetPluginInfo未使用SetServiceClass设置服务接口的实现类，则框架会在
//接到对serviceID的服务请求时，会调用此函数，请在此函数中创建该服务接口返回框架。
//此函数主要设计为用于C++实现的DLL模块，因为如VC实现的接口类无法提供Delphi可用的实现类TClassxxx
function DLLGetObject(const serviceID: PAnsiChar): IInterface; stdcall;
begin
  Result := nil;
end;

//该函数在框架获取插件信息时调用，框架传入im接口，通过该接口反馈插件信息和接口服务信息
procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;
begin
  im.SetAuthor(''); //插件模块作者
  im.SetComment('');//插件简要说明
  im.SetPluginID('{86321E0F-9A55-426C-843F-A55036086617}');//插件ID
  im.SetPluginName('SplashDemo');//插件名称
  im.SetVersion('1.0.0');//插件版本
  im.SetUpdateHistory('');//插件更新历史

  //你可以定义一个扩展点，本插件只截获加载过程的信息，通过扩展点把信息发送出去，
  //任何实现扩展点的Form都能成为一个启动闪屏，这个按自个心意设计就行了。
  {
  with im.AppendServiceInfo(IID_SplashExtPoint) do begin
    SetAuthor(''); //服务接口作者
    SetComment('');//服务功能特点简要说明
    SetSingleton(True);//服务是否要以单例模式运行
    SetServiceClass(TSplashExtPoint);//服务接口的实现类
    SetServiceName('ISplashExtPoint');//服务名称
    SetImplementServiceID('');//服务实现的扩展点ID
  end; }
end;

{此处可以做一些插件模块正常运行所需要的初始化操作，该函数被调用的
时机是：插件DLL已被框架载入，但未激活(包括插件中的服务项)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := IServiceMgr;
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
end;

//此处做一些插件模块退出前的清理操作，该函数被框架调用的
//时机是：插件提供的所有接口服务已停用，插件模块即将被DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  frmSplash.Free;
  GServiceManager := nil;
end;

//服务被激活后调用
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin
  //以下为正宗的加载情况显示代码，用作参考，本例中不用此代码，
  //而在示例Form中模拟加载显示过程
  if serviceID = IID_SplashExtPoint then begin
    frmSplash.Tag := 1; //保存已载入的插件数量，本插件DLL必须是第一个加载的。
    Exit;
  end;

  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    if GetPluginsCount<=frmSplash.Tag then
      Exit;
    with GetPluginInfoByIndex(GetPluginsCount-1) as IPluginInfo do begin
      frmSplash.mmo1.Lines.Append(
        '加载插件：' + GetPluginName + '  版本：' + GetVersion + '  文件：' + GetDllName);
    end;
    frmSplash.Tag := GetPluginsCount;
  end;
end;

//服务被DeActive前调用
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin
end;

end.
