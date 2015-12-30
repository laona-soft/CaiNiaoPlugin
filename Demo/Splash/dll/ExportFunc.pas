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

//�����DLLGetPluginInfoδʹ��SetServiceClass���÷���ӿڵ�ʵ���࣬���ܻ���
//�ӵ���serviceID�ķ�������ʱ������ô˺��������ڴ˺����д����÷���ӿڷ��ؿ�ܡ�
//�˺�����Ҫ���Ϊ����C++ʵ�ֵ�DLLģ�飬��Ϊ��VCʵ�ֵĽӿ����޷��ṩDelphi���õ�ʵ����TClassxxx
function DLLGetObject(const serviceID: PAnsiChar): IInterface; stdcall;
begin
  Result := nil;
end;

//�ú����ڿ�ܻ�ȡ�����Ϣʱ���ã���ܴ���im�ӿڣ�ͨ���ýӿڷ��������Ϣ�ͽӿڷ�����Ϣ
procedure DLLGetPluginInfo(const im: IPluginInfo); stdcall;
begin
  im.SetAuthor(''); //���ģ������
  im.SetComment('');//�����Ҫ˵��
  im.SetPluginID('{86321E0F-9A55-426C-843F-A55036086617}');//���ID
  im.SetPluginName('SplashDemo');//�������
  im.SetVersion('1.0.0');//����汾
  im.SetUpdateHistory('');//���������ʷ

  //����Զ���һ����չ�㣬�����ֻ�ػ���ع��̵���Ϣ��ͨ����չ�����Ϣ���ͳ�ȥ��
  //�κ�ʵ����չ���Form���ܳ�Ϊһ������������������Ը�������ƾ����ˡ�
  {
  with im.AppendServiceInfo(IID_SplashExtPoint) do begin
    SetAuthor(''); //����ӿ�����
    SetComment('');//�������ص��Ҫ˵��
    SetSingleton(True);//�����Ƿ�Ҫ�Ե���ģʽ����
    SetServiceClass(TSplashExtPoint);//����ӿڵ�ʵ����
    SetServiceName('ISplashExtPoint');//��������
    SetImplementServiceID('');//����ʵ�ֵ���չ��ID
  end; }
end;

{�˴�������һЩ���ģ��������������Ҫ�ĳ�ʼ���������ú��������õ�
ʱ���ǣ����DLL�ѱ�������룬��δ����(��������еķ�����)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := IServiceMgr;
  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;
end;

//�˴���һЩ���ģ���˳�ǰ������������ú�������ܵ��õ�
//ʱ���ǣ�����ṩ�����нӿڷ�����ͣ�ã����ģ�鼴����DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  frmSplash.Free;
  GServiceManager := nil;
end;

//���񱻼�������
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin
  //����Ϊ���ڵļ��������ʾ���룬�����ο��������в��ô˴��룬
  //����ʾ��Form��ģ�������ʾ����
  if serviceID = IID_SplashExtPoint then begin
    frmSplash.Tag := 1; //����������Ĳ�������������DLL�����ǵ�һ�����صġ�
    Exit;
  end;

  with GServiceManager.GetService(PLUGIN_MANAGER_ID) as IPluginManager do begin
    if GetPluginsCount<=frmSplash.Tag then
      Exit;
    with GetPluginInfoByIndex(GetPluginsCount-1) as IPluginInfo do begin
      frmSplash.mmo1.Lines.Append(
        '���ز����' + GetPluginName + '  �汾��' + GetVersion + '  �ļ���' + GetDllName);
    end;
    frmSplash.Tag := GetPluginsCount;
  end;
end;

//����DeActiveǰ����
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin
end;

end.
