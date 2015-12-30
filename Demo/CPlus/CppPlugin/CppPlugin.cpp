// CppPlugin.cpp : Defines the entry point for the DLL application.
//
#include "stdafx.h"
#include "SortIntf.h"
#include "WisdomCoreInterfaceForC.h"
#include <string>

#pragma comment(lib,  "rpcrt4.lib")  //UuidFromString�������ڵ�Ԫ

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    return TRUE;
}


IServiceManager *GServiceMgr = NULL;  //ȫ�ֱ���

typedef IUnknown IInterface;
extern "C" __declspec(dllexport) IUnknown* __stdcall GetCppObject( );
extern "C" __declspec(dllexport) void __stdcall GetPluginInfo( );
extern "C" __declspec(dllexport) void __stdcall InitializePlugin( );
extern "C" __declspec(dllexport) void __stdcall ServiceStart( );
extern "C" __declspec(dllexport) void __stdcall ServiceStop( );
extern "C" __declspec(dllexport) void __stdcall UninitializePlugin( );


//�˺�����Ҫ���Ϊ����C++ʵ�ֵ�DLLģ�飬���ڴ˴�����serviceID�������󷵻ء�
IInterface* __stdcall GetCppObject(  char* const serviceID )
{	
#ifdef UNICODE
	TCHAR sid[100] = {0};
	wsprintfW(sid, L"%hs", serviceID);
	if (_tcscmp(sid, IID_Cpp_sort_demo)==0)
		return new TSortService;
	else
		return NULL;
#else
	if (strcmp(serviceID, IID_Cpp_sort_demo)==0)
		return new TSortService;
	else
		return NULL;
#endif
}


//�ú����ڿ�ܻ�ȡ�����Ϣʱ���ã���ܴ���im�ӿڣ�ͨ���ýӿڷ��������Ϣ�ͽӿڷ�����Ϣ
void __stdcall GetPluginInfo( IPluginInfo  * const im )
{ 
  im->SetAuthor( _T("IceAir") ); //���ģ������
  im->SetComment( _T("��ʾʹ��VC++��д�Ĳ��ʹ�á�") );//�����Ҫ˵��
  im->SetPluginID( _T("{1B617B6F-E718-4dbf-8893-C3AB61ECD5B0}") );//���ID
  im->SetPluginName( _T("CppPlugin") );//�������
  im->SetVersion( _T("1.0.0") );//����汾
  im->SetUpdateHistory( _T("Ver1.0.0 20140712") );//���������ʷ
  
  //���÷�����Ϣ
  IServiceInfoForC *sv=NULL;  //һ��Ҫ��ʼ��
  im->AppendServiceInfo(IID_Cpp_sort_demo, &sv); 
  sv->SetAuthor(_T("IceAir"));
  sv->SetComment(_T("������ӿ���ʾ��һ�����������������д�С���������"));
  sv->SetServiceName(_T("ISortService"));
  sv->SetVersion(_T("Ver1.02 buid201407170126"));
  sv->Release();
}

/*�˴�������һЩ���ģ��������������Ҫ�ĳ�ʼ���������ú��������õ�
ʱ���ǣ����DLL�ѱ�������룬��δ����(��������еķ�����)*/
void __stdcall InitializePlugin(  IServiceManager * const IServiceMgr )
{
	GServiceMgr = IServiceMgr;
	GServiceMgr->AddRef();
}

//�˴���һЩ���ģ���˳�ǰ������������ú�������ܵ��õ�
//ʱ���ǣ�����ṩ�����нӿڷ�����ͣ�ã����ģ�鼴����DeActive
void __stdcall UninitializePlugin(  IServiceManager * const IServiceMgr )
{
	GServiceMgr->Release();
}

//���񱻼�������

void __stdcall ServiceStart(  char* const serviceID )
{
}

//����DeActiveǰ����
void __stdcall ServiceStop(  char* const serviceID )
{
}

//------------------------------------------------------------------------------------------

/*

ISortService* __stdcall GetSortIntf()
{
	return new TSortService;
}
*/
