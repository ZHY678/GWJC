unit JWCPosition;

interface

uses
  JCWMesh;

  type JC_POSI_EXTTYPE = (
    JCPOSI_RFID_ID = 1,	//读取到RFID标签的位置
    JCPOSI_USER_MARK = 2 //用户备注的信息，用于行车过程中备注一些信息，比如到哪个站了
  );

  const MAX_POSITION_NAME_LENGHT = 32;

  //检测距离信息
  type JCP_Distance = record
    dKiloMark: Double;		//公里标，单位km
    uiDistance: Int64;		//累计的距离，单位1mm，只要车动了，就累加距离
    uiPulseID: Int64;		//脉冲iD，使用脉冲编码器的统计编码信息，或者其他统计的标识距离的信号
    fSpeed: Single;
  end;

  type JC_POLE_TYPE = (
    JCPOLE_POLE,	//普通支柱
	  JCPOLE_MAO		//锚段关
  );

  //支柱名
  type JCP_PoleName = record
    strStation: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;	//站区名
    strMaoName: array [0..MAX_POSITION_NAME_LENGHT - 1] of Char;	//锚段名
    strPoleName: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;	//支柱名
    iPoleMark: Integer;		//定位标志，比如是否锚段关节
  end;

  //检测的线路信息
  type JCP_MesStart = record
    strLineName: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;			//线路名称，比如xxx一号线
    bLineDirection: Boolean;	//线路方向	上行线、下行线
    bKiloMarkInc: Boolean;		//公里标是否递增; true = 递增； false = 递减

    pole_start: JCP_PoleName;		//起始的位置
    distance_start: JCP_Distance;	//起始的位置
  end;

  //设置检测任务的起始位置
  function Jcw_POSI_SetBeginPosition(h: Pointer; const start: JCP_MesStart; strUserMark: string): Integer; cdecl; external 'JCWLib.dll';
//  JCW_RET Jcw_POSI_SetBeginPosition(JCWHANDLE h, const JCP_MesStart& start, std::string& strUserMark);

  function Jcw_POSI_SetEndPosition(h: Pointer; const pole: JCP_PoleName; const distance: JCP_Distance; strUserMark: string): Integer; cdecl; external 'JCWLib.dll';
//  JCW_RET Jcw_POSI_SetEndPosition(JCWHANDLE h, const JCP_PoleName& pole, const JCP_Distance& distance, std::string& strUserMark);

  //设置实时的位置
  function Jcw_POSI_SetRealTimePosition(h: Pointer; const pole: JCP_PoleName; const distance: JCP_Distance): Integer; cdecl; external 'JCWLib.dll';

  //设置拓展数据
  function Jcw_POSI_SetRealTimeExtData(h: Pointer; const pet: JC_POSI_EXTTYPE; const StrData: String): Integer; cdecl; external 'JCWLib.dll';

implementation

end.
