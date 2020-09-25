unit JCWDataDef;

interface

  type
    tagPOINTF = record
      x: Single;
      y: Single;
    end;
//      PPOINTF = ^tagPOINTF;
    PPOINTF = array of tagPOINTF;

  const
    JCWJH_MAX_LINE_NUM = 4;
    JCW_INVALIDVALUE = 65536;

    JCW_OK = 0;					//执行正确完成
    JCW_ERROR_UNKNOW = -1;			//发生未知错误
    JCW_INVALID_HANDLE = -2;		//无效的实例句柄
    JCW_ERR_INVALID_DEVID = -3;	//无效设备ID
    JCW_ERR_ALREADY_START = -4;	//已启动，不能更改设置
    JCW_ERR_NO_START = -5;			//未启动，不能更改设置
    JCW_ERR_INVALID_PARAMETER = -6;	//无效参数值，参数超出有效范围，或者参数组合无效

    JCW_ERR_NOIMPLEMENT = -404;	//未实现

//  var
//    JCWHANDLE : Pointer;
//    JCW_RET : Integer;

  {$Z4+}
  type JMDEVID = (
    JMID_GLOBAL = 0,		//全局对象，比如调整整体的导高、拉出值

    JMID_COMP_LEFT = 1,		//左补偿
    JMID_COMP_RIGHT = 2,	//右补偿

    JMID_GEO_DEV0 = 11,		//几何参数1
    JMID_GEO_DEV1 = 12,		//几何参数2
    JMID_GEO_DEV2 = 13,		//几何参数3
    JMID_GEO_DEV3 = 14,
    JMID_GEO_DEV4 = 15,
    JMID_GEO_DEV5 = 16,
    JMID_GEO_DEV6 = 17,
    JMID_GEO_DEV7 = 18,


    JMID_TRACK3_LEFT = 21,	//第三轨左轨
    JMID_TRACK3_RIGHT = 22, //第三轨右轨


    JMID_COMP_LEFT_RF = 101,	//特殊左补偿
    JMID_COMP_RIGHT_RF = 102	//特殊右补偿
    ); {$Z4-}

  //导线定位点类
  {$Z4+}
  type JCWPosi = (
    JCXP_UNKNOW = 0,	//未知
    JCXP_LINE = 1,		//导线位置
    JCXP_DROPPER = 2,	//吊弦位置
    JCXP_POLE = 3,		//支柱位置
    JCXP_ELECCONN = 4,	//电连接
    JCXP_MAO = 5	   	//锚段关节位置
  ); {$Z4-}

  //接触线类型
  {$Z4+}
  type JCXType = (
    JCXT_UNKNOW = 0,	//未知导线类型
    JCXT_FLEX = 1,		//柔性导线
    JCXT_RIGI = 2,		//刚性导线
    JCXT_TRACK3	= 3	  //第三轨
  ); {$Z4-}

  {$Z4+}
  type JCWType = (
    JCWT_UNKNOW = 0,		//未知导线类型
    JCWT_LINE_1 = 1,		//单支导线
    JCWT_LINE_2 = 2,		//双支导线
    JCWT_MAO_1 = 3,			//单支导线锚段关节
    JCWT_MAO_2 = 4,			//双支导线锚段关节
    JCWT_RF_1 = 5,			//刚柔混合
    JCWT_RF_2 = 6 			//双支柔性，刚柔混合
  ); {$Z4-}

  //设备安装参数
  type JCDevSetupParam = record
    public
      fTrackDist: Single;	//轨距
      procedure JCDevSetupParam();
  end;

  //接触线磨耗值
  type JCXMH = record
    public
      iLineRidus_UM: Integer;	//导线直径，指定导线的类型.单位(um);eg 13200,15200
      fMsH: Single;				//磨损的厚度(mm)	 <=0 = 未知
      fSyH: Single;				//剩余的厚度(mm)	 <= 0 = 未知
      fBotLen: Single;			//底面的长度(mm)	 <= 0 = 未知
      procedure JCXMH();
      procedure Reset();
  end;

  //接触线测量数据
  type JCXData = record
    public
      pntLinePos: tagPOINTF;   //导线空间位置;x = 拉出值; y = 导高
      mh: JCXMH;               //磨耗值

      lt: JCXType;             //接触线类型
      posi: JCWPosi;           //导线是否定位导线

      procedure JCXData();
      procedure Reset();
  end;

  type JCWJH = record
    public
      sVersion: Word;   //数据的版本
      sBagSize: Word;   //数据包大小
      uiSyncID: Int64;   //同步的ID
      dTimestamp: Double;   //测量的时间戳（s）
      uiFrameNo: Int64;   //测量的帧号

      uiLineNum: Cardinal;   //测量到的导线数量，对应 数组：jcx
      jcx: array [0..JCWJH_MAX_LINE_NUM - 1] of JCXData;   //未补偿的几何参数，通过 uiLineNum 表示有效内容数量
      jcxComp: array [0..JCWJH_MAX_LINE_NUM - 1] of JCXData;   //补偿后的几何参数;通过 uiLineCompsateNum 表示有效内容数量

      pntCompLeft: tagPOINTF;   //左补偿
      pntCompRight: tagPOINTF;   //右补偿

      posi: JCWPosi;   //是否定位点
      lt: JCWType;   //导线的类型
      uiLineCompsateNum: Cardinal;   //补偿后有效的导线数量，对应数组:jcxComp

      procedure JCWJH();
      procedure Reset();
      function HasCompste(): Boolean;
  end;

implementation

procedure JCDevSetupParam.JCDevSetupParam();
begin
  ;
end;

procedure JCXMH.JCXMH();
begin
  Reset();
end;

procedure JCXMH.Reset();
begin
  iLineRidus_UM := 0;	//0 = 未知
  fMsH := -1;			//磨损厚度, <0 = 未知
  fSyH := -1;			//导线剩余的厚度；	<= 0 = 未知
  fBotLen := -1;		//底面磨损面的长度 <= 0 = 未知
end;

procedure JCXData.JCXData();
begin
  Reset();
end;

procedure JCXData.Reset();
begin
  pntLinePos.x := JCW_INVALIDVALUE;
  pntLinePos.y := JCW_INVALIDVALUE;
  mh.Reset();
  lt := JCXT_UNKNOW;
  posi := JCXP_UNKNOW;
end;

procedure JCWJH.JCWJH();
begin
  Reset();
end;

procedure JCWJH.Reset();
begin
  sVersion := 1;
  sBagSize := sizeof(Self);
  uiSyncID := 0;
  dTimestamp := 0;
  uiFrameNo := 0;
  uiLineNum := 0;
  uiLineCompsateNum := 0;
  lt := JCWT_UNKNOW;

  pntCompLeft.x := JCW_INVALIDVALUE;
  pntCompLeft.y := JCW_INVALIDVALUE;
  pntCompRight.x := JCW_INVALIDVALUE;
  pntCompRight.y := JCW_INVALIDVALUE;
end;

function JCWJH.HasCompste: Boolean;
begin
  Result := ((pntCompLeft.x <> JCW_INVALIDVALUE) and (pntCompRight.x <> JCW_INVALIDVALUE));
end;

end.
