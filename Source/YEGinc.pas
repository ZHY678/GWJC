unit YEGinc;

interface

    //���ܣ�����һ��ʵ��;�൱��new һ������
    function YEG_CreateInstance: Pointer; cdecl; external 'YEGLib.dll';

    //���ܣ��ͷ�һ��ʵ��
    procedure YEG_DestoryInstance(h: Pointer); cdecl; external 'YEGLib.dll';

    //���ӵ��豸����Ҫָ���豸��ip��ַ
    function YEG_Connect(h: Pointer; strIP: PAnsiChar): Integer; cdecl; external 'YEGLib.dll';

    //�Ͽ��豸����
    procedure YEG_Disconnect(h: Pointer); cdecl; external 'YEGLib.dll';

    //�����ɼ������ñ�������Żᴫ��ɨ���
    function YEG_StartGrab(h: Pointer): Integer; cdecl; external 'YEGLib.dll';

    //ֹͣ�ɼ���ֹͣ����ɨ����
    procedure YEG_StopGrab(h: Pointer); cdecl; external 'YEGLib.dll';

    type
      YEGtagPOINTF = record
        x: Single;
        y: Single;
      end;
//      PPOINTF = ^tagPOINTF;
      PPOINTF = array of YEGtagPOINTF;

    //���ƻص�����
    //const void* �û�ָ���Ĳ���
    //double	ʱ�������λ��; ����ʱ�ɼ�ͨ�� time * speed = dist(���룩
    //UINT64		֡���룬���ⴥ��ģʽ�£�һ֡����һ������������һ���������
    //POINTF	���ƵĿռ��
    //UINT		�������
      YEG_fnPointCloudCallBack = procedure(pTag: Pointer; dtimestamp: Double; uiframeNo: Int64; potArray: PPOINTF; uiPotNum: Cardinal);

    //����ɨ���Ļص�
    function YEG_SetScanPointCallBack(h: Pointer; fn: YEG_fnPointCloudCallBack; pTag: Pointer): Integer; cdecl; external 'YEGLib.dll';

    //���ܣ������ع�ʱ�䣬��λ΢��(us)
    function YEG_SetExposureTime(h: Pointer; const uiExpoTimeUS: Cardinal): Integer; cdecl; external 'YEGLib.dll';

    //���ܣ������ع�ʱ�䣬��λ΢��(us)
    function YEG_SetGain(h: Pointer; fGain: Single): Integer; cdecl; external 'YEGLib.dll';

implementation

end.
