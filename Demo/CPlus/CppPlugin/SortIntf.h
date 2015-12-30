#if _MSC_VER > 1000
#pragma once
#endif 

#include "StdAfx.h"
#include "WisdomCoreInterfaceForC.h"

const MyChar IID_Cpp_sort_demo[] = _T("{4208E4A4-F017-495a-81AA-D650DA613F02}");
const MyChar IID_ILOG[] = _T("{0E048007-252A-44D7-9536-DDFF813B7408}");



interface DECLSPEC_UUID("{4208E4A4-F017-495a-81AA-D650DA613F02}")
ISortService : public IUnknown
{
public:
	virtual void __stdcall Sort(int *p, int len) = 0;
	virtual MyChar * __stdcall GetVer(int len) = 0;
};


interface DECLSPEC_UUID("{0E048007-252A-44D7-9536-DDFF813B7408}")
ILog : public IUnknown
{
public:
	virtual void __stdcall Log(PMyChar msg) = 0;
};


class TSortService : public ISortService
{
private:
	long m_ref;
public:
	TSortService();
	~TSortService();
    HRESULT STDMETHODCALLTYPE QueryInterface(REFIID riid, void** ppv);
    ULONG STDMETHODCALLTYPE AddRef();  
    ULONG STDMETHODCALLTYPE Release();
	void __stdcall Sort(int *p, int len);
	MyChar * __stdcall GetVer(int len);
};
