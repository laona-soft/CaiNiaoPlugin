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
    //�滻dll�е�Application��Exe�е�һ�£����Է���һЩ����Ĵ�������
    //���������һ�䣬����ʹ�ò�ͬ��������dll/exe��ϵ���ʱ����dll�����
    //�д������ڷŵ���Exe��ʾ�Ļ����������̻����ע��������һ���������
    //�����ʹ��D7�����Exe����XE���ϴ�����dll�����������ʹ�á�
//    Application := app.GetApplication;
  end;
end;

procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  Application := OldApplication;
end;

procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin
  //�ڷ���ʼ��ʱ������UI��ʾ
  if '8AE93D0D-8E31-49C7-BE40-89C87CF0DA07' = serviceID then begin
    //������ȡ��ʾ���������ȫ�����������Ƶģ����������������һ�����ʵ����
    //�ܽ����ܣ����ṩ�˻�ȡ����������ĺ�������˴�������Щ��������ʾ���У�
    //�ڱ�Demo�У�ֻ�Ǽ򵥵����������Ϸ���һ��Panel������Ҫ�ѽ�����ʾ�����棬
    //���Դ˴��ͼ򵥻�ȡ���Panel������������ʾ����Ϳ����ˡ�
    //Form2 := TForm2.Create();
  end;
end;

procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin
  //�ڷ��������ʱ������UI
  //if serviceID = IID_MyExtendPoint then

end;

end.
