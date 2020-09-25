unit JCWMesh;

interface

uses
  JCWDataDef;

  //��ȡ������汾��
  function Jcw_GetLibVersionStr(): PAnsiChar; cdecl; external 'JCWLib.dll';

	//���ܣ�����һ��ʵ��
  function Jcw_InitInstance(): Pointer; cdecl; external 'JCWLib.dll';

	//���ܣ��ͷ�һ��ʵ��
  function Jcw_UninitInstance(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//д�������ļ�
  function Jcw_SaveConfig(h: Pointer; const strCfgFile: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//��ȡһ������
  function Jcw_LoadConfig(h: Pointer; const strCfgFile: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ����ò��ò������磺���
	function Jcw_SetDevArrangeParam(h: Pointer; p: JCDevSetupParam): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ������Զ������ݣ�һ�㲻Ҫ���ô˽ӿڣ��˽ӿ�������������Ĳ���
	//iDataTypeID ���ݵ����ͱ�־ֵ
	//pDatas ���ݵ�ָ��
	//uiDataSize ���ݵĴ�С
  function Jcw_SetCustomData(h: Pointer; id: JMDEVID;
  iDataTypeID: Integer; const pDatas: Pointer; uiDataSize: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�Զ������ݣ�һ�㲻Ҫ���ô˽ӿڣ��˽ӿ�������������Ĳ���
	//iDataTypeID ���ݵ����ͱ�־ֵ
	//pBuff ���ڴ洢���ݵ�ָ��
	//uiBuffSize �������ڴ��С
	//uiDataSize ���ݵĴ�С
  function Jcw_GetCustomData(h: Pointer; id: JMDEVID; iDataTypeID: Integer; const pBuff: Pointer;
  uiBuffSize: Cardinal; OUT uiDataSize: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//	JCW_RET Jcw_GetCustomData(JCWHANDLE h, JMDEVID id, int iDataTypeID, const void* pBuff, IN UINT uiBuffSize, OUT UINT& uiDataSize);

	//���ܣ������豸���ӵ�ַ��Ϣ
	//id			�豸ID
	//strDevIP		�豸��IP��ַ
	//uiDevPort		�豸��ͨ�Ŷ˿ڣ��������������д0����ʾʹ��Ĭ�϶˿�
  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PAnsiChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PWideChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';
//  function Jcw_SetDevAddress(h: Pointer; id: JMDEVID; const strDevIP: PChar; uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�Ѿ����õ��豸��ַ�б�
	//idArray		�豸ID�Ļ�����
	//uiBuffNum		�������������������С�������Ϊ uiBuffNum = sizeof(idArray) / sizeof(JMDEVID)
	//uiDevNumber	�����õ��豸����
  function Jcw_GetDevIDList(h: Pointer; idArray: array of JMDEVID; uiBuffNum: Cardinal; OUT uiDevNumber: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�豸���ӵ�ַ��Ϣ
	//id			�豸ID
	//strDevIP		�豸��IP��ַ
	//uiDevPort		�豸��ͨ�Ŷ˿ڣ��������������д0����ʾʹ��Ĭ�϶˿�
  function Jcw_GetDevAddress(h: Pointer; id: JMDEVID; OUT strDevIPBuff: PAnsiChar; OUT uiDevPort: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//�ص������Ķ���
  type
    Jcw_fnJCWResultCallBack = procedure(const pTag: Pointer; const data: JCWJH);

	//���ܣ����ü�������ݻص��Ľӿں���ָ��
  function Jcw_SetResultCallBack(h: Pointer; const pTag: Pointer; fnCB: Jcw_fnJCWResultCallBack): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ����õ�һ�豸�ļ�����ݵĻص�
  function Jcw_SetDevResultCallBack(h: Pointer; id: JMDEVID; const Tag: Pointer; fnCB: Jcw_fnJCWResultCallBack): Integer; cdecl; external 'JCWLib.dll';

	//���ƻص�����
	//UINT64	ϵͳͬ��id������֡��
	//UINT		��֡ͼ��ĵ�n������
	//POINTF*	���ƵĿռ��
	//UINT		2d�������
  type
    Jcw_fnPointCloudCallBack = procedure(pTag: Pointer; uiframeNo: Int64; tmp: Cardinal; potArray: PPOINTF; const uiPotNum: Cardinal);

	//���ܣ������豸�ĵ��ƻص���������ʾ�����δ���
  function Jcw_SetDevPointCloudCallBack(h: Pointer; const pTag: Pointer; fnCB: Jcw_fnPointCloudCallBack): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ��������ݽ��չ��������ò�����Ϻ���ñ��ӿ�
  function Jcw_Start(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ�ֹͣ���ݽ��չ���
  function Jcw_Stop(h: Pointer): Integer; cdecl; external 'JCWLib.dll';
//  procedure Jcw_Stop(h: Pointer); cdecl; external 'JCWLib.dll';

  {$Z4+}
  type IsWork = (
    JCW_DEVSTATE_NOWORK = -1,			//δ����
		JCW_DEVSTATE_DISCONNECT = 0,		//δ����
		JCW_DEVSTATE_WORKING = 1			//��������״̬
  );
  {$Z4-}

	//���ܣ������豸������״̬��״ֵ̬��������ö�ٱ���ֵ
	//iState = JCW_DEVSTATE_NOWORK ������
  function Jcw_GetDevState(h: Pointer; id: JMDEVID; OUT iState: Integer): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�豸�Ĳ���֡��
  function Jcw_GetDevFPS(h: Pointer; id: JMDEVID; OUT fFPS: Single): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�豸���ӵ�ʱ������λ��(s)
  function Jcw_GetDevConnTime(h: Pointer; id: JMDEVID; OUT uiTimeSec: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ������ع�ʱ�䣬��λ΢��(us)
  function Jcw_SetExposureTime(h: Pointer; id: JMDEVID; const uiExpoTime: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�ع�ʱ�䣬��λ΢��(us)
  function Jcw_GetExposureTime(h: Pointer; id: JMDEVID; OUT uiExpoTime: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���������ɼ��ĸ߶�
	//uiOffsetY �����y����ƫ����
	//uiHeight ����ɼ�ͼ��ĸ߶�
  function Jcw_SetCamHei(h: Pointer; id: JMDEVID; const uiOffsetY: Cardinal; const uiHeight: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ����ĸ߶�
	//uiOffsetY �����y����ƫ����
	//uiHeight ����ɼ�ͼ��ĸ߶�
  function Jcw_GetCamHei(h: Pointer; id: JMDEVID; OUT uiOffSetY: Cardinal; OUT uiHeight: Cardinal): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ����ð�װ�Ĳ���
	//����ֵΪŷ������
  function Jcw_SetDevSetupParam(h: Pointer; id: JMDEVID; const dXA: Double; const dXB: Double; const dXC: Double;
  const dYA: Double; const dYB: Double; const dYC: Double): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ���ȡ�豸��װ�Ĳ���
	//����ֵΪŷ������
  function Jcw_GetDevSetupParam(h: Pointer; id: JMDEVID; OUT dXA: Double; OUT dXB: Double; OUT dXC: Double;
  OUT dYA: Double; OUT dYB: Double; OUT dYC: Double): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ����ð�װ����б��
	//dAngle Ҫ�����ĽǶ�
	//dXOffset ˮƽֵ������ֵ; ���㷽ʽ result_x = value_x + dXOffset
	//dYOffset ��ֱֵ��������  ���㷽ʽ result_y = value_y + dYOffset
  function Jcw_SetDevSetupAngle(h: Pointer; id: JMDEVID; const dAngle: Double;
  const dxOffset: Double; const dYOffset: Double): Integer; cdecl; external 'JCWLib.dll';

	//�����豸��ͬ��ID��Ϊ�ͻ������������ͬ��
	//uiSyncID �û�ָ����ID����֮������������У��������д���ֵ��syncid��ֱ�����µ��ø�����ֵ
  function Jcw_SetSyncID(h: Pointer; uiSyncID: Int64): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ�����һ��������԰����ļ������ҿ�ʼ����
	//strFilePath ������ļ���
  function Jcw_CreateDebugDataFile(h: Pointer; const strFilePath: PAnsiChar): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ�ֹͣ����������ݣ����ҹرս���԰����ļ�
  function Jcw_CloseDebugDataFile(h: Pointer): Integer; cdecl; external 'JCWLib.dll';

	//���ܣ��ɼ����Ŀ���������
	//iGrabState �Ƿ�ɼ�
  function Jcw_GrabTargetProfile(h: Pointer; id: JMDEVID; iGrabState: Integer): Integer; cdecl; external 'JCWLib.dll';

implementation

end.
