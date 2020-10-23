unit UI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, UI_LineSetting,
  System.Actions, Vcl.ActnList, dxSkinsCore, dxSkinsDefaultPainters,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.Ribbon, cxClasses, dxBar, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxRibbonSkins,
  dxRibbonCustomizationForm, dxRibbon, Vcl.ExtCtrls, dxStatusBar,
  dxRibbonStatusBar, RzTabs, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart, UGlobalpara, JCWMesh, JCWDataDef, YEGinc,
  UI_SensorSetting, System.IniFiles, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer, IdSocketHandle, IdGlobal, sfContnrs, UFirFilter, MtxExpr;

type
  data2D = record
    lineWidth, lineHeight, lineWidthValue, lineHeightValue: Single;
  end;

  sResultDataPara = record              //��Ϣͷ
    lineName: array [0..99] of Char;    //��·����
    Version: Byte;                      //����汾
    reserved: array [0..394] of Byte;   //Ԥ��
    inight: Integer;                    //��ʼ�˺�
    inidis: Integer;                    //��ʼ����꣬��λm
    Buchang: Integer;                   //�����������λm   value*10000
    shangxia: Byte;                     //�����У�0=δ֪ 1=���� 2=���У�
    rundir: Byte;                       //������1=�� 0=����
    initzengjian: Byte;                 //���������1=�� 0=����
    DataTime: array [0..11] of Char;    //�ɼ�ʱ�� YYMMDDHHMMSS
  end;

  sDataFrame = record                    //����
    LCZ11_value: Single;                 //�Ӵ���1����ֵ1��mm
    LCZ12_value: Single;                 //�Ӵ���1����ֵ2������˫��ʱ����mm
    LCZSP1_value: Single;                //�Ӵ���1ˮƽ���루����˫��ʱ����mm
    LCZ21_value: Single;                 //�Ӵ���2����ֵ1��mm
    LCZ22_value: Single;                 //�Ӵ���2����ֵ2������˫��ʱ����mm
    LCZSP2_value: Single;                //�Ӵ���2ˮƽ���루����˫��ʱ����mm
    DGZ11_value: Single;                 //�Ӵ���1����ֵ1��mm
    DGZ12_value: Single;                 //�Ӵ���1����ֵ2������˫��ʱ����mm
    DGZ21_value: Single;                 //�Ӵ���2����ֵ1��mm
    DGZ22_value: Single;                 //�Ӵ���2����ֵ2������˫��ʱ����mm
    SPJL_value: Single;                  //ê�λ��߲洦�Ӵ���ˮƽ���룬mm
    SPGC_value: Single;                  //ê�λ��߲洦�Ӵ��߸߲mm
    DGBHL_value: Single;                 //���߱仯��
    DWDGC_value: Single;                 //��λ��߲mm
    JCL_value: Single;                   //�Ӵ�����N
    JCL_mean: Single;                    //�Ӵ�����ֵ��N
    JCL_max: Single;                     //�Ӵ������ֵ��N
    JCL_min: Single;                     //�Ӵ�����Сֵ��N
    JCL_std: Single;                     //�Ӵ�����׼����
    YD1_value: Single;                   //Ӳ��1������ٶ�ֵ��m/s^2
    YD2_value: Single;                   //Ӳ��2������ٶ�ֵ��m/s^2
    DL_value: Single;                    //����ֵ��A
    RH_value: Single;                    //�������ڱ��ֵ30%��ʱ�䣬ms
    RH_time: Single;                     //ȼ������ʱ�䣬ms
    RH_numb: Single;                     //ȼ������
    reserved: array [0..6] of Integer;   //����
    FrameID: Integer;                    //��Ƶ֡��
    ghNumb: Integer;                     //�˺�
    myspeed: Single;                     //�ٶȣ���λkm/h
    mykilo: Double;                      //����꣬��λm
    mark: Byte;                          //   01���������� 02����ê�λ��߲� 03�����쳣����
    CheckTime: Integer;                  //���ʱ�䣬����Ϣͷ�ɼ�ʱ�俪ʼ��ʱ�䣬��λms
  end;

  TRecord_OriginalHv = record
    OHv: array [0..69] of Byte;
  end;

  TRecord_Hv = record
    Power1, Power2, Power3, Power4, HardSpot1, HardSpot2, HardSpot3, HardSpot4, HardSpot5, HardSpot6: Single;
  end;

  TRecord_OriginalLv = record
    OLv: array [0..7] of Byte;
  end;

  TRecord_Lv = record
    Electric: Single;
    encoder: Integer;
    Status1, Status2: Byte;
  end;

  Record_SaveOriginal = record
    Om_data: JCWJH;
    OHvData: TRecord_OriginalHv;
    OLvData: TRecord_OriginalLv;
  end;

  TData_2D = record
    Data_2D: array [0..199] of JCWJH;
  end;

  TData_Hv = record
    Data_Hv: array [0..199] of TRecord_OriginalHv;
  end;

  TData_Lv = record
    Data_Lv: array [0..199] of TRecord_OriginalLv;
  end;

  TData_Extra = record
    LCZSP1_value: Single;                //�Ӵ���1ˮƽ���루����˫��ʱ����mm
    LCZSP2_value: Single;                //�Ӵ���2ˮƽ���루����˫��ʱ����mm
    SPJL_value: Single;                  //ê�λ��߲洦�Ӵ���ˮƽ���룬mm
    SPGC_value: Single;                  //ê�λ��߲洦�Ӵ��߸߲mm
    DGBHL_value: Single;                 //���߱仯��
    DWDGC_value: Single;                 //��λ��߲mm
    ghNumb: Integer;                     //�˺�
    myspeed: Single;                     //�ٶȣ���λkm/h
    mykilo: Double;                      //����꣬��λm
    mark: Byte;                          //   01���������� 02����ê�λ��߲� 03�����쳣����
    CheckTime: Integer;                  //���ʱ�䣬����Ϣͷ�ɼ�ʱ�俪ʼ��ʱ�䣬��λms
  end;

  TData_Dealing = record
    TempJCWJH: JCWJH;
    TempHv: TRecord_Hv;
    TempLv: TRecord_Lv;
  end;

  TForm_UI = class(TForm)
    MainMenu_UI: TMainMenu;
    MenuItem_Setting: TMenuItem;
    MenuItem_Collect: TMenuItem;
    MenuItem_Help: TMenuItem;
    MenuItem_Init: TMenuItem;
    MenuItem_Sensor: TMenuItem;
    MenuItem_Restore: TMenuItem;
    MenuItem_Version: TMenuItem;
    MenuItem_StartCollect: TMenuItem;
    MenuItem_StopCollect: TMenuItem;
    MenuItem_Save: TMenuItem;
    MenuItem_Server: TMenuItem;
    MenuItem_LineAndSensor: TMenuItem;
    MenuItem_StartSave: TMenuItem;
    MenuItem_StopSave: TMenuItem;
    MenuItem_Connect: TMenuItem;
    MenuItem_DisConnect: TMenuItem;
    MenuItem_InitLine: TMenuItem;
    MenuItem_Close: TMenuItem;
    ActionList: TActionList;
    Action_OpenLineUI: TAction;
    Action_CloseLineUI: TAction;
    Action_Version: TAction;
    Action_Close: TAction;
    dxBarManager: TdxBarManager;
    MenuItem_Playback: TMenuItem;
    MenuItem_SelectData: TMenuItem;
    MenuItem_StartPlayback: TMenuItem;
    MenuItem_Pauseplayback: TMenuItem;
    OpenDialog: TOpenDialog;
    dxRibbonTab_System: TdxRibbonTab;
    dxRibbon: TdxRibbon;
    dxRibbonTab_Debug: TdxRibbonTab;
    ManagerBar_Setting: TdxBar;
    ManagerBar_System: TdxBar;
    LargeButton_InitSetting: TdxBarLargeButton;
    LargeButton_Recovery: TdxBarLargeButton;
    LargeButton_Info: TdxBarLargeButton;
    LargeButton_Close: TdxBarLargeButton;
    ManagerBar_Collect: TdxBar;
    ManagerBar_Save: TdxBar;
    ManagerBar_Server: TdxBar;
    ManagerBar_LineAndSensor: TdxBar;
    ManagerBar_Playback: TdxBar;
    LargeButton_StartCollect: TdxBarLargeButton;
    LargeButton_StopCollect: TdxBarLargeButton;
    LargeButton_StartSave: TdxBarLargeButton;
    LargeButton_StopSave: TdxBarLargeButton;
    LargeButton_Connect: TdxBarLargeButton;
    LargeButton_Disconnect: TdxBarLargeButton;
    LargeButton_Line: TdxBarLargeButton;
    LargeButton_SelectData: TdxBarLargeButton;
    LargeButton_StartPlayback: TdxBarLargeButton;
    LargeButton_StopPlayback: TdxBarLargeButton;
    LargeButton_Pause: TdxBarLargeButton;
    MenuItem_Pause: TMenuItem;
    MenuItem_Display: TMenuItem;
    MenuItem_Conductor: TMenuItem;
    MenuItem_Parameter: TMenuItem;
    MenuItem_Contactforce: TMenuItem;
    MenuItem_Hardspot: TMenuItem;
    MenuItem_Electric: TMenuItem;
    MenuItem_Arcing: TMenuItem;
    ManagerBar_Display: TdxBar;
    LargeButton_Conductor: TdxBarLargeButton;
    LargeButton_Parameter: TdxBarLargeButton;
    LargeButton_Contactforce: TdxBarLargeButton;
    LargeButton_Hardspot: TdxBarLargeButton;
    LargeButton_Electric: TdxBarLargeButton;
    LargeButton_Arcing: TdxBarLargeButton;
    dxRibbonStatusBar: TdxRibbonStatusBar;
    Timer: TTimer;
    RzPageControl: TRzPageControl;
    TabSheet_Conductor: TRzTabSheet;
    TabSheet_Parameter: TRzTabSheet;
    TabSheet_Contactforce: TRzTabSheet;
    TabSheet_Hardspot: TRzTabSheet;
    TabSheet_Electric: TRzTabSheet;
    TabSheet_Acying: TRzTabSheet;
    Chart_Condutor: TChart;
    Chart_Electric: TChart;
    Chart_Contactforce: TChart;
    Chart_Parameter: TChart;
    Chart_Acying: TChart;
    Chart_Hardspot: TChart;
    Series_Line1Width: TFastLineSeries;
    Series_Line1Height: TFastLineSeries;
    Series_Line2Width: TFastLineSeries;
    Series_Line2Height: TFastLineSeries;
    Series_LineDistance1: TFastLineSeries;
    Series_Line3Width: TFastLineSeries;
    Series_Line3Height: TFastLineSeries;
    Series_Line4Width: TFastLineSeries;
    Series_Line4Height: TFastLineSeries;
    Series_LineDistance2: TFastLineSeries;
    Series_Width: TFastLineSeries;
    Series_Height: TFastLineSeries;
    Series_Changerate: TFastLineSeries;
    Series_Elevation: TFastLineSeries;
    Series_Force: TFastLineSeries;
    Series_ForceAve: TFastLineSeries;
    Series_ForceMax: TFastLineSeries;
    Series_ForceMin: TFastLineSeries;
    Series_ForceVariance: TFastLineSeries;
    Series_Vacc1: TFastLineSeries;
    Series_Vacc2: TFastLineSeries;
    Series_ElectricValue: TFastLineSeries;
    Series_ElectricTime: TFastLineSeries;
    Series_AcyingTime: TFastLineSeries;
    Series_AcyingCount: TFastLineSeries;
    Action_ConductorDisplay: TAction;
    Action_ParameterDisplay: TAction;
    Action_ForceDisplay: TAction;
    Action_HardspotDisplay: TAction;
    Action_ElectricDisplay: TAction;
    Action_AcyingDisplay: TAction;
    Action_Restore: TAction;
    Action_StopCollect: TAction;
    Action_StartCollect: TAction;
    LargeButton_Sensor: TdxBarLargeButton;
    Action_OpenSensorUI: TAction;
    Timer_InitSubGroup: TTimer;
    IdUDPServer_Hv: TIdUDPServer;
    MenuItem_Calibration: TMenuItem;
    Action_StartCalibrate: TAction;
    Action_StopCalibrate: TAction;
    LargeButton_StartCalibrate: TdxBarLargeButton;
    LargeButton_StopCalibrate: TdxBarLargeButton;
    MenuItem_StopCalibrate: TMenuItem;
    IdUDPServer_Lv: TIdUDPServer;
    IdUDPServer_Acying: TIdUDPServer;
    Action_StartSave: TAction;
    Action_StopSave: TAction;
    Action_OpenFile: TAction;
    Action_StartPlayback: TAction;
    Action_StopPlayback: TAction;
    procedure Action_OpenLineUIExecute(Sender: TObject);
    procedure Action_CloseLineUIExecute(Sender: TObject);
    procedure Action_VersionExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure dxRibbonMinimizedChanged(Sender: TdxCustomRibbon);
    procedure Action_ConductorDisplayExecute(Sender: TObject);
    procedure Action_ParameterDisplayExecute(Sender: TObject);
    procedure Action_ForceDisplayExecute(Sender: TObject);
    procedure Action_HardspotDisplayExecute(Sender: TObject);
    procedure Action_ElectricDisplayExecute(Sender: TObject);
    procedure Action_AcyingDisplayExecute(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action_StopCollectExecute(Sender: TObject);
    procedure Action_StartCollectExecute(Sender: TObject);
    procedure Action_OpenSensorUIExecute(Sender: TObject);
    procedure Timer_InitSubGroupTimer(Sender: TObject);
    procedure IdUDPServer_HvUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Action_StartCalibrateExecute(Sender: TObject);
    procedure Action_StopCalibrateExecute(Sender: TObject);
    procedure IdUDPServer_LvUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure IdUDPServer_AcyingUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Action_StartSaveExecute(Sender: TObject);
    procedure Action_StopSaveExecute(Sender: TObject);
    procedure Action_OpenFileExecute(Sender: TObject);
    procedure Action_StartPlaybackExecute(Sender: TObject);
    procedure Action_StopPlaybackExecute(Sender: TObject);
  private
    { Private declarations }
    errorLogPath, backupFilePath: String;   //�����ļ�·��
    LineName, TCPIP, HvUDPIP, HvUDPPort, LvUDPIP, LvUDPPort, AcyingUDPIP, AcyingUDPPort: string;
    IsDebug, drawThreshold: Byte;

    FGlobalpara: TGlobalpara;

    procedure InitFolder;
    function JCWSetIP(tempTCPIP: string): Integer;
    function YEGConnect(tempTCPIP: string): Integer;
    procedure YEGDisconnect;
    procedure LoadOriginalData(TempLoadOriginalPath: string);
  public
    { Public declarations }
    //2D���ݱ�������������ֵ��
    m_data: JCWJH;
//    m_lock: THandle;

    //2D���ݱ������������ݣ�
    m_vecPot : array of YEGtagPOINTF;
    m_dTimeStampLast: Single;
    m_uiFrameNo, m_uiFrameRecvCount, m_uiPotNum: Cardinal;
//    m_mutex: THandle;

    m_hjcw: Pointer;
    m_iDevid: JMDEVID;

    m_hYEG: Pointer;   //ָ���Cardinal������

    pSaveThread, pProcessThread, pDrawThread: DWORD;   //�����߳�
    startMs, nowMs: DWORD;
    startTime: string;
    configurationFilePath, TempOrignalDataPath, TempResultDataPath, savedOriginalDataPath, savedResultDataPath: string;

    CS: TRTLCriticalSection;

    tempData_2D: TData_2D;
    tempData_Hv: TData_Hv;
    tempData_Lv: TData_Lv;
    calCounts, drawCounts, counts: Word;

    IsRun, IsSave, IsPlayback, IsCalibrating: Boolean;

    Data2DCache, HvUDPCache, LvUDPCache, AcyingCache, DrawCache, OriginalCache, ResultCache: TsfQueue;

    array_DataDeal: array [0..999] of Record_SaveOriginal;    //��ԭʼ��������
    array_DataDealing: array[0..999] of TData_Dealing;   //��������е����飬�����˲��������
    array_ResultDeal: array[0..999] of sDataFrame;   //�����Ľ������
    temp_X, temp_Y: array[0..3] of Single;   //2D����ֵȡǰһ��ֵ����

    calibrate_Force, calibrate_Electricity, calibrate_Power1, calibrate_Power2, calibrate_Power3, calibrate_Power4, calibrate_ACC1, calibrate_ACC2, calibrate_ACC3, calibrate_ACC4, calibrate_ACC5, calibrate_ACC6: Single;

    //��ͨ�˲���
    FirFilter_LowPassPower1: TFirFilter;
    FirFilter_LowPassPower2: TFirFilter;
    FirFilter_LowPassPower3: TFirFilter;
    FirFilter_LowPassPower4: TFirFilter;
    FirFilter_LowPassHardSpot1: TFirFilter;
    FirFilter_LowPassHardSpot2: TFirFilter;
    FirFilter_LowPassHardSpot3: TFirFilter;
    FirFilter_LowPassHardSpot4: TFirFilter;
    FirFilter_LowPassHardSpot5: TFirFilter;
    FirFilter_LowPassHardSpot6: TFirFilter;
    FirFilter_LowPassHardElectric: TFirFilter;

    //ƽ���˲���
    FirFilter_2DAverageX1: TFirFilter;
    FirFilter_2DAverageY1: TFirFilter;
    FirFilter_2DAverageXX1: TFirFilter;
    FirFilter_2DAverageYY1: TFirFilter;
    FirFilter_2DAverageX2: TFirFilter;
    FirFilter_2DAverageY2: TFirFilter;
    FirFilter_2DAverageXX2: TFirFilter;
    FirFilter_2DAverageYY2: TFirFilter;
    FirFilter_2DAverageX3: TFirFilter;
    FirFilter_2DAverageY3: TFirFilter;
    FirFilter_2DAverageXX3: TFirFilter;
    FirFilter_2DAverageYY3: TFirFilter;
    FirFilter_2DAverageX4: TFirFilter;
    FirFilter_2DAverageY4: TFirFilter;
    FirFilter_2DAverageXX4: TFirFilter;
    FirFilter_2DAverageYY4: TFirFilter;

    function Init2DIP: Integer;
    function Open2D: Integer;
    procedure Close2D;
    procedure UDPStartCollect;
    procedure UDPStopCollect;
    procedure InitConfigurationFile;
    procedure InitSubGroup;
    procedure SaveOriginalData(TempData: Record_SaveOriginal);
    procedure SaveResultData(TempData: sDataFrame);
    function AToV(kind_V: Byte; temp_A: Word): Single;
  end;

var
  Form_UI: TForm_UI;

implementation

{$R *.dfm}

function SaveThread(p: Pointer): Integer; stdcall;
var
  TempOrignalData: ^Record_SaveOriginal;
  TempOData: Record_SaveOriginal;
  TempResultData: ^sDataFrame;
  TempRData: sDataFrame;
begin
  while True do
  begin
    if Form_UI.OriginalCache.Count > 0 then
    begin
      TempOrignalData := Form_UI.OriginalCache.Pop;
      CopyMemory(@TempOData, TempOrignalData, SizeOf(Record_SaveOriginal));
      Dispose(TempOrignalData);
      Form_UI.SaveOriginalData(TempOData);
    end;

    if Form_UI.ResultCache.count > 0 then
    begin
      TempResultData := Form_UI.ResultCache.Pop;
      CopyMemory(@TempRData, TempResultData, SizeOf(Record_SaveOriginal));
      Dispose(TempResultData);
      Form_UI.SaveResultData(TempRData);
    end;

    Sleep(1);
  end;
end;

function ProcessThread(p: Pointer): Integer; stdcall;
var
  I: Word;
  J: Byte;
  TempWord: array [0..1] of Byte;
  TempInteger: array [0..3] of Byte;
  TempData2D: ^JCWJH;
  TempDataO2D: JCWJH;
  TempDataHv: ^TRecord_OriginalHv;
  TempDataOHv: TRecord_OriginalHv;
  TempDataLv: ^TRecord_OriginalLv;
  TempDataOLv: TRecord_OriginalLv;
  TempDataSO: ^Record_SaveOriginal;
  vector_X1, vector_Y1, vector_X2, vector_Y2, vector_X3, vector_Y3, vector_X4, vector_Y4: Vector;
  vector_Power1, vector_Power2, vector_Power3, vector_Power4, vector_HardSpot1, vector_HardSpot2, vector_HardSpot3, vector_HardSpot4, vector_HardSpot5, vector_HardSpot6, vector_Electricity: Vector;
begin
  while True do
  begin
    //����ȡֵ������2D�����ڲ��ԣ�
    if Form_UI.Data2DCache.count > 200 then
    begin
      if Form_UI.counts < 801 then
      begin
        for I := 0 to 199 do
        begin
          TempData2D := Form_UI.Data2DCache.Pop;
          CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
          Dispose(TempData2D);

          Form_UI.Array_DataDeal[I + Form_UI.counts].Om_data := TempDataO2D;
        end;
        Form_UI.counts := Form_UI.counts + 200;
      end
      else
      begin
        for I := 0 to 799 do
        begin
          Form_UI.Array_DataDeal[I] := Form_UI.Array_DataDeal[I + Form_UI.counts - 800];
        end;
        for I := 800 to 999 do
        begin
          TempData2D := Form_UI.Data2DCache.Pop;
          CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
          Dispose(TempData2D);
          Form_UI.Array_DataDeal[I].Om_data := TempDataO2D;
        end;
      end;
    end;

    //����ȡֵ
    if (Form_UI.Data2DCache.count > 200) and (Form_UI.HvUDPCache.count > 200) and (Form_UI.LvUDPCache.count > 200) then
    begin
      if Form_UI.counts < 801 then
      begin
        for I := Form_UI.counts to Form_UI.counts + 199 do
        begin
          TempData2D := Form_UI.Data2DCache.Pop;
          CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
          Dispose(TempData2D);
          Form_UI.Array_DataDeal[I].Om_data := TempDataO2D;

          TempDataHv := Form_UI.HvUDPCache.Pop;
          CopyMemory(@TempDataOHv, TempDataHv, SizeOf(TRecord_OriginalHv));
          Dispose(TempDataHv);
          Form_UI.Array_DataDeal[I].OHvData := TempDataOHv;

          TempDataLv := Form_UI.LvUDPCache.Pop;
          CopyMemory(@TempDataOLv, TempDataLv, SizeOf(TRecord_OriginalLv));
          Dispose(TempDataLv);
          Form_UI.Array_DataDeal[I].OLvData := TempDataOLv;
        end;
        Form_UI.counts := Form_UI.counts + 200;
      end
      else
      begin
        for I := 0 to 799 do
        begin
          Form_UI.Array_DataDeal[I] := Form_UI.Array_DataDeal[I + Form_UI.counts - 800];
        end;
        for I := 800 to 999 do
        begin
          TempData2D := Form_UI.Data2DCache.Pop;
          CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
          Dispose(TempData2D);
          Form_UI.Array_DataDeal[I].Om_data := TempDataO2D;

          TempDataHv := Form_UI.HvUDPCache.Pop;
          CopyMemory(@TempDataOHv, TempDataHv, SizeOf(TRecord_OriginalHv));
          Dispose(TempDataHv);
          Form_UI.Array_DataDeal[I].OHvData := TempDataOHv;

          TempDataLv := Form_UI.LvUDPCache.Pop;
          CopyMemory(@TempDataOLv, TempDataLv, SizeOf(TRecord_OriginalLv));
          Dispose(TempDataLv);
          Form_UI.Array_DataDeal[I].OLvData := TempDataOLv;
        end;
        Form_UI.counts := 1000;
      end;

      //ԭʼ���ݴ洢
      if Form_UI.IsSave then
      begin
        for I := Form_UI.counts - 200 to Form_UI.counts - 1 do
        begin
          New(TempDataSO);
          CopyMemory(TempDataSO, @Form_UI.Array_DataDeal[I], SizeOf(Record_SaveOriginal));
          Form_UI.OriginalCache.Push(TempDataSO);
        end;
      end;

      //���ݴ���
      for I := Form_UI.counts - 200 to Form_UI.counts - 1 do
      begin
        //���ݴ������鸳ֵ��������
        Form_UI.array_DataDealing[I].TempJCWJH := Form_UI.array_DataDeal[I].Om_data;

        //2D���ݴ���ֵȡǰһ��ֵ
        for J := 0 to 3 do
        begin
          if Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x = 65536 then
          begin
            if Form_UI.temp_X[J] <> 65537 then
            begin
              Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x := Form_UI.temp_X[J];
            end
            else Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x := 0;
          end
          else Form_UI.temp_X[J] := Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x;

          if Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y = 65536 then
          begin
            if Form_UI.temp_Y[J] <> 65537 then
            begin
              Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y := Form_UI.temp_Y[J];
            end
            else Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y := 0;
          end
          else Form_UI.temp_Y[J] := Form_UI.array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y;
        end;

        //��ѹ�ṹ���ѹ��ֵ
        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[44];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[45];
        Form_UI.array_DataDealing[I].TempHv.Power1 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[46];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[47];
        Form_UI.array_DataDealing[I].TempHv.Power2 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[48];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[49];
        Form_UI.array_DataDealing[I].TempHv.Power3 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[50];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[51];
        Form_UI.array_DataDealing[I].TempHv.Power4 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[52];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[53];
        Form_UI.array_DataDealing[I].TempHv.HardSpot1 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[54];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[55];
        Form_UI.array_DataDealing[I].TempHv.HardSpot2 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[56];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[57];
        Form_UI.array_DataDealing[I].TempHv.HardSpot3 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[58];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[59];
        Form_UI.array_DataDealing[I].TempHv.HardSpot4 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[60];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[61];
        Form_UI.array_DataDealing[I].TempHv.HardSpot5 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := Form_UI.array_DataDeal[I].OHvData.OHv[62];
        TempWord[1] := Form_UI.array_DataDeal[I].OHvData.OHv[63];
        Form_UI.array_DataDealing[I].TempHv.HardSpot6 := Form_UI.AToV(14, Word(TempWord));

        //��ѹ�ṹ���ѹ��ֵ
        TempWord[0] := Form_UI.array_DataDeal[I].OLvData.OLv[0];
        TempWord[1] := Form_UI.array_DataDeal[I].OLvData.OLv[1];
        Form_UI.array_DataDealing[I].TempLv.Electric := Form_UI.AToV(14, Word(TempWord));

        TempInteger[0] := Form_UI.array_DataDeal[I].OLvData.OLv[2];
        TempInteger[1] := Form_UI.array_DataDeal[I].OLvData.OLv[3];
        TempInteger[2] := Form_UI.array_DataDeal[I].OLvData.OLv[4];
        TempInteger[3] := Form_UI.array_DataDeal[I].OLvData.OLv[5];
        Form_UI.array_DataDealing[I].TempLv.encoder := Integer(TempInteger);

        Form_UI.array_DataDealing[I].TempLv.Status1 := Form_UI.array_DataDeal[I].OLvData.OLv[6];

        Form_UI.array_DataDealing[I].TempLv.Status2 := Form_UI.array_DataDeal[I].OLvData.OLv[7];
      end;

      //�˲�ǰvector��ֵ
      vector_X1.Size(200); vector_Y1.Size(200); vector_X2.Size(200); vector_Y2.Size(200); vector_X3.Size(200); vector_Y3.Size(200); vector_X4.Size(200); vector_Y4.Size(200);
      vector_Power1.Size(200); vector_Power2.Size(200); vector_Power3.Size(200); vector_Power4.Size(200); vector_Electricity.Size(200);
      vector_HardSpot1.Size(200); vector_HardSpot2.Size(200); vector_HardSpot3.Size(200); vector_HardSpot4.Size(200); vector_HardSpot5.Size(200); vector_HardSpot6.Size(200);

      for I := 0 to 199 do
      begin
        vector_X1[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[0].pntLinePos.x;
        vector_Y1[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[0].pntLinePos.y;
        vector_X2[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[1].pntLinePos.x;
        vector_Y2[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[1].pntLinePos.y;
        vector_X3[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[2].pntLinePos.x;
        vector_Y3[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[2].pntLinePos.y;
        vector_X4[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[3].pntLinePos.x;
        vector_Y4[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempJCWJH.jcx[3].pntLinePos.y;

        vector_Power1[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.Power1;
        vector_Power2[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.Power2;
        vector_Power3[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.Power3;
        vector_Power4[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.Power4;
        vector_HardSpot1[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot1;
        vector_HardSpot2[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot2;
        vector_HardSpot3[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot3;
        vector_HardSpot4[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot4;
        vector_HardSpot5[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot5;
        vector_HardSpot6[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempHv.HardSpot6;

        vector_Electricity[I] := Form_UI.array_DataDealing[I + Form_UI.counts - 200].TempLv.Electric;
      end;


      //�����˲�
      Form_UI.FirFilter_2DAverageX1.filter(vector_X1, vector_X1);
      Form_UI.FirFilter_2DAverageY1.filter(vector_Y1, vector_Y1);
      Form_UI.FirFilter_2DAverageX2.filter(vector_X2, vector_X2);
      Form_UI.FirFilter_2DAverageY2.filter(vector_Y2, vector_Y2);
      Form_UI.FirFilter_2DAverageX3.filter(vector_X3, vector_X3);
      Form_UI.FirFilter_2DAverageY3.filter(vector_Y3, vector_Y3);
      Form_UI.FirFilter_2DAverageX4.filter(vector_X4, vector_X4);
      Form_UI.FirFilter_2DAverageY4.filter(vector_Y4, vector_Y4);

      Form_UI.FirFilter_LowPassPower1.filter(vector_Power1, vector_Power1);
      Form_UI.FirFilter_LowPassPower2.filter(vector_Power2, vector_Power2);
      Form_UI.FirFilter_LowPassPower3.filter(vector_Power3, vector_Power3);
      Form_UI.FirFilter_LowPassPower4.filter(vector_Power4, vector_Power4);

      Form_UI.FirFilter_LowPassHardSpot1.filter(vector_HardSpot1, vector_HardSpot1);
      Form_UI.FirFilter_LowPassHardSpot2.filter(vector_HardSpot2, vector_HardSpot2);
      Form_UI.FirFilter_LowPassHardSpot3.filter(vector_HardSpot3, vector_HardSpot3);
      Form_UI.FirFilter_LowPassHardSpot4.filter(vector_HardSpot4, vector_HardSpot4);
      Form_UI.FirFilter_LowPassHardSpot5.filter(vector_HardSpot5, vector_HardSpot5);
      Form_UI.FirFilter_LowPassHardSpot6.filter(vector_HardSpot6, vector_HardSpot6);

      Form_UI.FirFilter_LowPassHardElectric.filter(vector_Electricity, vector_Electricity);

      //�˲���ֵ���������򵥼���
      for I := Form_UI.counts - 200 to Form_UI.counts - 1 do
      begin
        case Form_UI.array_DataDealing[I].TempJCWJH.uiLineNum of
          0:
          begin
            ;
          end;
          1:
          begin
            ;
          end;
          2:
          begin
            ;
          end;
          3:
          begin
            ;
          end;
        end;
        Form_UI.array_ResultDeal[I].LCZ11_value
      end;

    end;
    Sleep(1);
  end;
end;

function DrawThread(p: Pointer): Integer; stdcall;
begin
//  Synchronize();
  while True do
  begin


    Sleep(1);
  end;
end;

procedure OnPointCould(pTag: Pointer; dtimestamp: Double; uiframeNo: Int64; potArray: PPOINTF; uiPotNum: Cardinal); cdecl;
var
  i : cardinal;
begin
  if WaitForSingleObject(m_mutex, INFINITE) = WAIT_OBJECT_0 then
  begin
    if uiPotNum > 5 then
    begin
      Setlength(Form_UI.m_vecPot, uiPotNum);
      for i := 0 to uiPotNum - 1 do
      begin
        Form_UI.m_vecPot[i] := potArray[i];
      end;
    end;
    Form_UI.m_dTimeStampLast := dtimestamp;
    Form_UI.m_uiFrameNo := uiframeNo;
    Form_UI.m_uiFrameRecvCount := Form_UI.m_uiFrameRecvCount + 1;
    Form_UI.m_uiPotNum := uiPotNum;
  end;
  ReleaseMutex(m_mutex);
end;

procedure fnResultCallback(const pTag: Pointer; const tempData: JCWJH); cdecl;
var
  TempData2D: ^JCWJH;
begin
  if WaitForSingleObject(m_lock, INFINITE) = WAIT_OBJECT_0 then
  begin
    Form_UI.m_data := tempData;
    New(TempData2D);
    CopyMemory(TempData2D, @tempData, SizeOf(JCWJH));
    Form_UI.Data2DCache.Push(TempData2D);

//    Dispose(TempData2D);

    Sleep(1);
  end;
  ReleaseMutex(m_lock);
end;

procedure TForm_UI.Action_AcyingDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Acying;
end;

procedure TForm_UI.Action_CloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm_UI.Action_CloseLineUIExecute(Sender: TObject);
begin
  Form_LineSetting.Close;
end;

procedure TForm_UI.Action_ConductorDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Conductor;
end;

procedure TForm_UI.Action_ElectricDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Electric;
end;

procedure TForm_UI.Action_ForceDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_ContactForce;
end;

procedure TForm_UI.Action_HardspotDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Hardspot;
end;

procedure TForm_UI.Action_OpenFileExecute(Sender: TObject);
begin
  LargeButton_StartPlayback.Enabled := False;
  LargeButton_StopPlayback.Enabled := False;
  if IsRun then Action_StopCollectExecute(Sender);

  if OpenDialog.Execute then
  begin
    LargeButton_InitSetting.Enabled := False;
    LargeButton_Pause.Enabled := False;
    LargeButton_StartCollect.Enabled := False;
    LargeButton_StopCollect.Enabled := False;
    LoadOriginalData(OpenDialog.FileName);
  end;
end;

procedure TForm_UI.Action_OpenLineUIExecute(Sender: TObject);
begin
  Form_LineSetting.Show;
end;

procedure TForm_UI.Action_OpenSensorUIExecute(Sender: TObject);
begin
  Form_Sensor.Show;
end;

procedure TForm_UI.Action_ParameterDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Parameter;
end;

procedure TForm_UI.Action_RestoreExecute(Sender: TObject);
var
  backupTextFile: TextFile;
begin
  AssignFile(backupTextFile, backupFilePath);
  if FileExists(backupFilePath) then
  begin
    if MessageBox(Handle, '��ȷ��Ҫ�ָ�֮ǰ��������', '�ָ�����', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
    begin
      CopyFile(PChar(backupFilePath), PChar(configurationFilePath), False);
      InitConfigurationFile;
      InitSubGroup;
      MessageBox(Handle, '�����ѻָ���', '�ָ�����', MB_OK + MB_ICONQUESTION);
    end;
  end
  else MessageBox(Handle, 'δ���ֱ��ݵ������ļ���', '�ָ�����', MB_OK + MB_ICONQUESTION);
end;

procedure TForm_UI.Action_StartCalibrateExecute(Sender: TObject);
begin
  IsCalibrating := True;
end;

procedure TForm_UI.Action_StartCollectExecute(Sender: TObject);
begin
//  IdUDPServer_UDP.Active := True;
//  UDPStartCollect;

  case Init2DIP of
    0:
    begin
      case Open2D of
        0:
        begin
          dxRibbonStatusBar.Panels[3].Text := '2D��������������ʼ������';

          if not IsRun then
          begin
            StartMs := GetTickCount;
            startTime := FormatDateTime('yymmddhhnnss', Now);
            ResumeThread(PSaveThread);
            ResumeThread(PProcessThread);
            ResumeThread(PDrawThread);
            IdUDPServer_Hv.Active := True;
            IdUDPServer_Lv.Active := True;
            IdUDPServer_Acying.Active := True;
            IsRun := True;
            UDPStartCollect;
            dxRibbonStatusBar.Panels[0].Text := '���ڲɼ���';
            dxRibbonStatusBar.Panels[4].Text := '��·״����' + Form_LineSetting.shangxiaxing + Form_LineSetting.direction + '��';
            dxRibbonStatusBar.Panels[5].Text := '����꣺' + FloatToStr(Form_LineSetting.kilometer) + 'km';
          end;
        end;
        -1: dxRibbonStatusBar.Panels[3].Text := '2D����������δ֪����';
        -2: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч��ʵ�������';
        -3: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч�豸ID��';
        -4: dxRibbonStatusBar.Panels[3].Text := '2D�����������������ܸ������á�';
        -5: dxRibbonStatusBar.Panels[3].Text := '2D������δ���������ܸ������á�';
        -6: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч����ֵ������������Ч��Χ�����߲��������Ч��';
        -404: dxRibbonStatusBar.Panels[3].Text := '2D������δʵ�֡�';
      end;
    end;
    -1: dxRibbonStatusBar.Panels[3].Text := '2D����������δ֪����';
    -2: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч��ʵ�������';
    -3: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч�豸ID��';
    -4: dxRibbonStatusBar.Panels[3].Text := '2D�����������������ܸ������á�';
    -5: dxRibbonStatusBar.Panels[3].Text := '2D������δ���������ܸ������á�';
    -6: dxRibbonStatusBar.Panels[3].Text := '2D��������Ч����ֵ������������Ч��Χ�����߲��������Ч��';
    -404: dxRibbonStatusBar.Panels[3].Text := '2D������δʵ�֡�';
  end;
end;

procedure TForm_UI.Action_StartPlaybackExecute(Sender: TObject);
begin
  IsPlayback := True;
  ResumeThread(PSaveThread);
  ResumeThread(PProcessThread);
  ResumeThread(PDrawThread);
end;

procedure TForm_UI.Action_StartSaveExecute(Sender: TObject);
begin
  if not IsSave then TempOrignalDataPath := SavedOriginalDataPath + FormatDateTime('yyyymmddhhnnss', Now) + '.dat';
  IsSave := True;
  dxRibbonStatusBar.Panels[1].Text := '���ڴ洢���ݡ�';
end;

procedure TForm_UI.Action_StopCalibrateExecute(Sender: TObject);
begin
  IsCalibrating := False;
  InitSubGroup;
end;

procedure TForm_UI.Action_StopCollectExecute(Sender: TObject);
var
  I: Byte;
begin
  if IsRun then
  begin
    UDPStopCollect;
    SuspendThread(Form_UI.PSaveThread);
    SuspendThread(Form_UI.PProcessThread);
    SuspendThread(Form_UI.PDrawThread);

    IdUDPServer_Hv.Active := False;
    IdUDPServer_Lv.Active := False;
    IdUDPServer_Acying.Active := False;

    Data2DCache.clear;
    HvUDPCache.clear;
    LvUDPCache.clear;
    AcyingCache.clear;
    DrawCache.clear;
    OriginalCache.clear;
    ResultCache.clear;

    IsRun := False;
    IsSave := False;
    dxRibbonStatusBar.Panels[0].Text := '��ֹͣ�ɼ���';
    dxRibbonStatusBar.Panels[1].Text := 'δ�洢���ݡ�';

    //Ϊ�´ο�ʼ��׼��
    counts:= 0;
    calCounts:= 0;
    drawCounts:= 0;

    //2D����ֵȡǰһ��ֵ�����ʼ��
    for I := 0 to 3 do
    begin
      temp_X[I] := 65537;
      temp_Y[I] := 65537;
    end;

    Close2D;
    dxRibbonStatusBar.Panels[3].Text := '2D��������ֹͣ������';
  end;
end;

procedure TForm_UI.Action_StopPlaybackExecute(Sender: TObject);
begin
  SuspendThread(PSaveThread);
  SuspendThread(PProcessThread);
  SuspendThread(PDrawThread);
  IsCalibrating := False;
  LargeButton_InitSetting.Enabled := True;
  LargeButton_Pause.Enabled := True;
  LargeButton_StartCollect.Enabled := True;
  LargeButton_StopCollect.Enabled := True;
end;

procedure TForm_UI.Action_StopSaveExecute(Sender: TObject);
begin
  IsSave := False;
  dxRibbonStatusBar.Panels[1].Text := 'δ�洢���ݡ�';
end;

procedure TForm_UI.Action_VersionExecute(Sender: TObject);
var
  verInfoSize, errorExtraction, verValueSize: DWORD;
  result: String;
  verInfo: Pointer;
  verValue: PVSFixedFileInfo;
  result1, result2, result3, result4: Word;
begin
  verInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), errorExtraction);
  if verInfoSize = 0 then
  begin
    errorExtraction := GetLastError;
    result := '0.0.0.0';
  end;
  GetMem(verInfo, verInfoSize);
  GetFileVerSionInfo(PChar(Paramstr(0)), 0, verInfoSize, verInfo);
  VerQueryValue(verInfo, '\', Pointer(verValue), verValueSize);
  with verValue^ do
  begin
    result1 := DwFileVersionms shr 16;
    result2 := DwFileVersionms And $ffff;
    result3 := DwFileVersionls shr 16;
    result4 := DwFileVersionls And $ffff;
  end;
  result := '����汾�ţ�' + IntToStr(result1) + '.' + IntToStr(result2) + '.' + IntToStr(result3) + '.' + IntToStr(result4);
  FreeMem(verInfo, verInfoSize);
  MessageBox(handle, PWideChar(result), '��Ϣ��ʾ', MB_OK);
end;

procedure TForm_UI.dxRibbonMinimizedChanged(Sender: TdxCustomRibbon);
begin
//  dxRibbon.ShowTabGroups := True;
end;

procedure TForm_UI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  if MessageBox(handle, '��ȷ��Ҫ�˳�ϵͳ��', '��Ϣ��ʾ', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then CanClose := True
//  else CanClose := False;
end;

procedure TForm_UI.FormCreate(Sender: TObject);
var
  FSaveThreadID, FProcessThreadID, FDrawThreadID: DWORD;   //�����߳�ID,THandle����
  W: array [0..1] of Double;
  FirOrder: Integer;
  I: Byte;
//  TempWord: array [0..1] of Byte;
begin
  RzPageControl.ActivePage := TabSheet_Conductor;

  //������Ӧ��ַ
  ErrorLogPath := ExtractFilePath(Application.ExeName)  + Ansistring('ErrorLog\ErrorLog.txt');
  ConfigurationFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\ConfigurationFile.txt');
  BackupFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\���ñ���\ConfigurationFile.txt');
  SavedOriginalDataPath := ExtractFilePath(Application.ExeName) + AnsiString('SavedData\');
  SavedResultDataPath := ExtractFilePath(Application.ExeName) + AnsiString('DATA\');

  //2D��ʼ������������ֵ��
//  Set8087CW(DWord($133f));   //���δ�����
  m_lock := CreateMutex(nil, False, nil);
  m_hjcw := Jcw_InitInstance();
  m_iDevid := JMID_GEO_DEV0;
  Jcw_SetResultCallBack(m_hjcw, self, @fnResultCallback);

  //2D��ʼ�����������ݣ�
  m_mutex := CreateMutex(nil, False, nil);
  m_hYEG := YEG_CreateInstance;
//  YEG_SetScanPointCallBack(m_hYEG, @OnPointCould, Self);

  InitFolder;
  InitConfigurationFile;

  IdUDPServer_Hv.DefaultPort := StrToInt(HvUDPPort);
  IdUDPServer_Lv.DefaultPort := StrToInt(LvUDPPort);
  IdUDPServer_Acying.DefaultPort := StrToInt(AcyingUDPPort);

  FGlobalpara.DataSelfDelete(SavedOriginalDataPath, 20.0);    //������ɾ�������·���ǲ����ڵ�·���ǲ�������
  FGlobalpara.DataSelfDelete(SavedResultDataPath, 20.0);    //������ɾ��

//  InitializeCriticalSection(CS);

  Data2DCache := TsfQueue.Create;
  HvUDPCache := TsfQueue.Create;
  LvUDPCache := TsfQueue.Create;
  AcyingCache := TsfQueue.Create;
  DrawCache := TsfQueue.Create;
  OriginalCache := TsfQueue.Create;
  ResultCache := TsfQueue.Create;

  //�˲�����ʼ��
  W[0] := 95;
  W[1] := 100;
  FirFilter_LowPassPower1 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassPower2 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassPower3 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassPower4 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot1 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot2 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot3 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot4 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot5 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardSpot6 := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  FirFilter_LowPassHardElectric := TFirFilter.create(UserLowPass, W, FirOrder, 0.5, 200);
  W[0] := 5;
  FirFilter_2DAverageX1 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageY1 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageXX1 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageYY1 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageX2 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageY2 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageXX2 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageYY2 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageX3 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageY3 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageXX3 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageYY3 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageX4 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageY4 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageXX4 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);
  FirFilter_2DAverageYY4 := TFirFilter.create(UserAverage, W, FirOrder, 0.5, 200);

  //�����߳�
  PSaveThread := CreateThread(nil, 0, @SaveThread, nil, 4, FSaveThreadID);
  PProcessThread := CreateThread(nil, 0, @ProcessThread, nil, 4, FProcessThreadID);
  PDrawThread := CreateThread(nil, 0, @DrawThread, nil, 4, FDrawThreadID);

  Timer_InitSubGroup.Enabled := True;

  //�������ͳ�ʼ��
  IsRun := False;
  IsSave := False;
  IsPlayback := False;
  IsCalibrating := False;

  //�����ͼ�������ʼ��
  counts := 0;
  calCounts := 0;
  drawCounts := 0;

  //2D����ֵȡǰһ��ֵ�����ʼ��
  for I := 0 to 3 do
  begin
    temp_X[I] := 65537;
    temp_Y[I] := 65537;
  end;

  //����
//  TempWord[0] := 254;
//  TempWord[1] := 255;
//  counts := Word(TempWord);
end;

procedure TForm_UI.FormDestroy(Sender: TObject);
begin
  UDPStopCollect;
  SuspendThread(Form_UI.PSaveThread);
  SuspendThread(Form_UI.PProcessThread);
  SuspendThread(Form_UI.PDrawThread);

  //�߳�����
  TerminateThread(PSaveThread, 0);
  TerminateThread(PProcessThread, 0);
  TerminateThread(PDrawThread, 0);

  Data2DCache.Free;
  HvUDPCache.Free;
  LvUDPCache.Free;
  AcyingCache.Free;
  DrawCache.Free;
  OriginalCache.Free;
  ResultCache.Free;

  //��ͣUDP����
  IdUDPServer_Hv.Active := False;
  IdUDPServer_Lv.Active := False;
  IdUDPServer_Acying.Active := False;

  //�˲�������
  FirFilter_LowPassPower1.Free;
  FirFilter_LowPassPower2.Free;
  FirFilter_LowPassPower3.Free;
  FirFilter_LowPassPower4.Free;
  FirFilter_LowPassHardSpot1.Free;
  FirFilter_LowPassHardSpot2.Free;
  FirFilter_LowPassHardSpot3.Free;
  FirFilter_LowPassHardSpot4.Free;
  FirFilter_LowPassHardSpot5.Free;
  FirFilter_LowPassHardSpot6.Free;
  FirFilter_LowPassHardElectric.Free;
  FirFilter_2DAverageX1.Free;
  FirFilter_2DAverageY1.Free;
  FirFilter_2DAverageXX1.Free;
  FirFilter_2DAverageYY1.Free;
  FirFilter_2DAverageX2.Free;
  FirFilter_2DAverageY2.Free;
  FirFilter_2DAverageXX2.Free;
  FirFilter_2DAverageYY2.Free;
  FirFilter_2DAverageX3.Free;
  FirFilter_2DAverageY3.Free;
  FirFilter_2DAverageXX3.Free;
  FirFilter_2DAverageYY3.Free;
  FirFilter_2DAverageX4.Free;
  FirFilter_2DAverageY4.Free;
  FirFilter_2DAverageXX4.Free;
  FirFilter_2DAverageYY4.Free;

  //2D����
  CloseHandle(m_mutex);
  CloseHandle(m_lock);

//  DeleteCriticalSection(CS);
end;

procedure TForm_UI.TimerTimer(Sender: TObject);
begin
  dxRibbonStatusBar.Panels[6].Text := FormatDateTime('yyyy��mm��dd�� hh:nn:ss', Now);
end;

procedure TForm_UI.Timer_InitSubGroupTimer(Sender: TObject);
begin
  InitSubGroup;
  Timer_InitSubGroup.Enabled := False;
end;

procedure TForm_UI.InitFolder;
begin
  if not DirectoryExists(ExtractFilePath(ErrorLogPath)) then ForceDirectories(ExtractFilePath(ErrorLogPath));
  if not DirectoryExists(ExtractFilePath(BackupFilePath)) then ForceDirectories(ExtractFilePath(BackupFilePath));
  if not DirectoryExists(ExtractFilePath(SavedOriginalDataPath)) then ForceDirectories(ExtractFilePath(SavedOriginalDataPath));
  if not DirectoryExists(ExtractFilePath(SavedResultDataPath)) then ForceDirectories(ExtractFilePath(SavedResultDataPath));
end;

procedure TForm_UI.InitConfigurationFile;
var
  ConfigurationTextFile : TextFile;
  IniFile : TIniFile;
begin
  try
    AssignFile(ConfigurationTextFile, ConfigurationFilePath);
    if not FileExists(ConfigurationFilePath) then
    Begin
      Rewrite(ConfigurationTextFile);
      Writeln(ConfigurationTextFile, '[��������]');
      Writeln(ConfigurationTextFile, '��·���� = δ֪��·');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[����������]');
      Writeln(ConfigurationTextFile, '2DIP = 192.168.100.100');
      Writeln(ConfigurationTextFile, 'HvUDPIP = 10.10.10.2');
      Writeln(ConfigurationTextFile, 'HvUDPPort = 1025');
      Writeln(ConfigurationTextFile, 'LvUDPIP = 10.10.10.3');
      Writeln(ConfigurationTextFile, 'LvUDPPort = 1025');
      Writeln(ConfigurationTextFile, 'AcyingUDPIP = 10.10.10.4');
      Writeln(ConfigurationTextFile, 'AcyingUDPPort = 1025');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[�궨]');
      Writeln(ConfigurationTextFile, 'Force = 0');
      Writeln(ConfigurationTextFile, 'Electricity = 0');
      Writeln(ConfigurationTextFile, 'Power1 = 0');
      Writeln(ConfigurationTextFile, 'Power2 = 0');
      Writeln(ConfigurationTextFile, 'Power3 = 0');
      Writeln(ConfigurationTextFile, 'Power4 = 0');
      Writeln(ConfigurationTextFile, 'ACC1 = 0');
      Writeln(ConfigurationTextFile, 'ACC2 = 0');
      Writeln(ConfigurationTextFile, 'ACC3 = 0');
      Writeln(ConfigurationTextFile, 'ACC4 = 0');
      Writeln(ConfigurationTextFile, 'ACC5 = 0');
      Writeln(ConfigurationTextFile, 'ACC6 = 0');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[����]');
      Writeln(ConfigurationTextFile, '���� = 0');
      Writeln(ConfigurationTextFile, '���� = 20');
      Writeln(ConfigurationTextFile, '');

      CloseFile(ConfigurationTextFile);
    End;

    IniFile := TIniFile.Create(ConfigurationFilePath);

    LineName := IniFile.ReadString('��������', '��·����', 'δ֪��·');

    TCPIP := IniFile.ReadString('����������', '2DIP', '192.168.100.100');
    HvUDPIP := IniFile.ReadString('����������', 'HvUDPIP', '10.10.10.2');
    HvUDPPort := IniFile.ReadString('����������', 'HvUDPPort', '1025');
    LvUDPIP := IniFile.ReadString('����������', 'LvUDPIP', '10.10.10.3');
    LvUDPPort := IniFile.ReadString('����������', 'LvUDPPort', '1025');
    AcyingUDPIP := IniFile.ReadString('����������', 'AcyingUDPIP', '10.10.10.4');
    AcyingUDPPort := IniFile.ReadString('����������', 'AcyingUDPPort', '1025');

    Calibrate_Force := IniFile.ReadFloat('�궨', 'Force', 0);
    Calibrate_Electricity := IniFile.ReadFloat('�궨', 'Electricity', 0);
    Calibrate_Power1 := IniFile.ReadFloat('�궨', 'Power1', 0);
    Calibrate_Power2 := IniFile.ReadFloat('�궨', 'Power2', 0);
    Calibrate_Power3 := IniFile.ReadFloat('�궨', 'Power3', 0);
    Calibrate_Power4 := IniFile.ReadFloat('�궨', 'Power4', 0);
    Calibrate_ACC1 := IniFile.ReadFloat('�궨', 'ACC1', 0);
    Calibrate_ACC2 := IniFile.ReadFloat('�궨', 'ACC2', 0);
    Calibrate_ACC3 := IniFile.ReadFloat('�궨', 'ACC3', 0);
    Calibrate_ACC4 := IniFile.ReadFloat('�궨', 'ACC4', 0);
    Calibrate_ACC5 := IniFile.ReadFloat('�궨', 'ACC5', 0);
    Calibrate_ACC6 := IniFile.ReadFloat('�궨', 'ACC6', 0);

    IsDebug := IniFile.ReadInteger('����', '����', 1);
    drawThreshold := IniFile.ReadInteger('����', '����', 20);

    IniFile.Free;

    if IsDebug > 0 then
    begin
      dxRibbonTab_Debug.Visible := True;

      MenuItem_Collect.Visible := True;
      MenuItem_Save.Visible := True;
      MenuItem_Server.Visible := True;
      MenuItem_LineAndSensor.Visible := True;
      MenuItem_Playback.Visible := True;
    end
    else
    begin
      dxRibbonTab_Debug.Visible := False;

      MenuItem_Collect.Visible := False;
      MenuItem_Save.Visible := False;
      MenuItem_Server.Visible := False;
      MenuItem_LineAndSensor.Visible := False;
      MenuItem_Playback.Visible := False;
    end;

  except
    On E : Exception Do
    begin
      FGlobalpara.ShowAndSaveErrorLog(ErrorLogPath, 'InitConfigurationFile', E.Message, False);
      dxRibbonStatusBar.Panels[0].Text := '�����ʼ��ʧ�ܣ����������ļ���';
      LargeButton_InitSetting.Enabled := False;
      MenuItem_Init.Enabled := False;
    end;
  end;
end;

procedure TForm_UI.InitSubGroup;
var
  division: TArray<string>;
  i: Byte;
begin
  Form_LineSetting.ComboBox_Line.Items.Add(LineName);

  division := TCPIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_IP1.Text := division[i];
      1: Form_Sensor.Edit_IP2.Text := division[i];
      2: Form_Sensor.Edit_IP3.Text := division[i];
      3: Form_Sensor.Edit_IP4.Text := division[i];
    end;
  end;

  division := HvUDPIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_UDPHvIP1.Text := division[i];
      1: Form_Sensor.Edit_UDPHvIP2.Text := division[i];
      2: Form_Sensor.Edit_UDPHvIP3.Text := division[i];
      3: Form_Sensor.Edit_UDPHvIP4.Text := division[i];
    end;
  end;
  Form_Sensor.Edit_UDPHvPort.Text := HvUDPPort;

  division := LvUDPIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_UDPLvIP1.Text := division[i];
      1: Form_Sensor.Edit_UDPLvIP2.Text := division[i];
      2: Form_Sensor.Edit_UDPLvIP3.Text := division[i];
      3: Form_Sensor.Edit_UDPLvIP4.Text := division[i];
    end;
  end;
  Form_Sensor.Edit_UDPLvPort.Text := LvUDPPort;

  division := AcyingUDPIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_UDPAcyingIP1.Text := division[i];
      1: Form_Sensor.Edit_UDPAcyingIP2.Text := division[i];
      2: Form_Sensor.Edit_UDPAcyingIP3.Text := division[i];
      3: Form_Sensor.Edit_UDPAcyingIP4.Text := division[i];
    end;
  end;
  Form_Sensor.Edit_UDPAcyingPort.Text := AcyingUDPPort;

  Form_Sensor.Edit_CalCounts.Text := IntToStr(drawThreshold);

  Form_Sensor.Edit_Force.Text := FloatToStr(Calibrate_Force);
  Form_Sensor.Edit_Electricity.Text := FloatToStr(Calibrate_Electricity);
  Form_Sensor.Edit_Power1.Text := FloatToStr(Calibrate_Power1);
  Form_Sensor.Edit_Power2.Text := FloatToStr(Calibrate_Power2);
  Form_Sensor.Edit_Power3.Text := FloatToStr(Calibrate_Power3);
  Form_Sensor.Edit_Power4.Text := FloatToStr(Calibrate_Power4);
  Form_Sensor.Edit_ACC1.Text := FloatToStr(Calibrate_ACC1);
  Form_Sensor.Edit_ACC2.Text := FloatToStr(Calibrate_ACC2);
  Form_Sensor.Edit_ACC3.Text := FloatToStr(Calibrate_ACC3);
  Form_Sensor.Edit_ACC4.Text := FloatToStr(Calibrate_ACC4);
  Form_Sensor.Edit_ACC5.Text := FloatToStr(Calibrate_ACC5);
  Form_Sensor.Edit_ACC6.Text := FloatToStr(Calibrate_ACC6);
end;

function TForm_UI.JCWSetIP(tempTCPIP: string) : Integer;
begin
  Result := Jcw_SetDevAddress(m_hjcw, m_iDevid, PAnsiChar(AnsiString(tempTCPIP)), 6771);
end;

function TForm_UI.YEGConnect(tempTCPIP: string) : Integer;
begin
  Result := YEG_Connect(m_hYEG, PAnsiChar(AnsiString(tempTCPIP)));
end;

procedure TForm_UI.YEGDisconnect;
begin
  if m_hYEG <> nil then YEG_Disconnect(m_hYEG);
end;

procedure TForm_UI.IdUDPServer_AcyingUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  Sleep(2);
end;

procedure TForm_UI.IdUDPServer_HvUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  TempDataHv: ^TRecord_OriginalHv;
begin
  New(TempDataHv);
  CopyMemory(TempDataHv, @AData, SizeOf(TRecord_OriginalHv));
  Form_UI.HvUDPCache.Push(TempDataHv);
end;

procedure TForm_UI.IdUDPServer_LvUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  TempDataLv: ^TRecord_OriginalLv;
begin
  New(TempDataLv);
  CopyMemory(TempDataLv, @AData, SizeOf(TRecord_OriginalLv));
  Form_UI.LvUDPCache.Push(TempDataLv);
end;

function TForm_UI.Init2DIP: Integer;
begin
  Result := JCWSetIP(TCPIP);
  if Result = 0 then Result := YEGConnect(TCPIP);
end;

function TForm_UI.Open2D: Integer;
begin
  Result := Jcw_Start(m_hjcw);
  if Result = 0 then Result := YEG_StartGrab(m_hYEG);
end;

procedure TForm_UI.Close2D;
begin
  YEGDisconnect;
  Jcw_Stop(m_hjcw);
  YEG_StopGrab(m_hYEG);
end;

procedure TForm_UI.UDPStartCollect;
var
  Buffer_Send: TIdBytes;
  I: Byte;
  TempTime: TDateTime;
begin
  TempTime := Now;
  SetLength(Buffer_Send, 50);
  Buffer_Send[0] := 2;
  Buffer_Send[1] := 20;
  Buffer_Send[2] := 48;
  Buffer_Send[3] := 1;
  for I := 4 to 39 do Buffer_Send[I] := 0;
  Buffer_Send[40] := 1;
  Buffer_Send[41] := 0;
  Buffer_Send[42] := 0;
  Buffer_Send[43] := 0;
  Buffer_Send[44] := StrToInt(FormatDateTime('yy', TempTime));
  Buffer_Send[45] := StrToInt(FormatDateTime('mm', TempTime));
  Buffer_Send[46] := StrToInt(FormatDateTime('dd', TempTime));
  Buffer_Send[47] := StrToInt(FormatDateTime('hh', TempTime));
  Buffer_Send[48] := StrToInt(FormatDateTime('nn', TempTime));
  Buffer_Send[49] := StrToInt(FormatDateTime('ss', TempTime));
//  IdUDPServer_Hv.SendBuffer('10.10.10.2', 1025, Buffer_Send);

  Buffer_Send[2] := 49;
//  IdUDPServer_Lv.SendBuffer('10.10.10.3', 1025, Buffer_Send);

  Buffer_Send[2] := 50;
//  IdUDPServer_Acying.SendBuffer('10.10.10.4', 1025, Buffer_Send);

//  IdUDPServer_Hv.SendBuffer('127.0.0.5', 1025, Buffer_Send);
//  IdUDPServer_Hv.SendBuffer('192.168.3.100', 1025, Buffer_Send);
end;

procedure TForm_UI.UDPStopCollect;
var
  Buffer_Send: TIdBytes;
  I: Byte;
  TempTime: TDateTime;
begin
  TempTime := Now;
  SetLength(Buffer_Send, 50);
  Buffer_Send[0] := 2;
  Buffer_Send[1] := 20;
  Buffer_Send[2] := 48;
  Buffer_Send[3] := 2;
  for I := 4 to 39 do Buffer_Send[I] := 0;
  Buffer_Send[40] := 1;
  Buffer_Send[41] := 0;
  Buffer_Send[42] := 0;
  Buffer_Send[43] := 0;
  Buffer_Send[44] := StrToInt(FormatDateTime('yy', TempTime));
  Buffer_Send[45] := StrToInt(FormatDateTime('mm', TempTime));
  Buffer_Send[46] := StrToInt(FormatDateTime('dd', TempTime));
  Buffer_Send[47] := StrToInt(FormatDateTime('hh', TempTime));
  Buffer_Send[48] := StrToInt(FormatDateTime('nn', TempTime));
  Buffer_Send[49] := StrToInt(FormatDateTime('ss', TempTime));
//  IdUDPServer_Hv.SendBuffer('10.10.10.2', 1025, Buffer_Send);

  Buffer_Send[2] := 49;
//  IdUDPServer_Lv.SendBuffer('10.10.10.3', 1025, Buffer_Send);

  Buffer_Send[2] := 50;
//  IdUDPServer_Acying.SendBuffer('10.10.10.4', 1025, Buffer_Send);

//  IdUDPServer_Hv.SendBuffer('192.168.3.100', 1025, Buffer_Send);
end;

procedure TForm_UI.SaveOriginalData(TempData: Record_SaveOriginal);
var
  SaveOriginalFile : file;
  FileStream : TFileStream;
  WritePosition : Int64;
  LengthNumber : Integer;
begin
  if not FileExists(TempOrignalDataPath) then
  begin
    AssignFile(SaveOriginalFile, TempOrignalDataPath);
    Rewrite(SaveOriginalFile, 1);
    CloseFile(SaveOriginalFile);
  end;
  FileStream := TFileStream.Create(TempOrignalDataPath, 2);
  WritePosition := FileStream.Size;
  FileStream.Seek(WritePosition, 0);
  LengthNumber := FileStream.Write(TempData, SizeOf(Record_SaveOriginal));
  FileStream.Destroy;
end;

procedure TForm_UI.SaveResultData(TempData: sDataFrame);
var
  SaveResultlFile : file;
  FileStream : TFileStream;
  WritePosition : Int64;
  LengthNumber : Integer;
begin
  if not FileExists(TempResultDataPath) then
  begin
    AssignFile(SaveResultlFile, TempResultDataPath);
    Rewrite(SaveResultlFile, 1);
    CloseFile(SaveResultlFile);
  end;
  FileStream := TFileStream.Create(TempResultDataPath, 2);
  WritePosition := FileStream.Size;
  FileStream.Seek(WritePosition, 0);
  LengthNumber := FileStream.Write(TempData, SizeOf(sDataFrame));
  FileStream.Destroy;
end;

procedure TForm_UI.LoadOriginalData(TempLoadOriginalPath: string);
var
  FileStream : TFileStream;
  LoadDataSize : Int64;
  InputDataSize : LongWord;
  TempPlayBackData : Record_SaveOriginal;
  TempDataO2D: JCWJH;
  TempDataOHv: TRecord_OriginalHv;
  TempDataOLv: TRecord_OriginalLv;
  TempData2D: ^JCWJH;
  TempDataHv: ^TRecord_OriginalHv;
  TempDataLv: ^TRecord_OriginalLv;
begin
  FileStream := TFileStream.Create(TempLoadOriginalPath, 2);
  LoadDataSize := FileStream.Size;
  FileStream.Seek(0, soBeginning);
  InputDataSize := 0;

  Data2DCache.clear;
  HvUDPCache.clear;
  LvUDPCache.clear;
  AcyingCache.clear;
  DrawCache.clear;
  OriginalCache.clear;
  ResultCache.clear;

  while InputDataSize < LoadDataSize do
  begin
    Application.ProcessMessages;
    dxRibbonStatusBar.Panels[1].Text := '���ڶ�ȡ���ݣ����Ժ�';
    FileStream.ReadBuffer(TempPlayBackData, SizeOf(Record_SaveOriginal));

    TempDataO2D := TempPlayBackData.Om_data;
    TempDataOHv := TempPlayBackData.OHvData;
    TempDataOLv := TempPlayBackData.OLvData;

    New(TempData2D);
    CopyMemory(TempData2D, @TempDataO2D, SizeOf(JCWJH));
    Data2DCache.Push(TempData2D);

    New(TempDataHv);
    CopyMemory(TempDataHv, @TempDataOHv, SizeOf(TRecord_OriginalHv));
    HvUDPCache.Push(TempDataHv);

    New(TempDataLv);
    CopyMemory(TempDataLv, @TempDataOLv, SizeOf(TRecord_OriginalLv));
    LvUDPCache.Push(TempDataLv);

    InputDataSize := InputDataSize + SizeOf(Record_SaveOriginal);
  end;
  dxRibbonStatusBar.Panels[1].Text := '���ݶ�ȡ��ϣ����Կ�ʼ�طš�';
  FileStream.Free;
end;

function TForm_UI.AToV(kind_V: Byte; temp_A: Word): Single;
begin
  case kind_V of
    10:Result := temp_A * 2.5 / 65535;
    11:Result := temp_A * 5 / 65535;
    12:Result := temp_A * 10 / 65535;
    13:Result := temp_A * 5 / 65535 - 2.5;
    14:Result := temp_A * 10 / 65535 - 5;
    15:Result := temp_A * 20 / 65535 - 10;
  end;
end;
end.
