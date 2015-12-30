unit ServicesImplement;

interface

uses WisdomCoreInterfaceForD, ServicesInterface;

type
  TSplashExtPoint = class(TPluginInterfacedObject, ISplashExtPoint)
  private

  public
    procedure Hello();
  end;

implementation

{ TSplashExtPoint}

procedure TSplashExtPoint.Hello;
begin

end;

end.

