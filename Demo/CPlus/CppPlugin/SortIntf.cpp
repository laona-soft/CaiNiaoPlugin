#include "SortIntf.h"


extern IServiceManager *GServiceMgr;

TSortService::TSortService()
		: m_ref(0)
{
}

TSortService::~TSortService()
{
}


HRESULT STDMETHODCALLTYPE TSortService::QueryInterface(REFIID riid, void** ppv)
{
		if (riid == __uuidof(ISortService))
		{
			*ppv = (ISortService*)this;
			return S_OK;
		}

		return E_NOINTERFACE;
}


ULONG STDMETHODCALLTYPE TSortService::AddRef()
{
		return ::InterlockedIncrement(&m_ref);
}
    

ULONG STDMETHODCALLTYPE TSortService::Release()
{
		if (::InterlockedDecrement(&m_ref) == 0)
		{
			delete this;
			return 0;
		}

		return m_ref;
}
   

void __stdcall TSortService::Sort(int *p, int len)
{
		//使用冒泡排序法
		int i, j, k;
		for (i=0; i<len-1; ++i)
			for (j=i+1; j<len; ++j)
				if ( *(p+i) > *(p+j) )
				{
					k = *(p+i);
					*(p+i) = *(p+j);
					*(p+j) = k;
				}

        if (GServiceMgr->ServiceIsActive(IID_ILOG))
		{
			IUnknown *un = NULL;
			GServiceMgr->GetService(IID_ILOG, &un);
			if (un != NULL)
			{
				ILog *log = NULL;
	            GUID guid; 
               #ifdef UNICODE
                UuidFromStringW((unsigned short *)_T("0E048007-252A-44D7-9536-DDFF813B7408"), &guid);
               #else
                UuidFromStringA((unsigned char *)_T("0E048007-252A-44D7-9536-DDFF813B7408"), &guid);
               #endif
				un->QueryInterface(guid ,(void**)&log);
				if (log != NULL)
				{
					log->Log(_T("C++ DLL调用Host提供的ILog服务，反馈排序结果："));
					char num[4];
					char rs[200]; 
					for (i=0; i<len; ++i)
					{
						sprintf(num, "%d", *(p+i));
						strcat(rs, num); 
					    strcat(rs, "   ");
					}
#ifdef UNICODE
					TCHAR rs2[100] = {0};
					wsprintfW(rs2, L"%hs", rs);
					log->Log(rs2);
#else
					log->Log(rs);
#endif
					log->Log(_T("-------------------------------------------------------------------------------------"));
					log->Release();
				}
				un->Release();
			}
		}
}

TCHAR * __stdcall TSortService::GetVer(int len)
{
	return _T("YES , I GET IT");
}
