object DmHttpSrv: TDmHttpSrv
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 640
  Top = 129
  Height = 150
  Width = 215
  object RtcHs: TRtcHttpServer
    MultiThreaded = True
    ServerAddr = '0.0.0.0'
    ServerPort = '80'
    RestartOn.ListenLost = True
    RestartOn.ListenError = True
    OnDataOut = RtcHsDataOut
    OnDataIn = RtcHsDataIn
    Left = 24
    Top = 8
  end
  object RtcDp: TRtcDataProvider
    Server = RtcHs
    OnCheckRequest = RtcDpCheckRequest
    OnDataReceived = RtcDpDataReceived
    Left = 64
    Top = 8
  end
end
