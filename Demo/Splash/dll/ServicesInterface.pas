unit ServicesInterface;

interface

const
  IID_SplashExtPoint = '{7984E679-14A1-4ABC-976F-E091DF142C5D}';

type
  ISplashExtPoint = interface(IInterface)
    [IID_SplashExtPoint]
    procedure Hello();
  end;


implementation

end.

