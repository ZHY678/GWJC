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
  IdUDPServer, IdSocketHandle, IdGlobal, sfContnrs, UFirFilter;

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
    OHv: array [0..63] of Byte;
  end;

  TRecord_Hv = record
    Power1, Power2, Power3, Power4, HardSpot1, HardSpot2, HardSpot3, HardSpot4, HardSpot5, HardSpot6: Word;
  end;

  TRecord_OriginalLv = record
    OLv: array [0..7] of Byte;
  end;

  TRecord_Lv = record
    Electric: Word;
    encoder: Integer;
    Status1, Status2: Byte;
  end;

  Record_SaveOriginal = record
    Om_data: JCWJH;
    OHvData: TRecord_OriginalHv;
    OLvData: TRecord_OriginalLv;
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
  private
    { Private declarations }
    errorLogPath, backupFilePath, savedOriginalDataPath, savedResultDataPath: String;   //各个文件路径
    LineName, TCPIP, HvUDPIP, HvUDPPort, LvUDPIP, LvUDPPort, AcyingUDPIP, AcyingUDPPort: string;
    IsDebug, drawThreshold: Byte;

    FGlobalpara: TGlobalpara;

    procedure InitFolder;
    procedure InitSubGroup;
    function JCWSetIP(tempTCPIP: string): Integer;
    function YEGConnect(tempTCPIP: string): Integer;
    procedure YEGDisconnect;
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

    PCollectThread, PProcessThread, PDrawThread: DWORD;   //各个线程
    configurationFilePath: string;

    CS: TRTLCriticalSection;

//    data2DArray: array[0..4] of array[0..199] of data2D;
//    draw2DArray: array[0..4] of array[0..999] of data2D;
//    drawTimeX: array[0..999] of Double;
    calCounts, drawCounts, counts: Word;
//    TempX, TempY : array [0..3] of Single;

    IsRun, IsSave, IsPlayback: Boolean;

    Data2DCache, HvUDPCache, LvUDPCache, AcyingCache, DrawCache, OriginalCache, ResultCache: TsfQueue;

    Array_DataDeal: array [0..999] of Record_SaveOriginal;

    Force, Electricity, Power_1, Power_2, Power_3, Power_4, ACC1, ACC2, ACC3, ACC4, ACC5, ACC6: Single;

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
  end;

var
  Form_UI: TForm_UI;

implementation

{$R *.dfm}

function SaveThread(p: Pointer): Integer; stdcall;
begin
  while True do
  begin
    ;
  end;
end;

function ProcessThread(p: Pointer): Integer; stdcall;
var
  I: Word;
  TempData2D: ^JCWJH;
  TempDataO2D: JCWJH;
  TempDataHv: ^TRecord_OriginalHv;
  TempDataOHv: TRecord_OriginalHv;
  TempDataLv: ^TRecord_OriginalLv;
  TempDataOLv: TRecord_OriginalLv;
begin
  while True do
  begin
    //数据取值
    if Form_UI.Data2DCache.count > 200 then
    begin
      if Form_UI.counts < 801 then
      begin
        for I := Form_UI.counts to Form_UI.counts + 199 do
        begin
          TempData2D := Form_UI.Data2DCache.Pop;
          CopyMemory(@TempDataO2D, TempData2D, SizeOf(JCWJH));
          Dispose(TempData2D);

          Form_UI.Array_DataDeal[I].Om_data := TempDataO2D;
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
          Form_UI.Array_DataDeal[I].Om_data := TempDataO2D;
        end;
      end;
    end;

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
      end;
    end;

    //原始数据存储
    if Form_UI.IsSave then
    begin
      ;
    end;
  end;
end;

function DrawThread(p: Pointer): Integer; stdcall;
//var
//  I: Byte;
//  J: Word;
//  Series_Line1WidthValues, Series_Line1HeightValues, Series_Line2WidthValues, Series_Line2HeightValues, Series_LineDistance1Values,
//  Series_Line3WidthValues, Series_Line3HeightValues, Series_Line4WidthValues, Series_Line4HeightValues, Series_LineDistance2Values,
//  ValuesX: TChartValues;
begin
//  Synchronize();
  while True do
  begin


//    //以下部分只是连续2D200HZ频率采集绘图显示，因为是没有速度信号的，所以只做采集绘图测试用
//    EnterCriticalSection(Form_UI.CS);
//    if Form_UI.calCounts = 200 then
//    begin
////      //奇怪的数组赋值问题
////      for J := 0 to 199 do
////      begin
////        if Form_UI.data2DArray[1][J].lineWidth <> 0 then
////        begin
////          Form_UI.data2DArray[4][J].lineWidth := Abs(Form_UI.data2DArray[1][J].lineWidth - Form_UI.data2DArray[0][J].lineWidth);
////          Form_UI.data2DArray[4][J].lineHeight := Abs(Form_UI.data2DArray[1][J].lineHeight - Form_UI.data2DArray[0][J].lineHeight);
////        end;
////        if Form_UI.data2DArray[3][J].lineWidth <> 0 then
////        begin
////          Form_UI.data2DArray[4][J].lineWidthValue := Abs(Form_UI.data2DArray[3][J].lineWidth - Form_UI.data2DArray[2][J].lineWidth);
////          Form_UI.data2DArray[4][J].lineHeightValue := Abs(Form_UI.data2DArray[3][J].lineHeight - Form_UI.data2DArray[2][J].lineHeight);
////        end;
////      end;
//
//      if Form_UI.drawCounts < 5 then
//      begin
//        for I := 0 to 3 do
//        begin
//          for J := 0 to 199 do
//          begin
//            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineWidth := Form_UI.data2DArray[I][J].lineWidth;
//            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineHeight := Form_UI.data2DArray[I][J].lineHeight;
//            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineWidthValue := Form_UI.data2DArray[I][J].lineWidthValue;
//            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineHeightValue := Form_UI.data2DArray[I][J].lineHeightValue;
//          end;
//        end;
//        Form_UI.drawCounts := Form_UI.drawCounts + 1;
//      end
//      else
//      begin
//        for I := 0 to 3 do
//        begin
//          for J := 200 to 999 do
//          begin
//            Form_UI.draw2DArray[I][J - 200].lineWidth := Form_UI.draw2DArray[I][J].lineWidth;
//            Form_UI.draw2DArray[I][J - 200].lineHeight := Form_UI.draw2DArray[I][J].lineHeight;
//            Form_UI.draw2DArray[I][J - 200].lineWidthValue := Form_UI.draw2DArray[I][J].lineWidthValue;
//            Form_UI.draw2DArray[I][J - 200].lineHeightValue := Form_UI.draw2DArray[I][J].lineHeightValue;
//          end;
//        end;
//        for I := 0 to 3 do
//        begin
//          for J := 800 to 999 do
//          begin
//            Form_UI.draw2DArray[I][J].lineWidth := Form_UI.data2DArray[I][J - 800].lineWidth;
//            Form_UI.draw2DArray[I][J].lineHeight := Form_UI.data2DArray[I][J - 800].lineHeight;
//            Form_UI.draw2DArray[I][J].lineWidthValue := Form_UI.data2DArray[I][J - 800].lineWidthValue;
//            Form_UI.draw2DArray[I][J].lineHeightValue := Form_UI.data2DArray[I][J - 800].lineHeightValue;
//          end;
//        end;
//        for J := 0 to 999 do Form_UI.drawTimeX[J] := Form_UI.drawTimeX[J] + 1;
//      end;
//
//      SetLength(Series_Line1WidthValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line1HeightValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line2WidthValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line2HeightValues, length(Form_UI.drawTimeX));
//      SetLength(Series_LineDistance1Values, length(Form_UI.drawTimeX));
//      SetLength(Series_Line3WidthValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line3HeightValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line4WidthValues, length(Form_UI.drawTimeX));
//      SetLength(Series_Line4HeightValues, length(Form_UI.drawTimeX));
//      SetLength(Series_LineDistance2Values, length(Form_UI.drawTimeX));
//      SetLength(ValuesX, length(Form_UI.drawTimeX));
//
////      //奇怪数组赋值问题
////      for J := 0 to 999 do
////      begin
////        Series_Line1WidthValues[J] := Form_UI.draw2DArray[0][J].lineWidth;
////        Series_Line1HeightValues[J] := Form_UI.draw2DArray[0][J].lineHeight;
////        Series_Line2WidthValues[J] := Form_UI.draw2DArray[1][J].lineWidth;
////        Series_Line2HeightValues[J] := Form_UI.draw2DArray[1][J].lineHeight;
////        Series_LineDistance1Values[J] := Form_UI.data2DArray[4][J].lineWidth;
////        Series_Line3WidthValues[J] := Form_UI.draw2DArray[2][J].lineWidth;
////        Series_Line3HeightValues[J] := Form_UI.draw2DArray[2][J].lineHeight;
////        Series_Line4WidthValues[J] := Form_UI.draw2DArray[3][J].lineWidth;
////        Series_Line4HeightValues[J] := Form_UI.draw2DArray[3][J].lineHeight;
////        Series_LineDistance2Values[J] := Form_UI.data2DArray[4][J].lineWidthValue;
////        ValuesX[J] := Form_UI.drawTimeX[J];
////      end;
//
//      for J := 0 to 999 do
//      begin
//        Series_Line1WidthValues[J] := Form_UI.draw2DArray[0][J].lineWidth;
//        Series_Line1HeightValues[J] := Form_UI.draw2DArray[0][J].lineHeight;
//        Series_Line2WidthValues[J] := Form_UI.draw2DArray[1][J].lineWidth;
//        Series_Line2HeightValues[J] := Form_UI.draw2DArray[1][J].lineHeight;
//        Series_LineDistance1Values[J] := Form_UI.data2DArray[4][J].lineWidth;
//        Series_Line3WidthValues[J] := Form_UI.draw2DArray[2][J].lineWidth;
//        Series_Line3HeightValues[J] := Form_UI.draw2DArray[2][J].lineHeight;
//        Series_Line4WidthValues[J] := Form_UI.draw2DArray[3][J].lineWidth;
//        Series_Line4HeightValues[J] := Form_UI.draw2DArray[3][J].lineHeight;
//        Series_LineDistance2Values[J] := Form_UI.data2DArray[4][J].lineWidthValue;
//        if Series_Line2WidthValues[J] <> 0 then
//        begin
//          Series_LineDistance1Values[J] := Abs(Series_Line2WidthValues[J] - Series_Line1WidthValues[J]);
//        end
//        else Series_LineDistance1Values[J] := 0;
//        if Series_Line4WidthValues[J] <> 0 then
//        begin
//          Series_LineDistance2Values[J] := Abs(Series_Line4WidthValues[J] - Series_Line3WidthValues[J]);
//        end
//        else Series_LineDistance2Values[J] := 0;
//        ValuesX[J] := Form_UI.drawTimeX[J];
//      end;
//
//      //曲线绘图
//      if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Conductor then
//      begin
//        Form_UI.Series_Line1Width.XValues.Value := ValuesX;
//        Form_UI.Series_Line1Width.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line1Width.XValues.Modified := True;
//
//        Form_UI.Series_Line1Height.XValues.Value := ValuesX;
//        Form_UI.Series_Line1Height.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line1Height.XValues.Modified := True;
//
//        Form_UI.Series_Line2Width.XValues.Value := ValuesX;
//        Form_UI.Series_Line2Width.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line2Width.XValues.Modified := True;
//
//        Form_UI.Series_Line2Height.XValues.Value := ValuesX;
//        Form_UI.Series_Line2Height.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line2Height.XValues.Modified := True;
//
//        Form_UI.Series_LineDistance1.XValues.Value := ValuesX;
//        Form_UI.Series_LineDistance1.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_LineDistance1.XValues.Modified := True;
//
//        Form_UI.Series_Line3Width.XValues.Value := ValuesX;
//        Form_UI.Series_Line3Width.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line3Width.XValues.Modified := True;
//
//        Form_UI.Series_Line3Height.XValues.Value := ValuesX;
//        Form_UI.Series_Line3Height.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line3Height.XValues.Modified := True;
//
//        Form_UI.Series_Line4Width.XValues.Value := ValuesX;
//        Form_UI.Series_Line4Width.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line4Width.XValues.Modified := True;
//
//        Form_UI.Series_Line4Height.XValues.Value := ValuesX;
//        Form_UI.Series_Line4Height.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line4Height.XValues.Modified := True;
//
//        Form_UI.Series_LineDistance2.XValues.Value := ValuesX;
//        Form_UI.Series_LineDistance2.XValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_LineDistance2.XValues.Modified := True;
//
//        Form_UI.Series_Line1Width.YValues.Value := Series_Line1WidthValues;
//        Form_UI.Series_Line1Width.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line1Width.YValues.Modified := True;
//
//        Form_UI.Series_Line1Height.YValues.Value := Series_Line1HeightValues;
//        Form_UI.Series_Line1Height.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line1Height.YValues.Modified := True;
//
//        Form_UI.Series_Line2Width.YValues.Value := Series_Line2WidthValues;
//        Form_UI.Series_Line2Width.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line2Width.YValues.Modified := True;
//
//        Form_UI.Series_Line2Height.YValues.Value := Series_Line2HeightValues;
//        Form_UI.Series_Line2Height.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line2Height.YValues.Modified := True;
//
//        Form_UI.Series_LineDistance1.YValues.Value := Series_LineDistance1Values;
//        Form_UI.Series_LineDistance1.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_LineDistance1.YValues.Modified := True;
//
//        Form_UI.Series_Line3Width.YValues.Value := Series_Line3WidthValues;
//        Form_UI.Series_Line3Width.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line3Width.YValues.Modified := True;
//
//        Form_UI.Series_Line3Height.YValues.Value := Series_Line3HeightValues;
//        Form_UI.Series_Line3Height.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line3Height.YValues.Modified := True;
//
//        Form_UI.Series_Line4Width.YValues.Value := Series_Line4WidthValues;
//        Form_UI.Series_Line4Width.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line4Width.YValues.Modified := True;
//
//        Form_UI.Series_Line4Height.YValues.Value := Series_Line4HeightValues;
//        Form_UI.Series_Line4Height.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_Line4Height.YValues.Modified := True;
//
//        Form_UI.Series_LineDistance2.YValues.Value := Series_LineDistance2Values;
//        Form_UI.Series_LineDistance2.YValues.Count := length(Form_UI.drawTimeX);
//        Form_UI.Series_LineDistance2.YValues.Modified := True;
//
//        Form_UI.Series_Line1Width.Repaint;
//        Form_UI.Series_Line1Height.Repaint;
//        Form_UI.Series_Line2Width.Repaint;
//        Form_UI.Series_Line2Height.Repaint;
//        Form_UI.Series_LineDistance1.Repaint;
//        Form_UI.Series_Line3Width.Repaint;
//        Form_UI.Series_Line3Height.Repaint;
//        Form_UI.Series_Line4Width.Repaint;
//        Form_UI.Series_Line4Height.Repaint;
//        Form_UI.Series_LineDistance2.Repaint;
//
//        Form_UI.calCounts := 0;
//      end;
//    end;
//
//    Sleep(5);
//
//    LeaveCriticalSection(Form_UI.CS);
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
  i: Byte;
  TempData2D: ^JCWJH;
begin
  if WaitForSingleObject(m_lock, INFINITE) = WAIT_OBJECT_0 then
  begin
    Form_UI.m_data := tempData;
    New(TempData2D);
    CopyMemory(TempData2D, @Form_UI.m_data, SizeOf(JCWJH));
    Form_UI.Data2DCache.Push(TempData2D);

//    if Form_UI.calCounts < 200 then
//    begin
//      Form_UI.m_data := tempData;
//      for I := 0 to 3 do
//      begin
//        Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth := Form_UI.m_data.jcx[i].pntLinePos.x;
//        Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight := Form_UI.m_data.jcx[i].pntLinePos.y;
//        Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue := Form_UI.m_data.jcxComp[i].pntLinePos.x;
//        Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue := Form_UI.m_data.jcxComp[i].pntLinePos.y;
//
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth <> 65536 then Form_UI.TempX[i] := Form_UI.m_data.jcx[i].pntLinePos.x;
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight <> 65536 then Form_UI.TempY[i] := Form_UI.m_data.jcx[i].pntLinePos.y;
//
//        //无效数据设为0
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth := Form_UI.TempX[i];
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight := Form_UI.TempY[i];
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue := 0;
//        if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue := 0;
//
//  //      //测试数据真实性
//  //      if Form_UI.data2DArray[0][Form_UI.calCounts].lineWidth > 60 then
//  //      begin
//  //        Sleep(5);
//  //      end;
//      end;
//
//      Inc(Form_UI.calCounts);
//    end;
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
  ;
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
          dxRibbonStatusBar.Panels[3].Text := '2D传感器已正常开始工作。';

          if not IsRun then
          begin
            ResumeThread(Form_UI.PCollectThread);
            ResumeThread(Form_UI.PProcessThread);
            ResumeThread(Form_UI.PDrawThread);
            IdUDPServer_Hv.Active := True;
            IdUDPServer_Lv.Active := True;
            IdUDPServer_Acying.Active := True;
            IsRun := True;
            UDPStartCollect;
            dxRibbonStatusBar.Panels[0].Text := '正在采集。';
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

procedure TForm_UI.Action_StartSaveExecute(Sender: TObject);
begin
  IsSave := True;
end;

procedure TForm_UI.Action_StopCalibrateExecute(Sender: TObject);
begin
  ;
end;

procedure TForm_UI.Action_StopCollectExecute(Sender: TObject);
var
  I: Byte;
  J: Word;
begin
  if IsRun then
  begin
    UDPStopCollect;
    SuspendThread(Form_UI.PCollectThread);
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
    dxRibbonStatusBar.Panels[0].Text := '已停止采集。';

    //为下次开始做准备
    counts:= 0;
    calCounts:= 0;
    drawCounts:= 0;
//    for I := 0 to 4 do
//    begin
//      for J := 0 to 199 do
//      begin
//        data2DArray[I][J].lineHeight := 0;
//        data2DArray[I][J].lineWidth := 0;
//        data2DArray[I][J].lineHeightValue := 0;
//        data2DArray[I][J].lineWidthValue := 0;
//      end;
//    end;
//    for I := 0 to 4 do
//    begin
//      for J := 0 to 999 do
//      begin
//        draw2DArray[I][J].lineHeight := 0;
//        draw2DArray[I][J].lineWidth := 0;
//        draw2DArray[I][J].lineHeightValue := 0;
//        draw2DArray[I][J].lineWidthValue := 0;
//      end;
//    end;
//    for J := 0 to 999 do drawTimeX[J] := (J + 1) * 0.005;

    Close2D;
    dxRibbonStatusBar.Panels[3].Text := '2D传感器已停止工作。';
  end;
end;

procedure TForm_UI.Action_StopSaveExecute(Sender: TObject);
begin
  IsSave := False;
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
//  I: Byte;
//  J: Word;
  I: Word;
  W: array [0..1] of Double;
  FirOrder: Integer;
begin
  RzPageControl.ActivePage := TabSheet_Conductor;

  //关联相应地址
  ErrorLogPath := ExtractFilePath(Application.ExeName)  + Ansistring('ErrorLog\ErrorLog.txt');
  ConfigurationFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\ConfigurationFile.txt');
  BackupFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\配置备份\ConfigurationFile.txt');
  SavedOriginalDataPath := ExtractFilePath(Application.ExeName) + AnsiString('SavedData\');
  SavedResultDataPath := ExtractFilePath(Application.ExeName) + AnsiString('DATA\');

  //2D初始化（导高拉出值）
  Set8087CW(DWord($133f));   //屏蔽错误用
  m_lock := CreateMutex(nil, False, nil);
  m_hjcw := Jcw_InitInstance();
  m_iDevid := JMID_GEO_DEV0;
  Jcw_SetResultCallBack(m_hjcw, self, @fnResultCallback);

  //2D初始化（点云数据）
  m_mutex := CreateMutex(nil, False, nil);
  m_hYEG := YEG_CreateInstance;
  YEG_SetScanPointCallBack(m_hYEG, @OnPointCould, Self);

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

  //创建线程
  PCollectThread := CreateThread(nil, 0, @SaveThread, nil, 4, FSaveThreadID);
  PProcessThread := CreateThread(nil, 0, @ProcessThread, nil, 4, FProcessThreadID);
  PDrawThread := CreateThread(nil, 0, @DrawThread, nil, 4, FDrawThreadID);

  Timer_InitSubGroup.Enabled := True;

  //布尔类型初始化
  IsRun := False;
  IsSave := False;
  IsPlayback := False;

//  for I := 0 to 1999 do
//  begin
//    Array_DataDeal[I] := 0;
//  end;

//  //计算绘图数组初始化
//  for I := 0 to 4 do
//  begin
//    for J := 0 to 199 do
//    begin
//      data2DArray[I][J].lineHeight := 0;
//      data2DArray[I][J].lineWidth := 0;
//      data2DArray[I][J].lineHeightValue := 0;
//      data2DArray[I][J].lineWidthValue := 0;
//    end;
//  end;
//  for I := 0 to 4 do
//  begin
//    for J := 0 to 999 do
//    begin
//      draw2DArray[I][J].lineHeight := 0;
//      draw2DArray[I][J].lineWidth := 0;
//      draw2DArray[I][J].lineHeightValue := 0;
//      draw2DArray[I][J].lineWidthValue := 0;
//    end;
//  end;
//  for J := 0 to 999 do drawTimeX[J] := (J + 1) * 0.005;

  //计算绘图技术点初始化
//  drawThreshold := 20;
  counts:= 0;
  calCounts:= 0;
  drawCounts:= 0;
end;

procedure TForm_UI.FormDestroy(Sender: TObject);
begin
  //线程销毁
  TerminateThread(PCollectThread, 0);
  TerminateThread(PProcessThread, 0);
  TerminateThread(PDrawThread, 0);

  //暂停UDP接收
  IdUDPServer_Hv.Active := False;
  IdUDPServer_Lv.Active := False;
  IdUDPServer_Acying.Active := False;

  Data2DCache.Free;
  HvUDPCache.Free;
  LvUDPCache.Free;
  AcyingCache.Free;
  DrawCache.Free;
  OriginalCache.Free;
  ResultCache.Free;

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
      Writeln(ConfigurationTextFile, '2DIP = 192.168.100.100');
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
      Writeln(ConfigurationTextFile, '点数 = 20');
      Writeln(ConfigurationTextFile, '');

      CloseFile(ConfigurationTextFile);
    End;

    IniFile := TIniFile.Create(ConfigurationFilePath);

    LineName := IniFile.ReadString('基础设置', '线路名称', '未知线路');

    TCPIP := IniFile.ReadString('传感器设置', '2DIP', '192.168.100.100');
    HvUDPIP := IniFile.ReadString('传感器设置', 'HvUDPIP', '10.10.10.2');
    HvUDPPort := IniFile.ReadString('传感器设置', 'HvUDPPort', '1025');
    LvUDPIP := IniFile.ReadString('传感器设置', 'LvUDPIP', '10.10.10.3');
    LvUDPPort := IniFile.ReadString('传感器设置', 'LvUDPPort', '1025');
    AcyingUDPIP := IniFile.ReadString('传感器设置', 'AcyingUDPIP', '10.10.10.4');
    AcyingUDPPort := IniFile.ReadString('传感器设置', 'AcyingUDPPort', '1025');

    Force := IniFile.ReadFloat('标定', 'Force', '0');
    Electricity := IniFile.ReadFloat('标定', 'Electricity', '0');
    Power_1 := IniFile.ReadFloat('标定', 'Power1', '0');
    Power_2 := IniFile.ReadFloat('标定', 'Power2', '0');
    Power_3 := IniFile.ReadFloat('标定', 'Power3', '0');
    Power_4 := IniFile.ReadFloat('标定', 'Power4', '0');
    ACC1 := IniFile.ReadFloat('标定', 'ACC1', '0');
    ACC2 := IniFile.ReadFloat('标定', 'ACC2', '0');
    ACC3 := IniFile.ReadFloat('标定', 'ACC3', '0');
    ACC4 := IniFile.ReadFloat('标定', 'ACC4', '0');
    ACC5 := IniFile.ReadFloat('标定', 'ACC5', '0');
    ACC6 := IniFile.ReadFloat('标定', 'ACC6', '0');

    IsDebug := IniFile.ReadInteger('调试', '调试', 1);
    drawThreshold := IniFile.ReadInteger('调试', '点数', 20);

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
  Sleep(52);
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
  IdUDPServer_Hv.SendBuffer('10.10.10.2', 1025, Buffer_Send);

  Buffer_Send[2] := 49;
  IdUDPServer_Lv.SendBuffer('10.10.10.3', 1025, Buffer_Send);

  Buffer_Send[2] := 50;
  IdUDPServer_Acying.SendBuffer('10.10.10.4', 1025, Buffer_Send);

  IdUDPServer_Hv.SendBuffer('192.168.3.100', 1025, Buffer_Send);
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
  IdUDPServer_Hv.SendBuffer('10.10.10.2', 1025, Buffer_Send);

  Buffer_Send[2] := 49;
  IdUDPServer_Lv.SendBuffer('10.10.10.3', 1025, Buffer_Send);

  Buffer_Send[2] := 50;
  IdUDPServer_Acying.SendBuffer('10.10.10.4', 1025, Buffer_Send);

  IdUDPServer_Hv.SendBuffer('192.168.3.100', 1025, Buffer_Send);
end;

end.
