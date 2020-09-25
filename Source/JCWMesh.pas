unit JCWMesh;

interface

uses
  JCWDataDef;

  //获取开发库版本号
  function Jcw_GetLibVersionStr(): PAnsiChar; cdecl; external 'JCWLib.dll';

	//功能：构造一个实例
  function Jcw_InitInstance(): Pointer; cdecl; external 'JCWLib.dll';

	//功能：释放一个实例
  function Jcw_UninitInstance(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//写入配置文件
  function Jcw_SaveConfig(h: Pointer; const strCfgFile: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//读取一份配置
  function Jcw_LoadConfig(h: Pointer; const strCfgFile: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置布置参数，如：轨距
	function Jcw_SetDevArrangeParam(h: Pointer; p: JCDevSetupParam): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置自定义数据，一般不要调用此接口，此接口用于设置特殊的参数
	//iDataTypeID 数据的类型标志值
	//pDatas 数据的指针
	//uiDataSize 数据的大小
  function Jcw_SetCustomData(h: Pointer; id: JMDEVID;
  iDataTypeID: Integer; const pDatas: Pointer; uiDataSize: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取自定义数据，一般不要调用此接口，此接口用于设置特殊的参数
	//iDataTypeID 数据的类型标志值
	//pBuff 用于存储数据的指针
	//uiBuffSize 缓存块的内存大小
	//uiDataSize 数据的大小
  function Jcw_GetCustomData(h: Pointer; id: JMDEVID; iDataTypeID: Integer; const pBuff: Pointer;
  uiBuffSize: Cardinal; OUT uiDataSize: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//	JCW_RET Jcw_GetCustomData(JCWHANDLE h, JMDEVID id, int iDataTypeID, const void* pBuff, IN UINT uiBuffSize, OUT UINT& uiDataSize);

	//功能：设置设备连接地址信息
	//id			设备ID
	//strDevIP		设备的IP地址
	//uiDevPort		设备的通信端口；非特殊情况，填写0，表示使用默认端口
  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PAnsiChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PWideChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取已经设置的设备地址列表
	//idArray		设备ID的缓冲区
	//uiBuffNum		缓冲区的数量，数组大小；可理解为 uiBuffNum = sizeof(idArray) / sizeof(JMDEVID)
	//uiDevNumber	已设置的设备数量
  function Jcw_GetDevIDList(h: Pointer; idArray: array of JMDEVID; uiBuffNum: Cardinal; OUT uiDevNumber: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取设备连接地址信息
	//id			设备ID
	//strDevIP		设备的IP地址
	//uiDevPort		设备的通信端口；非特殊情况，填写0，表示使用默认端口
  function Jcw_GetDevAddress(h: Pointer; id: JMDEVID; OUT strDevIPBuff: PAnsiChar; OUT uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//回调函数的定义
  type
    Jcw_fnJCWResultCallBack = procedure(const pTag: Pointer; const data: JCWJH);

	//功能：设置检测结果数据回调的接口函数指针
  function Jcw_SetResultCallBack(h: Pointer; const pTag: Pointer; fnCB: Jcw_fnJCWResultCallBack): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置单一设备的检测数据的回调
  function Jcw_SetDevResultCallBack(h: Pointer; id: JMDEVID; const Tag: Pointer; fnCB: Jcw_fnJCWResultCallBack): Integer; cdecl; external 'JCWLib.dll';

	//点云回调函数
	//UINT64	系统同步id，或者帧号
	//UINT		单帧图像的第n组数据
	//POINTF*	点云的空间点
	//UINT		2d点的数量
  type
    Jcw_fnPointCloudCallBack = procedure(pTag: Pointer; uiframeNo: Int64; tmp: Cardinal; potArray: PPOINTF; const uiPotNum: Cardinal);

	//功能：设置设备的点云回调，用于显示及二次处理
  function Jcw_SetDevPointCloudCallBack(h: Pointer; const pTag: Pointer; fnCB: Jcw_fnPointCloudCallBack): Integer; cdecl; external 'JCWLib.dll';

	//功能：启动数据接收工作，设置参数完毕后调用本接口
  function Jcw_Start(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//功能：停止数据接收工作
  function Jcw_Stop(h: Pointer): Integer; cdecl; external 'JCWLib.dll';
//  procedure Jcw_Stop(h: Pointer); cdecl; external 'JCWLib.dll';

  {$Z4+}
  type IsWork = (
    JCW_DEVSTATE_NOWORK = -1,			//未工作
		JCW_DEVSTATE_DISCONNECT = 0,		//未连接
		JCW_DEVSTATE_WORKING = 1			//正常工作状态
  );
  {$Z4-}

	//功能：返回设备的连接状态，状态值参数以上枚举变量值
	//iState = JCW_DEVSTATE_NOWORK 。。。
  function Jcw_GetDevState(h: Pointer; id: JMDEVID; OUT iState: Integer): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取设备的测量帧率
  function Jcw_GetDevFPS(h: Pointer; id: JMDEVID; OUT fFPS: Single): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取设备连接的时长，单位秒(s)
  function Jcw_GetDevConnTime(h: Pointer; id: JMDEVID; OUT uiTimeSec: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置曝光时间，单位微秒(us)
  function Jcw_SetExposureTime(h: Pointer; id: JMDEVID; const uiExpoTime: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取曝光时间，单位微秒(us)
  function Jcw_GetExposureTime(h: Pointer; id: JMDEVID; OUT uiExpoTime: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置相机采集的高度
	//uiOffsetY 相机的y方向偏移量
	//uiHeight 相机采集图像的高度
  function Jcw_SetCamHei(h: Pointer; id: JMDEVID; const uiOffsetY: Cardinal; const uiHeight: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取相机的高度
	//uiOffsetY 相机的y方向偏移量
	//uiHeight 相机采集图像的高度
  function Jcw_GetCamHei(h: Pointer; id: JMDEVID; OUT uiOffSetY: Cardinal; OUT uiHeight: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置安装的参数
	//参数值为欧拉矩阵
  function Jcw_SetDevSetupParam(h: Pointer; id: JMDEVID; const dXA: Double; const dXB: Double; const dXC: Double;
  const dYA: Double; const dYB: Double; const dYC: Double): Integer; cdecl; external 'JCWLib.dll';

	//功能：获取设备安装的参数
	//参数值为欧拉矩阵
  function Jcw_GetDevSetupParam(h: Pointer; id: JMDEVID; OUT dXA: Double; OUT dXB: Double; OUT dXC: Double;
  OUT dYA: Double; OUT dYB: Double; OUT dYC: Double): Integer; cdecl; external 'JCWLib.dll';

	//功能：设置安装的倾斜角
	//dAngle 要修正的角度
	//dXOffset 水平值的修正值; 计算方式 result_x = value_x + dXOffset
	//dYOffset 垂直值得修正量  计算方式 result_y = value_y + dYOffset
  function Jcw_SetDevSetupAngle(h: Pointer; id: JMDEVID; const dAngle: Double;
  const dxOffset: Double; const dYOffset: Double): Integer; cdecl; external 'JCWLib.dll';

	//设置设备的同步ID，为客户程序关联数据同步
	//uiSyncID 用户指定的ID，在之后的所有数据中，都将带有此数值的syncid，直到重新调用更新数值
  function Jcw_SetSyncID(h: Pointer; uiSyncID: Int64): Integer; cdecl; external 'JCWLib.dll';

	//功能：创建一个保存调试包的文件，并且开始保存
	//strFilePath 保存的文件名
  function Jcw_CreateDebugDataFile(h: Pointer; const strFilePath: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//功能：停止保存调试数据，并且关闭结调试包的文件
  function Jcw_CloseDebugDataFile(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//功能：采集检测目标的轮廓点
	//iGrabState 是否采集
  function Jcw_GrabTargetProfile(h: Pointer; id: JMDEVID; iGrabState: Integer): Integer; cdecl; external 'JCWLib.dll';

implementation

end.
