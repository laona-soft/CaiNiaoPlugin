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
  im.SetComment('���ƵĲ����������ר���ڼ����ڴ��е�DLL�����');//�����Ҫ˵��
  im.SetPluginID('{B287096A-6B56-4B6B-AAE6-F78AD005F1DC}');//���ID
  im.SetPluginName('MemoryLoader');//�������
  im.SetVersion('1.0.0');//����汾
  im.SetUpdateHistory('2014/7/31 ��һ�汾');//���������ʷ

  with im.AppendServiceInfo(IID_MemoryLoader) do begin
    SetVersion('1.0.0');
    SetAuthor('IceAir'); //����ӿ�����
    SetComment('�÷���ר���ڴ��ڴ��м���DLL������ر������ڿͻ��˵Ĳ���ɷ���������Ҳ�ϣ���浽�����ϣ��ڴ���ص�Ԫʹ�õ�������ϡ��д��MemoryModule���ڴ����ر�ʾ�����ߵ����غ͸�л��');//�������ص��Ҫ˵��
    SetSingleton(False);//�����Ƿ�Ҫ�Ե���ģʽ����
    SetServiceClass(TMemoryLoader);//����ӿڵ�ʵ����
    SetServiceName('IMemoryLoader');//��������
    SetImplementServiceID('');//����ʵ�ֵ���չ��ID
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
