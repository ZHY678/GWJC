unit JWCPosition;

interface

uses
  JCWMesh;

  type JC_POSI_EXTTYPE = (
    JCPOSI_RFID_ID = 1,	//��ȡ��RFID��ǩ��λ��
    JCPOSI_USER_MARK = 2 //�û���ע����Ϣ�������г������б�עһЩ��Ϣ�����絽�ĸ�վ��
  );

  const MAX_POSITION_NAME_LENGHT = 32;

  //��������Ϣ
  type JCP_Distance = record
    dKiloMark: Double;		//����꣬��λkm
    uiDistance: Int64;		//�ۼƵľ��룬��λ1mm��ֻҪ�����ˣ����ۼӾ���
    uiPulseID: Int64;		//����iD��ʹ�������������ͳ�Ʊ�����Ϣ����������ͳ�Ƶı�ʶ������ź�
    fSpeed: Single;
  end;

  type JC_POLE_TYPE = (
    JCPOLE_POLE,	//��֧ͨ��
	  JCPOLE_MAO		//ê�ι�
  );

  //֧����
  type JCP_PoleName = record
    strStation: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;	//վ����
    strMaoName: array [0..MAX_POSITION_NAME_LENGHT - 1] of Char;	//ê����
    strPoleName: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;	//֧����
    iPoleMark: Integer;		//��λ��־�������Ƿ�ê�ιؽ�
  end;

  //������·��Ϣ
  type JCP_MesStart = record
    strLineName: array [0..MAX_POSITION_NAME_LENGHT - 1] of char;			//��·���ƣ�����xxxһ����
    bLineDirection: Boolean;	//��·����	�����ߡ�������
    bKiloMarkInc: Boolean;		//������Ƿ����; true = ������ false = �ݼ�

    pole_start: JCP_PoleName;		//��ʼ��λ��
    distance_start: JCP_Distance;	//��ʼ��λ��
  end;

  //���ü���������ʼλ��
  function Jcw_POSI_SetBeginPosition(h: Pointer; const start: JCP_MesStart; strUserMark: string): Integer; cdecl; external 'JCWLib.dll';
//  JCW_RET Jcw_POSI_SetBeginPosition(JCWHANDLE h, const JCP_MesStart& start, std::string& strUserMark);

  function Jcw_POSI_SetEndPosition(h: Pointer; const pole: JCP_PoleName; const distance: JCP_Distance; strUserMark: string): Integer; cdecl; external 'JCWLib.dll';
//  JCW_RET Jcw_POSI_SetEndPosition(JCWHANDLE h, const JCP_PoleName& pole, const JCP_Distance& distance, std::string& strUserMark);

  //����ʵʱ��λ��
  function Jcw_POSI_SetRealTimePosition(h: Pointer; const pole: JCP_PoleName; const distance: JCP_Distance): Integer; cdecl; external 'JCWLib.dll';

  //������չ����
  function Jcw_POSI_SetRealTimeExtData(h: Pointer; const pet: JC_POSI_EXTTYPE; const StrData: String): Integer; cdecl; external 'JCWLib.dll';

implementation

end.
