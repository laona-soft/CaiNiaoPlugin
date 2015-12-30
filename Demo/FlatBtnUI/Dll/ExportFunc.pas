unit ExportFunc;

interface

uses WisdomCoreInterfaceForD, IntfCommon, Forms; 

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

var
  OldApplication: TApplication;

implementation

uses Unit2;

function  DLLGetObject(const serviceID: PAnsiChar): IInterface; stdcall;
begin
  Result := nil;
end;

procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;
begin
  im.SetAuthor('IceAir');
  im.SetComment('Only a Simple Test Plugin');
  im.SetPluginID('{C65302CD-B0B0-4C7D-BB2E-DC8EBA74416F}');
  im.SetPluginName('a Simple Plugin');
  im.SetUpdateHistory('The first version');
  im.SetVersion('1.0.0');
  with im.AppendServiceInfo(IID_MyExtendPoint) do begin
    SetAuthor('IceAir');
    SetComment('a ui Service');
    SetSingleton(True);
    SetServiceClass(TMyExtendPoint);
    SetServiceName('TMyExtendPoint');
    SetImplementServiceID(IID_ExtPoint);
  end;
end;

procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
var
  app: IAppInfo;
begin
  OldApplication := Application;
  if IServiceMgr.ServiceIsActive(IID_AppInfo) then begin
    app := IServiceMgr.GetService(IID_AppInfo) as IAppInfo;
    //替换dll中的Application和Exe中的一致，可以方便一些问题的处理，但是
    //如果加上这一句，当如使用不同编译器的dll/exe混合调用时，在dll中如果
    //有创建窗口放到主Exe显示的话，创建过程会出错，注掉以下这一句就正常了
    //你可以使用D7编译的Exe调用XE以上创建的dll插件都能正常使用。
//    Application := app.GetApplication;
  end;
end;

procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  Application := OldApplication;
end;

procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin
  //在服务开始的时候设置UI显示
  if '8AE93D0D-8E31-49C7-BE40-89C87CF0DA07' = serviceID then begin
    //怎样获取显示区域这个完全看是怎样定制的，比如可能是已有另一个插件实现了
    //总界面框架，并提供了获取各界面区域的函数，则此处调用这些函数来显示就行，
    //在本Demo中，只是简单地在主界面上放了一个Panel，我们要把界面显示在里面，
    //所以此处就简单获取这个Panel做父容器来显示界面就可以了。
    //Form2 := TForm2.Create();
  end;
end;

procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin
  //在服务结束的时候销毁UI
  //if serviceID = IID_MyExtendPoint then

end;

end.
