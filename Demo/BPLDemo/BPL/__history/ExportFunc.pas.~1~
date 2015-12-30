unit ExportFunc;

interface

uses WisdomCoreInterfaceForD, IntfCommon, Unit1;

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
  im.SetAuthor('IceAir'); //插件模块作者
  im.SetComment('演示BPL的使用，仅简单Show一下BPL中的一个Form。');//插件简要说明
  im.SetPluginID('WisdomPluginFramework.Demo.bplDemo');//插件ID
  im.SetPluginName('Demo.bplDemo');//插件名称
  im.SetVersion('1.0.0');//插件版本
  im.SetUpdateHistory('Ver1.0.0 20140729');//插件更新历史

  with im.AppendServiceInfo(IID_BPLTest) do begin
    SetAuthor('IceAir'); //服务接口作者
    SetComment('展示BPL中的Form的服务接口');//服务功能特点简要说明
    SetSingleton(True);//服务是否要以单例模式运行
    SetServiceClass(TBPLTest);
    SetServiceName('IBPLTest');//服务名称
  end;
end;

{此处可以做一些插件模块正常运行所需要的初始化操作，该函数被调用的
时机是：插件DLL已被框架载入，但未激活(包括插件中的服务项)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := IServiceMgr;
end;

//此处做一些插件模块退出前的清理操作，该函数被框架调用的
//时机是：插件提供的所有接口服务已停用，插件模块即将被DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := nil;
end;

//服务被激活后调用
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin
end;

//服务被DeActive前调用
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin

end;

end.
