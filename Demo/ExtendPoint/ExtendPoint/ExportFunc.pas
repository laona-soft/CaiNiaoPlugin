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
  im.SetComment('��ʾ��չ���ʹ�ã���ʾ���ʹ��һ��������Զ�̬�ر����������չ����չ�ֺ͹��ܡ�');//�����Ҫ˵��
  im.SetPluginID('{BE855F6C-CE5D-42FF-85C2-CCC31AC7A47E}');//���ID
  im.SetPluginName('ToolBarExtPoint');//�������
  im.SetVersion('1.0.0');//����汾
  im.SetUpdateHistory('Ver1.0.0 20140621');//���������ʷ

  with im.AppendServiceInfo(IID_ToolBarExt) do begin
    SetAuthor('IceAir'); //����ӿ�����
    SetComment('ToolBarԤ���Ŀɶ�̬���Ӱ�ť����չ�㡣');//�������ص��Ҫ˵��
    SetIsExtendPoint(True);
    SetSingleton(False);//�����Ƿ�Ҫ�Ե���ģʽ����
    SetServiceName('IToolBarExt');//��������
  end;
end;

{�˴�������һЩ���ģ��������������Ҫ�ĳ�ʼ���������ú��������õ�
ʱ���ǣ����DLL�ѱ�������룬��δ����(��������еķ�����)}
procedure DLLInitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  GServiceManager := IServiceMgr;
  if IServiceMgr.ServiceIsActive(IID_AppInfo) then
    with IServiceMgr.GetService(IID_AppInfo) as IAppInfo do begin
      //�����ľ����������ͬһ�������»������D7��Exe + XE5��DLL
      {Form1 := TForm1.Create(nil);
      //�������¾�Ҳ�ɣ�
      //Form1 := TForm1.CreateParented(GetMainForm.Handle);
      Form1.Parent := GetMainForm;
      Form1.Show;}

      //���¾�������칹�������Ľ������VC��EXE + XE5��DLL
      Form1 := TForm1.CreateParented(GetMainFormHandle);
      Form1.ParentWindow := GetMainFormHandle;
      Form1.Left := 0;
      Form1.Top  := 0;
      Form1.Visible := true;
      Form1.Show;
    end;
end;

//�˴���һЩ���ģ���˳�ǰ������������ú�������ܵ��õ�
//ʱ���ǣ�����ṩ�����нӿڷ�����ͣ�ã����ģ�鼴����DeActive
procedure DLLUninitializePlugin(const IServiceMgr: IServiceManager); stdcall;
begin
  if Assigned(Form1) then
    Form1.Free;
  GServiceManager := nil;  
end;

//���񱻼�������
procedure DLLServiceStart(const serviceID: PAnsiChar); stdcall;
var
  t: TToolButton;
  bmp, bmp1: TBitmap;
begin
  //����service�Ƿ�ʵ�ֵ��Ǳ��������������չ��
  if Assigned(Form1) and GServiceManager.ServiceIsActive(serviceID) then
    with GServiceManager.GetServiceInfo(serviceID) do
      if GetImplementServiceID = IID_ToolBarExt then begin
        //����ǣ�����ToolBar�����Ӱ�ť
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

//����DeActiveǰ����
procedure DLLServiceStop(const serviceID: PAnsiChar); stdcall;
begin

end;

end.
