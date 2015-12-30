unit ExportFunc;

interface

uses WisdomCoreInterfaceForD, ServicesInterface, Forms, ComCtrls, Graphics;

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

uses MyToolbarUI;

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
  im.SetComment('演示扩展点的使用，演示如何使得一个界面可以动态地被其它插件扩展界面展现和功能。');//插件简要说明
  im.SetPluginID('{BE855F6C-CE5D-42FF-85C2-CCC31AC7A47E}');//插件ID
  im.SetPluginName('ToolBarExtPoint');//插件名称
  im.SetVersion('1.0.0');//插件版本
  im.SetUpdateHistory('Ver1.0.0 20140621');//插件更新历史

  with im.AppendServiceInfo(IID_ToolBarExt) do begin
    SetAuthor('IceAir'); //服务接口作者
    SetComment('ToolBar预留的可动态增加按钮的扩展点。');//服务功能特点简要说明
    SetIsExtendPoint(True);
    SetSingleton(False);//服务是否要以单例模式运行
    SetServiceName('IToolBarExt');//服务名称
  end;
end;

{此处可以做一些插件模块正常运行所需要的初始化操作，该函数被调用的
时机是：插件DLL已被框架载入，但未激活(包括插件中的服务项)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := IServiceMgr;
  if IServiceMgr.ServiceIsActive(IID_AppInfo) then
    with IServiceMgr.GetService(IID_AppInfo) as IAppInfo do begin
      //以下四句如果不用在同一编译器下会出错，如D7的Exe + XE5的DLL
      {Form1 := TForm1.Create(nil);
      //或者以下句也可：
      //Form1 := TForm1.CreateParented(GetMainForm.Handle);
      Form1.Parent := GetMainForm;
      Form1.Show;}

      //以下句可用于异构编译器的结果，如VC的EXE + XE5的DLL
      Form1 := TForm1.CreateParented(GetMainFormHandle);
      Form1.ParentWindow := GetMainFormHandle;
      Form1.Left := 0;
      Form1.Top  := 0;
      Form1.Visible := true;
      Form1.Show;
    end;
end;

//此处做一些插件模块退出前的清理操作，该函数被框架调用的
//时机是：插件提供的所有接口服务已停用，插件模块即将被DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  if Assigned(Form1) then
    Form1.Free;
  GServiceManager := nil;  
end;

//服务被激活后调用
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
var
  t: TToolButton;
  bmp, bmp1: TBitmap;
begin
  //检查此service是否实现的是本插件中宣布的扩展点
  if Assigned(Form1) and GServiceManager.ServiceIsActive(serviceID) then
    with GServiceManager.GetServiceInfo(serviceID) do
      if GetImplementServiceID = IID_ToolBarExt then begin
        //如果是，则在ToolBar上增加按钮
        t := TToolButton.Create(Form1.ToolBar1);
        t.Parent := Form1.ToolBar1;
        t.Left := 1000;
        with GServiceManager.GetService(serviceID) as IExtToolButton do begin
          t.Caption := string(GetCaption);
          bmp := tbitmap.Create;
          bmp.Width := 48;
          bmp.Height := 48;
          GetBitmap(bmp.Canvas.Handle);
          t.ImageIndex := Form1.ImageList1.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);
          t.OnClick := GetClickEvent;
        end;
      end;
end;

//服务被DeActive前调用
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin

end;

end.
