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

  sResultDataPara = record              //信息头
    lineName: array [0..99] of Char;    //线路名称
    Version: Byte;                      //软件版本
    reserved: array [0..394] of Byte;   //预留
    inight: Integer;                    //初始杆号
    inidis: Integer;                    //初始公里标，单位m
    Buchang: Integer;                   //采样间隔，单位m   value*10000
    shangxia: Byte;                     //上下行（0=未知 1=上行 2=下行）
    rundir: Byte;                       //正反向（1=正 0=反）
    initzengjian: Byte;                 //里程增减（1=增 0=减）
    DataTime: array [0..11] of Char;    //采集时间 YYMMDDHHMMSS
  end;

  sDataFrame = record                    //数据
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
    mark: Byte;                          //   01代表公里标矫正 02代表锚段或线叉 03代表异常数据
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

  TRecord_OriginalAcying = record
    Acying: array[0..9] of Byte;
  end;

  TRecord_Acying = record
    pluseTime, pluseCounts: Word;
    pluseNumber, pluseStatus: Byte;
  end;

  Record_SaveOriginal = record
    Om_data: JCWJH;
    OHvData: TRecord_OriginalHv;
    OLvData: TRecord_OriginalLv;
    AcyingData: TRecord_OriginalAcying;
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
    LCZSP1_value: Single;                //接触线1水平距离（柔性双线时），mm
    LCZSP2_value: Single;                //接触线2水平距离（柔性双线时），mm
    SPJL_value: Single;                  //锚段或线叉处接触线水平距离，mm
    SPGC_value: Single;                  //锚段或线叉处接触线高差，mm
    DGBHL_value: Single;                 //导高变化率
    DWDGC_value: Single;                 //定位点高差，mm
    ghNumb: Integer;                     //杆号
    myspeed: Single;                     //速度，单位km/h
    mykilo: Double;                      //公里标，单位m
    mark: Byte;                          //   01代表公里标矫正 02代表锚段或线叉 03代表异常数据
    CheckTime: Integer;                  //检测时间，从信息头采集时间开始的时间，单位ms
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
    procedure Action_StartSimulateExecute(Sender: TObject);
    procedure Action_StopSimulateExecute(Sender: TObject);
  private
    { Private declarations }
    errorLogPath, backupFilePath: String;   //各个文件路径
    LineName, TCPIP, HvUDPIP, HvUDPPort, LvUDPIP, LvUDPPort, AcyingUDPIP, AcyingUDPPort: string;
    IsDebug: Byte;

    FGlobalpara: TGlobalpara;

    FileStream_Original, FileStream_Result : TFileStream;

    procedure InitFolder;
    function JCWSetIP(tempTCPIP: string): Integer;
    function YEGConnect(tempTCPIP: string): Integer;
    procedure YEGDisconnect;
    procedure LoadOriginalData(TempLoadOriginalPath: string);
    procedure SaveResultHead(tempPath, tempLineName: string; initDis: Double; shangxia, rundir: string; initzengjian: Byte);
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

    pSaveThread, pProcessThread, pDrawThread: DWORD;   //各个线程
    startMs, nowMs: DWORD;
    startTime: string;
    configurationFilePath, TempOrignalDataPath, TempResultDataPath, savedOriginalDataPath, savedResultDataPath: string;
    GSpeed: Double;
    GKilometer: Single;

//    CS: TRTLCriticalSection;

    tempData_2D: TData_2D;
    tempData_Hv: TData_Hv;
    tempData_Lv: TData_Lv;

    //drawCounts 一次性绘图的点数
    //calCounts 计算均值、最大值、最小值、均方根值的点数多少
    //calingCounts 正在计算的点数多少，如果超了就要滑动，目前和399有关
    calCounts, drawCounts, calingCounts, paintCounts: Word;
//    counts: Word;

    IsRun, IsSave, IsPlayback, IsFirstCalibrate, IsCalibrating, IsFirstCal, IsGJD, IsJCDL: Boolean;

    Data2DCache, HvUDPCache, LvUDPCache, AcyingCache, DrawCache, OriginalCache, ResultCache: TsfQueue;
    drawThreshold, poleCounts: Byte;   //绘图点数和支柱计算高差计数
    noPlusCounts, calHCounts, calMaoCounts: Word;   //无脉冲的数据计数和检测到柱和锚段的计数
    temp_X, temp_Y: array[0..3] of Single;   //2D错误值取前一个值数组
    time_Electricity: Single;   //电流大于标准值百分之30开始时间
    time_CalSpeed: Single;

    DrawData: array [0..25, 0..4999] of Single;   //绘图数据数组

    calibrate_Force, calibrate_Electricity, calibrate_Power1, calibrate_Power2, calibrate_Power3, calibrate_Power4, calibrate_ACC1, calibrate_ACC2, calibrate_ACC3, calibrate_ACC4, calibrate_ACC5, calibrate_ACC6: Single;
    YL1, YL2, YL3, YL4, YD1, YD2, YD3, YD4, YD5, YD6, JCL, Calib_DY: Single;
    array_CalForce: array of Single;

    //滤波器所要的vector数组
    vector_X1, vector_Y1, vector_X2, vector_Y2, vector_X3, vector_Y3, vector_X4, vector_Y4: Vector;
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

    //平滑滤波器
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
    procedure StartSaveOriginalData;
    procedure SaveOriginalData(TempData: Record_SaveOriginal);
    procedure StopSaveOriginalData;
    procedure StartSaveResultData;
    procedure SaveResultData(TempData: sDataFrame);
    procedure StopSaveResultData;
    function AToV(kind_V: Byte; temp_A: Word): Single;
    function CalJCL(tempV: Single): Single;
    function CalYD(tempV, tempM: Single): Single;
    function CalDL(tempV: Single): Single;
    function CalMean(tempArray: array of Single): Single;
    function CalMax(tempArray: array of Single): Single;
    function CalMin(tempArray: array of Single): Single;
    function Calstd(tempArray: array of Single): Single;
    function CalAve(tempArray: array of Single): Single;
    procedure UDPStartSimulate;
    procedure UDPStopSimulate;
    function DrawLine: Integer;
  end;

var
  Form_UI: TForm_UI;

  const
    ESV = 5.0;   //电流标准值
    Distance_Pluse = 13;   //一个脉冲距离13mm
    Number_Draw = 5000;   //绘图的点数
    Number_Cal = 200;     //一次性计算的点数

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

    Sleep(1);
  end;
end;

function DrawThread(p: Pointer): Integer; stdcall;
var
  TempResultData: ^sDataFrame;
  TempRData: sDataFrame;
  I: Word;
  tmp0ChartValues, tmp1ChartValues, tmp2ChartValues, tmp3ChartValues, tmp4ChartValues, tmp5ChartValues, tmp6ChartValues, tmp7ChartValues, tmp8ChartValues, tmp9ChartValues, tmp10ChartValues: TChartValues;
begin
  while True do
  begin
    if Form_UI.DrawCache.count > Form_UI.drawThreshold then
    begin
      if Form_UI.paintCounts + Form_UI.drawThreshold < Number_Draw + 1 then
      begin
        for I := 0 to Form_UI.drawThreshold - 1 do
        begin
          TempResultData := Form_UI.DrawCache.Pop;
          CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
          Dispose(TempResultData);

          Form_UI.DrawData[0][I + Form_UI.paintCounts] := TempRData.LCZ11_value;
          Form_UI.DrawData[1][I + Form_UI.paintCounts] := TempRData.LCZ12_value;
          Form_UI.DrawData[2][I + Form_UI.paintCounts] := TempRData.LCZSP1_value;
          Form_UI.DrawData[3][I + Form_UI.paintCounts] := TempRData.LCZ21_value;
          Form_UI.DrawData[4][I + Form_UI.paintCounts] := TempRData.LCZ22_value;
          Form_UI.DrawData[5][I + Form_UI.paintCounts] := TempRData.LCZSP2_value;
          Form_UI.DrawData[6][I + Form_UI.paintCounts] := TempRData.DGZ11_value;
          Form_UI.DrawData[7][I + Form_UI.paintCounts] := TempRData.DGZ12_value;
          Form_UI.DrawData[8][I + Form_UI.paintCounts] := TempRData.DGZ21_value;
          Form_UI.DrawData[9][I + Form_UI.paintCounts] := TempRData.DGZ22_value;
          Form_UI.DrawData[10][I + Form_UI.paintCounts] := TempRData.SPJL_value;
          Form_UI.DrawData[11][I + Form_UI.paintCounts] := TempRData.SPGC_value;
          Form_UI.DrawData[12][I + Form_UI.paintCounts] := TempRData.DGBHL_value;
          Form_UI.DrawData[13][I + Form_UI.paintCounts] := TempRData.DWDGC_value;
          Form_UI.DrawData[14][I + Form_UI.paintCounts] := TempRData.JCL_value;
          Form_UI.DrawData[15][I + Form_UI.paintCounts] := TempRData.JCL_mean;
          Form_UI.DrawData[16][I + Form_UI.paintCounts] := TempRData.JCL_max;
          Form_UI.DrawData[17][I + Form_UI.paintCounts] := TempRData.JCL_min;
          Form_UI.DrawData[18][I + Form_UI.paintCounts] := TempRData.JCL_std;
          Form_UI.DrawData[19][I + Form_UI.paintCounts] := TempRData.YD1_value;
          Form_UI.DrawData[20][I + Form_UI.paintCounts] := TempRData.YD2_value;
          Form_UI.DrawData[21][I + Form_UI.paintCounts] := TempRData.DL_value;
          Form_UI.DrawData[22][I + Form_UI.paintCounts] := TempRData.RH_value;
          Form_UI.DrawData[23][I + Form_UI.paintCounts] := TempRData.RH_time;
          Form_UI.DrawData[24][I + Form_UI.paintCounts] := TempRData.RH_numb;
          Form_UI.DrawData[25][I + Form_UI.paintCounts] := TempRData.mykilo;
        end;
        Form_UI.paintCounts := Form_UI.paintCounts + Form_UI.drawThreshold;
      end
      else
      begin
        for I := 0 to 9999 - Form_UI.paintCounts - Form_UI.drawThreshold do
        begin
          Form_UI.DrawData[0][I] := Form_UI.DrawData[0][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[1][I] := Form_UI.DrawData[1][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[2][I] := Form_UI.DrawData[2][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[3][I] := Form_UI.DrawData[3][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[4][I] := Form_UI.DrawData[4][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[5][I] := Form_UI.DrawData[5][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[6][I] := Form_UI.DrawData[6][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[7][I] := Form_UI.DrawData[7][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[8][I] := Form_UI.DrawData[8][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[9][I] := Form_UI.DrawData[9][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[10][I] := Form_UI.DrawData[10][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[11][I] := Form_UI.DrawData[11][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[12][I] := Form_UI.DrawData[12][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[13][I] := Form_UI.DrawData[13][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[14][I] := Form_UI.DrawData[14][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[15][I] := Form_UI.DrawData[15][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[16][I] := Form_UI.DrawData[16][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[17][I] := Form_UI.DrawData[17][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[18][I] := Form_UI.DrawData[18][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[19][I] := Form_UI.DrawData[19][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[20][I] := Form_UI.DrawData[20][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[21][I] := Form_UI.DrawData[21][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[22][I] := Form_UI.DrawData[22][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[23][I] := Form_UI.DrawData[23][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[24][I] := Form_UI.DrawData[24][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
          Form_UI.DrawData[25][I] := Form_UI.DrawData[25][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        end;

        for I := Number_Draw - 1 - Form_UI.drawThreshold to Number_Draw - 1 do
        begin
          TempResultData := Form_UI.DrawCache.Pop;
          CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
          Dispose(TempResultData);

          Form_UI.DrawData[0][I] := TempRData.LCZ11_value;
          Form_UI.DrawData[1][I] := TempRData.LCZ12_value;
          Form_UI.DrawData[2][I] := TempRData.LCZSP1_value;
          Form_UI.DrawData[3][I] := TempRData.LCZ21_value;
          Form_UI.DrawData[4][I] := TempRData.LCZ22_value;
          Form_UI.DrawData[5][I] := TempRData.LCZSP2_value;
          Form_UI.DrawData[6][I] := TempRData.DGZ11_value;
          Form_UI.DrawData[7][I] := TempRData.DGZ12_value;
          Form_UI.DrawData[8][I] := TempRData.DGZ21_value;
          Form_UI.DrawData[9][I] := TempRData.DGZ22_value;
          Form_UI.DrawData[10][I] := TempRData.SPJL_value;
          Form_UI.DrawData[11][I] := TempRData.SPGC_value;
          Form_UI.DrawData[12][I] := TempRData.DGBHL_value;
          Form_UI.DrawData[13][I] := TempRData.DWDGC_value;
          Form_UI.DrawData[14][I] := TempRData.JCL_value;
          Form_UI.DrawData[15][I] := TempRData.JCL_mean;
          Form_UI.DrawData[16][I] := TempRData.JCL_max;
          Form_UI.DrawData[17][I] := TempRData.JCL_min;
          Form_UI.DrawData[18][I] := TempRData.JCL_std;
          Form_UI.DrawData[19][I] := TempRData.YD1_value;
          Form_UI.DrawData[20][I] := TempRData.YD2_value;
          Form_UI.DrawData[21][I] := TempRData.DL_value;
          Form_UI.DrawData[22][I] := TempRData.RH_value;
          Form_UI.DrawData[23][I] := TempRData.RH_time;
          Form_UI.DrawData[24][I] := TempRData.RH_numb;
          Form_UI.DrawData[25][I] := TempRData.mykilo;
        end;
      end;

      if Form_UI.paintCounts > Number_Draw then Form_UI.paintCounts := Number_Draw;

      SetLength(tmp0ChartValues, Form_UI.paintCounts);
      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp0ChartValues[I] := Form_UI.DrawData[25][I];
      end;

      if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Conductor then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);
        SetLength(tmp3ChartValues, Form_UI.paintCounts);
        SetLength(tmp4ChartValues, Form_UI.paintCounts);
        SetLength(tmp5ChartValues, Form_UI.paintCounts);
        SetLength(tmp6ChartValues, Form_UI.paintCounts);
        SetLength(tmp7ChartValues, Form_UI.paintCounts);
        SetLength(tmp8ChartValues, Form_UI.paintCounts);
        SetLength(tmp9ChartValues, Form_UI.paintCounts);
        SetLength(tmp10ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[0][I];
          tmp2ChartValues[I] := Form_UI.DrawData[1][I];
          tmp3ChartValues[I] := Form_UI.DrawData[2][I];
          tmp4ChartValues[I] := Form_UI.DrawData[3][I];
          tmp5ChartValues[I] := Form_UI.DrawData[4][I];
          tmp6ChartValues[I] := Form_UI.DrawData[5][I];
          tmp7ChartValues[I] := Form_UI.DrawData[6][I];
          tmp8ChartValues[I] := Form_UI.DrawData[7][I];
          tmp9ChartValues[I] := Form_UI.DrawData[8][I];
          tmp10ChartValues[I] := Form_UI.DrawData[9][I];
        end;

        Form_UI.Series_Line1Width.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line1Width.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line1Width.XValues.Modified := True;
        Form_UI.Series_Line1Width.YValues.Value := tmp1ChartValues;
        Form_UI.Series_Line1Width.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line1Width.YValues.Modified := True;

        Form_UI.Series_Line2Width.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line2Width.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line2Width.XValues.Modified := True;
        Form_UI.Series_Line2Width.YValues.Value := tmp2ChartValues;
        Form_UI.Series_Line2Width.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line2Width.YValues.Modified := True;

        Form_UI.Series_LineDistance1.XValues.Value := tmp0ChartValues;
        Form_UI.Series_LineDistance1.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_LineDistance1.XValues.Modified := True;
        Form_UI.Series_LineDistance1.YValues.Value := tmp3ChartValues;
        Form_UI.Series_LineDistance1.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_LineDistance1.YValues.Modified := True;

        Form_UI.Series_Line3Width.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line3Width.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line3Width.XValues.Modified := True;
        Form_UI.Series_Line3Width.YValues.Value := tmp4ChartValues;
        Form_UI.Series_Line3Width.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line3Width.YValues.Modified := True;

        Form_UI.Series_Line4Width.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line4Width.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line4Width.XValues.Modified := True;
        Form_UI.Series_Line4Width.YValues.Value := tmp5ChartValues;
        Form_UI.Series_Line4Width.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line4Width.YValues.Modified := True;

        Form_UI.Series_LineDistance2.XValues.Value := tmp0ChartValues;
        Form_UI.Series_LineDistance2.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_LineDistance2.XValues.Modified := True;
        Form_UI.Series_LineDistance2.YValues.Value := tmp6ChartValues;
        Form_UI.Series_LineDistance2.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_LineDistance2.YValues.Modified := True;

        Form_UI.Series_Line1Height.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line1Height.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line1Height.XValues.Modified := True;
        Form_UI.Series_Line1Height.YValues.Value := tmp7ChartValues;
        Form_UI.Series_Line1Height.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line1Height.YValues.Modified := True;

        Form_UI.Series_Line2Height.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line2Height.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line2Height.XValues.Modified := True;
        Form_UI.Series_Line2Height.YValues.Value := tmp8ChartValues;
        Form_UI.Series_Line2Height.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line2Height.YValues.Modified := True;

        Form_UI.Series_Line3Height.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line3Height.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line3Height.XValues.Modified := True;
        Form_UI.Series_Line3Height.YValues.Value := tmp9ChartValues;
        Form_UI.Series_Line3Height.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line3Height.YValues.Modified := True;

        Form_UI.Series_Line4Height.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Line4Height.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line4Height.XValues.Modified := True;
        Form_UI.Series_Line4Height.YValues.Value := tmp10ChartValues;
        Form_UI.Series_Line4Height.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Line4Height.YValues.Modified := True;

        Form_UI.Series_Line1Width.Repaint;
  //        Form_UI.Series_Line2Width.Repaint;
  //        Form_UI.Series_LineDistance1.Repaint;
  //        Form_UI.Series_Line3Width.Repaint;
  //        Form_UI.Series_Line4Width.Repaint;
  //        Form_UI.Series_LineDistance2.Repaint;
  //        Form_UI.Series_Line1Height.Repaint;
  //        Form_UI.Series_Line2Height.Repaint;
  //        Form_UI.Series_Line3Height.Repaint;
  //        Form_UI.Series_Line4Height.Repaint;
      end
      else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Parameter then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);
        SetLength(tmp3ChartValues, Form_UI.paintCounts);
        SetLength(tmp4ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[10][I];
          tmp2ChartValues[I] := Form_UI.DrawData[11][I];
          tmp3ChartValues[I] := Form_UI.DrawData[12][I];
          tmp4ChartValues[I] := Form_UI.DrawData[13][I];
        end;

        Form_UI.PointSeries_Width.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_Width.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Width.XValues.Modified := True;
        Form_UI.PointSeries_Width.YValues.Value := tmp1ChartValues;
        Form_UI.PointSeries_Width.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Width.YValues.Modified := True;

        Form_UI.PointSeries_Height.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_Height.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Height.XValues.Modified := True;
        Form_UI.PointSeries_Height.YValues.Value := tmp2ChartValues;
        Form_UI.PointSeries_Height.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Height.YValues.Modified := True;

        Form_UI.PointSeries_Changerate.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_Changerate.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Changerate.XValues.Modified := True;
        Form_UI.PointSeries_Changerate.YValues.Value := tmp3ChartValues;
        Form_UI.PointSeries_Changerate.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Changerate.YValues.Modified := True;

        Form_UI.PointSeries_Elevation.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_Elevation.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Elevation.XValues.Modified := True;
        Form_UI.PointSeries_Elevation.YValues.Value := tmp4ChartValues;
        Form_UI.PointSeries_Elevation.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_Elevation.YValues.Modified := True;

        Form_UI.PointSeries_Width.Repaint;
  //        Form_UI.PointSeries_Height.Repaint;
  //        Form_UI.PointSeries_Changerate.Repaint;
  //        Form_UI.PointSeries_Elevation.Repaint;
      end
      else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_ContactForce then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);
        SetLength(tmp3ChartValues, Form_UI.paintCounts);
        SetLength(tmp4ChartValues, Form_UI.paintCounts);
        SetLength(tmp5ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[14][I];
          tmp2ChartValues[I] := Form_UI.DrawData[15][I];
          tmp3ChartValues[I] := Form_UI.DrawData[16][I];
          tmp4ChartValues[I] := Form_UI.DrawData[17][I];
          tmp5ChartValues[I] := Form_UI.DrawData[18][I];
        end;

        Form_UI.Series_Force.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Force.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Force.XValues.Modified := True;
        Form_UI.Series_Force.YValues.Value := tmp1ChartValues;
        Form_UI.Series_Force.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Force.YValues.Modified := True;

        Form_UI.Series_ForceAve.XValues.Value := tmp0ChartValues;
        Form_UI.Series_ForceAve.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceAve.XValues.Modified := True;
        Form_UI.Series_ForceAve.YValues.Value := tmp2ChartValues;
        Form_UI.Series_ForceAve.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceAve.YValues.Modified := True;

        Form_UI.Series_ForceMax.XValues.Value := tmp0ChartValues;
        Form_UI.Series_ForceMax.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceMax.XValues.Modified := True;
        Form_UI.Series_ForceMax.YValues.Value := tmp3ChartValues;
        Form_UI.Series_ForceMax.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceMax.YValues.Modified := True;

        Form_UI.Series_ForceMin.XValues.Value := tmp0ChartValues;
        Form_UI.Series_ForceMin.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceMin.XValues.Modified := True;
        Form_UI.Series_ForceMin.YValues.Value := tmp4ChartValues;
        Form_UI.Series_ForceMin.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceMin.YValues.Modified := True;

        Form_UI.Series_ForceVariance.XValues.Value := tmp0ChartValues;
        Form_UI.Series_ForceVariance.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceVariance.XValues.Modified := True;
        Form_UI.Series_ForceVariance.YValues.Value := tmp5ChartValues;
        Form_UI.Series_ForceVariance.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ForceVariance.YValues.Modified := True;

        Form_UI.Series_Force.Repaint;
  //        Form_UI.Series_ForceAve.Repaint;
  //        Form_UI.Series_ForceMax.Repaint;
  //        Form_UI.Series_ForceMin.Repaint;
  //        Form_UI.Series_ForceVariance.Repaint;
      end
      else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Hardspot then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[19][I];
          tmp2ChartValues[I] := Form_UI.DrawData[20][I];
        end;

        Form_UI.Series_Vacc1.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Vacc1.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Vacc1.XValues.Modified := True;
        Form_UI.Series_Vacc1.YValues.Value := tmp1ChartValues;
        Form_UI.Series_Vacc1.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Vacc1.YValues.Modified := True;

        Form_UI.Series_Vacc2.XValues.Value := tmp0ChartValues;
        Form_UI.Series_Vacc2.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Vacc2.XValues.Modified := True;
        Form_UI.Series_Vacc2.YValues.Value := tmp2ChartValues;
        Form_UI.Series_Vacc2.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_Vacc2.YValues.Modified := True;

        Form_UI.Series_Vacc1.Repaint;
  //        Form_UI.Series_Vacc2.Repaint;
      end
      else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Electric then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[21][I];
          tmp2ChartValues[I] := Form_UI.DrawData[22][I];
        end;

        Form_UI.Series_ElectricValue.XValues.Value := tmp0ChartValues;
        Form_UI.Series_ElectricValue.XValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ElectricValue.XValues.Modified := True;
        Form_UI.Series_ElectricValue.YValues.Value := tmp1ChartValues;
        Form_UI.Series_ElectricValue.YValues.Count := Form_UI.paintCounts;
        Form_UI.Series_ElectricValue.YValues.Modified := True;

        Form_UI.PointSeries_ElectricTime.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_ElectricTime.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_ElectricTime.XValues.Modified := True;
        Form_UI.PointSeries_ElectricTime.YValues.Value := tmp2ChartValues;
        Form_UI.PointSeries_ElectricTime.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_ElectricTime.YValues.Modified := True;

        Form_UI.Series_ElectricValue.Repaint;
  //        Form_UI.PointSeries_ElectricTime.Repaint;
      end
      else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Acying then
      begin
        SetLength(tmp1ChartValues, Form_UI.paintCounts);
        SetLength(tmp2ChartValues, Form_UI.paintCounts);

        for I := 0 to Form_UI.paintCounts - 1 do
        begin
          tmp1ChartValues[I] := Form_UI.DrawData[23][I];
          tmp2ChartValues[I] := Form_UI.DrawData[24][I];
        end;

        Form_UI.PointSeries_AcyingTime.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_AcyingTime.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_AcyingTime.XValues.Modified := True;
        Form_UI.PointSeries_AcyingTime.YValues.Value := tmp1ChartValues;
        Form_UI.PointSeries_AcyingTime.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_AcyingTime.YValues.Modified := True;

        Form_UI.PointSeries_AcyingCount.XValues.Value := tmp0ChartValues;
        Form_UI.PointSeries_AcyingCount.XValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_AcyingCount.XValues.Modified := True;
        Form_UI.PointSeries_AcyingCount.YValues.Value := tmp2ChartValues;
        Form_UI.PointSeries_AcyingCount.YValues.Count := Form_UI.paintCounts;
        Form_UI.PointSeries_AcyingCount.YValues.Modified := True;

        Form_UI.PointSeries_AcyingTime.Repaint;
  //        Form_UI.PointSeries_AcyingCount.Repaint;
      end;
      Sleep(100);
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
  I, J, tempCounts: Word;
//  plusCounts: Byte;
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

  startRecordKm, endRecordKm, startKm, tempKm, startPlus, tempPlus, startAcyingCount, startAcyingTime, tmpSpeed, tmpPluse: Double;   //最开始的脉冲数
  array_DataDeal: array [0..199] of Record_SaveOriginal;    //最原始数据数组
  array_DataDealing: array[0..199] of TData_Dealing;   //处理过程中的数组，包括滤波、计算等
  array_ResultDeal: array[0..199] of sDataFrame;   //计算后的结果数据
  array_PlusResult: array[0..398] of sDataFrame;
  temp_arrayYD1, temp_arrayYD2, temp_arrayJCL, temp_arrayDL: array of Single;   //一个脉冲内的计算数据
  temp_SPJL_value, temp_SPGC_value, temp_DGBHL_value, temp_DWDGC_value: array of Single;   //定位点改变的取均值的数组
  temp_MaxH, temp_MinH: Single;   //定位点高差的最大值和最小值
  temp_arraycalibYL1, temp_arraycalibYL2, temp_arraycalibYL3, temp_arraycalibYL4, temp_arraycalibYD1, temp_arraycalibYD2, temp_arraycalibYD4, temp_arraycalibYD5: array of Single;

  //额外加俩标定数组
  array_CalibResultDeal: array[0..199] of TRecord_Hv;
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

        //原始数据存储
        if Form_UI.IsSave then
        begin
          New(TempDataSO);
          CopyMemory(TempDataSO, @Array_DataDeal[I], SizeOf(Record_SaveOriginal));
          Form_UI.OriginalCache.Push(TempDataSO);
        end;
      end;

      //因为燃弧传感器采样频率由500设置成了200，所以地下的代码暂时已经改到了上面，底下的不删，作为备份
//      //燃弧数据从500个点抽200个点赋值
//      J := 0;
//      tempCounts := 0;
//      for I := 0 to 499 do
//      begin
//        TempDataAcying := Form_UI.AcyingCache.Pop;
//        CopyMemory(@TempDataOAcying, TempDataAcying, SizeOf(TRecord_OriginalAcying));
//        Dispose(TempDataAcying);
//
//        if I = J + 1 then
//        begin
//          array_DataDeal[tempCounts].AcyingData := TempDataOAcying;
//          tempCounts := tempCounts + 1;
//        end;
//        if I = J + 4 then
//        begin
//          array_DataDeal[tempCounts].AcyingData := TempDataOAcying;
//          tempCounts := tempCounts + 1;
//          J := J + 5;
//        end;
//      end;

      //数据处理
      for I := 0 to Number_Cal - 1 do
      begin
        //数据处理数组赋值（初步）
        array_DataDealing[I].TempJCWJH := array_DataDeal[I].Om_data;

        //2D数据错误值取前一个值
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

        //燃弧结构体赋值
        TempWord[0] := array_DataDeal[I].AcyingData.Acying[3];
        TempWord[1] := array_DataDeal[I].AcyingData.Acying[4];
        array_DataDealing[I].TempAcying.pluseTime := Word(TempWord);

        TempWord[0] := array_DataDeal[I].AcyingData.Acying[5];
        TempWord[1] := array_DataDeal[I].AcyingData.Acying[6];
        array_DataDealing[I].TempAcying.pluseCounts := Word(TempWord);

        array_DataDealing[I].TempAcying.pluseNumber := array_DataDeal[I].AcyingData.Acying[7];
        array_DataDealing[I].TempAcying.pluseStatus := array_DataDeal[I].AcyingData.Acying[8];
      end;

      //滤波前vector赋值
      for I := 0 to Number_Cal - 1 do
      begin
        Form_UI.vector_X1[I] := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.x;
        Form_UI.vector_Y1[I] := array_DataDealing[I].TempJCWJH.jcx[0].pntLinePos.y;
        Form_UI.vector_X2[I] := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.x;
        Form_UI.vector_Y2[I] := array_DataDealing[I].TempJCWJH.jcx[1].pntLinePos.y;
        Form_UI.vector_X3[I] := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.x;
        Form_UI.vector_Y3[I] := array_DataDealing[I].TempJCWJH.jcx[2].pntLinePos.y;
        Form_UI.vector_X4[I] := array_DataDealing[I].TempJCWJH.jcx[3].pntLinePos.x;
        Form_UI.vector_Y4[I] := array_DataDealing[I].TempJCWJH.jcx[3].pntLinePos.y;

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
      Form_UI.FirFilter_2DAverageX1.filter(Form_UI.vector_X1, Form_UI.vector_X1);
      Form_UI.FirFilter_2DAverageY1.filter(Form_UI.vector_Y1, Form_UI.vector_Y1);
      Form_UI.FirFilter_2DAverageX2.filter(Form_UI.vector_X2, Form_UI.vector_X2);
      Form_UI.FirFilter_2DAverageY2.filter(Form_UI.vector_Y2, Form_UI.vector_Y2);
      Form_UI.FirFilter_2DAverageX3.filter(Form_UI.vector_X3, Form_UI.vector_X3);
      Form_UI.FirFilter_2DAverageY3.filter(Form_UI.vector_Y3, Form_UI.vector_Y3);
      Form_UI.FirFilter_2DAverageX4.filter(Form_UI.vector_X4, Form_UI.vector_X4);
      Form_UI.FirFilter_2DAverageY4.filter(Form_UI.vector_Y4, Form_UI.vector_Y4);

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
            array_ResultDeal[I].LCZ11_value := Form_UI.vector_X1[I];
            array_ResultDeal[I].LCZ12_value := 0;
            array_ResultDeal[I].LCZSP1_value := 0;
            array_ResultDeal[I].LCZ21_value := 0;
            array_ResultDeal[I].LCZ22_value := 0;
            array_ResultDeal[I].LCZSP2_value := 0;
            array_ResultDeal[I].DGZ11_value := Form_UI.vector_Y1[I];
            array_ResultDeal[I].DGZ12_value := 0;
            array_ResultDeal[I].DGZ21_value := 0;
            array_ResultDeal[I].DGZ22_value := 0;
          end;
          2:
          begin
            array_ResultDeal[I].LCZ11_value := Form_UI.vector_X1[I];
            array_ResultDeal[I].LCZ12_value := Form_UI.vector_X2[I];
            array_ResultDeal[I].LCZSP1_value := Abs(Form_UI.vector_X2[I] - Form_UI.vector_X1[I]);
            array_ResultDeal[I].LCZ21_value := 0;
            array_ResultDeal[I].LCZ22_value := 0;
            array_ResultDeal[I].LCZSP2_value := 0;
            array_ResultDeal[I].DGZ11_value := Form_UI.vector_Y1[I];
            array_ResultDeal[I].DGZ12_value := Form_UI.vector_Y2[I];
            array_ResultDeal[I].DGZ21_value := 0;
            array_ResultDeal[I].DGZ22_value := 0;
          end;
          3:
          begin
            array_ResultDeal[I].LCZ11_value := Form_UI.vector_X1[I];
            array_ResultDeal[I].LCZ12_value := Form_UI.vector_X2[I];
            array_ResultDeal[I].LCZSP1_value := Abs(Form_UI.vector_X2[I] - Form_UI.vector_X1[I]);
            array_ResultDeal[I].LCZ21_value := Form_UI.vector_X3[I];
            array_ResultDeal[I].LCZ22_value := 0;
            array_ResultDeal[I].LCZSP2_value := 0;
            array_ResultDeal[I].DGZ11_value := Form_UI.vector_Y1[I];
            array_ResultDeal[I].DGZ12_value := Form_UI.vector_Y2[I];
            array_ResultDeal[I].DGZ21_value := Form_UI.vector_Y3[I];
            array_ResultDeal[I].DGZ22_value := 0;
          end;
          4:
          begin
            array_ResultDeal[I].LCZ11_value := Form_UI.vector_X1[I];
            array_ResultDeal[I].LCZ12_value := Form_UI.vector_X2[I];
            array_ResultDeal[I].LCZSP1_value := Abs(Form_UI.vector_X2[I] - Form_UI.vector_X1[I]);
            array_ResultDeal[I].LCZ21_value := Form_UI.vector_X3[I];
            array_ResultDeal[I].LCZ22_value := Form_UI.vector_X4[I];
            array_ResultDeal[I].LCZSP2_value := Abs(Form_UI.vector_X4[I] - Form_UI.vector_X3[I]);
            array_ResultDeal[I].DGZ11_value := Form_UI.vector_Y1[I];
            array_ResultDeal[I].DGZ12_value := Form_UI.vector_Y2[I];
            array_ResultDeal[I].DGZ21_value := Form_UI.vector_Y3[I];
            array_ResultDeal[I].DGZ22_value := Form_UI.vector_Y4[I];
          end;
        end;
        array_ResultDeal[I].SPJL_value := 0;
        array_ResultDeal[I].SPGC_value := 0;
        array_ResultDeal[I].DGBHL_value := 0;
        array_ResultDeal[I].DWDGC_value := 0;

        //硬点赋值
        array_ResultDeal[I].YD1_value := Form_UI.CalYD(Form_UI.vector_HardSpot3[I], 1);   //第二个参数是质量
        array_ResultDeal[I].YD2_value := Form_UI.CalYD(Form_UI.vector_HardSpot6[I], 1);
        array_CalibResultDeal[I].HardSpot1 := Form_UI.CalYD(Form_UI.vector_HardSpot1[I], 1);
        array_CalibResultDeal[I].HardSpot2 := Form_UI.CalYD(Form_UI.vector_HardSpot2[I], 1);
        array_CalibResultDeal[I].HardSpot3 := Form_UI.CalYD(Form_UI.vector_HardSpot3[I], 1);
        array_CalibResultDeal[I].HardSpot4 := Form_UI.CalYD(Form_UI.vector_HardSpot4[I], 1);
        array_CalibResultDeal[I].HardSpot5 := Form_UI.CalYD(Form_UI.vector_HardSpot5[I], 1);
        array_CalibResultDeal[I].HardSpot6 := Form_UI.CalYD(Form_UI.vector_HardSpot6[I], 1);

        //接触力赋值
        array_CalibResultDeal[I].Power1 := Form_UI.CalJCL(Form_UI.vector_Power1[I]);
        array_CalibResultDeal[I].Power2 := Form_UI.CalJCL(Form_UI.vector_Power2[I]);
        array_CalibResultDeal[I].Power3 := Form_UI.CalJCL(Form_UI.vector_Power3[I]);
        array_CalibResultDeal[I].Power4 := Form_UI.CalJCL(Form_UI.vector_Power4[I]);
        array_ResultDeal[I].JCL_value := array_CalibResultDeal[I].Power1 + array_CalibResultDeal[I].Power2 + array_CalibResultDeal[I].Power3 + array_CalibResultDeal[I].Power4 - array_CalibResultDeal[I].HardSpot3 - array_CalibResultDeal[I].HardSpot6 - 0;   //0暂时为重力
        array_ResultDeal[I].JCL_mean := 0;
        array_ResultDeal[I].JCL_max := 0;
        array_ResultDeal[I].JCL_min := 0;
        array_ResultDeal[I].JCL_std := 0;

        //电流赋值
        array_ResultDeal[I].DL_value := Form_UI.CalDL(Form_UI.vector_Electricity[I]);
        array_ResultDeal[I].RH_value := 0;

        //燃弧赋值
        array_ResultDeal[I].RH_time := array_DataDealing[I].TempAcying.pluseTime;
        array_ResultDeal[I].RH_numb := array_DataDealing[I].TempAcying.pluseCounts;

        for J := 0 to 6 do array_ResultDeal[I].reserved[J] := 0;

        array_ResultDeal[I].FrameID := 0;
        array_ResultDeal[I].ghNumb := 0;
        array_ResultDeal[I].myspeed := 0;
        array_ResultDeal[I].mykilo := array_DataDealing[I].TempLv.encoder;

        if array_DataDealing[I].TempJCWJH.posi = JCXP_POLE then
        begin
          array_ResultDeal[I].mark := 4;
        end
        else if array_DataDealing[I].TempJCWJH.posi = JCXP_MAO then
        begin
          array_ResultDeal[I].mark := 2
        end
        else array_ResultDeal[I].mark := 0;

        array_ResultDeal[I].CheckTime := GetTickCount - Form_UI.startMs;
      end;

      //初步按照脉冲计算（这小段代码是第一次开始计算所遇到的情况）
      if Form_UI.IsFirstCal then
      begin
        tempPlus := array_ResultDeal[0].mykilo;
        startPlus := array_ResultDeal[0].mykilo;
        startKm := Form_LineSetting.kilometer;
        startRecordKm := Form_LineSetting.kilometer;
        startAcyingTime := array_ResultDeal[0].RH_time;
        startAcyingCount := array_ResultDeal[0].RH_numb;

        if array_ResultDeal[0].mark = 2 then
        begin
          if array_ResultDeal[0].LCZ12_value <> 0 then
          begin
            Form_UI.calHCounts := Form_UI.calHCounts + 1;
            SetLength(temp_SPJL_value, Form_UI.calHCounts);
            SetLength(temp_SPGC_value, Form_UI.calHCounts);
            SetLength(temp_DGBHL_value, Form_UI.calHCounts);
            SetLength(temp_DWDGC_value, Form_UI.calHCounts);
            temp_MaxH := array_ResultDeal[0].DGZ11_value;
            temp_MinH := array_ResultDeal[0].DGZ11_value;
            temp_SPJL_value[Form_UI.calHCounts - 1] := Abs(array_ResultDeal[0].LCZ12_value - array_ResultDeal[0].LCZ11_value);
            temp_SPGC_value[Form_UI.calHCounts - 1] := Abs(array_ResultDeal[0].DGZ12_value - array_ResultDeal[0].DGZ11_value);
            temp_DGBHL_value[Form_UI.calHCounts - 1] := 0;
            temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
          end;
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
          if Form_UI.calingCounts < 398 then
          begin
            array_PlusResult[Form_UI.calingCounts] := array_ResultDeal[I];
            Form_UI.calingCounts := Form_UI.calingCounts + 1;
          end
          else
          begin
            for J := 0 to 397 do array_PlusResult[J] := array_PlusResult[J + 1];
            array_PlusResult[Form_UI.calingCounts - 1] := array_ResultDeal[I];
            if Form_UI.calingCounts < 399 then Form_UI.calingCounts := Form_UI.calingCounts + 1;
          end;

          //速度、公里标赋值
          tempKm := (tempPlus - startPlus) * Distance_Pluse / 1000000 + startKm;
          array_PlusResult[Form_UI.calingCounts - 1].mykilo := tempKm;
          if Form_UI.time_CalSpeed = 0 then
          begin
            array_PlusResult[Form_UI.calingCounts - 1].myspeed := 0;
            Form_UI.time_CalSpeed := GetTickCount;
            tmpPluse := tempPlus;
          end
          else
          begin
            if GetTickCount - Form_UI.time_CalSpeed > 2500 then
            begin
              temp_time := GetTickCount;
              array_PlusResult[Form_UI.calingCounts - 1].myspeed := Abs((tempPlus - tmpPluse) * Distance_Pluse / 1000 / 1000) / ((temp_time - Form_UI.time_CalSpeed) / 1000 / 60 / 60);
              Form_UI.GSpeed := array_PlusResult[Form_UI.calingCounts - 1].myspeed;
              tmpSpeed := array_PlusResult[Form_UI.calingCounts - 1].myspeed;
              Form_UI.time_CalSpeed := temp_time;
              tmpPluse := tempPlus;
            end
            else
            begin
              if tmpSpeed <> 0 then array_PlusResult[Form_UI.calingCounts - 1].myspeed := tmpSpeed;
            end;
          end;
          startPlus := tempPlus;
          startKm := tempKm;
          Form_UI.GKilometer := startKm;

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
              Form_UI.calMaoCounts := 0;
              SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
              SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
            end;
          end;

          //为高差计算做准备
          if temp_MaxH < array_ResultDeal[I].DGZ11_value then temp_MaxH := array_ResultDeal[I].DGZ11_value;
          if temp_MinH > array_ResultDeal[I].DGZ11_value then temp_MinH := array_ResultDeal[I].DGZ11_value;

          //区段计算
          if array_ResultDeal[I].mark = 4 then
          begin
            Form_UI.IsGJD := True;
            Form_UI.poleCounts := 0;
            endRecordKm := tempKm;
            if Abs(endRecordKm - startRecordKm) > 5 then
            begin
              Form_UI.calHCounts := Form_UI.calHCounts + 1;
              SetLength(temp_DGBHL_value, Form_UI.calHCounts);
              SetLength(temp_DWDGC_value, Form_UI.calHCounts);
              temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
              temp_DGBHL_value[Form_UI.calHCounts - 1] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000;
              array_PlusResult[Form_UI.calingCounts - 1].DWDGC_value := Form_UI.CalAve(temp_DWDGC_value);
              array_PlusResult[Form_UI.calingCounts - 1].DGBHL_value := Form_UI.CalAve(temp_DGBHL_value);
              Form_UI.calHCounts := 0;
              SetLength(temp_DGBHL_value, Form_UI.calHCounts);
              SetLength(temp_DWDGC_value, Form_UI.calHCounts);
            end;
          end
          else
          begin
            if Form_UI.IsGJD then
            begin
              if Form_UI.poleCounts < 100 then
              begin
                Form_UI.poleCounts := Form_UI.poleCounts + 1;
              end
              else
              begin
                Form_UI.IsGJD := False;
                Form_UI.poleCounts := 0;
                temp_MaxH := 0;
                temp_MinH := 0;
                startRecordKm := tempKm;
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
          array_PlusResult[Form_UI.calingCounts - 1].JCL_value := Form_UI.CalMean(temp_arrayJCL) - Form_UI.calibrate_Force;
          array_PlusResult[Form_UI.calingCounts - 1].DL_value := Form_UI.CalMean(temp_arrayDL) - Form_UI.calibrate_Electricity;
          array_PlusResult[Form_UI.calingCounts - 1].YD1_value := Form_UI.CalMean(temp_arrayYD1) - Form_UI.calibrate_ACC3;
          array_PlusResult[Form_UI.calingCounts - 1].YD2_value := Form_UI.CalMean(temp_arrayYD2) - Form_UI.calibrate_ACC6;
          if array_PlusResult[Form_UI.calingCounts - 1].DL_value > ESV * 0.3 then
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

          //燃弧赋值
          if array_PlusResult[Form_UI.calingCounts - 1].RH_numb <> startAcyingCount then startAcyingCount := array_PlusResult[Form_UI.calingCounts - 1].RH_numb
          else
          begin
            array_PlusResult[Form_UI.calingCounts - 1].RH_time := 0;
            array_PlusResult[Form_UI.calingCounts - 1].RH_numb := 0;
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
            if Form_UI.IsCalibrating then
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
              if (Form_UI.YL1 = 0) and  (Form_UI.YL2 = 0) and (Form_UI.YL3 = 0) and (Form_UI.YL4 = 0) and
              (Form_UI.YD1 = 0) and (Form_UI.YD2 = 0) and (Form_UI.YD3 = 0) and (Form_UI.YD4 = 0) and (Form_UI.YD5 = 0) and (Form_UI.YD6 = 0) and
              (Form_UI.Calib_DY = 0) and  (Form_UI.JCL = 0) then
              begin
                Form_UI.Calibrate_Force := Form_UI.JCL - Form_UI.YL1 - Form_UI.YL2 - Form_UI.YL3 - Form_UI.YL4 + Form_UI.YD3 + Form_UI.YD6;
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

                Form_UI.YL1 := 0;
                Form_UI.YL2 := 0;
                Form_UI.YL3 := 0;
                Form_UI.YL4 := 0;
                Form_UI.YD1 := 0;
                Form_UI.YD2 := 0;
                Form_UI.YD3 := 0;
                Form_UI.YD4 := 0;
                Form_UI.YD5 := 0;
                Form_UI.YD6 := 0;
                Form_UI.Calib_DY := 0;
                Form_UI.JCL := 0;

                if FileExists(Form_UI.ConfigurationFilePath) then
                begin
                  IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
                  Inifile.WriteString('标定', 'Force', FloatToStr(Form_UI.Calibrate_Force));
                  Inifile.WriteString('标定', 'Electricity', FloatToStr(Form_UI.Calibrate_Electricity));
                  Inifile.WriteString('标定', 'Power1', FloatToStr(Form_UI.Calibrate_Power1));
                  Inifile.WriteString('标定', 'Power2', FloatToStr(Form_UI.Calibrate_Power2));
                  Inifile.WriteString('标定', 'Power3', FloatToStr(Form_UI.Calibrate_Power3));
                  Inifile.WriteString('标定', 'Power4', FloatToStr(Form_UI.Calibrate_Power4));
                  Inifile.WriteString('标定', 'ACC1', FloatToStr(Form_UI.Calibrate_ACC1));
                  Inifile.WriteString('标定', 'ACC2', FloatToStr(Form_UI.Calibrate_ACC2));
                  Inifile.WriteString('标定', 'ACC3', FloatToStr(Form_UI.Calibrate_ACC3));
                  Inifile.WriteString('标定', 'ACC4', FloatToStr(Form_UI.Calibrate_ACC4));
                  Inifile.WriteString('标定', 'ACC5', FloatToStr(Form_UI.Calibrate_ACC5));
                  Inifile.WriteString('标定', 'ACC6', FloatToStr(Form_UI.Calibrate_ACC6));
                  IniFile.Free;

                  Form_UI.InitSubGroup;
                end;
                Form_UI.IsFirstCalibrate := False;
              end;
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

          //计算力的均值、最大值、最小值、均方根值
          if Form_UI.calingCounts > Form_UI.calCounts - 1 then
          begin
            for J := 0 to Form_UI.calCounts - 1 do
            begin
              Form_UI.array_CalForce[J] := array_PlusResult[Form_UI.calingCounts - Form_UI.calCounts + J].JCL_value;
            end;
            array_PlusResult[Form_UI.calingCounts - 1].JCL_mean := Form_UI.CalMean(Form_UI.array_CalForce);
            array_PlusResult[Form_UI.calingCounts - 1].JCL_max := Form_UI.CalMax(Form_UI.array_CalForce);
            array_PlusResult[Form_UI.calingCounts - 1].JCL_min := Form_UI.CalMin(Form_UI.array_CalForce);
            array_PlusResult[Form_UI.calingCounts - 1].JCL_std := Form_UI.Calstd(Form_UI.array_CalForce);
          end;

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
              if Form_UI.calMaoCounts < 999 then
              begin
                Form_UI.calMaoCounts := Form_UI.calMaoCounts + 1;
                SetLength(temp_SPJL_value, Form_UI.calMaoCounts);
                SetLength(temp_SPGC_value, Form_UI.calMaoCounts);
                temp_SPJL_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
                temp_SPGC_value[Form_UI.calMaoCounts - 1] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
              end
              else
              begin
                for J := 0 to 997 do
                begin
                  temp_SPJL_value[J] := temp_SPJL_value[J + 1];
                  temp_SPGC_value[J] := temp_SPGC_value[J + 1];
                end;
                temp_SPJL_value[998] := Abs(array_ResultDeal[I].LCZ12_value - array_ResultDeal[I].LCZ11_value);
                temp_SPGC_value[998] := Abs(array_ResultDeal[I].DGZ12_value - array_ResultDeal[I].DGZ11_value);
              end;
            end;
          end;

          //为高差计算做准备
          if temp_MaxH < array_ResultDeal[I].DGZ11_value then temp_MaxH := array_ResultDeal[I].DGZ11_value;
          if temp_MinH > array_ResultDeal[I].DGZ11_value then temp_MinH := array_ResultDeal[I].DGZ11_value;

          //区段计算
          if array_ResultDeal[I].mark = 4 then
          begin
            endRecordKm := tempKm;
            if Abs(endRecordKm - startRecordKm) > 5 then
            begin
              if Form_UI.calHCounts < 999 then
              begin
                Form_UI.calHCounts := Form_UI.calHCounts + 1;
                SetLength(temp_DGBHL_value, Form_UI.calHCounts);
                SetLength(temp_DWDGC_value, Form_UI.calHCounts);
                temp_DWDGC_value[Form_UI.calHCounts - 1] := Abs(temp_MaxH - temp_MinH);
                temp_DGBHL_value[Form_UI.calHCounts - 1] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000;
              end
              else
              begin
                for J := 0 to 997 do
                begin
                  temp_DWDGC_value[J] := temp_DWDGC_value[J + 1];
                  temp_DGBHL_value[J] := temp_DGBHL_value[J + 1];
                end;
                temp_DWDGC_value[998] := Abs(temp_MaxH - temp_MinH);
                temp_DGBHL_value[998] := temp_DWDGC_value[Form_UI.calHCounts - 1] / Abs(endRecordKm - startRecordKm) / 1000;
              end;
            end;
          end;

          //硬点、接触力、电流均值计算
          if Form_UI.noPlusCounts < 999 then
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
            for J := 0 to 997 do
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
            temp_arrayYD1[998] := array_ResultDeal[I].YD1_value;
            temp_arrayYD2[998] := array_ResultDeal[I].YD2_value;
            temp_arrayJCL[998] := array_ResultDeal[I].JCL_value;
            temp_arrayDL[998] := array_ResultDeal[I].DL_value;

            temp_arraycalibYL1[998] := array_CalibResultDeal[I].Power1;
            temp_arraycalibYL2[998] := array_CalibResultDeal[I].Power2;
            temp_arraycalibYL3[998] := array_CalibResultDeal[I].Power3;
            temp_arraycalibYL4[998] := array_CalibResultDeal[I].Power4;
            temp_arraycalibYD1[998] := array_CalibResultDeal[I].HardSpot1;
            temp_arraycalibYD2[998] := array_CalibResultDeal[I].HardSpot2;
            temp_arraycalibYD4[998] := array_CalibResultDeal[I].HardSpot4;
            temp_arraycalibYD5[998] := array_CalibResultDeal[I].HardSpot5;
          end;
        end;
      end;
      Sleep(500);
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

procedure TForm_UI.Action_StartCalibrateExecute(Sender: TObject);
begin
  IsFirstCalibrate := True;
  IsCalibrating := True;
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
            StartMs := GetTickCount;
            startTime := FormatDateTime('yymmddhhnnss', Now);
            ResumeThread(PSaveThread);
            ResumeThread(PProcessThread);
            ResumeThread(PDrawThread);
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
  ResumeThread(PDrawThread);
end;

procedure TForm_UI.Action_StartSaveExecute(Sender: TObject);
begin
  if not IsSave then
  begin
    TempOrignalDataPath := SavedOriginalDataPath + FormatDateTime('yyyymmddhhnnss', Now) + '.dat';
    TempResultDataPath := SavedResultDataPath + Form_LineSetting.line_name + '_' + FormatDateTime('yymmddhhnnss', Now) + '\GWResult.dat';
    if not DirectoryExists(ExtractFilePath(TempResultDataPath)) then ForceDirectories(ExtractFilePath(TempResultDataPath));
    SaveResultHead(TempResultDataPath, Form_LineSetting.line_name, Form_LineSetting.kilometer, Form_LineSetting.shangxiaxing, Form_LineSetting.direction, Form_LineSetting.plus_minus);
    StartSaveOriginalData;
    StartSaveResultData;
    IsSave := True;
    dxRibbonStatusBar.Panels[1].Text := '正在存储数据。';
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
            StartMs := GetTickCount;
            startTime := FormatDateTime('yymmddhhnnss', Now);
            ResumeThread(PSaveThread);
            ResumeThread(PProcessThread);
            ResumeThread(PDrawThread);
            IsRun := True;
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
  IsCalibrating := False;
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

    SuspendThread(Form_UI.PSaveThread);
    SuspendThread(Form_UI.PProcessThread);
    SuspendThread(Form_UI.PDrawThread);

    IsRun := False;
    IsSave := False;
    dxRibbonStatusBar.Panels[0].Text := '已停止采集。';
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';

    Data2DCache.clear;
    HvUDPCache.clear;
    LvUDPCache.clear;
    AcyingCache.clear;
    DrawCache.clear;
    OriginalCache.clear;
    ResultCache.clear;

    //为下次开始做准备
    IsFirstCal := True;
    IsJCDL := True;
    IsGJD := False;
//    counts:= 0;
    drawCounts:= 0;
    calingCounts := 0;
    noPlusCounts := 0;
    calHCounts := 0;
    calMaoCounts := 0;
    poleCounts := 0;
    paintCounts := 0;

    time_Electricity := 0;
    time_CalSpeed := 0;

    //2D错误值取前一个值数组初始化
    for I := 0 to 3 do
    begin
      temp_X[I] := 65537;
      temp_Y[I] := 65537;
    end;

    //绘图数据数组初始化
    for I := 0 to 25 do
    begin
      for J := 0 to 4999 do
      begin
        DrawData[I][J] := 0;
      end;
    end;

    Close2D;
    dxRibbonStatusBar.Panels[3].Text := '2D传感器已停止工作。';
  end;
end;

procedure TForm_UI.Action_StopPlaybackExecute(Sender: TObject);
begin
  SuspendThread(PSaveThread);
  SuspendThread(PProcessThread);
  SuspendThread(PDrawThread);
  IsFirstCalibrate := False;
  IsCalibrating := False;
  LargeButton_InitSetting.Enabled := True;
  LargeButton_Pause.Enabled := True;
  LargeButton_StartCollect.Enabled := True;
  LargeButton_StopCollect.Enabled := True;
end;

procedure TForm_UI.Action_StopSaveExecute(Sender: TObject);
begin
  if IsSave then
  begin
    IsSave := False;
    OriginalCache.clear;
    ResultCache.clear;
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';
    StopSaveOriginalData;
    StopSaveResultData;
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

    Data2DCache.clear;
    HvUDPCache.clear;
    LvUDPCache.clear;
    AcyingCache.clear;
    DrawCache.clear;
    OriginalCache.clear;
    ResultCache.clear;

    SuspendThread(PSaveThread);
    SuspendThread(PProcessThread);
    SuspendThread(PDrawThread);

    IsRun := False;
    IsSave := False;
    dxRibbonStatusBar.Panels[0].Text := '已停止采集。';
    dxRibbonStatusBar.Panels[1].Text := '未存储数据。';

    //为下次开始做准备
    IsFirstCal := True;
    IsJCDL := True;
    IsGJD := False;
//    counts:= 0;
    drawCounts:= 0;
    calingCounts := 0;
    noPlusCounts := 0;
    calHCounts := 0;
    calMaoCounts := 0;
    poleCounts := 0;
    paintCounts := 0;

    time_Electricity := 0;
    time_CalSpeed := 0;

    //2D错误值取前一个值数组初始化
    for I := 0 to 3 do
    begin
      temp_X[I] := 65537;
      temp_Y[I] := 65537;
    end;

    //绘图数据数组初始化
    for I := 0 to 25 do
    begin
      for J := 0 to 4999 do
      begin
        DrawData[I][J] := 0;
      end;
    end;

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
//  dxRibbon.ShowTabGroups := True;
end;

procedure TForm_UI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//  if MessageBox(handle, '您确定要退出系统吗？', '信息提示', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then CanClose := True
//  else CanClose := False;
end;

procedure TForm_UI.FormCreate(Sender: TObject);
var
  FSaveThreadID, FProcessThreadID, FDrawThreadID: DWORD;   //各个线程ID,THandle不行
  W: array [0..1] of Double;
  FirOrder: Integer;
  I: Byte;
  J: Word;
//  Test: array of Single;
begin
  RzPageControl.ActivePage := TabSheet_Conductor;

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

  IdUDPServer_Hv.DefaultPort := StrToInt(HvUDPPort);
  IdUDPServer_Lv.DefaultPort := StrToInt(LvUDPPort);
  IdUDPServer_Acying.DefaultPort := StrToInt(AcyingUDPPort);

  FGlobalpara.DataSelfDelete(SavedOriginalDataPath, 20.0);    //数据自删减，如果路径是不存在的路径是不会出错的
  FGlobalpara.DataSelfDelete(SavedResultDataPath, 20.0);    //数据自删减

//  InitializeCriticalSection(CS);

  Data2DCache := TsfQueue.Create;
  HvUDPCache := TsfQueue.Create;
  LvUDPCache := TsfQueue.Create;
  AcyingCache := TsfQueue.Create;
  DrawCache := TsfQueue.Create;
  OriginalCache := TsfQueue.Create;
  ResultCache := TsfQueue.Create;

  //滤波器初始化
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

  vector_X1.Size(Number_Cal);
  vector_Y1.Size(Number_Cal);
  vector_X2.Size(Number_Cal);
  vector_Y2.Size(Number_Cal);
  vector_X3.Size(Number_Cal);
  vector_Y3.Size(Number_Cal);
  vector_X4.Size(Number_Cal);
  vector_Y4.Size(Number_Cal);
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
  PDrawThread := CreateThread(nil, 0, @DrawThread, nil, 4, FDrawThreadID);

  Timer_InitSubGroup.Enabled := True;

  //布尔类型初始化
  IsRun := False;
  IsSave := False;
  IsPlayback := False;
  IsFirstCalibrate := False;
  IsCalibrating := False;
  IsFirstCal := True;
  IsJCDL := True;
  IsGJD := False;

  //计算绘图技术点初始化
//  counts := 0;
  drawCounts := 0;
  calingCounts := 0;
  noPlusCounts := 0;
  calHCounts := 0;
  calMaoCounts := 0;
  poleCounts := 0;
  paintCounts := 0;

  JCL := 0;
  Calib_DY := 0;
  YL1 := 0;
  YL2 := 0;
  YL3 := 0;
  YL4 := 0;
  YD1 := 0;
  YD2 := 0;
  YD3 := 0;
  YD4 := 0;
  YD5 := 0;
  YD6 := 0;
  time_Electricity := 0;
  time_CalSpeed := 0;

  //2D错误值取前一个值数组初始化
  for I := 0 to 3 do
  begin
    temp_X[I] := 65537;
    temp_Y[I] := 65537;
  end;

  //绘图数据数组初始化
  for I := 0 to 25 do
  begin
    for J := 0 to 4999 do
    begin
      DrawData[I][J] := 0;
    end;
  end;

//  //测试
//  SetLength(Test, 0);
end;

procedure TForm_UI.FormDestroy(Sender: TObject);
begin
  if IsSave then
  begin
    Action_StopSaveExecute(Sender);
  end;

  if IsRun then
  begin
    Action_StopCollectExecute(Sender);
    Action_StopSimulateExecute(Sender);
  end;


  //线程销毁
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

  //2D析构
  CloseHandle(m_mutex);
  CloseHandle(m_lock);

//  DeleteCriticalSection(CS);
end;

procedure TForm_UI.TimerTimer(Sender: TObject);
begin
  dxRibbonStatusBar.Panels[5].Text := '公里标：' + Formatfloat('0.000', GKilometer) + 'km   速度：' + Formatfloat('0.000', GSpeed) + 'km/h';
  dxRibbonStatusBar.Panels[6].Text := FormatDateTime('yyyy年mm月dd日 hh:nn:ss', Now);
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
      Writeln(ConfigurationTextFile, 'HvUDPIP = 10.10.10.2');
      Writeln(ConfigurationTextFile, 'HvUDPPort = 1025');
      Writeln(ConfigurationTextFile, 'LvUDPIP = 10.10.10.3');
      Writeln(ConfigurationTextFile, 'LvUDPPort = 1025');
      Writeln(ConfigurationTextFile, 'AcyingUDPIP = 10.10.10.4');
      Writeln(ConfigurationTextFile, 'AcyingUDPPort = 1025');
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
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[调试]');
      Writeln(ConfigurationTextFile, '调试 = 0');
      Writeln(ConfigurationTextFile, '绘图点数 = 50');
      Writeln(ConfigurationTextFile, '计算点数 = 100');
      Writeln(ConfigurationTextFile, '');

      CloseFile(ConfigurationTextFile);
    End;

    IniFile := TIniFile.Create(ConfigurationFilePath);

    LineName := IniFile.ReadString('基础设置', '线路名称', '未知线路');

    TCPIP := IniFile.ReadString('传感器设置', '2DIP', '10.10.10.100');
    HvUDPIP := IniFile.ReadString('传感器设置', 'HvUDPIP', '10.10.10.2');
    HvUDPPort := IniFile.ReadString('传感器设置', 'HvUDPPort', '1025');
    LvUDPIP := IniFile.ReadString('传感器设置', 'LvUDPIP', '10.10.10.3');
    LvUDPPort := IniFile.ReadString('传感器设置', 'LvUDPPort', '1025');
    AcyingUDPIP := IniFile.ReadString('传感器设置', 'AcyingUDPIP', '10.10.10.4');
    AcyingUDPPort := IniFile.ReadString('传感器设置', 'AcyingUDPPort', '1025');

    Calibrate_Force := IniFile.ReadFloat('标定', 'Force', 0);
    Calibrate_Electricity := IniFile.ReadFloat('标定', 'Electricity', 0);
    Calibrate_Power1 := IniFile.ReadFloat('标定', 'Power1', 0);
    Calibrate_Power2 := IniFile.ReadFloat('标定', 'Power2', 0);
    Calibrate_Power3 := IniFile.ReadFloat('标定', 'Power3', 0);
    Calibrate_Power4 := IniFile.ReadFloat('标定', 'Power4', 0);
    Calibrate_ACC1 := IniFile.ReadFloat('标定', 'ACC1', 0);
    Calibrate_ACC2 := IniFile.ReadFloat('标定', 'ACC2', 0);
    Calibrate_ACC3 := IniFile.ReadFloat('标定', 'ACC3', 0);
    Calibrate_ACC4 := IniFile.ReadFloat('标定', 'ACC4', 0);
    Calibrate_ACC5 := IniFile.ReadFloat('标定', 'ACC5', 0);
    Calibrate_ACC6 := IniFile.ReadFloat('标定', 'ACC6', 0);

    IsDebug := IniFile.ReadInteger('调试', '调试', 1);
    drawThreshold := IniFile.ReadInteger('调试', '绘图点数', 50);
    calCounts := IniFile.ReadInteger('调试', '计算点数', 100);
    SetLength(array_CalForce, calCounts);
//    IdUDPServer_Hv.Binding.PeerIP := TCPIP;

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

  Form_Sensor.Edit_DrawCounts.Text := IntToStr(drawThreshold);
  Form_Sensor.Edit_CalCounts.Text := IntToStr(calCounts);

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
var
  I: Byte;
  tmp: array [0..9] of Byte;
  tempDataAcying: ^TRecord_OriginalAcying;
begin
  for I := 0 to 9 do tmp[I] := AData[I];

  New(tempDataAcying);
  CopyMemory(tempDataAcying, @tmp, SizeOf(TRecord_OriginalAcying));
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

procedure TForm_UI.SaveResultHead(tempPath: string; tempLineName: string; initDis: Double; shangxia: string; rundir: string; initzengjian: Byte);
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

  if Length(tempLineName) > 0 then
  begin
    for I := 0 to Length(tempLineName) - 1 do
    begin
      TempData.lineName[I] := tempLineName[I];
    end;
  end;
  TempData.Version := 1;
  for I := 0 to 394 do TempData.reserved[I] := 0;
  TempData.inight := 0;
  TempData.inidis := Round(initDis * 1000);
  TempData.Buchang := 0;
  if shangxia = '上行' then TempData.shangxia := 1
  else TempData.shangxia := 2;
  if rundir = '正向' then TempData.rundir := 1
  else TempData.rundir := 0;
  if initzengjian = 1 then TempData.initzengjian := 1
  else TempData.initzengjian := 0;

  tempString := FormatDateTime('yymmddhhnnss', Now);
  for I := 0 to 11 do TempData.DataTime[I] := tempString[I];

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

function TForm_UI.CalJCL(tempV: Single): Single;
begin
  Result := tempV * 117.34;
end;

function TForm_UI.CalYD(tempV: Single; tempM: Single): Single;
begin
  Result := tempV * 1000 * tempM;
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
  Buffer_Send[42] := 200;
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
  Buffer_Send[42] := 200;
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

function TForm_UI.DrawLine: Integer;
var
  TempResultData: ^sDataFrame;
  TempRData: sDataFrame;
  I: Word;
  tmp0ChartValues, tmp1ChartValues, tmp2ChartValues, tmp3ChartValues, tmp4ChartValues, tmp5ChartValues, tmp6ChartValues, tmp7ChartValues, tmp8ChartValues, tmp9ChartValues, tmp10ChartValues: TChartValues;
begin
  if Form_UI.DrawCache.count > Form_UI.drawThreshold then
  begin
    if Form_UI.paintCounts + Form_UI.drawThreshold < Number_Draw + 1 then
    begin
      for I := 0 to Form_UI.drawThreshold - 1 do
      begin
        TempResultData := Form_UI.DrawCache.Pop;
        CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
        Dispose(TempResultData);

        Form_UI.DrawData[0][I + Form_UI.paintCounts] := TempRData.LCZ11_value;
        Form_UI.DrawData[1][I + Form_UI.paintCounts] := TempRData.LCZ12_value;
        Form_UI.DrawData[2][I + Form_UI.paintCounts] := TempRData.LCZSP1_value;
        Form_UI.DrawData[3][I + Form_UI.paintCounts] := TempRData.LCZ21_value;
        Form_UI.DrawData[4][I + Form_UI.paintCounts] := TempRData.LCZ22_value;
        Form_UI.DrawData[5][I + Form_UI.paintCounts] := TempRData.LCZSP2_value;
        Form_UI.DrawData[6][I + Form_UI.paintCounts] := TempRData.DGZ11_value;
        Form_UI.DrawData[7][I + Form_UI.paintCounts] := TempRData.DGZ12_value;
        Form_UI.DrawData[8][I + Form_UI.paintCounts] := TempRData.DGZ21_value;
        Form_UI.DrawData[9][I + Form_UI.paintCounts] := TempRData.DGZ22_value;
        Form_UI.DrawData[10][I + Form_UI.paintCounts] := TempRData.SPJL_value;
        Form_UI.DrawData[11][I + Form_UI.paintCounts] := TempRData.SPGC_value;
        Form_UI.DrawData[12][I + Form_UI.paintCounts] := TempRData.DGBHL_value;
        Form_UI.DrawData[13][I + Form_UI.paintCounts] := TempRData.DWDGC_value;
        Form_UI.DrawData[14][I + Form_UI.paintCounts] := TempRData.JCL_value;
        Form_UI.DrawData[15][I + Form_UI.paintCounts] := TempRData.JCL_mean;
        Form_UI.DrawData[16][I + Form_UI.paintCounts] := TempRData.JCL_max;
        Form_UI.DrawData[17][I + Form_UI.paintCounts] := TempRData.JCL_min;
        Form_UI.DrawData[18][I + Form_UI.paintCounts] := TempRData.JCL_std;
        Form_UI.DrawData[19][I + Form_UI.paintCounts] := TempRData.YD1_value;
        Form_UI.DrawData[20][I + Form_UI.paintCounts] := TempRData.YD2_value;
        Form_UI.DrawData[21][I + Form_UI.paintCounts] := TempRData.DL_value;
        Form_UI.DrawData[22][I + Form_UI.paintCounts] := TempRData.RH_value;
        Form_UI.DrawData[23][I + Form_UI.paintCounts] := TempRData.RH_time;
        Form_UI.DrawData[24][I + Form_UI.paintCounts] := TempRData.RH_numb;
        Form_UI.DrawData[25][I + Form_UI.paintCounts] := TempRData.mykilo;
      end;
      Form_UI.paintCounts := Form_UI.paintCounts + Form_UI.drawThreshold;
    end
    else
    begin
      for I := 0 to 9999 - Form_UI.paintCounts - Form_UI.drawThreshold do
      begin
        Form_UI.DrawData[0][I] := Form_UI.DrawData[0][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[1][I] := Form_UI.DrawData[1][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[2][I] := Form_UI.DrawData[2][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[3][I] := Form_UI.DrawData[3][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[4][I] := Form_UI.DrawData[4][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[5][I] := Form_UI.DrawData[5][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[6][I] := Form_UI.DrawData[6][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[7][I] := Form_UI.DrawData[7][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[8][I] := Form_UI.DrawData[8][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[9][I] := Form_UI.DrawData[9][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[10][I] := Form_UI.DrawData[10][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[11][I] := Form_UI.DrawData[11][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[12][I] := Form_UI.DrawData[12][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[13][I] := Form_UI.DrawData[13][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[14][I] := Form_UI.DrawData[14][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[15][I] := Form_UI.DrawData[15][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[16][I] := Form_UI.DrawData[16][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[17][I] := Form_UI.DrawData[17][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[18][I] := Form_UI.DrawData[18][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[19][I] := Form_UI.DrawData[19][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[20][I] := Form_UI.DrawData[20][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[21][I] := Form_UI.DrawData[21][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[22][I] := Form_UI.DrawData[22][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[23][I] := Form_UI.DrawData[23][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[24][I] := Form_UI.DrawData[24][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[25][I] := Form_UI.DrawData[25][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
      end;

      for I := Number_Draw - 1 - Form_UI.drawThreshold to Number_Draw - 1 do
      begin
        TempResultData := Form_UI.DrawCache.Pop;
        CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
        Dispose(TempResultData);

        Form_UI.DrawData[0][I] := TempRData.LCZ11_value;
        Form_UI.DrawData[1][I] := TempRData.LCZ12_value;
        Form_UI.DrawData[2][I] := TempRData.LCZSP1_value;
        Form_UI.DrawData[3][I] := TempRData.LCZ21_value;
        Form_UI.DrawData[4][I] := TempRData.LCZ22_value;
        Form_UI.DrawData[5][I] := TempRData.LCZSP2_value;
        Form_UI.DrawData[6][I] := TempRData.DGZ11_value;
        Form_UI.DrawData[7][I] := TempRData.DGZ12_value;
        Form_UI.DrawData[8][I] := TempRData.DGZ21_value;
        Form_UI.DrawData[9][I] := TempRData.DGZ22_value;
        Form_UI.DrawData[10][I] := TempRData.SPJL_value;
        Form_UI.DrawData[11][I] := TempRData.SPGC_value;
        Form_UI.DrawData[12][I] := TempRData.DGBHL_value;
        Form_UI.DrawData[13][I] := TempRData.DWDGC_value;
        Form_UI.DrawData[14][I] := TempRData.JCL_value;
        Form_UI.DrawData[15][I] := TempRData.JCL_mean;
        Form_UI.DrawData[16][I] := TempRData.JCL_max;
        Form_UI.DrawData[17][I] := TempRData.JCL_min;
        Form_UI.DrawData[18][I] := TempRData.JCL_std;
        Form_UI.DrawData[19][I] := TempRData.YD1_value;
        Form_UI.DrawData[20][I] := TempRData.YD2_value;
        Form_UI.DrawData[21][I] := TempRData.DL_value;
        Form_UI.DrawData[22][I] := TempRData.RH_value;
        Form_UI.DrawData[23][I] := TempRData.RH_time;
        Form_UI.DrawData[24][I] := TempRData.RH_numb;
        Form_UI.DrawData[25][I] := TempRData.mykilo;
      end;
    end;

    if Form_UI.paintCounts > Number_Draw then Form_UI.paintCounts := Number_Draw;

    SetLength(tmp0ChartValues, Form_UI.paintCounts);
    for I := 0 to Form_UI.paintCounts - 1 do
    begin
      tmp0ChartValues[I] := Form_UI.DrawData[25][I];
    end;

    if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Conductor then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);
      SetLength(tmp5ChartValues, Form_UI.paintCounts);
      SetLength(tmp6ChartValues, Form_UI.paintCounts);
      SetLength(tmp7ChartValues, Form_UI.paintCounts);
      SetLength(tmp8ChartValues, Form_UI.paintCounts);
      SetLength(tmp9ChartValues, Form_UI.paintCounts);
      SetLength(tmp10ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[0][I];
        tmp2ChartValues[I] := Form_UI.DrawData[1][I];
        tmp3ChartValues[I] := Form_UI.DrawData[2][I];
        tmp4ChartValues[I] := Form_UI.DrawData[3][I];
        tmp5ChartValues[I] := Form_UI.DrawData[4][I];
        tmp6ChartValues[I] := Form_UI.DrawData[5][I];
        tmp7ChartValues[I] := Form_UI.DrawData[6][I];
        tmp8ChartValues[I] := Form_UI.DrawData[7][I];
        tmp9ChartValues[I] := Form_UI.DrawData[8][I];
        tmp10ChartValues[I] := Form_UI.DrawData[9][I];
      end;

      Form_UI.Series_Line1Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line1Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Width.XValues.Modified := True;
      Form_UI.Series_Line1Width.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Line1Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Width.YValues.Modified := True;

      Form_UI.Series_Line2Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line2Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Width.XValues.Modified := True;
      Form_UI.Series_Line2Width.YValues.Value := tmp2ChartValues;
      Form_UI.Series_Line2Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Width.YValues.Modified := True;

      Form_UI.Series_LineDistance1.XValues.Value := tmp0ChartValues;
      Form_UI.Series_LineDistance1.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance1.XValues.Modified := True;
      Form_UI.Series_LineDistance1.YValues.Value := tmp3ChartValues;
      Form_UI.Series_LineDistance1.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance1.YValues.Modified := True;

      Form_UI.Series_Line3Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line3Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Width.XValues.Modified := True;
      Form_UI.Series_Line3Width.YValues.Value := tmp4ChartValues;
      Form_UI.Series_Line3Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Width.YValues.Modified := True;

      Form_UI.Series_Line4Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line4Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Width.XValues.Modified := True;
      Form_UI.Series_Line4Width.YValues.Value := tmp5ChartValues;
      Form_UI.Series_Line4Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Width.YValues.Modified := True;

      Form_UI.Series_LineDistance2.XValues.Value := tmp0ChartValues;
      Form_UI.Series_LineDistance2.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance2.XValues.Modified := True;
      Form_UI.Series_LineDistance2.YValues.Value := tmp6ChartValues;
      Form_UI.Series_LineDistance2.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance2.YValues.Modified := True;

      Form_UI.Series_Line1Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line1Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Height.XValues.Modified := True;
      Form_UI.Series_Line1Height.YValues.Value := tmp7ChartValues;
      Form_UI.Series_Line1Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Height.YValues.Modified := True;

      Form_UI.Series_Line2Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line2Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Height.XValues.Modified := True;
      Form_UI.Series_Line2Height.YValues.Value := tmp8ChartValues;
      Form_UI.Series_Line2Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Height.YValues.Modified := True;

      Form_UI.Series_Line3Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line3Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Height.XValues.Modified := True;
      Form_UI.Series_Line3Height.YValues.Value := tmp9ChartValues;
      Form_UI.Series_Line3Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Height.YValues.Modified := True;

      Form_UI.Series_Line4Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line4Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Height.XValues.Modified := True;
      Form_UI.Series_Line4Height.YValues.Value := tmp10ChartValues;
      Form_UI.Series_Line4Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Height.YValues.Modified := True;

      Form_UI.Series_Line1Width.Repaint;
//        Form_UI.Series_Line2Width.Repaint;
//        Form_UI.Series_LineDistance1.Repaint;
//        Form_UI.Series_Line3Width.Repaint;
//        Form_UI.Series_Line4Width.Repaint;
//        Form_UI.Series_LineDistance2.Repaint;
//        Form_UI.Series_Line1Height.Repaint;
//        Form_UI.Series_Line2Height.Repaint;
//        Form_UI.Series_Line3Height.Repaint;
//        Form_UI.Series_Line4Height.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Parameter then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[10][I];
        tmp2ChartValues[I] := Form_UI.DrawData[11][I];
        tmp3ChartValues[I] := Form_UI.DrawData[12][I];
        tmp4ChartValues[I] := Form_UI.DrawData[13][I];
      end;

      Form_UI.PointSeries_Width.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Width.XValues.Modified := True;
      Form_UI.PointSeries_Width.YValues.Value := tmp1ChartValues;
      Form_UI.PointSeries_Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Width.YValues.Modified := True;

      Form_UI.PointSeries_Height.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Height.XValues.Modified := True;
      Form_UI.PointSeries_Height.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Height.YValues.Modified := True;

      Form_UI.PointSeries_Changerate.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Changerate.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Changerate.XValues.Modified := True;
      Form_UI.PointSeries_Changerate.YValues.Value := tmp3ChartValues;
      Form_UI.PointSeries_Changerate.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Changerate.YValues.Modified := True;

      Form_UI.PointSeries_Elevation.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Elevation.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Elevation.XValues.Modified := True;
      Form_UI.PointSeries_Elevation.YValues.Value := tmp4ChartValues;
      Form_UI.PointSeries_Elevation.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Elevation.YValues.Modified := True;

      Form_UI.PointSeries_Width.Repaint;
//        Form_UI.PointSeries_Height.Repaint;
//        Form_UI.PointSeries_Changerate.Repaint;
//        Form_UI.PointSeries_Elevation.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_ContactForce then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);
      SetLength(tmp5ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[14][I];
        tmp2ChartValues[I] := Form_UI.DrawData[15][I];
        tmp3ChartValues[I] := Form_UI.DrawData[16][I];
        tmp4ChartValues[I] := Form_UI.DrawData[17][I];
        tmp5ChartValues[I] := Form_UI.DrawData[18][I];
      end;

      Form_UI.Series_Force.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Force.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Force.XValues.Modified := True;
      Form_UI.Series_Force.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Force.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Force.YValues.Modified := True;

      Form_UI.Series_ForceAve.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceAve.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceAve.XValues.Modified := True;
      Form_UI.Series_ForceAve.YValues.Value := tmp2ChartValues;
      Form_UI.Series_ForceAve.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceAve.YValues.Modified := True;

      Form_UI.Series_ForceMax.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceMax.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMax.XValues.Modified := True;
      Form_UI.Series_ForceMax.YValues.Value := tmp3ChartValues;
      Form_UI.Series_ForceMax.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMax.YValues.Modified := True;

      Form_UI.Series_ForceMin.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceMin.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMin.XValues.Modified := True;
      Form_UI.Series_ForceMin.YValues.Value := tmp4ChartValues;
      Form_UI.Series_ForceMin.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMin.YValues.Modified := True;

      Form_UI.Series_ForceVariance.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceVariance.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceVariance.XValues.Modified := True;
      Form_UI.Series_ForceVariance.YValues.Value := tmp5ChartValues;
      Form_UI.Series_ForceVariance.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceVariance.YValues.Modified := True;

      Form_UI.Series_Force.Repaint;
//        Form_UI.Series_ForceAve.Repaint;
//        Form_UI.Series_ForceMax.Repaint;
//        Form_UI.Series_ForceMin.Repaint;
//        Form_UI.Series_ForceVariance.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Hardspot then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[19][I];
        tmp2ChartValues[I] := Form_UI.DrawData[20][I];
      end;

      Form_UI.Series_Vacc1.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Vacc1.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc1.XValues.Modified := True;
      Form_UI.Series_Vacc1.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Vacc1.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc1.YValues.Modified := True;

      Form_UI.Series_Vacc2.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Vacc2.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc2.XValues.Modified := True;
      Form_UI.Series_Vacc2.YValues.Value := tmp2ChartValues;
      Form_UI.Series_Vacc2.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc2.YValues.Modified := True;

      Form_UI.Series_Vacc1.Repaint;
//        Form_UI.Series_Vacc2.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Electric then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[21][I];
        tmp2ChartValues[I] := Form_UI.DrawData[22][I];
      end;

      Form_UI.Series_ElectricValue.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ElectricValue.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ElectricValue.XValues.Modified := True;
      Form_UI.Series_ElectricValue.YValues.Value := tmp1ChartValues;
      Form_UI.Series_ElectricValue.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ElectricValue.YValues.Modified := True;

      Form_UI.PointSeries_ElectricTime.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_ElectricTime.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTime.XValues.Modified := True;
      Form_UI.PointSeries_ElectricTime.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_ElectricTime.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTime.YValues.Modified := True;

      Form_UI.Series_ElectricValue.Repaint;
//        Form_UI.PointSeries_ElectricTime.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Acying then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[23][I];
        tmp2ChartValues[I] := Form_UI.DrawData[24][I];
      end;

      Form_UI.PointSeries_AcyingTime.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingTime.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTime.XValues.Modified := True;
      Form_UI.PointSeries_AcyingTime.YValues.Value := tmp1ChartValues;
      Form_UI.PointSeries_AcyingTime.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTime.YValues.Modified := True;

      Form_UI.PointSeries_AcyingCount.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingCount.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCount.XValues.Modified := True;
      Form_UI.PointSeries_AcyingCount.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_AcyingCount.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCount.YValues.Modified := True;

      Form_UI.PointSeries_AcyingTime.Repaint;
//        Form_UI.PointSeries_AcyingCount.Repaint;
    end;
    Sleep(100);
  end;
end;
end.
