unit ServicesInterface;

interface

uses
  {$IFDEF _USE_FOR_CPP}
  WisdomCoreInterfaceForC,
  {$ENDIF}
  WisdomCoreInterfaceForD;

const
  IID_MemoryLoader = '{B069A976-D69E-4935-813A-EB25528A1D25}';

type
  IMemoryLoader = interface(IPluginLoader)
    [IID_MemoryLoader]
  end;


implementation

end.

