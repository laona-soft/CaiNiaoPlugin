// CppPlugin.cpp : Defines the entry point for the DLL application.
//
#include "stdafx.h"
#include "SortIntf.h"
#include "WisdomCoreInterfaceForC.h"
#include <string>

#pragma comment(lib,  "rpcrt4.lib")  //UuidFromString函数所在单元

BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    return TRUE;
}


IServiceManager *GServiceMgr = NULL;  //全局变量

typedef IUnknown IInterface;
extern "C" __declspec(dllexport) IUnknown* __stdcall GetCppObject( );
extern "C" __declspec(dllexport) void __stdcall GetPluginInfo( );
extern "C" __declspec(dllexport) void __stdcall InitializePlugin( );
extern "C" __declspec(dllexport) void __stdcall ServiceStart( );
extern "C" __declspec(dllexport) void __stdcall ServiceStop( );
extern "C" __declspec(dllexport) void __stdcall UninitializePlugin( );


//此函数主要设计为用于C++实现的DLL模块，需在此处根据serviceID创建对象返回。
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


//该函数在框架获取插件信息时调用，框架传入im接口，通过该接口反馈插件信息和接口服务信息
void __stdcall GetPluginInfo( IPluginInfo  * const im )
{ 
  im->SetAuthor( _T("IceAir") ); //插件模块作者
  im->SetComment( _T("演示使用VC++编写的插件使用。") );//插件简要说明
  im->SetPluginID( _T("{1B617B6F-E718-4dbf-8893-C3AB61ECD5B0}") );//插件ID
  im->SetPluginName( _T("CppPlugin") );//插件名称
  im->SetVersion( _T("1.0.0") );//插件版本
  im->SetUpdateHistory( _T("Ver1.0.0 20140712") );//插件更新历史
  
  //设置服务信息
  IServiceInfoForC *sv=NULL;  //一定要初始化
  im->AppendServiceInfo(IID_Cpp_sort_demo, &sv); 
  sv->SetAuthor(_T("IceAir"));
  sv->SetComment(_T("本服务接口演示对一个输入的整形数组进行从小到大的排序。"));
  sv->SetServiceName(_T("ISortService"));
  sv->SetVersion(_T("Ver1.02 buid201407170126"));
  sv->Release();
}

/*此处可以做一些插件模块正常运行所需要的初始化操作，该函数被调用的
时机是：插件DLL已被框架载入，但未激活(包括插件中的服务项)*/
void __stdcall InitializePlugin(  IServiceManager * const IServiceMgr )
{
	GServiceMgr = IServiceMgr;
	GServiceMgr->AddRef();
}

//此处做一些插件模块退出前的清理操作，该函数被框架调用的
//时机是：插件提供的所有接口服务已停用，插件模块即将被DeActive
void __stdcall UninitializePlugin(  IServiceManager * const IServiceMgr )
{
	GServiceMgr->Release();
}

//服务被激活后调用

void __stdcall ServiceStart(  char* const serviceID )
{
}

//服务被DeActive前调用
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
