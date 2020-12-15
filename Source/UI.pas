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
  IdUDPServer, IdSocketHandle, IdGlobal, sfContnrs, UFirFilter, MtxExpr,
  UDrawThread;

type
  sResultDataPara = packed record              //信息头
    lineName: array [0..99] of Char;    //线路名称
    Version: Byte;                      //软件版本
    reserved: array [0..394] of Byte;   //预留
    inight: Integer;                    //初始杆号
    inidis: Integer;                    //初始公里标，单位m
    Buchang: Integer;                   //采样间隔，单位m   value*10000
    shangxia: Byte;                     //上下行（0=未知 1=上行 2=下行）
    rundir: Byte;                       //正反向（1=正 0=反）
    initzengjian: Byte;                 //里程增减（1=增 0=减）
    ghzengjian: Byte;                   //杆号增减（1=增 0=减）
    DataTime: array [0..11] of Char;    //采集时间 YYMMDDHHMMSS
  end;

  sDataFrame = packed record                    //数据
    LCZ11_value: Single;                 //接触线1拉出值1，mm
    LCZ12_value: Single;                 //接触线1拉出值2（柔性双线时），mm
    LCZSP1_value: Single;                //接触线1水平距离（柔性双线时），mm
    LCZ21_value: Single;                 //接触线2拉出值1，mm
    LCZ22_value: Single;                 //接触线2拉出值2（柔性双线时），mm
    LCZSP2_value: Single;                //接触线2水平距离（柔性双线时），mm
    DGZ11_value: Single;                 //接触线1导高值1，mm
    DGZ12_value: Single;                 //接触线1导高值2（柔性双线时），mm
    DGZ21_value: Single;                 //接触线2导高值1，mm
    DGZ22_value: Single;                 //接触线2导高值2（柔性双线时），mm
    SPJL_value: Single;                  //锚段或线叉处接触线水平距离，mm
    SPGC_value: Single;                  //锚段或线叉处接触线高差，mm
    DGBHL_value: Single;                 //导高变化率
    DWDGC_value: Single;                 //定位点高差，mm
    JCL_value: Single;                   //接触力，N
    JCL_mean: Single;                    //接触力均值，N
    JCL_max: Single;                     //接触力最大值，N
    JCL_min: Single;                     //接触力最小值，N
    JCL_std: Single;                     //接触力标准方差
    YD1_value: Single;                   //硬点1垂向加速度值，m/s^2
    YD2_value: Single;                   //硬点2垂向加速度值，m/s^2
    DL_value: Single;                    //电流值，A
    RH_value: Single;                    //电流大于标称值30%的时间，ms
    RH_time: Single;                     //燃弧持续时间，ms
    RH_numb: Single;                     //燃弧次数
    reserved: array [0..6] of Integer;   //保留
    FrameID: Integer;                    //视频帧号
    ghNumb: Integer;                     //杆号
    myspeed: Single;                     //速度，单位km/h
    mykilo: Double;                      //公里标，单位m
    Errmark: Byte;                       //  03代表异常数据
    mark: Byte;                          //  01代表公里标矫正 02代表锚段或线叉
    CheckTime: Integer;                  //检测时间，从信息头采集时间开始的时间，单位ms
  end;

  TRecord_OriginalHv = record
    OHv: array [0..69] of Byte;
  end;

  //也用于记录标定数据
  TRecord_Hv = record
    HardSpot1, HardSpot2, HardSpot3, HardSpot4, HardSpot5, HardSpot6, Power1, Power2, Power3, Power4: Single;
  end;

  TRecord_OriginalLv = record
    OLv: array [0..51] of Byte;
  end;

  TRecord_Lv = record
    Electric: Single;
    encoder: Integer;
    Status1, Status2: Byte;
  end;

  //原始燃弧信息里加了初始公里标和杆号以及公里标杆号的递增递减
  TRecord_OriginalAcying = record
    Distance_Init: Double;
    Pole_Init: Integer;
    initzengjian: Byte;
    ghzengjian: Byte;
    Acying: array[0..9] of Byte;
  end;

  TRecord_Acying = record
    Distance_Init: Double;
    Pole_Init: Integer;
    initzengjian: Byte;
    ghzengjian: Byte;
    pluseTime, pluseCounts: Word;
    pluseNumber, pluseStatus: Byte;
  end;

  Record_SaveOriginal = record
    Om_data: JCWJH;
    OHvData: TRecord_OriginalHv;
    OLvData: TRecord_OriginalLv;
    AcyingData: TRecord_OriginalAcying;
  end;

  TData_Dealing = record
    TempJCWJH: JCWJH;
    TempHv: TRecord_Hv;
    TempLv: TRecord_Lv;
    TempAcying: TRecord_Acying;
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
    MenuItem_LineAndSensor: TMenuItem;
    MenuItem_StartSave: TMenuItem;
    MenuItem_StopSave: TMenuItem;
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
    ManagerBar_LineAndSensor: TdxBar;
    ManagerBar_Playback: TdxBar;
    LargeButton_StartCollect: TdxBarLargeButton;
    LargeButton_StopCollect: TdxBarLargeButton;
    LargeButton_StartSave: TdxBarLargeButton;
    LargeButton_StopSave: TdxBarLargeButton;
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
    Series_Force: TFastLineSeries;
    Series_ForceAve: TFastLineSeries;
    Series_ForceMax: TFastLineSeries;
    Series_ForceMin: TFastLineSeries;
    Series_ForceVariance: TFastLineSeries;
    Series_Vacc1: TFastLineSeries;
    Series_Vacc2: TFastLineSeries;
    Series_ElectricValue: TFastLineSeries;
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
    Action_StartInitCalibrate: TAction;
    Action_StopCalibrate: TAction;
    IdUDPServer_Lv: TIdUDPServer;
    IdUDPServer_Acying: TIdUDPServer;
    Action_StartSave: TAction;
    Action_StopSave: TAction;
    Action_OpenFile: TAction;
    Action_StartPlayback: TAction;
    Action_StopPlayback: TAction;
    PointSeries_Width: TPointSeries;
    PointSeries_Height: TPointSeries;
    PointSeries_Changerate: TPointSeries;
    PointSeries_Elevation: TPointSeries;
    PointSeries_ElectricTime: TPointSeries;
    PointSeries_AcyingTime: TPointSeries;
    PointSeries_AcyingCount: TPointSeries;
    ManagerBar_Simulation: TdxBar;
    LargeButton_StartSimulate: TdxBarLargeButton;
    LargeButton_StopSimulate: TdxBarLargeButton;
    MenuItem_Simulation: TMenuItem;
    MenuItem_StartSimulate: TMenuItem;
    MenuItem_StopSimulate: TMenuItem;
    Action_StartSimulate: TAction;
    Action_StopSimulate: TAction;
    LargeButton_Data: TdxBarLargeButton;
    MenuItem_Data: TMenuItem;
    TabSheet_Data: TRzTabSheet;
    Chart_Data: TChart;
    FastLineSeries_Line1Height: TFastLineSeries;
    FastLineSeries_Line1Width: TFastLineSeries;
    FastLineSeries_Vacc1: TFastLineSeries;
    FastLineSeries_Vacc2: TFastLineSeries;
    FastLineSeries_Force: TFastLineSeries;
    PointSeries_AcyingCountData: TPointSeries;
    PointSeries_AcyingTimeData: TPointSeries;
    FastLineSeries_ElectricValue: TFastLineSeries;
    PointSeries_ElectricTimeData: TPointSeries;
    Action_DataDisplay: TAction;
    FastLineSeries_Pole: TFastLineSeries;
    MenuItem_CalibrateSetting: TMenuItem;
    MenuItem_InitCalibrate: TMenuItem;
    MenuItem_RaiseCalibrate: TMenuItem;
    MenuItem_Normal: TMenuItem;
    ManagerBar_Calibrate: TdxBar;
    LargeButton_StartInitCali: TdxBarLargeButton;
    LargeButton_StartRaiseCali: TdxBarLargeButton;
    LargeButton_StartNormalCali: TdxBarLargeButton;
    LargeButton_StopCalibrate: TdxBarLargeButton;
    MenuItem_StopCalibrate: TMenuItem;
    Action_StartRaiseCalibrate: TAction;
    Action_StartNormalCalibrate: TAction;
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
    procedure Action_StartInitCalibrateExecute(Sender: TObject);
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
    procedure Action_StartSimulateExecute(Sender: TObject);
    procedure Action_StopSimulateExecute(Sender: TObject);
    procedure Action_DataDisplayExecute(Sender: TObject);
    procedure Action_StartRaiseCalibrateExecute(Sender: TObject);
    procedure Action_StartNormalCalibrateExecute(Sender: TObject);
  private
    { Private declarations }
    errorLogPath, backupFilePath: String;   //各个文件路径
    LineName, TCPIP, HvUDPIP, HvUDPPort, LvUDPIP, LvUDPPort, AcyingUDPIP, AcyingUDPPort, ComputerIP, ComputerPort: string;
    IsDebug: Byte;

    FGlobalpara: TGlobalpara;

    FileStream_Original, FileStream_Result: TFileStream;

    procedure InitFolder;
    function JCWSetIP(tempTCPIP: string): Integer;
    function YEGConnect(tempTCPIP: string): Integer;
    procedure YEGDisconnect;
    procedure LoadOriginalData(TempLoadOriginalPath: string);
    procedure SaveResultHead(tempPath, tempLineName: string; inight: Integer; initDis: Double; shangxia, rundir: string; initzengjian, ghzengjian: Byte);
  public
    { Public declarations }
    //2D数据变量（导高拉出值）
    m_data: JCWJH;
//    m_lock: THandle;

    //2D数据变量（点云数据）
    m_vecPot : array of YEGtagPOINTF;
    m_dTimeStampLast: Single;
    m_uiFrameNo, m_uiFrameRecvCount, m_uiPotNum: Cardinal;
//    m_mutex: THandle;

    m_hjcw: Pointer;
    m_iDevid: JMDEVID;

    m_hYEG: Pointer;   //指针和Cardinal都可以

    pSaveThread, pProcessThread: DWORD;   //各个线程
    startMs: Single;   //检测时间，从信息头采集时间开始的时间，单位ms
    startTime: string;
    configurationFilePath, TempOrignalDataPath, TempResultDataPath, savedOriginalDataPath, savedResultDataPath: string;
    GSpeed: Double;
    GKilometer: Single;

    FDrawThread: TDrawThread;

    Counts_Package, Counts_Save, Counts_Number: Integer;   //包号测试，这三个变量在程序中无任何实际意义，但是存在的意义是为了测试是否丢失数据

//    CS: TRTLCriticalSection;

    //drawCounts 一次性绘图的点数
    //calCounts 计算均值、最大值、最小值、均方根值的点数多少
    //calingCounts 正在计算的点数多少，如果超了就要滑动，目前和Number_Cal * 2 - 1有关
    calCounts, drawCounts, calingCounts, paintCounts: Word;

    IsRun, IsSave, IsPlayback, IsFirstCalibrate, IsCalibrating_Init, IsCalibrating_Raise, IsCalibrating_Normal, IsFirstCal, IsGJD, IsJCDL: Boolean;

    Data2DCache, HvUDPCache, LvUDPCache, AcyingCache, DrawCache, OriginalCache, ResultCache: TsfQueue;
    drawThreshold, poleCounts: Byte;   //绘图点数和支柱计算高差计数
    pole_ghNumb: Integer;   //正在计数的杆号
    noPlusCounts, calHCounts, calMaoCounts: Word;   //无脉冲的数据计数和检测到柱和锚段的计数
    temp_X, temp_Y: array[0..3] of Single;   //2D错误值取前一个值数组
    time_Electricity: Single;   //电流大于标准值百分之30开始时间
    time_CalSpeed, tempStartTime, tempEndTime: Single;

    DrawData: array [0..26, 0..4999] of Single;   //绘图数据数组

    AcyingNumber_First: SmallInt;

    Direction_Sensor, IsCompensate: Byte;   //传感器方向和是否补偿
    Value_Quality, Value_StandradElectricity: Single;   //弓网质量和电流标准值

    calibrate_Force, calibrate_Electricity, calibrate_Power1, calibrate_Power2, calibrate_Power3, calibrate_Power4,
    calibrate_ACC1, calibrate_ACC2, calibrate_ACC3, calibrate_ACC4, calibrate_ACC5, calibrate_ACC6,
    calibrate_ForceK, calibrate_ForceB, Force_CalK, Force_CalB, tmpForceK, tmpForceB: Single;   //读取的配置参数及标定参数

    YL1, YL2, YL3, YL4, YD1, YD2, YD3, YD4, YD5, YD6, JCL, Calib_DY: Single;   //此行和上一行是压力、硬点、接触力和电流标定值
    Sensitivity_YL1, Sensitivity_YL2, Sensitivity_YL3, Sensitivity_YL4, Sensitivity_ACC1, Sensitivity_ACC2: Single;
    calibrate_DGZ, calibrate_LCZ: Single;
    Distance_Pluse, D_Wheel: Single;
    N_Pluse: Word;
    array_CalForce: array of Single;

    //滤波器所要的vector数组
    vector_Power1, vector_Power2, vector_Power3, vector_Power4, vector_HardSpot1, vector_HardSpot2, vector_HardSpot3, vector_HardSpot4, vector_HardSpot5, vector_HardSpot6, vector_Electricity: Vector;

    //低通滤波器
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

    function Init2DIP: Integer;
    function Open2D: Integer;
    procedure Close2D;
    procedure UDPStartCollect;
    procedure UDPStopCollect;
    procedure InitConfigurationFile;
    procedure InitSubGroup;
    procedure StartSaveOriginalData;
    procedure SaveOriginalData(TempData: Record_SaveOriginal);
    procedure StopSaveOriginalData;
    procedure StartSaveResultData;
    procedure SaveResultData(TempData: sDataFrame);
    procedure StopSaveResultData;
    function AToV(kind_V: Byte; temp_A: Word): Single;
    function CalJCL(tempV, tempSensitivity: Single): Single;
    function CalYD(tempV, tempSensitivity: Single): Single;
    function CalDL(tempV: Single): Single;
    function CalMean(tempArray: array of Single): Single;
    function CalMax(tempArray: array of Single): Single;
    function CalMin(tempArray: array of Single): Single;
    function Calstd(tempArray: array of Single): Single;
    function CalAve(tempArray: array of Single): Single;
    procedure UDPStartSimulate;
    procedure UDPStopSimulate;
  end;

var
  Form_UI: TForm_UI;

  const
//    Distance_Pluse = 33;          //一个脉冲距离13mm（200个脉冲），现在一个脉冲距离32.9mm（80个脉冲）
    Number_Draw = 5000;           //绘图的点数
    Number_Cal = 200;             //一次性计算的点数，这里也是一秒的采集频率，改这个的时候注意上方的结构体长度应作出相应的变化
    G = 9.8;                      //重力加速度
    Fq_BandPass = 20;             //低通滤波带通频率
    Fq_CutOff = 25;               //低通滤波截止频率
    Length_DynamicArray = 1000;   //中间计算过程动态数组长度
    time_Hz = 5;                  //每帧采样时间(ms)

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
      CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
      Dispose(TempResultData);
      Form_UI.SaveResultData(TempRData);
    end;
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

    Sleep(1);
  end;
  ReleaseMutex(m_lock);
end;

function ProcessThread(p: Pointer): Integer; stdcall;
var
  I, J: Word;
  TempWord: array [0..1] of Byte;
  TempInteger: array [0..3] of Byte;
  TempData2D: ^JCWJH;
  TempDataO2D: JCWJH;
  TempDataHv: ^TRecord_OriginalHv;
  TempDataOHv: TRecord_OriginalHv;
  TempDataLv: ^TRecord_OriginalLv;
  TempDataOLv: TRecord_OriginalLv;
  TempDataAcying: ^TRecord_OriginalAcying;
  TempDataOAcying: TRecord_OriginalAcying;
  TempDataSO: ^Record_SaveOriginal;
  TempDataSR: ^sDataFrame;
  IniFile : TIniFile;
  temp_time: Single;   //记录速度起始时间

  startRecordKm, endRecordKm, startKm, tempKm, nowKm, startPlus, tempPlus, tmpSpeed, tmpPluse: Double;   //最开始的脉冲数
  startghNumber: Integer;   //第一次测试时所记录的杆号初始号
  startKmZengjian, startGhzengjian: Byte;   //第一次测试时所记录的里程、杆号的递增递减
  array_DataDeal: array [0..Number_Cal - 1] of Record_SaveOriginal;    //最原始数据数组
  array_DataDealing: array[0..Number_Cal - 1] of TData_Dealing;   //处理过程中的数组，包括滤波、计算等
  array_ResultDeal: array[0..Number_Cal - 1] of sDataFrame;   //计算后的结果数据
  array_PlusResult: array[0..Number_Cal * 2 - 2] of sDataFrame;
  temp_arrayYD1, temp_arrayYD2, temp_arrayJCL, temp_arrayDL: array of Single;   //一个脉冲内的计算数据
  temp_SPJL_value, temp_SPGC_value, temp_DGBHL_value, temp_DWDGC_value: array of Single;   //定位点改变的取均值的数组
  temp_MaxH, temp_MinH: Single;   //定位点高差的最大值和最小值
  temp_arraycalibYL1, temp_arraycalibYL2, temp_arraycalibYL3, temp_arraycalibYL4, temp_arraycalibYD1, temp_arraycalibYD2, temp_arraycalibYD4, temp_arraycalibYD5: array of Single;

  //额外加俩标定数组
  array_CalibResultDeal: array[0..Number_Cal - 1] of TRecord_Hv;
begin
  while True do
  begin
    //数据取值
    if (Form_UI.Data2DCache.count > Number_Cal) and (Form_UI.HvUDPCache.count > Number_Cal) and (Form_UI.LvUDPCache.count > Number_Cal) and (Form_UI.AcyingCache.count > Number_Cal) then
    begin
      for I := 0 to Number_Cal - 1 do
      begin
        TempData2D := Form_UI.Data2DCache.Pop;
        CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
        Dispose(TempData2D);
        Array_DataDeal[I].Om_data := TempDataO2D;
//        TempData2D := Form_UI.Data2DCache.Pop;
//        CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
//        Dispose(TempData2D);

        TempDataHv := Form_UI.HvUDPCache.Pop;
        CopyMemory(@TempDataOHv, TempDataHv, SizeOf(TRecord_OriginalHv));
        Dispose(TempDataHv);
        Array_DataDeal[I].OHvData := TempDataOHv;

        TempDataLv := Form_UI.LvUDPCache.Pop;
        CopyMemory(@TempDataOLv, TempDataLv, SizeOf(TRecord_OriginalLv));
        Dispose(TempDataLv);
        Array_DataDeal[I].OLvData := TempDataOLv;

        TempDataAcying := Form_UI.AcyingCache.Pop;
        CopyMemory(@TempDataOAcying, TempDataAcying, SizeOf(TRecord_OriginalAcying));
        Dispose(TempDataAcying);
        array_DataDeal[I].AcyingData := TempDataOAcying;

        Form_UI.Counts_Number := Form_UI.Counts_Number + 1;

        //原始数据存储
        if Form_UI.IsSave then
        begin
          New(TempDataSO);
          CopyMemory(TempDataSO, @Array_DataDeal[I], SizeOf(Record_SaveOriginal));
          Form_UI.OriginalCache.Push(TempDataSO);
        end;
      end;

      //数据处理
      for I := 0 to Number_Cal - 1 do
      begin
        //数据处理数组赋值（初步）
        array_DataDealing[I].TempJCWJH := array_DataDeal[I].Om_data;

        //2D数据错误值取前一个值
        if Form_UI.IsCompensate = 0 then
        begin
          for J := 0 to 3 do
          begin
            if array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x = 65536 then
            begin
              if Form_UI.temp_X[J] <> 65537 then
              begin
                array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x := Form_UI.temp_X[J];
              end
              else array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x := 0;
            end
            else Form_UI.temp_X[J] := array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.x;

            if array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y = 65536 then
            begin
              if Form_UI.temp_Y[J] <> 65537 then
              begin
                array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y := Form_UI.temp_Y[J];
              end
              else array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y := 0;
            end
            else Form_UI.temp_Y[J] := array_DataDealing[I].TempJCWJH.jcx[J].pntLinePos.y;
          end;
        end
        else
        begin
          for J := 0 to 3 do
          begin
            if array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.x = 65536 then
            begin
              if Form_UI.temp_X[J] <> 65537 then
              begin
                array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.x := Form_UI.temp_X[J];
              end
              else array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.x := 0;
            end
            else Form_UI.temp_X[J] := array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.x;

            if array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.y = 65536 then
            begin
              if Form_UI.temp_Y[J] <> 65537 then
              begin
                array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.y := Form_UI.temp_Y[J];
              end
              else array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.y := 0;
            end
            else Form_UI.temp_Y[J] := array_DataDealing[I].TempJCWJH.jcxComp[J].pntLinePos.y;
          end;
        end;

        //高压结构体电压赋值
        TempWord[0] := array_DataDeal[I].OHvData.OHv[44];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[45];
        array_DataDealing[I].TempHv.HardSpot1 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[46];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[47];
        array_DataDealing[I].TempHv.HardSpot2 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[48];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[49];
        array_DataDealing[I].TempHv.HardSpot3 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[50];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[51];
        array_DataDealing[I].TempHv.HardSpot4 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[52];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[53];
        array_DataDealing[I].TempHv.HardSpot5 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[54];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[55];
        array_DataDealing[I].TempHv.HardSpot6 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[56];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[57];
        array_DataDealing[I].TempHv.Power1 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[58];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[59];
        array_DataDealing[I].TempHv.Power2 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[60];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[61];
        array_DataDealing[I].TempHv.Power3 := Form_UI.AToV(14, Word(TempWord));

        TempWord[0] := array_DataDeal[I].OHvData.OHv[62];
        TempWord[1] := array_DataDeal[I].OHvData.OHv[63];
        array_DataDealing[I].TempHv.Power4 := Form_UI.AToV(14, Word(TempWord));

        //低压结构体电压赋值
        TempWord[0] := array_DataDeal[I].OLvData.OLv[44];
        TempWord[1] := array_DataDeal[I].OLvData.OLv[45];
        array_DataDealing[I].TempLv.Electric := Form_UI.AToV(14, Word(TempWord));

        TempInteger[0] := array_DataDeal[I].OLvData.OLv[46];
        TempInteger[1] := array_DataDeal[I].OLvData.OLv[47];
        TempInteger[2] := array_DataDeal[I].OLvData.OLv[48];
        TempInteger[3] := array_DataDeal[I].OLvData.OLv[49];
        array_DataDealing[I].TempLv.encoder := Integer(TempInteger);

        array_DataDealing[I].TempLv.Status1 := array_DataDeal[I].OLvData.OLv[50];

        array_DataDealing[I].TempLv.Status2 := array_DataDeal[I].OLvData.OLv[51];

        //用低压包号赋值包号测试
        TempInteger[0] := array_DataDeal[I].OLvData.OLv[40];
        TempInteger[1] := array_DataDeal[I].OLvData.OLv[41];
        TempInteger[2] := array_DataDeal[I].OLvData.OLv[42];
        TempInteger[3] := array_DataDeal[I].OLvData.OLv[43];
        Form_UI.Counts_Package := Integer(TempInteger);

        //燃弧结构体赋值
        TempWord[0] := array_DataDeal[I].AcyingData.Acying[3];
        TempWord[1] := array_DataDeal[I].AcyingData.Acying[4];
        array_DataDealing[I].TempAcying.pluseTime := Word(TempWord);

        TempWord[0] := array_DataDeal[I].AcyingData.Acying[5];
        TempWord[1] := array_DataDeal[I].AcyingData.Acying[6];
        array_DataDealing[I].TempAcying.pluseCounts := Word(TempWord);

        array_DataDealing[I].TempAcying.pluseNumber := array_DataDeal[I].AcyingData.Acying[2];   //原来是7，现在改为2，采集燃弧序号
        array_DataDealing[I].TempAcying.pluseStatus := array_DataDeal[I].AcyingData.Acying[8];

        //后面新加的燃弧结构中的公里标、杆的信息赋值
        array_DataDealing[I].TempAcying.Distance_Init := array_DataDeal[I].AcyingData.Distance_Init;
        array_DataDealing[I].TempAcying.Pole_Init := array_DataDeal[I].AcyingData.Pole_Init;
        array_DataDealing[I].TempAcying.initzengjian := array_DataDeal[I].AcyingData.initzengjian;
        array_DataDealing[I].TempAcying.ghzengjian := array_DataDeal[I].AcyingData.ghzengjian;
      end;

      //滤波前vector赋值
      for I := 0 to Number_Cal - 1 do
      begin
        Form_UI.vector_Power1[I] := array_DataDealing[I].TempHv.Power1;
        Form_UI.vector_Power2[I] := array_DataDealing[I].TempHv.Power2;
        Form_UI.vector_Power3[I] := array_DataDealing[I].TempHv.Power3;
        Form_UI.vector_Power4[I] := array_DataDealing[I].TempHv.Power4;
        Form_UI.vector_HardSpot1[I] := array_DataDealing[I].TempHv.HardSpot1;
        Form_UI.vector_HardSpot2[I] := array_DataDealing[I].TempHv.HardSpot2;
        Form_UI.vector_HardSpot3[I] := array_DataDealing[I].TempHv.HardSpot3;
        Form_UI.vector_HardSpot4[I] := array_DataDealing[I].TempHv.HardSpot4;
        Form_UI.vector_HardSpot5[I] := array_DataDealing[I].TempHv.HardSpot5;
        Form_UI.vector_HardSpot6[I] := array_DataDealing[I].TempHv.HardSpot6;

        Form_UI.vector_Electricity[I] := array_DataDealing[I].TempLv.Electric;
      end;

      //数据滤波
      Form_UI.FirFilter_LowPassPower1.filter(Form_UI.vector_Power1, Form_UI.vector_Power1);
      Form_UI.FirFilter_LowPassPower2.filter(Form_UI.vector_Power2, Form_UI.vector_Power2);
      Form_UI.FirFilter_LowPassPower3.filter(Form_UI.vector_Power3, Form_UI.vector_Power3);
      Form_UI.FirFilter_LowPassPower4.filter(Form_UI.vector_Power4, Form_UI.vector_Power4);

      Form_UI.FirFilter_LowPassHardSpot1.filter(Form_UI.vector_HardSpot1, Form_UI.vector_HardSpot1);
      Form_UI.FirFilter_LowPassHardSpot2.filter(Form_UI.vector_HardSpot2, Form_UI.vector_HardSpot2);
      Form_UI.FirFilter_LowPassHardSpot3.filter(Form_UI.vector_HardSpot3, Form_UI.vector_HardSpot3);
      Form_UI.FirFilter_LowPassHardSpot4.filter(Form_UI.vector_HardSpot4, Form_UI.vector_HardSpot4);
      Form_UI.FirFilter_LowPassHardSpot5.filter(Form_UI.vector_HardSpot5, Form_UI.vector_HardSpot5);
      Form_UI.FirFilter_LowPassHardSpot6.filter(Form_UI.vector_HardSpot6, Form_UI.vector_HardSpot6);

      Form_UI.FirFilter_LowPassHardElectric.filter(Form_UI.vector_Electricity, Form_UI.vector_Electricity);

      //滤波后赋值并做初步简单计算
      for I := 0 to Number_Cal - 1 do
      begin
        //2D赋值
        if Form_UI.IsCompensate = 0 then
        begin
          case array_DataDealing[I].TempJCWJH.uiLineNum of
            0:
            begin
              array_ResultDeal[I].LCZ11_value := 0;
              array_ResultDeal[I].LCZ12_value := 0;
              array_ResultDeal[I].LCZSP1_value := 0;
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := 0;
              array_ResultDeal[I].DGZ12_value := 0;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            1:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := 0;
              array_ResultDeal[I].LCZSP1_value := 0;
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := 0;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            2:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            3:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            4:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ22_value := array_DataDealing[I].TempJCWJH.jcx[3].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP2_value := Abs(array_DataDealing[I].TempJCWJH.jcx[3].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.x);
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ22_value := array_DataDealing[I].TempJCWJH.jcx[3].pntLinePos.y - Form_UI.calibrate_DGZ;
            end;
          end;
        end
        else
        begin
          case array_DataDealing[I].TempJCWJH.uiLineCompsateNum of
            0:
            begin
              array_ResultDeal[I].LCZ11_value := 0;
              array_ResultDeal[I].LCZ12_value := 0;
              array_ResultDeal[I].LCZSP1_value := 0;
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := 0;
              array_ResultDeal[I].DGZ12_value := 0;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            1:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := 0;
              array_ResultDeal[I].LCZSP1_value := 0;
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := 0;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            2:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := 0;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := 0;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            3:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := array_DataDealing[I].TempJCWJH.jcxComp[2].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ22_value := 0;
              array_ResultDeal[I].LCZSP2_value := 0;
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := array_DataDealing[I].TempJCWJH.jcxComp[2].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ22_value := 0;
            end;
            4:
            begin
              array_ResultDeal[I].LCZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP1_value := Abs(array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.x);
              array_ResultDeal[I].LCZ21_value := array_DataDealing[I].TempJCWJH.jcxComp[2].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZ22_value := array_DataDealing[I].TempJCWJH.jcxComp[3].pntLinePos.x - Form_UI.calibrate_LCZ;
              array_ResultDeal[I].LCZSP2_value := Abs(array_DataDealing[I].TempJCWJH.jcxComp[3].pntLinePos.x - array_DataDealing[I].TempJCWJH.jcxComp[2].pntLinePos.x);
              array_ResultDeal[I].DGZ11_value := array_DataDealing[I].TempJCWJH.jcxComp[0].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ12_value := array_DataDealing[I].TempJCWJH.jcxComp[1].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ21_value := array_DataDealing[I].TempJCWJH.jcxComp[2].pntLinePos.y - Form_UI.calibrate_DGZ;
              array_ResultDeal[I].DGZ22_value := array_DataDealing[I].TempJCWJH.jcxComp[3].pntLinePos.y - Form_UI.calibrate_DGZ;
            end;
          end;
        end;

        array_ResultDeal[I].SPJL_value := 0;
        array_ResultDeal[I].SPGC_value := 0;
        array_ResultDeal[I].DGBHL_value := 0;
        array_ResultDeal[I].DWDGC_value := 0;

        //硬点赋值
        array_ResultDeal[I].YD1_value := Form_UI.CalYD(Form_UI.vector_HardSpot3[I], Form_UI.Sensitivity_ACC1);   //第二个参数是灵敏度系数
        array_ResultDeal[I].YD2_value := Form_UI.CalYD(Form_UI.vector_HardSpot6[I], Form_UI.Sensitivity_ACC2);
        array_CalibResultDeal[I].HardSpot1 := Form_UI.CalYD(Form_UI.vector_HardSpot1[I], Form_UI.Sensitivity_ACC1);
        array_CalibResultDeal[I].HardSpot2 := Form_UI.CalYD(Form_UI.vector_HardSpot2[I], Form_UI.Sensitivity_ACC1);
        array_CalibResultDeal[I].HardSpot3 := Form_UI.CalYD(Form_UI.vector_HardSpot3[I], Form_UI.Sensitivity_ACC1);
        array_CalibResultDeal[I].HardSpot4 := Form_UI.CalYD(Form_UI.vector_HardSpot4[I], Form_UI.Sensitivity_ACC2);
        array_CalibResultDeal[I].HardSpot5 := Form_UI.CalYD(Form_UI.vector_HardSpot5[I], Form_UI.Sensitivity_ACC2);
        array_CalibResultDeal[I].HardSpot6 := Form_UI.CalYD(Form_UI.vector_HardSpot6[I], Form_UI.Sensitivity_ACC2);

        //接触力赋值
        array_CalibResultDeal[I].Power1 := Form_UI.CalJCL(Form_UI.vector_Power1[I], Form_UI.Sensitivity_YL1);
        array_CalibResultDeal[I].Power2 := Form_UI.CalJCL(Form_UI.vector_Power2[I], Form_UI.Sensitivity_YL2);
        array_CalibResultDeal[I].Power3 := Form_UI.CalJCL(Form_UI.vector_Power3[I], Form_UI.Sensitivity_YL3);
        array_CalibResultDeal[I].Power4 := Form_UI.CalJCL(Form_UI.vector_Power4[I], Form_UI.Sensitivity_YL4);

        if Form_UI.Direction_Sensor = 1 then array_ResultDeal[I].JCL_value := array_CalibResultDeal[I].Power1 + array_CalibResultDeal[I].Power2 + array_CalibResultDeal[I].Power3 + array_CalibResultDeal[I].Power4 + Form_UI.Value_Quality * (array_CalibResultDeal[I].HardSpot3 + array_CalibResultDeal[I].HardSpot6) / 2 - Form_UI.Value_Quality * G
        else array_ResultDeal[I].JCL_value := array_CalibResultDeal[I].Power1 + array_CalibResultDeal[I].Power2 + array_CalibResultDeal[I].Power3 + array_CalibResultDeal[I].Power4 - Form_UI.Value_Quality * (array_CalibResultDeal[I].HardSpot3 + array_CalibResultDeal[I].HardSpot6) / 2 - Form_UI.Value_Quality * G;

//        array_ResultDeal[I].JCL_mean := 0;
//        array_ResultDeal[I].JCL_max := 0;
//        array_ResultDeal[I].JCL_min := 0;
//        array_ResultDeal[I].JCL_std := 0;

        //原本正常计算按上述计算，但现在这四个力的值为别赋值为4个压力传感器的值
        array_ResultDeal[I].JCL_mean := array_CalibResultDeal[I].Power1 - Form_UI.Calibrate_Power1;
        array_ResultDeal[I].JCL_max := array_CalibResultDeal[I].Power2 - Form_UI.Calibrate_Power2;
        array_ResultDeal[I].JCL_min := array_CalibResultDeal[I].Power3 - Form_UI.Calibrate_Power3;
        array_ResultDeal[I].JCL_std := array_CalibResultDeal[I].Power4 - Form_UI.Calibrate_Power4;

        //电流赋值
        array_ResultDeal[I].DL_value := Form_UI.CalDL(Form_UI.vector_Electricity[I]);
        array_ResultDeal[I].RH_value := 0;

        //燃弧赋值
        if Form_UI.AcyingNumber_First = -1 then
        begin
          Form_UI.AcyingNumber_First := array_DataDealing[I].TempAcying.pluseNumber;
          array_ResultDeal[I].RH_time := array_DataDealing[I].TempAcying.pluseTime;
          array_ResultDeal[I].RH_numb := array_DataDealing[I].TempAcying.pluseCounts;
        end
        else
        begin
          if Form_UI.AcyingNumber_First <> array_DataDealing[I].TempAcying.pluseNumber then
          begin
            Form_UI.AcyingNumber_First := array_DataDealing[I].TempAcying.pluseNumber;
            array_ResultDeal[I].RH_time := array_DataDealing[I].TempAcying.pluseTime;
            array_ResultDeal[I].RH_numb := array_DataDealing[I].TempAcying.pluseCounts;
          end
          else
          begin
            array_ResultDeal[I].RH_time := 0;
            array_ResultDeal[I].RH_numb := 0;
          end;
        end;

        for J := 0 to 6 do array_ResultDeal[I].reserved[J] := 0;

        array_ResultDeal[I].FrameID := 0;
        array_ResultDeal[I].ghNumb := 0;
        array_ResultDeal[I].myspeed := 0;
        array_ResultDeal[I].mykilo := array_DataDealing[I].TempLv.encoder;
        array_ResultDeal[I].Errmark := 0;

        if array_DataDealing[I].TempJCWJH.posi = JCXP_POLE then
        begin
          array_ResultDeal[I].mark := 4;
        end
        else if array_DataDealing[I].TempJCWJH.posi = JCXP_MAO then
        begin
          array_ResultDeal[I].mark := 2
        end
        else array_ResultDeal[I].mark := 0;

        //经确认发现JCXP_UNKNOW可能是锚段或线叉，目前2D暂时不会出现JCXP_ELECCONN和JCXP_MAO
        if array_DataDealing[I].TempJCWJH.posi = JCXP_UNKNOW then
        begin
          array_ResultDeal[I].mark := 2;
        end;

        Form_UI.startMs := Form_UI.startMs + time_Hz;
        array_ResultDeal[I].CheckTime := Round(Form_UI.startMs);
      end;

      //初步按照脉冲计算（这小段代码是第一次开始计算所遇到的情况）
      if Form_UI.IsFirstCal then
      begin
        tempPlus := array_ResultDeal[0].mykilo;
        startPlus := array_ResultDeal[0].mykilo;
        startKm := array_DataDealing[0].TempAcying.Distance_Init;
        startghNumber := array_DataDealing[0].TempAcying.Pole_Init;
        startKmZengjian := array_DataDealing[0].TempAcying.initzengjian;
        startGhzengjian := array_DataDealing[0].TempAcying.ghzengjian;
        tempKm := 0;
        startRecordKm := array_DataDealing[0].TempAcying.Distance_Init;

        if array_ResultDeal[0].mark = 2 then
        begin
          if array_ResultDeal[0].LCZ12_value <> 0 then
          begin
            Form_UI.calMaoCounts := Form_UI.calMaoCounts + 1;
            SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
            SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
            temp_SPJL_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
            temp_SPGC_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
          end;
        end
        else Form_UI.calMaoCounts := 0;

        if array_ResultDeal[0].mark = 4 then
        begin
          Form_UI.calHCounts := Form_UI.calHCounts + 1;
          SetLength(temp_DGBHL_value, Form_UI.calHCounts);
          SetLength(temp_DWDGC_value, Form_UI.calHCounts);
          temp_MaxH := array_ResultDeal[0].DGZ11_value;
          temp_MinH := array_ResultDeal[0].DGZ11_value;
          temp_DGBHL_value[Form_UI.calHCounts - 1] := 0;
          temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
        end
        else
        begin
          Form_UI.calHCounts := 0;
          temp_MaxH := 0;
          temp_MinH := 0;
        end;

        Form_UI.IsFirstCal := False;
      end;

      for I := 0 to Number_Cal - 1 do
      begin
        tempPlus := array_ResultDeal[I].mykilo;
        if tempPlus - startPlus <> 0 then
        begin
          if Form_UI.calingCounts < Number_Cal * 2 - 2 then
          begin
            array_PlusResult[Form_UI.calingCounts] := array_ResultDeal[I];
            Form_UI.calingCounts := Form_UI.calingCounts + 1;
          end
          else
          begin
            for J := 0 to Number_Cal * 2 - 3 do array_PlusResult[J] := array_PlusResult[J + 1];
            array_PlusResult[Form_UI.calingCounts - 1] := array_ResultDeal[I];
            if Form_UI.calingCounts < Number_Cal * 2 - 1 then Form_UI.calingCounts := Form_UI.calingCounts + 1;
          end;

          //速度、公里标赋值
          if startKm <> array_DataDealing[I].TempAcying.Distance_Init then
          begin
            tempKm := 0;
            startKm := array_DataDealing[I].TempAcying.Distance_Init;
            startKmZengjian := array_DataDealing[I].TempAcying.initzengjian;
            Form_UI.DrawCache.clear;
            Form_UI.paintCounts := 0;
          end;

          if startKmZengjian <> array_DataDealing[I].TempAcying.initzengjian then
          begin
            tempKm := -tempKm;
            startKmZengjian := array_DataDealing[I].TempAcying.initzengjian;
            Form_UI.DrawCache.clear;
            Form_UI.paintCounts := 0;
          end;

          if array_DataDealing[I].TempAcying.initzengjian = 1 then tempKm := tempKm + Abs((tempPlus - startPlus) * Form_UI.Distance_Pluse / 1000000)
          else tempKm := tempKm - Abs((tempPlus - startPlus) * Form_UI.Distance_Pluse / 1000000);
          nowKm := tempKm + array_DataDealing[I].TempAcying.Distance_Init;
          array_PlusResult[Form_UI.calingCounts - 1].mykilo := nowKm * 1000;

          //time_CalSpeed这个变量就类似于一个布尔类型来判断是否开始计算速度了
          if Form_UI.time_CalSpeed = 0 then
          begin
            array_PlusResult[Form_UI.calingCounts - 1].myspeed := 0;
            Form_UI.time_CalSpeed := GetTickCount;
            tmpPluse := tempPlus;
          end
          else
          begin
            if Form_UI.tempEndTime - Form_UI.tempStartTime > 1000 then   //1000毫秒算一次速度
            begin
              array_PlusResult[Form_UI.calingCounts - 1].myspeed := Abs((tempPlus - tmpPluse) * Form_UI.Distance_Pluse / 1000 / 1000) / ((Form_UI.tempEndTime - Form_UI.tempStartTime) / 1000 / 60 / 60);
              Form_UI.GSpeed := array_PlusResult[Form_UI.calingCounts - 1].myspeed;
              tmpPluse := tempPlus;
              Form_UI.tempStartTime := Form_UI.tempEndTime;
              tmpSpeed := array_PlusResult[Form_UI.calingCounts - 1].myspeed;
            end
            else
            begin
              Form_UI.tempEndTime := Form_UI.tempEndTime + time_Hz;
              array_PlusResult[Form_UI.calingCounts - 1].myspeed := tmpSpeed;
            end;
          end;
          startPlus := tempPlus;
          Form_UI.GKilometer := nowKm;

          //锚段计算
          if array_ResultDeal[I].mark = 2 then
          begin
            if array_ResultDeal[I].LCZ12_value <> 0 then
            begin
              Form_UI.calMaoCounts := Form_UI.calMaoCounts + 1;
              SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
              SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
              temp_SPJL_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
              temp_SPGC_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
              array_PlusResult[Form_UI.calingCounts - 1].SPJL_value := Form_UI.CalAve(temp_SPJL_value);
              array_PlusResult[Form_UI.calingCounts - 1].SPGC_value := Form_UI.CalAve(temp_SPGC_value);
              array_PlusResult[Form_UI.calingCounts - 1].SPJL_value := temp_SPJL_value[Form_UI.calMaoCounts - 1];
              array_PlusResult[Form_UI.calingCounts - 1].SPGC_value := temp_SPGC_value[Form_UI.calMaoCounts - 1];
              Form_UI.calMaoCounts := 0;
              SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
              SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
            end;
          end;

          //为高差计算做准备
          if temp_MaxH = 0 then temp_MaxH := array_ResultDeal[I].DGZ11_value;
          if temp_MinH = 0 then temp_MinH := array_ResultDeal[I].DGZ11_value;
          if temp_MaxH < array_ResultDeal[I].DGZ11_value then temp_MaxH := array_ResultDeal[I].DGZ11_value;
          if temp_MinH > array_ResultDeal[I].DGZ11_value then temp_MinH := array_ResultDeal[I].DGZ11_value;

          //区段计算
          if array_ResultDeal[I].mark = 4 then
          begin
            Form_UI.IsGJD := True;
            Form_UI.poleCounts := 0;
          end
          else
          begin
            if Form_UI.IsGJD then
            begin
              if Form_UI.poleCounts < 50 then   //50是防止误判断
              begin
                Form_UI.poleCounts := Form_UI.poleCounts + 1;
              end
              else
              begin
                endRecordKm := nowKm;
                if Abs(endRecordKm - startRecordKm) > 0.005 then   //0.005是5米
                begin
                  Form_UI.calHCounts := Form_UI.calHCounts + 1;
                  SetLength(temp_DGBHL_value, Form_UI.calHCounts);
                  SetLength(temp_DWDGC_value, Form_UI.calHCounts);
                  temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
                  temp_DGBHL_value[Form_UI.calHCounts - 1] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000 / 1000;
                  array_PlusResult[Form_UI.calingCounts - 1].DWDGC_value := Form_UI.CalAve(temp_DWDGC_value);
                  array_PlusResult[Form_UI.calingCounts - 1].DGBHL_value := Form_UI.CalAve(temp_DGBHL_value);
                  Form_UI.calHCounts := 0;
                  SetLength(temp_DGBHL_value, Form_UI.calHCounts);
                  SetLength(temp_DWDGC_value, Form_UI.calHCounts);
                end;

                Form_UI.IsGJD := False;
                Form_UI.poleCounts := 0;
                temp_MaxH := 0;
                temp_MinH := 0;
                startRecordKm := nowKm;

                if startghNumber <> array_DataDealing[I].TempAcying.Pole_Init then
                begin
                  Form_UI.pole_ghNumb := 0;
                  startghNumber := array_DataDealing[I].TempAcying.Pole_Init;
                  startGhzengjian := array_DataDealing[I].TempAcying.ghzengjian;
                end;

                if startghNumber <> array_DataDealing[I].TempAcying.ghzengjian then
                begin
                  Form_UI.pole_ghNumb := -Form_UI.pole_ghNumb;
                  startGhzengjian := array_DataDealing[I].TempAcying.ghzengjian;
                end;

                if array_DataDealing[I].TempAcying.ghzengjian = 1 then Form_UI.pole_ghNumb := Form_UI.pole_ghNumb + 1
                else Form_UI.pole_ghNumb := Form_UI.pole_ghNumb - 1;
                array_PlusResult[Form_UI.calingCounts - 1].ghNumb := array_DataDealing[I].TempAcying.Pole_Init + Form_UI.pole_ghNumb;
              end;
            end;
          end;

          //硬点、接触力、电流均值计算
          Form_UI.noPlusCounts := Form_UI.noPlusCounts + 1;
          SetLength(temp_arrayYD1, Form_UI.noPlusCounts);
          SetLength(temp_arrayYD2, Form_UI.noPlusCounts);
          SetLength(temp_arrayJCL, Form_UI.noPlusCounts);
          SetLength(temp_arrayDL, Form_UI.noPlusCounts);
          temp_arrayYD1[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].YD1_value;
          temp_arrayYD2[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].YD2_value;
          temp_arrayJCL[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].JCL_value;
          temp_arrayDL[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].DL_value;
          array_PlusResult[Form_UI.calingCounts - 1].JCL_value := Form_UI.calibrate_ForceK * (Form_UI.CalMean(temp_arrayJCL) - Form_UI.calibrate_Force) + Form_UI.calibrate_ForceB;
          array_PlusResult[Form_UI.calingCounts - 1].DL_value := Abs(Form_UI.CalMean(temp_arrayDL) - Form_UI.calibrate_Electricity);   //暂时加绝对值计算电流，以后可能分正负值计算
          array_PlusResult[Form_UI.calingCounts - 1].YD1_value := Form_UI.CalMean(temp_arrayYD1) - Form_UI.calibrate_ACC3;
          array_PlusResult[Form_UI.calingCounts - 1].YD2_value := Form_UI.CalMean(temp_arrayYD2) - Form_UI.calibrate_ACC6;
          if array_PlusResult[Form_UI.calingCounts - 1].DL_value > Form_UI.Value_StandradElectricity * 0.3 then
          begin
            if Form_UI.IsJCDL then
            begin
              Form_UI.time_Electricity := GetTickCount;
              Form_UI.IsJCDL := False;
            end;
          end
          else
          begin
            if not Form_UI.IsJCDL then
            begin
              array_PlusResult[Form_UI.calingCounts - 1].RH_value := GetTickCount - Form_UI.time_Electricity;
              Form_UI.IsJCDL := True;
            end;
          end;

          //标定值同时计算
          SetLength(temp_arraycalibYL1, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL2, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL3, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL4, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD1, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD2, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD4, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD5, Form_UI.noPlusCounts);
          temp_arraycalibYL1[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power1;
          temp_arraycalibYL2[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power2;
          temp_arraycalibYL3[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power3;
          temp_arraycalibYL4[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power4;
          temp_arraycalibYD1[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot1;
          temp_arraycalibYD2[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot2;
          temp_arraycalibYD4[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot4;
          temp_arraycalibYD5[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot5;

          //是否进行标定
          if Form_UI.IsFirstCalibrate then
          begin
            if Form_UI.IsCalibrating_Init then
            begin
              Form_UI.YL1 := Form_UI.CalMean(temp_arraycalibYL1);
              Form_UI.YL2 := Form_UI.CalMean(temp_arraycalibYL2);
              Form_UI.YL3 := Form_UI.CalMean(temp_arraycalibYL3);
              Form_UI.YL4 := Form_UI.CalMean(temp_arraycalibYL4);
              Form_UI.YD1 := Form_UI.CalMean(temp_arraycalibYD1);
              Form_UI.YD2 := Form_UI.CalMean(temp_arraycalibYD2);
              Form_UI.YD3 := Form_UI.CalMean(temp_arrayYD1);
              Form_UI.YD4 := Form_UI.CalMean(temp_arraycalibYD4);
              Form_UI.YD5 := Form_UI.CalMean(temp_arraycalibYD5);
              Form_UI.YD6 := Form_UI.CalMean(temp_arrayYD2);
              Form_UI.Calib_DY := Form_UI.CalMean(temp_arrayDL);
              Form_UI.JCL := Form_UI.CalMean(temp_arrayJCL);
            end
            else
            begin
              if Form_UI.Direction_Sensor = 1 then Form_UI.Calibrate_Force := Form_UI.YL1 + Form_UI.YL2 + Form_UI.YL3 + Form_UI.YL4 + Form_UI.Value_Quality * (Form_UI.YD3 + Form_UI.YD6) / 2 - Form_UI.Value_Quality * G
              else Form_UI.Calibrate_Force := Form_UI.YL1 + Form_UI.YL2 + Form_UI.YL3 + Form_UI.YL4 - Form_UI.Value_Quality * (Form_UI.YD3 + Form_UI.YD6) / 2 - Form_UI.Value_Quality * G;

              Form_UI.Calibrate_Electricity := Form_UI.Calib_DY;
              Form_UI.Calibrate_Power1 := Form_UI.YL1;
              Form_UI.Calibrate_Power2 := Form_UI.YL2;
              Form_UI.Calibrate_Power3 := Form_UI.YL3;
              Form_UI.Calibrate_Power4 := Form_UI.YL4;
              Form_UI.Calibrate_ACC1 := Form_UI.YD1;
              Form_UI.Calibrate_ACC2 := Form_UI.YD2;
              Form_UI.Calibrate_ACC3 := Form_UI.YD3;
              Form_UI.Calibrate_ACC4 := Form_UI.YD4;
              Form_UI.Calibrate_ACC5 := Form_UI.YD5;
              Form_UI.Calibrate_ACC6 := Form_UI.YD6;

              if FileExists(Form_UI.ConfigurationFilePath) then
              begin
                IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
                Inifile.WriteString('标定', 'Force', FormatFloat('0.0', Form_UI.Calibrate_Force));
                Inifile.WriteString('标定', 'Electricity', FormatFloat('0.0', Form_UI.Calibrate_Electricity));
                Inifile.WriteString('标定', 'Power1', FormatFloat('0.0', Form_UI.Calibrate_Power1));
                Inifile.WriteString('标定', 'Power2', FormatFloat('0.0', Form_UI.Calibrate_Power2));
                Inifile.WriteString('标定', 'Power3', FormatFloat('0.0', Form_UI.Calibrate_Power3));
                Inifile.WriteString('标定', 'Power4', FormatFloat('0.0', Form_UI.Calibrate_Power4));
                Inifile.WriteString('标定', 'ACC1', FormatFloat('0.0', Form_UI.Calibrate_ACC1));
                Inifile.WriteString('标定', 'ACC2', FormatFloat('0.0', Form_UI.Calibrate_ACC2));
                Inifile.WriteString('标定', 'ACC3', FormatFloat('0.0', Form_UI.Calibrate_ACC3));
                Inifile.WriteString('标定', 'ACC4', FormatFloat('0.0', Form_UI.Calibrate_ACC4));
                Inifile.WriteString('标定', 'ACC5', FormatFloat('0.0', Form_UI.Calibrate_ACC5));
                Inifile.WriteString('标定', 'ACC6', FormatFloat('0.0', Form_UI.Calibrate_ACC6));
                IniFile.Free;

                Form_UI.InitSubGroup;
              end;
              Form_UI.IsFirstCalibrate := False;
            end;

            if Form_UI.IsCalibrating_Raise then Form_UI.tmpForceK := Form_UI.Force_CalK / (Form_UI.CalMean(temp_arrayJCL) - Form_UI.calibrate_Force)
            else
            begin
              Form_UI.calibrate_ForceK := Form_UI.tmpForceK;

              if FileExists(Form_UI.ConfigurationFilePath) then
              begin
                IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
                Inifile.WriteString('标定', 'ForceK', FormatFloat('0.0', Form_UI.calibrate_ForceK));
                IniFile.Free;

                Form_UI.InitSubGroup;
              end;

              Form_UI.IsFirstCalibrate := False;
            end;

            if Form_UI.IsCalibrating_Normal then Form_UI.tmpForceB := Form_UI.Force_CalB * G - Form_UI.calibrate_ForceK * (Form_UI.CalMean(temp_arrayJCL) - Form_UI.calibrate_Force)
            else
            begin
              Form_UI.calibrate_ForceB := Form_UI.tmpForceB;

              if FileExists(Form_UI.ConfigurationFilePath) then
              begin
                IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
                Inifile.WriteString('标定', 'ForceB', FormatFloat('0.0', Form_UI.calibrate_ForceB));
                IniFile.Free;

                Form_UI.InitSubGroup;
              end;

              Form_UI.IsFirstCalibrate := False;
            end;
          end;

          Form_UI.noPlusCounts := 0;
          SetLength(temp_arrayYD1, Form_UI.noPlusCounts);
          SetLength(temp_arrayYD2, Form_UI.noPlusCounts);
          SetLength(temp_arrayJCL, Form_UI.noPlusCounts);
          SetLength(temp_arrayDL, Form_UI.noPlusCounts);

          SetLength(temp_arraycalibYL1, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL2, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL3, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYL4, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD1, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD2, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD4, Form_UI.noPlusCounts);
          SetLength(temp_arraycalibYD5, Form_UI.noPlusCounts);

          //因为这儿的值分别显示4个力传感器的计算值，所以暂时注释
//          //计算力的均值、最大值、最小值、均方根值
//          if Form_UI.calingCounts > Form_UI.calCounts - 1 then
//          begin
//            for J := 0 to Form_UI.calCounts - 1 do
//            begin
//              Form_UI.array_CalForce[J] := array_PlusResult[Form_UI.calingCounts - Form_UI.calCounts + J].JCL_value;
//            end;
//            array_PlusResult[Form_UI.calingCounts - 1].JCL_mean := Form_UI.CalMean(Form_UI.array_CalForce);
//            array_PlusResult[Form_UI.calingCounts - 1].JCL_max := Form_UI.CalMax(Form_UI.array_CalForce);
//            array_PlusResult[Form_UI.calingCounts - 1].JCL_min := Form_UI.CalMin(Form_UI.array_CalForce);
//            array_PlusResult[Form_UI.calingCounts - 1].JCL_std := Form_UI.Calstd(Form_UI.array_CalForce);
//          end;

          //数据压入绘图缓存区中
          New(TempDataSR);
          CopyMemory(TempDataSR, @array_PlusResult[Form_UI.calingCounts - 1], SizeOf(sDataFrame));
          Form_UI.DrawCache.Push(TempDataSR);

          //压入结果数据存储缓存区
          if Form_UI.IsSave then
          begin
            New(TempDataSR);
            CopyMemory(TempDataSR, @array_PlusResult[Form_UI.calingCounts - 1], SizeOf(sDataFrame));
            Form_UI.ResultCache.Push(TempDataSR);
          end;
        end
        else
        begin
          //锚段计算
          if array_ResultDeal[I].mark = 2 then
          begin
            if array_ResultDeal[I].LCZ12_value <> 0 then
            begin
              if Form_UI.calMaoCounts < Length_DynamicArray - 1 then
              begin
                Form_UI.calMaoCounts := Form_UI.calMaoCounts + 1;
                SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
                SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
                temp_SPJL_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
                temp_SPGC_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
              end
              else
              begin
                for J := 0 to Length_DynamicArray - 3 do
                begin
                  temp_SPJL_value[J] := temp_SPJL_value[J + 1];
                  temp_SPGC_value[J] := temp_SPGC_value[J + 1];
                end;
                temp_SPJL_value[Length_DynamicArray - 2] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
                temp_SPGC_value[Length_DynamicArray - 2] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
              end;
            end;
          end;

          //为高差计算做准备
          if temp_MaxH < array_ResultDeal[I].DGZ11_value then temp_MaxH := array_ResultDeal[I].DGZ11_value;
          if temp_MinH > array_ResultDeal[I].DGZ11_value then temp_MinH := array_ResultDeal[I].DGZ11_value;

          //区段计算
          if array_ResultDeal[I].mark = 4 then
          begin
            endRecordKm := nowKm;
            if Abs(endRecordKm - startRecordKm) > 0.005 then
            begin
              if Form_UI.calHCounts < Length_DynamicArray - 1 then
              begin
                Form_UI.calHCounts := Form_UI.calHCounts + 1;
                SetLength(temp_DGBHL_value, Form_UI.calHCounts);
                SetLength(temp_DWDGC_value, Form_UI.calHCounts);
                temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
                temp_DGBHL_value[Form_UI.calHCounts - 1] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000;
              end
              else
              begin
                for J := 0 to Length_DynamicArray - 3 do
                begin
                  temp_DWDGC_value[J] := temp_DWDGC_value[J + 1];
                  temp_DGBHL_value[J] := temp_DGBHL_value[J + 1];
                end;
                temp_DWDGC_value[Length_DynamicArray - 2] := Abs(temp_MaxH - temp_MinH);
                temp_DGBHL_value[Length_DynamicArray - 2] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000;
              end;
            end;
          end;

          //硬点、接触力、电流均值计算
          if Form_UI.noPlusCounts < Length_DynamicArray - 1 then
          begin
            Form_UI.noPlusCounts := Form_UI.noPlusCounts + 1;
            SetLength(temp_arrayYD1, Form_UI.noPlusCounts);
            SetLength(temp_arrayYD2, Form_UI.noPlusCounts);
            SetLength(temp_arrayJCL, Form_UI.noPlusCounts);
            SetLength(temp_arrayDL, Form_UI.noPlusCounts);
            temp_arrayYD1[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].YD1_value;
            temp_arrayYD2[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].YD2_value;
            temp_arrayJCL[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].JCL_value;
            temp_arrayDL[Form_UI.noPlusCounts - 1] := array_ResultDeal[I].DL_value;

            SetLength(temp_arraycalibYL1, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYL2, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYL3, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYL4, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYD1, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYD2, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYD4, Form_UI.noPlusCounts);
            SetLength(temp_arraycalibYD5, Form_UI.noPlusCounts);
            temp_arraycalibYL1[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power1;
            temp_arraycalibYL2[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power2;
            temp_arraycalibYL3[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power3;
            temp_arraycalibYL4[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].Power4;
            temp_arraycalibYD1[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot1;
            temp_arraycalibYD2[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot2;
            temp_arraycalibYD4[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot4;
            temp_arraycalibYD5[Form_UI.noPlusCounts - 1] := array_CalibResultDeal[I].HardSpot5;
          end
          else
          begin
            for J := 0 to Length_DynamicArray - 3 do
            begin
              temp_arrayYD1[J] := temp_arrayYD1[J + 1];
              temp_arrayYD2[J] := temp_arrayYD2[J + 1];
              temp_arrayJCL[J] := temp_arrayJCL[J + 1];
              temp_arrayDL[J] := temp_arrayDL[J + 1];

              temp_arraycalibYL1[J] := temp_arraycalibYL1[J + 1];
              temp_arraycalibYL2[J] := temp_arraycalibYL2[J + 1];
              temp_arraycalibYL3[J] := temp_arraycalibYL3[J + 1];
              temp_arraycalibYL4[J] := temp_arraycalibYL4[J + 1];
              temp_arraycalibYD1[J] := temp_arraycalibYD1[J + 1];
              temp_arraycalibYD2[J] := temp_arraycalibYD2[J + 1];
              temp_arraycalibYD4[J] := temp_arraycalibYD4[J + 1];
              temp_arraycalibYD5[J] := temp_arraycalibYD5[J + 1];
            end;
            temp_arrayYD1[Length_DynamicArray - 2] := array_ResultDeal[I].YD1_value;
            temp_arrayYD2[Length_DynamicArray - 2] := array_ResultDeal[I].YD2_value;
            temp_arrayJCL[Length_DynamicArray - 2] := array_ResultDeal[I].JCL_value;
            temp_arrayDL[Length_DynamicArray - 2] := array_ResultDeal[I].DL_value;

            temp_arraycalibYL1[Length_DynamicArray - 2] := array_CalibResultDeal[I].Power1;
            temp_arraycalibYL2[Length_DynamicArray - 2] := array_CalibResultDeal[I].Power2;
            temp_arraycalibYL3[Length_DynamicArray - 2] := array_CalibResultDeal[I].Power3;
            temp_arraycalibYL4[Length_DynamicArray - 2] := array_CalibResultDeal[I].Power4;
            temp_arraycalibYD1[Length_DynamicArray - 2] := array_CalibResultDeal[I].HardSpot1;
            temp_arraycalibYD2[Length_DynamicArray - 2] := array_CalibResultDeal[I].HardSpot2;
            temp_arraycalibYD4[Length_DynamicArray - 2] := array_CalibResultDeal[I].HardSpot4;
            temp_arraycalibYD5[Length_DynamicArray - 2] := array_CalibResultDeal[I].HardSpot5;
          end;
        end;
      end;
      Application.ProcessMessages;
      Sleep(300);
    end;
  end;
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

procedure TForm_UI.Action_DataDisplayExecute(Sender: TObject);
begin
  RzPageControl.ActivePage := TabSheet_Data;
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
    if MessageBox(Handle, '您确定要恢复之前的设置吗？', '恢复设置', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
    begin
      CopyFile(PChar(backupFilePath), PChar(configurationFilePath), False);
      InitConfigurationFile;
      InitSubGroup;
      MessageBox(Handle, '设置已恢复。', '恢复设置', MB_OK + MB_ICONQUESTION);
    end;
  end
  else MessageBox(Handle, '未发现备份的配置文件。', '恢复设置', MB_OK + MB_ICONQUESTION);
end;

procedure TForm_UI.Action_StartInitCalibrateExecute(Sender: TObject);
begin
  LargeButton_StartInitCali.Enabled := False;
  LargeButton_StartRaiseCali.Enabled := False;
  LargeButton_StartNormalCali.Enabled := False;

  IsCalibrating_Init := True;
  IsFirstCalibrate := True;
end;

procedure TForm_UI.Action_StartNormalCalibrateExecute(Sender: TObject);
begin
  LargeButton_StartInitCali.Enabled := False;
  LargeButton_StartRaiseCali.Enabled := False;
  LargeButton_StartNormalCali.Enabled := False;

  IsCalibrating_Normal := True;
  IsFirstCalibrate := True;
end;

procedure TForm_UI.Action_StartCollectExecute(Sender: TObject);
begin
  case Init2DIP of
    0:
    begin
      case Open2D of
        0:
        begin
          dxRibbonStatusBar.Panels[3].Text := '2D传感器已正常开始工作。';

          if not IsRun then
          begin
            Counts_Package := 0;
            Counts_Save := 0;
            Counts_Number := 0;
            StartMs := 0;
            startTime := FormatDateTime('yymmddhhnnss', Now);
            Data2DCache.clear;
            HvUDPCache.clear;
            LvUDPCache.clear;
            AcyingCache.clear;
            DrawCache.clear;
            OriginalCache.clear;
            ResultCache.clear;
            ResumeThread(PSaveThread);
            ResumeThread(PProcessThread);
            FDrawThread.Resume;
            IsRun := True;
            UDPStartCollect;
            IdUDPServer_Acying.Active := True;
            dxRibbonStatusBar.Panels[0].Text := '正在采集。';
            dxRibbonStatusBar.Panels[4].Text := '线路状况：' + Form_LineSetting.shangxiaxing + Form_LineSetting.direction + '。';
            dxRibbonStatusBar.Panels[5].Text := '公里标：' + FloatToStr(Form_LineSetting.kilometer) + 'km   速度：0km/h';
          end;
        end;
        -1: dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
        -2: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
        -3: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
        -4: dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
        -5: dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
        -6: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
        -404: dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
      end;
    end;
    -1: dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
    -2: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
    -3: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
    -4: dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
    -5: dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
    -6: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
    -404: dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
  end;
end;

procedure TForm_UI.Action_StartPlaybackExecute(Sender: TObject);
begin
  IsPlayback := True;
  ResumeThread(PSaveThread);
  ResumeThread(PProcessThread);
  FDrawThread.Resume;
end;

procedure TForm_UI.Action_StartRaiseCalibrateExecute(Sender: TObject);
begin
  LargeButton_StartInitCali.Enabled := False;
  LargeButton_StartRaiseCali.Enabled := False;
  LargeButton_StartNormalCali.Enabled := False;

  IsCalibrating_Raise := True;
  IsFirstCalibrate := True;
end;

procedure TForm_UI.Action_StartSaveExecute(Sender: TObject);
begin
  if not IsSave then
  begin
    TempOrignalDataPath := SavedOriginalDataPath + FormatDateTime('yyyymmddhhnnss', Now) + '\GWOriginal.dat';
    if not DirectoryExists(ExtractFilePath(TempOrignalDataPath)) then ForceDirectories(ExtractFilePath(TempOrignalDataPath));
    CopyFile(PChar(configurationFilePath), PChar(ExtractFilePath(TempOrignalDataPath) + 'ConfigurationFile.txt'), False);
    TempResultDataPath := SavedResultDataPath + Form_LineSetting.line_name + '_' + FormatDateTime('yymmddhhnnss', Now) + '\GWResult.dat';
    if not DirectoryExists(ExtractFilePath(TempResultDataPath)) then ForceDirectories(ExtractFilePath(TempResultDataPath));
    SaveResultHead(TempResultDataPath, Form_LineSetting.line_name, Form_LineSetting.Pole_InitNumber, Form_LineSetting.kilometer, Form_LineSetting.shangxiaxing, Form_LineSetting.direction, Form_LineSetting.plus_minus, Form_LineSetting.Pole_Zengjian);
    StartSaveOriginalData;
    StartSaveResultData;
    IsSave := True;
    dxRibbonStatusBar.Panels[1].Text := '正在存储数据。';
    Application.ProcessMessages;
  end;
end;

procedure TForm_UI.Action_StartSimulateExecute(Sender: TObject);
begin
  case Init2DIP of
    0:
    begin
      case Open2D of
        0:
        begin
          dxRibbonStatusBar.Panels[3].Text := '2D传感器已正常开始工作。';

          if not IsRun then
          begin
            StartMs := 0;
            startTime := FormatDateTime('yymmddhhnnss', Now);
            Data2DCache.clear;
            HvUDPCache.clear;
            LvUDPCache.clear;
            AcyingCache.clear;
            DrawCache.clear;
            OriginalCache.clear;
            ResultCache.clear;
            ResumeThread(PSaveThread);
            ResumeThread(PProcessThread);
            FDrawThread.Resume;
            IsRun := True;
            Counts_Package := 0;
            Counts_Save := 0;
            Counts_Number := 0;
            UDPStartSimulate;
            IdUDPServer_Acying.Active := True;
            dxRibbonStatusBar.Panels[0].Text := '正在采集。';
            dxRibbonStatusBar.Panels[4].Text := '线路状况：' + Form_LineSetting.shangxiaxing + Form_LineSetting.direction + '。';
            dxRibbonStatusBar.Panels[5].Text := '公里标：' + FloatToStr(Form_LineSetting.kilometer) + 'km   速度：0km/h';
          end;
        end;
        -1: dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
        -2: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
        -3: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
        -4: dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
        -5: dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
        -6: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
        -404: dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
      end;
    end;
    -1: dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
    -2: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
    -3: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
    -4: dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
    -5: dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
    -6: dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
    -404: dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
  end;
end;

procedure TForm_UI.Action_StopCalibrateExecute(Sender: TObject);
begin
  IsCalibrating_Init := False;
  IsCalibrating_Raise := False;
  IsCalibrating_Normal := False;

  LargeButton_StartInitCali.Enabled := True;
  LargeButton_StartRaiseCali.Enabled := True;
  LargeButton_StartNormalCali.Enabled := True;
end;

procedure TForm_UI.Action_StopCollectExecute(Sender: TObject);
var
  I: Byte;
  J: Word;
begin
  if IsRun then
  begin
    UDPStopCollect;
    IdUDPServer_Acying.Active := False;

    SuspendThread(Form_UI.PProcessThread);
    FDrawThread.Suspend;
    SuspendThread(Form_UI.pSaveThread);

    IsRun := False;
    IsSave := False;
    dxRibbonStatusBar.Panels[0].Text := '已停止采集。';
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';

    //为下次开始做准备
    IsFirstCal := True;
    IsJCDL := True;
    IsGJD := False;
    drawCounts:= 0;
    calingCounts := 0;
    noPlusCounts := 0;
    calHCounts := 0;
    calMaoCounts := 0;
    poleCounts := 0;
    pole_ghNumb := 0;
    paintCounts := 0;
    AcyingNumber_First := -1;

    time_Electricity := 0;
    time_CalSpeed := 0;
    tempStartTime := 0;
    tempEndTime := 0;

    //2D错误值取前一个值数组初始化
    for I := 0 to 3 do
    begin
      temp_X[I] := 65537;
      temp_Y[I] := 65537;
    end;

    //绘图数据数组初始化
    for I := 0 to 26 do
    begin
      for J := 0 to Number_Draw - 1 do
      begin
        DrawData[I][J] := 0;
      end;
    end;
    SuspendThread(Form_UI.PSaveThread);

    Close2D;
    dxRibbonStatusBar.Panels[3].Text := '2D传感器已停止工作。';
  end;
end;

procedure TForm_UI.Action_StopPlaybackExecute(Sender: TObject);
begin
  SuspendThread(PProcessThread);
  FDrawThread.Suspend;
  IsFirstCalibrate := False;
  IsCalibrating_Init := False;
  IsCalibrating_Raise := False;
  IsCalibrating_Normal := False;
  LargeButton_InitSetting.Enabled := True;
  LargeButton_Pause.Enabled := True;
  LargeButton_StartCollect.Enabled := True;
  LargeButton_StopCollect.Enabled := True;
  IsPlayback := False;
end;

procedure TForm_UI.Action_StopSaveExecute(Sender: TObject);
begin
  if IsSave then
  begin
    SuspendThread(PProcessThread);
    SuspendThread(pSaveThread);
    IsSave := False;
    OriginalCache.clear;
    ResultCache.clear;
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';
    StopSaveOriginalData;
    StopSaveResultData;
    if IsRun or IsPlayback then
    begin
      ResumeThread(pSaveThread);
      ResumeThread(PProcessThread);
    end;
    Application.ProcessMessages;
  end;
end;

procedure TForm_UI.Action_StopSimulateExecute(Sender: TObject);
var
  I: Byte;
  J: Word;
begin
  if IsRun then
  begin
    UDPStopSimulate;
    IdUDPServer_Acying.Active := False;


    SuspendThread(PProcessThread);
    FDrawThread.Suspend;

    IsRun := False;
    IsSave := False;
    dxRibbonStatusBar.Panels[0].Text := '已停止采集。';
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';

    //为下次开始做准备
    IsFirstCal := True;
    IsJCDL := True;
    IsGJD := False;
    drawCounts:= 0;
    calingCounts := 0;
    noPlusCounts := 0;
    calHCounts := 0;
    calMaoCounts := 0;
    poleCounts := 0;
    pole_ghNumb := 0;
    paintCounts := 0;
    AcyingNumber_First := -1;

    time_Electricity := 0;
    time_CalSpeed := 0;
    tempStartTime := 0;
    tempEndTime := 0;

    //2D错误值取前一个值数组初始化
    for I := 0 to 3 do
    begin
      temp_X[I] := 65537;
      temp_Y[I] := 65537;
    end;

    //绘图数据数组初始化
    for I := 0 to 26 do
    begin
      for J := 0 to Number_Draw - 1 do
      begin
        DrawData[I][J] := 0;
      end;
    end;
    SuspendThread(PSaveThread);

    Close2D;
    dxRibbonStatusBar.Panels[3].Text := '2D传感器已停止工作。';
  end;
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
  result := '软件版本号：' + IntToStr(result1) + '.' + IntToStr(result2) + '.' + IntToStr(result3) + '.' + IntToStr(result4);
  FreeMem(verInfo, verInfoSize);
  MessageBox(handle, PWideChar(result), '信息提示', MB_OK);
end;

procedure TForm_UI.dxRibbonMinimizedChanged(Sender: TdxCustomRibbon);
begin
  dxRibbon.ShowTabGroups := True;
end;

procedure TForm_UI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageBox(handle, '您确定要退出系统吗？', '信息提示', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then CanClose := True
  else CanClose := False;
end;

procedure TForm_UI.FormCreate(Sender: TObject);
var
  FSaveThreadID, FProcessThreadID: DWORD;   //各个线程ID,THandle不行
  W: array [0..1] of Double;
  FirOrder: Integer;
  I: Byte;
  J: Word;
begin
  RzPageControl.ActivePage := TabSheet_Data;

  //关联相应地址
  ErrorLogPath := ExtractFilePath(Application.ExeName)  + Ansistring('ErrorLog\ErrorLog.txt');
  ConfigurationFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\ConfigurationFile.txt');
  BackupFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\配置备份\ConfigurationFile.txt');
  SavedOriginalDataPath := ExtractFilePath(Application.ExeName) + AnsiString('SavedData\');
  SavedResultDataPath := ExtractFilePath(Application.ExeName) + AnsiString('DATA\');

  //2D初始化（导高拉出值）
//  Set8087CW(DWord($133f));   //屏蔽错误用
  m_lock := CreateMutex(nil, False, nil);
  m_hjcw := Jcw_InitInstance();
  m_iDevid := JMID_GEO_DEV0;
  Jcw_SetResultCallBack(m_hjcw, self, @fnResultCallback);

  //2D初始化（点云数据）
  m_mutex := CreateMutex(nil, False, nil);
  m_hYEG := YEG_CreateInstance;
//  YEG_SetScanPointCallBack(m_hYEG, @OnPointCould, Self);

  InitFolder;
  InitConfigurationFile;

//  FGlobalpara.DataSelfDelete(SavedOriginalDataPath, 20.0);    //数据自删减，如果路径是不存在的路径是不会出错的
//  FGlobalpara.DataSelfDelete(SavedResultDataPath, 20.0);    //数据自删减

//  InitializeCriticalSection(CS);

  Data2DCache := TsfQueue.Create;
  HvUDPCache := TsfQueue.Create;
  LvUDPCache := TsfQueue.Create;
  AcyingCache := TsfQueue.Create;
  DrawCache := TsfQueue.Create;
  OriginalCache := TsfQueue.Create;
  ResultCache := TsfQueue.Create;

  //滤波器初始化
  W[0] := Fq_BandPass;
  W[1] := Fq_CutOff;
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

  vector_Power1.Size(Number_Cal);
  vector_Power2.Size(Number_Cal);
  vector_Power3.Size(Number_Cal);
  vector_Power4.Size(Number_Cal);
  vector_Electricity.Size(Number_Cal);
  vector_HardSpot1.Size(Number_Cal);
  vector_HardSpot2.Size(Number_Cal);
  vector_HardSpot3.Size(Number_Cal);
  vector_HardSpot4.Size(Number_Cal);
  vector_HardSpot5.Size(Number_Cal);
  vector_HardSpot6.Size(Number_Cal);

  //创建线程
  PSaveThread := CreateThread(nil, 0, @SaveThread, nil, 4, FSaveThreadID);
  PProcessThread := CreateThread(nil, 0, @ProcessThread, nil, 4, FProcessThreadID);
  FDrawThread := TDrawThread.Create;
  FDrawThread.Suspend;

  Timer_InitSubGroup.Enabled := True;

  //布尔类型初始化
  IsRun := False;
  IsSave := False;
  IsPlayback := False;
  IsFirstCalibrate := False;
  IsCalibrating_Init := False;
  IsCalibrating_Raise := False;
  IsCalibrating_Normal := False;
  IsFirstCal := True;
  IsJCDL := True;
  IsGJD := False;

  //计算绘图技术点初始化
  drawCounts := 0;
  calingCounts := 0;
  noPlusCounts := 0;
  calHCounts := 0;
  calMaoCounts := 0;
  poleCounts := 0;
  pole_ghNumb := 0;
  paintCounts := 0;
  Counts_Package := 0;
  Counts_Save := 0;
  Counts_Number := 0;
  AcyingNumber_First := -1;

  time_Electricity := 0;
  time_CalSpeed := 0;
  tempStartTime := 0;
  tempEndTime := 0;

  //2D错误值取前一个值数组初始化
  for I := 0 to 3 do
  begin
    temp_X[I] := 65537;
    temp_Y[I] := 65537;
  end;

  //绘图数据数组初始化
  for I := 0 to 26 do
  begin
    for J := 0 to Number_Draw - 1 do
    begin
      DrawData[I][J] := 0;
    end;
  end;

  //测试
//  CopyFile(PChar(configurationFilePath), PChar('D:\123\ConfigurationFile.txt'), False);
end;

procedure TForm_UI.FormDestroy(Sender: TObject);
begin
  Timer.Enabled := False;

  if IsSave then Action_StopSaveExecute(Sender);

  if IsRun then
  begin
    Action_StopCollectExecute(Sender);
    Action_StopSimulateExecute(Sender);
  end;

  //线程销毁
  TerminateThread(PSaveThread, 0);
  TerminateThread(PProcessThread, 0);
  FDrawThread.Free;

  Data2DCache.Free;
  HvUDPCache.Free;
  LvUDPCache.Free;
  AcyingCache.Free;
  DrawCache.Free;
  OriginalCache.Free;
  ResultCache.Free;

  //暂停UDP接收
  IdUDPServer_Hv.Active := False;
  IdUDPServer_Lv.Active := False;
  IdUDPServer_Acying.Active := False;

  //滤波器析构
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

  //2D析构
  CloseHandle(m_mutex);
  CloseHandle(m_lock);

//  DeleteCriticalSection(CS);
end;

procedure TForm_UI.TimerTimer(Sender: TObject);
begin
  //下面三句代码无意义，仅做测试用
  Counts_Package := Counts_Package;
  Counts_Save := Counts_Save;
  Counts_Number := Counts_Number;

  if IsRun or IsPlayback then Form_Sensor.Button_Comfirm.Enabled := False
  else Form_Sensor.Button_Comfirm.Enabled := True;

  dxRibbonStatusBar.Panels[5].Text := '公里标：' + Formatfloat('0.000', GKilometer) + 'km   速度：' + Formatfloat('0.000', GSpeed) + 'km/h';
  dxRibbonStatusBar.Panels[6].Text := FormatDateTime('yyyy年mm月dd日 hh:nn:ss', Now);

  Application.ProcessMessages;
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
      Writeln(ConfigurationTextFile, '[基础设置]');
      Writeln(ConfigurationTextFile, '线路名称 = 未知线路');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[传感器设置]');
      Writeln(ConfigurationTextFile, '2DIP = 10.10.10.100');
      Writeln(ConfigurationTextFile, 'HvUDPIP = 10.10.10.3');
      Writeln(ConfigurationTextFile, 'HvUDPPort = 1025');
      Writeln(ConfigurationTextFile, 'LvUDPIP = 10.10.10.2');
      Writeln(ConfigurationTextFile, 'LvUDPPort = 1026');
      Writeln(ConfigurationTextFile, 'AcyingUDPIP = 10.10.10.4');
      Writeln(ConfigurationTextFile, 'AcyingUDPPort = 1027');
      Writeln(ConfigurationTextFile, 'ComputerIP = 10.10.10.11');
      Writeln(ConfigurationTextFile, 'ComputerPort = 1025');
      Writeln(ConfigurationTextFile, 'ComputerPort = 1025');
      Writeln(ConfigurationTextFile, 'Direction = 1');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[车辆设置]');
      Writeln(ConfigurationTextFile, '轮径值 = 840');
      Writeln(ConfigurationTextFile, '轮径脉冲数 = 80');

      Writeln(ConfigurationTextFile, '[参数设置]');
      Writeln(ConfigurationTextFile, '是否补偿 = 0');
      Writeln(ConfigurationTextFile, '弓网质量 = 30');
      Writeln(ConfigurationTextFile, '电流标准值 = 1500');
      Writeln(ConfigurationTextFile, '压力传感器1灵敏度系数 = 2');
      Writeln(ConfigurationTextFile, '压力传感器2灵敏度系数 = 2');
      Writeln(ConfigurationTextFile, '压力传感器3灵敏度系数 = 2');
      Writeln(ConfigurationTextFile, '压力传感器4灵敏度系数 = 2');
      Writeln(ConfigurationTextFile, '加速度1灵敏度系数 = 24');
      Writeln(ConfigurationTextFile, '加速度2灵敏度系数 = 24');
      Writeln(ConfigurationTextFile, '弓网力 = 120');
      Writeln(ConfigurationTextFile, '载物力 = 10.2');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[标定]');
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
      Writeln(ConfigurationTextFile, 'ForceK = 1');
      Writeln(ConfigurationTextFile, 'ForceB = 0');
      Writeln(ConfigurationTextFile, 'DGZ = 0');
      Writeln(ConfigurationTextFile, 'LCZ = 0');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[调试]');
      Writeln(ConfigurationTextFile, '调试 = 0');
      Writeln(ConfigurationTextFile, '绘图点数 = 100');
      Writeln(ConfigurationTextFile, '计算点数 = 100');
      Writeln(ConfigurationTextFile, '');

      CloseFile(ConfigurationTextFile);
    End;

    IniFile := TIniFile.Create(ConfigurationFilePath);

    LineName := IniFile.ReadString('基础设置', '线路名称', '未知线路');

    TCPIP := IniFile.ReadString('传感器设置', '2DIP', '10.10.10.100');
    HvUDPIP := IniFile.ReadString('传感器设置', 'HvUDPIP', '10.10.10.3');
    HvUDPPort := IniFile.ReadString('传感器设置', 'HvUDPPort', '1025');
    LvUDPIP := IniFile.ReadString('传感器设置', 'LvUDPIP', '10.10.10.2');
    LvUDPPort := IniFile.ReadString('传感器设置', 'LvUDPPort', '1026');
    AcyingUDPIP := IniFile.ReadString('传感器设置', 'AcyingUDPIP', '10.10.10.4');
    AcyingUDPPort := IniFile.ReadString('传感器设置', 'AcyingUDPPort', '1027');
    ComputerIP := IniFile.ReadString('传感器设置', 'ComputerIP', '10.10.10.11');
    ComputerPort := IniFile.ReadString('传感器设置', 'ComputerPort', '1025');
    Direction_Sensor := IniFile.ReadInteger('传感器设置', 'Direction', 1);


    IsCompensate := IniFile.ReadInteger('参数设置', '是否补偿', 0);
    Value_Quality := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '弓网质量', 30)));
    Value_StandradElectricity := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '电流标准值', 1500)));
    Sensitivity_YL1 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '压力传感器1灵敏度系数', 2)));
    Sensitivity_YL2 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '压力传感器2灵敏度系数', 2)));
    Sensitivity_YL3 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '压力传感器3灵敏度系数', 2)));
    Sensitivity_YL4 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '压力传感器4灵敏度系数', 2)));
    Sensitivity_ACC1 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '加速度1灵敏度系数', 24)));
    Sensitivity_ACC2 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '加速度2灵敏度系数', 24)));
    Force_CalK := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '弓网力', 120)));
    Force_CalB := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('参数设置', '载物力', 10.2)));

    D_Wheel := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('车辆设置', '轮径值', 840)));
    N_Pluse := IniFile.ReadInteger('车辆设置', '轮径脉冲数', 80);
    Distance_Pluse := D_Wheel * 3.141592653 / N_Pluse;

    Calibrate_Force := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Force', 0)));
    Calibrate_Electricity := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Electricity', 0)));
    Calibrate_Power1 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Power1', 0)));
    Calibrate_Power2 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Power2', 0)));
    Calibrate_Power3 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Power3', 0)));
    Calibrate_Power4 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'Power4', 0)));
    Calibrate_ACC1 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC1', 0)));
    Calibrate_ACC2 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC2', 0)));
    Calibrate_ACC3 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC3', 0)));
    Calibrate_ACC4 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC4', 0)));
    Calibrate_ACC5 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC5', 0)));
    Calibrate_ACC6 := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ACC6', 0)));
    calibrate_ForceK := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ForceK', 1)));
    calibrate_ForceB := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'ForceB', 0)));
    calibrate_DGZ := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'DGZ', 0)));
    calibrate_LCZ := StrToFloat(FormatFloat('0.0', IniFile.ReadFloat('标定', 'LCZ', 0)));

    IsDebug := IniFile.ReadInteger('调试', '调试', 1);
    drawThreshold := IniFile.ReadInteger('调试', '绘图点数', 50);
    calCounts := IniFile.ReadInteger('调试', '计算点数', 100);
    SetLength(array_CalForce, calCounts);

    IdUDPServer_Hv.DefaultPort := StrToInt(HvUDPPort);
    IdUDPServer_Hv.Active := True;
    IdUDPServer_Lv.DefaultPort := StrToInt(LvUDPPort);
    IdUDPServer_Lv.Active := True;
    IdUDPServer_Acying.DefaultPort := StrToInt(AcyingUDPPort);

    IniFile.Free;

    if IsDebug > 0 then Menu := MainMenu_UI
    else Menu := nil;
  except
    On E : Exception Do
    begin
      FGlobalpara.ShowAndSaveErrorLog(ErrorLogPath, 'InitConfigurationFile', E.Message, False);
      dxRibbonStatusBar.Panels[0].Text := '软件初始化失败，请检查配置文件。';
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

  division := ComputerIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_ComputerIP1.Text := division[i];
      1: Form_Sensor.Edit_ComputerIP2.Text := division[i];
      2: Form_Sensor.Edit_ComputerIP3.Text := division[i];
      3: Form_Sensor.Edit_ComputerIP4.Text := division[i];
    end;
  end;
  Form_Sensor.Edit_ComputerPort.Text := ComputerPort;

  if Direction_Sensor = 1 then Form_Sensor.RadioButton_Zheng.Checked := True
  else Form_Sensor.RadioButton_Fu.Checked := True;

  Form_Sensor.Edit_Quality.Text := FormatFloat('0.0', Value_Quality);
  Form_Sensor.Edit_ElectrycityValue.Text := FormatFloat('0.0', Value_StandradElectricity);

  Form_Sensor.Edit_DrawCounts.Text := IntToStr(drawThreshold);
  Form_Sensor.Edit_CalCounts.Text := IntToStr(calCounts);

  Form_Sensor.Edit_ForceCalK.Text := FormatFloat('0.0', Force_CalK);
  Form_Sensor.Edit_ForceCalB.Text := FormatFloat('0.0', Force_CalB);

  Form_Sensor.Edit_Wheel.Text := FormatFloat('0.0', D_Wheel);
  Form_Sensor.Edit_Pluse.Text := IntToStr(N_Pluse);

  Form_Sensor.Edit_Force.Text := FormatFloat('0.0', Calibrate_Force);
  Form_Sensor.Edit_Electricity.Text := FormatFloat('0.0', Calibrate_Electricity);
  Form_Sensor.Edit_Power1.Text := FormatFloat('0.0', Calibrate_Power1);
  Form_Sensor.Edit_Power2.Text := FormatFloat('0.0', Calibrate_Power2);
  Form_Sensor.Edit_Power3.Text := FormatFloat('0.0', Calibrate_Power3);
  Form_Sensor.Edit_Power4.Text := FormatFloat('0.0', Calibrate_Power4);
  Form_Sensor.Edit_ACC1.Text := FormatFloat('0.0', Calibrate_ACC1);
  Form_Sensor.Edit_ACC2.Text := FormatFloat('0.0', Calibrate_ACC2);
  Form_Sensor.Edit_ACC3.Text := FormatFloat('0.0', Calibrate_ACC3);
  Form_Sensor.Edit_ACC4.Text := FormatFloat('0.0', Calibrate_ACC4);
  Form_Sensor.Edit_ACC5.Text := FormatFloat('0.0', Calibrate_ACC5);
  Form_Sensor.Edit_ACC6.Text := FormatFloat('0.0', Calibrate_ACC6);
  Form_Sensor.Edit_ForceK.Text := FormatFloat('0.0', calibrate_ForceK);
  Form_Sensor.Edit_ForceB.Text := FormatFloat('0.0', calibrate_ForceB);

  Form_Sensor.Edit_IsCompensate.Text := IntToStr(IsCompensate);
  Form_Sensor.Edit_DGZ.Text := FormatFloat('0.0', calibrate_DGZ);
  Form_Sensor.Edit_LCZ.Text := FormatFloat('0.0', calibrate_LCZ);
  Form_Sensor.Edit_YL1.Text := FormatFloat('0.0', Sensitivity_YL1);
  Form_Sensor.Edit_YL2.Text := FormatFloat('0.0', Sensitivity_YL2);
  Form_Sensor.Edit_YL3.Text := FormatFloat('0.0', Sensitivity_YL3);
  Form_Sensor.Edit_YL4.Text := FormatFloat('0.0', Sensitivity_YL4);
  Form_Sensor.Edit_AC1.Text := FormatFloat('0.0', Sensitivity_ACC1);
  Form_Sensor.Edit_AC2.Text := FormatFloat('0.0', Sensitivity_ACC2);
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
var
  I: Byte;
  tempData: TRecord_OriginalAcying;
  tempDataAcying: ^TRecord_OriginalAcying;
begin
  tempData.Distance_Init := Form_LineSetting.kilometer;
  tempData.Pole_Init := Form_LineSetting.Pole_InitNumber;
  tempData.initzengjian := Form_LineSetting.plus_minus;
  tempData.ghzengjian := Form_LineSetting.Pole_Zengjian;
  for I := 0 to 9 do tempData.Acying[I] := AData[I];

  New(tempDataAcying);
  CopyMemory(tempDataAcying, @tempData, SizeOf(TRecord_OriginalAcying));
  AcyingCache.Push(tempDataAcying);
end;

procedure TForm_UI.IdUDPServer_HvUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  I: Byte;
  tmp: array [0..69] of Byte;
  TempDataHv: ^TRecord_OriginalHv;
begin
  for I := 0 to 69 do tmp[I] := AData[I];

  New(TempDataHv);
  CopyMemory(TempDataHv, @tmp, SizeOf(TRecord_OriginalHv));
  HvUDPCache.Push(TempDataHv);
end;

procedure TForm_UI.IdUDPServer_LvUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  I: Byte;
  tmp: array [0..51] of Byte;
  TempDataLv: ^TRecord_OriginalLv;
begin
  for I := 0 to 51 do tmp[I] := AData[I];

  New(TempDataLv);
  CopyMemory(TempDataLv, @tmp, SizeOf(TRecord_OriginalLv));
  LvUDPCache.Push(TempDataLv);
end;

function TForm_UI.Init2DIP: Integer;
begin
  Result := JCWSetIP(TCPIP);
//  if Result = 0 then Result := YEGConnect(TCPIP);
end;

function TForm_UI.Open2D: Integer;
begin
  Result := Jcw_Start(m_hjcw);
//  if Result = 0 then Result := YEG_StartGrab(m_hYEG);
end;

procedure TForm_UI.Close2D;
begin
//  YEGDisconnect;
  Jcw_Stop(m_hjcw);
//  YEG_StopGrab(m_hYEG);
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
  IdUDPServer_Lv.SendBuffer('10.10.10.2', 1025, Buffer_Send);
  IdUDPServer_Hv.SendBuffer('10.10.10.3', 1025, Buffer_Send);
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
  Buffer_Send[3] := 1;
  for I := 4 to 39 do Buffer_Send[I] := 0;
  Buffer_Send[40] := 2;
  Buffer_Send[41] := 0;
  Buffer_Send[42] := 0;
  Buffer_Send[43] := 0;
  Buffer_Send[44] := StrToInt(FormatDateTime('yy', TempTime));
  Buffer_Send[45] := StrToInt(FormatDateTime('mm', TempTime));
  Buffer_Send[46] := StrToInt(FormatDateTime('dd', TempTime));
  Buffer_Send[47] := StrToInt(FormatDateTime('hh', TempTime));
  Buffer_Send[48] := StrToInt(FormatDateTime('nn', TempTime));
  Buffer_Send[49] := StrToInt(FormatDateTime('ss', TempTime));
  IdUDPServer_Lv.SendBuffer('10.10.10.2', 1025, Buffer_Send);
  IdUDPServer_Hv.SendBuffer('10.10.10.3', 1025, Buffer_Send);
end;

procedure TForm_UI.SaveResultHead(tempPath: string; tempLineName: string; inight: Integer; initDis: Double; shangxia: string; rundir: string; initzengjian: Byte; ghzengjian: Byte);
var
  SaveResultlFile : file;
  FileStream : TFileStream;
  WritePosition : Int64;
  LengthNumber : Integer;
  TempData: sResultDataPara;
  I: Word;
  tempString: string;
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

  for I := 0 to Length(TempData.lineName) - 1 do TempData.lineName[I] := '0';
  if Length(tempLineName) > 0 then for I := 0 to Length(tempLineName) - 1 do TempData.lineName[I] := tempLineName[I + 1];
  //结果数据协议版本增加了一版
  TempData.Version := 2;
  for I := 0 to 394 do TempData.reserved[I] := 0;
  TempData.inight := inight;
  TempData.inidis := Round(initDis * 1000);
  TempData.Buchang := 0;
  if shangxia = '上行' then TempData.shangxia := 1
  else TempData.shangxia := 2;
  if rundir = '正向' then TempData.rundir := 1
  else TempData.rundir := 0;
  if initzengjian = 1 then TempData.initzengjian := 1
  else TempData.initzengjian := 0;
  if ghzengjian = 1 then TempData.ghzengjian := 1
  else TempData.ghzengjian := 0;

  tempString := FormatDateTime('yymmddhhnnss', Now);
  for I := 0 to 11 do TempData.DataTime[I] := tempString[I + 1];

  LengthNumber := FileStream.Write(TempData, SizeOf(sResultDataPara));
  FileStream.Destroy;
end;

procedure TForm_UI.StartSaveOriginalData;
var
  SaveOriginalFile : file;
begin
  if not FileExists(TempOrignalDataPath) then
  begin
    AssignFile(SaveOriginalFile, TempOrignalDataPath);
    Rewrite(SaveOriginalFile, 1);
    CloseFile(SaveOriginalFile);
  end;
  FileStream_Original := TFileStream.Create(TempOrignalDataPath, 2);
end;

procedure TForm_UI.SaveOriginalData(TempData: Record_SaveOriginal);
var
  WritePosition : Int64;
  LengthNumber : Integer;
begin
  WritePosition := FileStream_Original.Size;
  FileStream_Original.Seek(WritePosition, 0);
  LengthNumber := FileStream_Original.Write(TempData, SizeOf(Record_SaveOriginal));
end;

procedure TForm_UI.StopSaveOriginalData;
begin
  FileStream_Original.Destroy;
end;

procedure TForm_UI.StartSaveResultData;
var
  SaveResultlFile : file;
begin
  if not FileExists(TempResultDataPath) then
  begin
    AssignFile(SaveResultlFile, TempResultDataPath);
    Rewrite(SaveResultlFile, 1);
    CloseFile(SaveResultlFile);
  end;
  FileStream_Result := TFileStream.Create(TempResultDataPath, 2);
end;

procedure TForm_UI.SaveResultData(TempData: sDataFrame);
var
  WritePosition : Int64;
  LengthNumber : Integer;
begin
  WritePosition := FileStream_Result.Size;
  FileStream_Result.Seek(WritePosition, 0);
  LengthNumber := FileStream_Result.Write(TempData, SizeOf(sDataFrame));
end;

procedure TForm_UI.StopSaveResultData;
begin
  FileStream_Result.Destroy;
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
  TempDataOAcying: TRecord_OriginalAcying;
  TempData2D: ^JCWJH;
  TempDataHv: ^TRecord_OriginalHv;
  TempDataLv: ^TRecord_OriginalLv;
  TempDataAcying: ^TRecord_OriginalAcying;
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
    dxRibbonStatusBar.Panels[1].Text := '正在读取数据，请稍后。';
    FileStream.ReadBuffer(TempPlayBackData, SizeOf(Record_SaveOriginal));

    TempDataO2D := TempPlayBackData.Om_data;
    TempDataOHv := TempPlayBackData.OHvData;
    TempDataOLv := TempPlayBackData.OLvData;
    TempDataOAcying := TempPlayBackData.AcyingData;

    New(TempData2D);
    CopyMemory(TempData2D, @TempDataO2D, SizeOf(JCWJH));
    Data2DCache.Push(TempData2D);

    New(TempDataHv);
    CopyMemory(TempDataHv, @TempDataOHv, SizeOf(TRecord_OriginalHv));
    HvUDPCache.Push(TempDataHv);

    New(TempDataLv);
    CopyMemory(TempDataLv, @TempDataOLv, SizeOf(TRecord_OriginalLv));
    LvUDPCache.Push(TempDataLv);

    New(TempDataAcying);
    CopyMemory(TempDataAcying, @TempDataOAcying, SizeOf(TRecord_OriginalAcying));
    AcyingCache.Push(TempDataAcying);

    InputDataSize := InputDataSize + SizeOf(Record_SaveOriginal);
    Counts_Save := Counts_Save + 1;
  end;
  dxRibbonStatusBar.Panels[1].Text := '数据读取完毕，可以开始回放。';
  FileStream.Free;

  LargeButton_StartPlayback.Enabled := True;
  LargeButton_StopPlayback.Enabled := True;
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

function TForm_UI.CalJCL(tempV: Single; tempSensitivity: Single): Single;
begin
  Result := tempV * 117.34 / tempSensitivity;
end;

function TForm_UI.CalYD(tempV: Single; tempSensitivity: Single): Single;
begin
  Result := tempV * 1000 / tempSensitivity;
end;

function TForm_UI.CalDL(tempV: Single): Single;
begin
  Result := tempV * 1000 / 2;
end;

function TForm_UI.CalMean(tempArray: array of Single): Single;
var
  I: Word;
begin
  if Length(tempArray) > 0 then
  begin
    Result := 0;
    for I := 0 to Length(tempArray) - 1 do Result := tempArray[I] + Result;
    Result := Result / Length(tempArray);
  end
  else Result := -1;
end;

function TForm_UI.CalMax(tempArray: array of Single): Single;
var
  I: Word;
begin
  if Length(tempArray) > 0 then
  begin
    Result := tempArray[0];
    for I := 0 to Length(tempArray) - 1 do
    begin  
      if Result < tempArray[I] then Result := tempArray[I];
    end;
  end
  else Result := -1;
end;

function TForm_UI.CalMin(tempArray: array of Single): Single;
var
  I: Word;
begin
  if Length(tempArray) > 0 then
  begin
    Result := tempArray[0];
    for I := 0 to Length(tempArray) - 1 do
    begin  
      if Result > tempArray[I] then Result := tempArray[I];
    end;
  end
  else Result := -1;
end;

function TForm_UI.Calstd(tempArray: array of Single): Single;
var
  I: Word;
begin
  if Length(tempArray) > 0 then
  begin
    Result := 0;
    for I := 0 to Length(tempArray) - 1 do Result := Sqr(tempArray[I]) + Result;
    Result := Sqrt(Result / Length(tempArray));  
  end
  else Result := -1;
end;

function TForm_UI.CalAve(tempArray: array of Single): Single;
var
  I, J: Word;
begin
  if Length(tempArray) > 0 then
  begin
    Result := 0;
    J := 0;
    for I := 0 to Length(tempArray) - 1 do
    begin
      if tempArray[I] <> 0 then
      begin
        Result := tempArray[I] + Result;
        J := J + 1;
      end;
    end;
    if J = 0 then
    begin
      Result := Result;
    end
    else Result := Result / J;
  end
  else Result := -1;
end;

procedure TForm_UI.UDPStartSimulate;
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
  Buffer_Send[41] := 1;
  Buffer_Send[42] := 35;
  Buffer_Send[43] := 0;
  Buffer_Send[44] := StrToInt(FormatDateTime('yy', TempTime));
  Buffer_Send[45] := StrToInt(FormatDateTime('mm', TempTime));
  Buffer_Send[46] := StrToInt(FormatDateTime('dd', TempTime));
  Buffer_Send[47] := StrToInt(FormatDateTime('hh', TempTime));
  Buffer_Send[48] := StrToInt(FormatDateTime('nn', TempTime));
  Buffer_Send[49] := StrToInt(FormatDateTime('ss', TempTime));
  IdUDPServer_Lv.SendBuffer('10.10.10.2', 1025, Buffer_Send);
  IdUDPServer_Hv.SendBuffer('10.10.10.3', 1025, Buffer_Send);
end;

procedure TForm_UI.UDPStopSimulate;
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
  Buffer_Send[40] := 2;
  Buffer_Send[41] := 1;
  Buffer_Send[42] := 35;
  Buffer_Send[43] := 0;
  Buffer_Send[44] := StrToInt(FormatDateTime('yy', TempTime));
  Buffer_Send[45] := StrToInt(FormatDateTime('mm', TempTime));
  Buffer_Send[46] := StrToInt(FormatDateTime('dd', TempTime));
  Buffer_Send[47] := StrToInt(FormatDateTime('hh', TempTime));
  Buffer_Send[48] := StrToInt(FormatDateTime('nn', TempTime));
  Buffer_Send[49] := StrToInt(FormatDateTime('ss', TempTime));
  IdUDPServer_Lv.SendBuffer('10.10.10.2', 1025, Buffer_Send);
  IdUDPServer_Hv.SendBuffer('10.10.10.3', 1025, Buffer_Send);
end;
end.
