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
  im.SetAuthor('IceAir'); //���ģ������
  im.SetComment('�ò��DLL��Ҫ��ʾ����ṩ��չ��IToolBarExt��ʵ�֡�');//�����Ҫ˵��
  im.SetPluginID('{A27A7515-4AA0-4BD9-B18F-FCB43831C277}');//���ID
  im.SetPluginName('extPointImp');//�������
  im.SetVersion('1.0.0');//����汾
  im.SetUpdateHistory('2014��6��22�� 1:22��');//���������ʷ

  with im.AppendServiceInfo(IID_ExtToolButton) do begin
    SetAuthor('IceAir'); //����ӿ�����
    SetComment('��չ��IToolBarExt��һ������ʵ�֡�');//�������ص��Ҫ˵��
    SetSingleton(True);//�����Ƿ�Ҫ�Ե���ģʽ����
    SetServiceClass(TExtToolButton);//����ӿڵ�ʵ����
    SetServiceName('IExtToolButton');//��������
    SetImplementServiceID(IID_ToolBarExt);//����ʵ�ֵ���չ��ID
  end;
end;

{�˴�������һЩ���ģ��������������Ҫ�ĳ�ʼ���������ú��������õ�
ʱ���ǣ����DLL�ѱ�������룬��δ����(��������еķ�����)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin

end;

//�˴���һЩ���ģ���˳�ǰ������������ú�������ܵ��õ�
//ʱ���ǣ�����ṩ�����нӿڷ�����ͣ�ã����ģ�鼴����DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  
end;

//���񱻼�������
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
begin

end;

//����DeActiveǰ����
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin

end;

end.
