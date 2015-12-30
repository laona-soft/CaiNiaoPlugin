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
  im.SetComment('定制的插件加载器，专用于加载内存中的DLL插件。');//插件简要说明
  im.SetPluginID('{B287096A-6B56-4B6B-AAE6-F78AD005F1DC}');//插件ID
  im.SetPluginName('MemoryLoader');//插件名称
  im.SetVersion('1.0.0');//插件版本
  im.SetUpdateHistory('2014/7/31 第一版本');//插件更新历史

  with im.AppendServiceInfo(IID_MemoryLoader) do begin
    SetVersion('1.0.0');
    SetAuthor('IceAir'); //服务接口作者
    SetComment('该服务专用于从内存中加载DLL插件，特别适用于客户端的插件由服务端推送且不希望存到磁盘上，内存加载单元使用到大侠武稀松写的MemoryModule，在此严重表示对作者的尊重和感谢！');//服务功能特点简要说明
    SetSingleton(False);//服务是否要以单例模式运行
    SetServiceClass(TMemoryLoader);//服务接口的实现类
    SetServiceName('IMemoryLoader');//服务名称
    SetImplementServiceID('');//服务实现的扩展点ID
  end;
end;

{此处可以做一些插件模块正常运行所需要的初始化操作，该函数被调用的
时机是：插件DLL已被框架载入，但未激活(包括插件中的服务项)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin

end;

//此处做一些插件模块退出前的清理操作，该函数被框架调用的
//时机是：插件提供的所有接口服务已停用，插件模块即将被DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  
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
