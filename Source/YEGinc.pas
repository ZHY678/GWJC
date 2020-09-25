unit YEGinc;

interface

    //功能：构造一个实例;相当于new 一个对象
    function YEG_CreateInstance: Pointer; cdecl; external 'YEGLib.dll';

    //功能：释放一个实例
    procedure YEG_DestoryInstance(h: Pointer); cdecl; external 'YEGLib.dll';

    //连接到设备，需要指定设备的ip地址
    function YEG_Connect(h: Pointer; strIP: PAnsiChar): Integer; cdecl; external 'YEGLib.dll';

    //断开设备连接
    procedure YEG_Disconnect(h: Pointer); cdecl; external 'YEGLib.dll';

    //启动采集，调用本函数后才会传输扫描点
    function YEG_StartGrab(h: Pointer): Integer; cdecl; external 'YEGLib.dll';

    //停止采集，停止传输扫描结果
    procedure YEG_StopGrab(h: Pointer); cdecl; external 'YEGLib.dll';

    type
      YEGtagPOINTF = record
        x: Single;
        y: Single;
      end;
//      PPOINTF = ^tagPOINTF;
      PPOINTF = array of YEGtagPOINTF;

    //点云回调函数
    //const void* 用户指定的参数
    //double	时间戳，单位秒; 匀速时可简单通过 time * speed = dist(距离）
    //UINT64		帧号码，在外触发模式下，一帧代表一个触发，代表一个间隔距离
    //POINTF	点云的空间点
    //UINT		点的数量
      YEG_fnPointCloudCallBack = procedure(pTag: Pointer; dtimestamp: Double; uiframeNo: Int64; potArray: PPOINTF; uiPotNum: Cardinal);

    //设置扫描点的回调
    function YEG_SetScanPointCallBack(h: Pointer; fn: YEG_fnPointCloudCallBack; pTag: Pointer): Integer; cdecl; external 'YEGLib.dll';

    //功能：设置曝光时间，单位微秒(us)
    function YEG_SetExposureTime(h: Pointer; const uiExpoTimeUS: Cardinal): Integer; cdecl; external 'YEGLib.dll';

    //功能：设置曝光时间，单位微秒(us)
    function YEG_SetGain(h: Pointer; fGain: Single): Integer; cdecl; external 'YEGLib.dll';

implementation

end.
