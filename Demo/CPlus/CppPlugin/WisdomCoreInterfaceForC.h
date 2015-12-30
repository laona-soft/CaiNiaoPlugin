#include <UNKNWN.h>
#if _MSC_VER > 1000
#pragma once
#endif 

/*
#define _USE_WSTR
#ifdef _USE_WSTR
  typedef wchar_t* PMyChar;
  typedef wchar_t MyChar;
#else
  typedef char* PMyChar;
  typedef char MyChar;
#endif
*/

#define PMyChar TCHAR* 
#define MyChar TCHAR 

const MyChar VER[] = _T("1.5");
const MyChar PLUGIN_MANAGER_ID[] = _T("{D647EB39-65A8-48F4-AC6B-995B624CC825}");
const MyChar CONFIG_ID[] = _T("{B95F4304-B45E-4285-A2EC-FAD1A483541F}");
const MyChar SERVICE_INFO_ID[] = _T("{983679B1-A622-4AC3-9749-0B170C025ED6}");
const MyChar PLUGIN_INFO_ID[] = _T("{B152682C-319C-4F13-B6B8-646D7F915FAF}");
const MyChar PLUGIN_LOADER[] = _T("{362F7327-068C-4152-8EE1-EFDB6A7A2001}");
const int PLUGIN_LOAD_ALWAYS = 0x0100;
const int PLUGIN_LOAD_WHEN_USED = 0x0200;
const int PLUGIN_LOAD_AUTO = 0x0400;

interface IPluginInfo;
interface IServiceInfo;
interface IServiceManager;
interface IPluginLoader;
interface IPluginManager;
interface IConfig;

typedef IPluginInfo IPluginInfoForC;
typedef IServiceInfo IServiceInfoForC;
typedef IServiceManager IServiceManagerForC;
typedef IPluginLoader IPluginLoaderForC;
typedef IPluginManager IPluginManagerForC;
typedef IConfig IConfigForC;
typedef IUnknown IInterface;
typedef IInterface* ( __stdcall * TCreateObjectFunc )( const IServiceManagerForC *serviceM, IServiceInfoForC *sv );
typedef TCreateObjectFunc TCreateObjectFunc2;

interface DECLSPEC_UUID( "{983679B1-A622-4AC3-9749-0B170C025ED6}" )
IServiceInfo: public IInterface {
  public:
  virtual void __stdcall AddExtendPointImpService( const IServiceInfo* service ) = 0;
  virtual PMyChar __stdcall GetAuthor( ) = 0;
  //virtual IPluginInfo* __stdcall GetBelongToPlugin( ) = 0;
  virtual HRESULT __stdcall GetBelongToPlugin(IPluginInfoForC **p) = 0;
  virtual PMyChar __stdcall GetComment( ) = 0;
  virtual TCreateObjectFunc __stdcall GetCreateObjectFunc( ) = 0;
  //virtual IServiceInfo* __stdcall GetExtendPointImpService( int idx ) = 0;
  virtual HRESULT __stdcall GetExtendPointImpService(int idx, IServiceInfo **p) = 0;
  virtual int __stdcall GetExtendPointImpServiceCount( ) = 0;
  virtual PMyChar __stdcall GetImplementServiceID( ) = 0;
  virtual PMyChar __stdcall GetServiceID( ) = 0;
  //virtual IInterface* __stdcall GetServiceIntf( ) = 0;
  virtual HRESULT __stdcall GetServiceIntf(IInterface **p) = 0;
  virtual PMyChar __stdcall GetServiceName( ) = 0;
  virtual PMyChar __stdcall GetVersion( ) = 0;
  virtual bool __stdcall IsActive( ) = 0;
  virtual bool __stdcall IsExtendPoint( ) = 0;
  virtual bool __stdcall IsSingleton( ) = 0;
  virtual void __stdcall RemoveExtendPointImpService( const PMyChar sid ) = 0;
  virtual void __stdcall SetActive( bool act ) = 0;
  virtual void __stdcall SetAuthor( const PMyChar author ) = 0;
  virtual void __stdcall SetBelongToPlugin( const IPluginInfoForC* ipf ) = 0;
  virtual void __stdcall SetComment( const PMyChar comment ) = 0;
  virtual void __stdcall SetCreateObjectFunc( const TCreateObjectFunc func ) = 0;
  virtual void __stdcall SetImplementServiceID( const PMyChar impID ) = 0;
  virtual void __stdcall SetIsExtendPoint( bool isExtPoint ) = 0;
  virtual void __stdcall SetReadOnly( ) = 0;
  virtual void __stdcall SetServiceID( const PMyChar id ) = 0;
  virtual void __stdcall SetServiceIntf( const IInterface *sv ) = 0;
  virtual void __stdcall SetServiceName( const PMyChar sName ) = 0;
  virtual void __stdcall SetSingleton( bool IsSingleton ) = 0;
  virtual void __stdcall SetVersion( const PMyChar VER ) = 0;
};


interface DECLSPEC_UUID( "{B95F4304-B45E-4285-A2EC-FAD1A483541F}" )
IPluginInfo: public IInterface {
//class IPluginInfo: public IInterface {
  public:
  //virtual IServiceInfoForC* __stdcall AppendServiceInfo( const PMyChar sid ) = 0;
  virtual HRESULT __stdcall AppendServiceInfo(const PMyChar sid, IServiceInfoForC **p) = 0;
  virtual PMyChar __stdcall GetAuthor( ) = 0;
  virtual PMyChar __stdcall GetComment( ) = 0;
  virtual PMyChar __stdcall GetDllName( ) = 0;
  virtual PMyChar __stdcall GetPluginID( ) = 0;
  //virtual IPluginLoaderForC* __stdcall GetPluginLoader( ) = 0;
  virtual HRESULT __stdcall GetPluginLoader(IPluginLoaderForC **p) = 0;
  virtual PMyChar __stdcall GetPluginName( ) = 0;
  virtual int __stdcall GetServiceCount( ) = 0;
  //virtual IServiceInfoForC* __stdcall GetServiceInfo( int idx ) = 0;
  virtual HRESULT __stdcall GetServiceInfo(int idx, IServiceInfoForC **p) = 0;
  virtual PMyChar __stdcall GetUpdateHistory( ) = 0;
  virtual PMyChar __stdcall GetVersion( ) = 0;
  virtual bool __stdcall IsActive( ) = 0;
  virtual bool __stdcall IsLoadedThroughConfig( ) = 0;
  virtual void __stdcall SetActive( bool act ) = 0;
  virtual void __stdcall SetAuthor( const PMyChar author ) = 0;
  virtual void __stdcall SetComment( const PMyChar comment ) = 0;
  virtual void __stdcall SetIsLoadedThroughConfig( bool ltFormCfg ) = 0;
  virtual void __stdcall SetPluginID( const PMyChar id ) = 0;
  virtual void __stdcall SetPluginLoader( const IPluginLoaderForC* loader ) = 0;
  virtual void __stdcall SetPluginName( const PMyChar theName ) = 0;
  virtual void __stdcall SetReadOnly( ) = 0;
  virtual void __stdcall SetUpdateHistory( const PMyChar memo ) = 0;
  virtual void __stdcall SetVersion( const PMyChar VER ) = 0;
};


interface DECLSPEC_UUID( "7A009246-485E-4C48-B56B-A78CBF053AA4" ) 
IServiceManager: public IInterface {
  public:
  virtual bool __stdcall AddServiceQuick( const PMyChar serviceID, const PMyChar impServiceID, const TCreateObjectFunc2 func, bool active = true, bool IsSingleton = false, bool IsExtendPoint = false ) = 0;
  virtual int __stdcall Count( ) = 0;
  virtual bool __stdcall ExistService( const PMyChar serviceID ) = 0;
  //virtual IInterface* __stdcall GetExtService( const PMyChar serviceID, int idx ) = 0;
  virtual HRESULT __stdcall GetExtService(const PMyChar serviceID, int idx, IInterface **p) = 0;
  virtual int __stdcall GetExtServiceCount( const PMyChar serviceID ) = 0;
  virtual HRESULT __stdcall GetExtServiceInfo( const PMyChar serviceID, int idx, IServiceInfoForC **intf ) = 0;
  //virtual IInterface* __stdcall GetService( const PMyChar serviceID ) = 0;
  virtual HRESULT __stdcall GetService(const PMyChar serviceID, IInterface **p) = 0;
  //virtual IServiceInfoForC* __stdcall GetServiceInfo( const PMyChar serviceID ) = 0;
  virtual HRESULT __stdcall GetServiceInfoByID(const PMyChar serviceID, IServiceInfoForC **p) = 0;
  virtual HRESULT __stdcall GetServiceInfoByIndex( int idx, IServiceInfoForC **p) = 0;
  virtual int __stdcall RegService( const IServiceInfoForC* sv ) = 0;
  virtual bool __stdcall ServiceIsActive( const PMyChar serviceID ) = 0;
  virtual bool __stdcall StartService( const PMyChar serviceID ) = 0;
  virtual bool __stdcall StopService( const PMyChar serviceID ) = 0;
  virtual int __stdcall UnRegService( const PMyChar serviceID ) = 0;
};


interface DECLSPEC_UUID( "{362F7327-068C-4152-8EE1-EFDB6A7A2001}" )
IPluginLoader: public IInterface {
  public:
  //virtual IInterface* __stdcall DLLGetObject( const PMyChar serviceID ) = 0;
  virtual HRESULT __stdcall DLLGetObject(const PMyChar serviceID, IInterface **p) = 0;
  virtual int __stdcall DLLGetPluginInfo( const IPluginInfoForC* im ) = 0;
  virtual void __stdcall DLLInitializePlugin( const IServiceManager* IServiceMgr ) = 0;
  virtual void __stdcall DLLServiceStart( const PMyChar serviceID ) = 0;
  virtual void __stdcall DLLServiceStop( const PMyChar serviceID ) = 0;
  virtual void __stdcall DLLUninitializePlugin( const IServiceManager* IServiceMgr ) = 0;
  virtual PMyChar __stdcall GetLoadedPluginFile( ) = 0;
  virtual int __stdcall LoadPlugin( const PMyChar pluginFile ) = 0;
  virtual int __stdcall UnLoadPlugin( ) = 0;
};


interface DECLSPEC_UUID( "{D647EB39-65A8-48F4-AC6B-995B624CC825}" ) 
IPluginManager: public IInterface {
  public:
  virtual int __stdcall CfgLoadPluginByPluginID( const PMyChar pluginID ) = 0;
  virtual int __stdcall CfgLoadPluginByServiceID( const PMyChar serviceID ) = 0;
  virtual int __stdcall CfgReLoadPlugins( ) = 0;
  //virtual IPluginInfo* __stdcall GetPluginInfoByIndex( int idx ) = 0;
  virtual HRESULT __stdcall GetPluginInfoByIndex(int idx, IPluginInfo **p) = 0;
  //virtual IPluginInfo* __stdcall GetPluginInfoByPluginID( const PMyChar pluginID ) = 0;
  virtual HRESULT __stdcall GetPluginInfoByPluginID(const PMyChar pluginID, IPluginInfo **p) = 0;
  virtual int __stdcall GetPluginsCount( ) = 0;
  virtual int __stdcall LoadPluginDirect( const PMyChar pluginFile, const PMyChar useLoader = NULL ) = 0;
  virtual int __stdcall SetPluginActiveByIndex( int idx ) = 0;
  virtual int __stdcall SetPluginActiveByPluginID( const PMyChar pluginID ) = 0;
  virtual int __stdcall SetPluginDeActiveByIndex( int idx ) = 0;
  virtual int __stdcall SetPluginDeActiveByPluginID( const PMyChar pluginID ) = 0;
  virtual int __stdcall UnLoadPluginByIndex( int idx ) = 0;
  virtual int __stdcall UnLoadPluginByPluginID( const PMyChar pluginID ) = 0;
  virtual int __stdcall UpdatePluginDirect( const PMyChar pluginFile, const PMyChar useLoader = NULL ) = 0;
};


interface DECLSPEC_UUID( "{B95F4304-B45E-4285-A2EC-FAD1A483541F}" ) 
IConfig: public IInterface {
  public:
  virtual void __stdcall AddExtendPoint( const IServiceInfo* sv ) = 0;
  virtual void __stdcall AddPlugin( const PMyChar dllFile ) = 0;
  virtual void __stdcall AddService( const IServiceInfo* sv ) = 0;
  virtual void __stdcall DisableExtendPoint( const PMyChar sid ) = 0;
  virtual void __stdcall DisablePlugin( const PMyChar pid ) = 0;
  virtual void __stdcall DisableService( const PMyChar serviceID ) = 0;
  virtual void __stdcall EnabledExtendPoint( const PMyChar sid ) = 0;
  virtual void __stdcall EnabledPlugin( const PMyChar pid ) = 0;
  virtual void __stdcall EnabledService( const PMyChar serviceID ) = 0;
  virtual bool __stdcall ExistExtPoint( const PMyChar sid ) = 0;
  virtual bool __stdcall ExistPlugin( const PMyChar pid ) = 0;
  virtual bool __stdcall ExistService( const PMyChar sid ) = 0;
  virtual bool __stdcall ExtPointIsDisable( const PMyChar sid ) = 0;
  virtual int __stdcall GetExtImpServiceCount( const PMyChar extSid ) = 0;
  virtual PMyChar __stdcall GetExtImpServiceID( const PMyChar extSid, int idx ) = 0;
  virtual int __stdcall GetPluginCount( ) = 0;
  virtual PMyChar __stdcall GetPluginLoaderID( const PMyChar pid ) = 0;
  virtual PMyChar __stdcall GetPluginLoadState( const PMyChar pid ) = 0;
  virtual void __stdcall Open( const PMyChar xmlFile ) = 0;
  virtual PMyChar __stdcall PluginDLL( const PMyChar pid ) = 0;
  virtual PMyChar __stdcall PluginIDFromExtSid( const PMyChar extSid ) = 0;
  virtual PMyChar __stdcall PluginIDFromIdx( int idx ) = 0;
  virtual PMyChar __stdcall PluginIDFromSid( const PMyChar sid ) = 0;
  virtual bool __stdcall PluginIsDisable( const PMyChar pid ) = 0;
  virtual void __stdcall Reload( ) = 0;
  virtual void __stdcall RemoveExtendPoint( const PMyChar sid ) = 0;
  virtual void __stdcall RemovePlugin( const PMyChar pid ) = 0;
  virtual void __stdcall RemoveService( const PMyChar serviceID ) = 0;
  virtual void __stdcall Save( ) = 0;
  virtual bool __stdcall ServiceIsDisable( const PMyChar sid ) = 0;
  virtual bool __stdcall ServiceIsSingleton( const PMyChar sid ) = 0;
  virtual void __stdcall SetExtendPointSingleton( const PMyChar sid, bool SetSingleton ) = 0;
  virtual void __stdcall SetPluginLoaderID( const PMyChar pid, const PMyChar lid ) = 0;
  virtual void __stdcall SetPluginLoadState( const PMyChar pid, const PMyChar state ) = 0;
  virtual void __stdcall SetServiceSingleton( const PMyChar serviceID, bool SetSingleton ) = 0;
};
