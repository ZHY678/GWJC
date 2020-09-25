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

    JCW_OK = 0;					//ִ����ȷ���
    JCW_ERROR_UNKNOW = -1;			//����δ֪����
    JCW_INVALID_HANDLE = -2;		//��Ч��ʵ�����
    JCW_ERR_INVALID_DEVID = -3;	//��Ч�豸ID
    JCW_ERR_ALREADY_START = -4;	//�����������ܸ�������
    JCW_ERR_NO_START = -5;			//δ���������ܸ�������
    JCW_ERR_INVALID_PARAMETER = -6;	//��Ч����ֵ������������Ч��Χ�����߲��������Ч

    JCW_ERR_NOIMPLEMENT = -404;	//δʵ��

//  var
//    JCWHANDLE : Pointer;
//    JCW_RET : Integer;

  {$Z4+}
  type JMDEVID = (
    JMID_GLOBAL = 0,		//ȫ�ֶ��󣬱����������ĵ��ߡ�����ֵ

    JMID_COMP_LEFT = 1,		//�󲹳�
    JMID_COMP_RIGHT = 2,	//�Ҳ���

    JMID_GEO_DEV0 = 11,		//���β���1
    JMID_GEO_DEV1 = 12,		//���β���2
    JMID_GEO_DEV2 = 13,		//���β���3
    JMID_GEO_DEV3 = 14,
    JMID_GEO_DEV4 = 15,
    JMID_GEO_DEV5 = 16,
    JMID_GEO_DEV6 = 17,
    JMID_GEO_DEV7 = 18,


    JMID_TRACK3_LEFT = 21,	//���������
    JMID_TRACK3_RIGHT = 22, //�������ҹ�


    JMID_COMP_LEFT_RF = 101,	//�����󲹳�
    JMID_COMP_RIGHT_RF = 102	//�����Ҳ���
    ); {$Z4-}

  //���߶�λ����
  {$Z4+}
  type JCWPosi = (
    JCXP_UNKNOW = 0,	//δ֪
    JCXP_LINE = 1,		//����λ��
    JCXP_DROPPER = 2,	//����λ��
    JCXP_POLE = 3,		//֧��λ��
    JCXP_ELECCONN = 4,	//������
    JCXP_MAO = 5	   	//ê�ιؽ�λ��
  ); {$Z4-}

  //�Ӵ�������
  {$Z4+}
  type JCXType = (
    JCXT_UNKNOW = 0,	//δ֪��������
    JCXT_FLEX = 1,		//���Ե���
    JCXT_RIGI = 2,		//���Ե���
    JCXT_TRACK3	= 3	  //������
  ); {$Z4-}

  {$Z4+}
  type JCWType = (
    JCWT_UNKNOW = 0,		//δ֪��������
    JCWT_LINE_1 = 1,		//��֧����
    JCWT_LINE_2 = 2,		//˫֧����
    JCWT_MAO_1 = 3,			//��֧����ê�ιؽ�
    JCWT_MAO_2 = 4,			//˫֧����ê�ιؽ�
    JCWT_RF_1 = 5,			//������
    JCWT_RF_2 = 6 			//˫֧���ԣ�������
  ); {$Z4-}

  //�豸��װ����
  type JCDevSetupParam = record
    public
      fTrackDist: Single;	//���
      procedure JCDevSetupParam();
  end;

  //�Ӵ���ĥ��ֵ
  type JCXMH = record
    public
      iLineRidus_UM: Integer;	//����ֱ����ָ�����ߵ�����.��λ(um);eg 13200,15200
      fMsH: Single;				//ĥ��ĺ��(mm)	 <=0 = δ֪
      fSyH: Single;				//ʣ��ĺ��(mm)	 <= 0 = δ֪
      fBotLen: Single;			//����ĳ���(mm)	 <= 0 = δ֪
      procedure JCXMH();
      procedure Reset();
  end;

  //�Ӵ��߲�������
  type JCXData = record
    public
      pntLinePos: tagPOINTF;   //���߿ռ�λ��;x = ����ֵ; y = ����
      mh: JCXMH;               //ĥ��ֵ

      lt: JCXType;             //�Ӵ�������
      posi: JCWPosi;           //�����Ƿ�λ����

      procedure JCXData();
      procedure Reset();
  end;

  type JCWJH = record
    public
      sVersion: Word;   //���ݵİ汾
      sBagSize: Word;   //���ݰ���С
      uiSyncID: Int64;   //ͬ����ID
      dTimestamp: Double;   //������ʱ�����s��
      uiFrameNo: Int64;   //������֡��

      uiLineNum: Cardinal;   //�������ĵ�����������Ӧ ���飺jcx
      jcx: array [0..JCWJH_MAX_LINE_NUM - 1] of JCXData;   //δ�����ļ��β�����ͨ�� uiLineNum ��ʾ��Ч��������
      jcxComp: array [0..JCWJH_MAX_LINE_NUM - 1] of JCXData;   //������ļ��β���;ͨ�� uiLineCompsateNum ��ʾ��Ч��������

      pntCompLeft: tagPOINTF;   //�󲹳�
      pntCompRight: tagPOINTF;   //�Ҳ���

      posi: JCWPosi;   //�Ƿ�λ��
      lt: JCWType;   //���ߵ�����
      uiLineCompsateNum: Cardinal;   //��������Ч�ĵ�����������Ӧ����:jcxComp

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
  iLineRidus_UM := 0;	//0 = δ֪
  fMsH := -1;			//ĥ����, <0 = δ֪
  fSyH := -1;			//����ʣ��ĺ�ȣ�	<= 0 = δ֪
  fBotLen := -1;		//����ĥ����ĳ��� <= 0 = δ֪
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
