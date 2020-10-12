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
  UI_SensorSetting, System.IniFiles;

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
  private
    { Private declarations }
    errorLogPath, backupFilePath, savedOriginalDataPath, savedResultDataPath: String;   //�����ļ�·��
    LineName, TCPIP, UDPIP, UDPPort: string;
    IsDebug: Byte;

    FGlobalpara: TGlobalpara;

    procedure InitFolder;
    procedure InitConfigurationFile;
    procedure InitSubGroup;
    function JCWSetIP(tempTCPIP: string): Integer;
    function YEGConnect(tempTCPIP: string): Integer;
    procedure YEGDisconnect;
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

    PCollectThread, PProcessThread, PDrawThread: DWORD;   //�����߳�
    configurationFilePath: string;

    CS: TRTLCriticalSection;

    data2DArray: array[0..4] of array[0..199] of data2D;
    draw2DArray: array[0..4] of array[0..999] of data2D;
    drawTimeX: array[0..999] of Single;
    calCounts, drawCounts: Word;
    TempX, TempY : array [0..3] of Single;

    IsRun, IsSave, IsPlayback: Boolean;

    function Init2DIP: Integer;
    function Open2D: Integer;
    procedure Close2D;
  end;

var
  Form_UI: TForm_UI;

implementation

{$R *.dfm}

function CollectThread(p: Pointer): Integer; stdcall;
begin
  while True do
  begin
    ;
  end;
end;

function ProcessThread(p: Pointer): Integer; stdcall;
begin
  while True do
  begin
    ;
  end;
end;

function DrawThread(p: Pointer): Integer; stdcall;
var
  I: Byte;
  J: Word;
  Series_Line1WidthValues, Series_Line1HeightValues, Series_Line2WidthValues, Series_Line2HeightValues, Series_LineDistance1Values,
  Series_Line3WidthValues, Series_Line3HeightValues, Series_Line4WidthValues, Series_Line4HeightValues, Series_LineDistance2Values,
  ValuesX: TChartValues;
begin
//  Synchronize();
  while True do
  begin


    //���²���ֻ������2D200HZƵ�ʲɼ���ͼ��ʾ����Ϊ��û���ٶ��źŵģ�����ֻ���ɼ���ͼ������
    EnterCriticalSection(Form_UI.CS);
    if Form_UI.calCounts > 199 then
    begin
//      //��ֵ����鸳ֵ����
//      for J := 0 to 199 do
//      begin
//        if Form_UI.data2DArray[1][J].lineWidth <> 0 then
//        begin
//          Form_UI.data2DArray[4][J].lineWidth := Abs(Form_UI.data2DArray[1][J].lineWidth - Form_UI.data2DArray[0][J].lineWidth);
//          Form_UI.data2DArray[4][J].lineHeight := Abs(Form_UI.data2DArray[1][J].lineHeight - Form_UI.data2DArray[0][J].lineHeight);
//        end;
//        if Form_UI.data2DArray[3][J].lineWidth <> 0 then
//        begin
//          Form_UI.data2DArray[4][J].lineWidthValue := Abs(Form_UI.data2DArray[3][J].lineWidth - Form_UI.data2DArray[2][J].lineWidth);
//          Form_UI.data2DArray[4][J].lineHeightValue := Abs(Form_UI.data2DArray[3][J].lineHeight - Form_UI.data2DArray[2][J].lineHeight);
//        end;
//      end;

      if Form_UI.drawCounts < 5 then
      begin
        for I := 0 to 3 do
        begin
          for J := 0 to 199 do
          begin
            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineWidth := Form_UI.data2DArray[I][J].lineWidth;
            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineHeight := Form_UI.data2DArray[I][J].lineHeight;
            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineWidthValue := Form_UI.data2DArray[I][J].lineWidthValue;
            Form_UI.draw2DArray[I][J + Form_UI.drawCounts * 200].lineHeightValue := Form_UI.data2DArray[I][J].lineHeightValue;
          end;
        end;
        Form_UI.drawCounts := Form_UI.drawCounts + 1;
      end
      else
      begin
        for I := 0 to 3 do
        begin
          for J := 200 to 999 do
          begin
            Form_UI.draw2DArray[I][J - 200].lineWidth := Form_UI.draw2DArray[I][J].lineWidth;
            Form_UI.draw2DArray[I][J - 200].lineHeight := Form_UI.draw2DArray[I][J].lineHeight;
            Form_UI.draw2DArray[I][J - 200].lineWidthValue := Form_UI.draw2DArray[I][J].lineWidthValue;
            Form_UI.draw2DArray[I][J - 200].lineHeightValue := Form_UI.draw2DArray[I][J].lineHeightValue;
          end;
        end;
        for I := 0 to 3 do
        begin
          for J := 800 to 999 do
          begin
            Form_UI.draw2DArray[I][J].lineWidth := Form_UI.data2DArray[I][J - 800].lineWidth;
            Form_UI.draw2DArray[I][J].lineHeight := Form_UI.data2DArray[I][J - 800].lineHeight;
            Form_UI.draw2DArray[I][J].lineWidthValue := Form_UI.data2DArray[I][J - 800].lineWidthValue;
            Form_UI.draw2DArray[I][J].lineHeightValue := Form_UI.data2DArray[I][J - 800].lineHeightValue;
          end;
        end;
        for J := 0 to 999 do Form_UI.drawTimeX[J] := Form_UI.drawTimeX[J] + 1;
      end;

      SetLength(Series_Line1WidthValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line1HeightValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line2WidthValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line2HeightValues, length(Form_UI.drawTimeX));
      SetLength(Series_LineDistance1Values, length(Form_UI.drawTimeX));
      SetLength(Series_Line3WidthValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line3HeightValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line4WidthValues, length(Form_UI.drawTimeX));
      SetLength(Series_Line4HeightValues, length(Form_UI.drawTimeX));
      SetLength(Series_LineDistance2Values, length(Form_UI.drawTimeX));
      SetLength(ValuesX, length(Form_UI.drawTimeX));

//      //������鸳ֵ����
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
//        ValuesX[J] := Form_UI.drawTimeX[J];
//      end;

      for J := 0 to 999 do
      begin
        Series_Line1WidthValues[J] := Form_UI.draw2DArray[0][J].lineWidth;
        Series_Line1HeightValues[J] := Form_UI.draw2DArray[0][J].lineHeight;
        Series_Line2WidthValues[J] := Form_UI.draw2DArray[1][J].lineWidth;
        Series_Line2HeightValues[J] := Form_UI.draw2DArray[1][J].lineHeight;
        Series_LineDistance1Values[J] := Form_UI.data2DArray[4][J].lineWidth;
        Series_Line3WidthValues[J] := Form_UI.draw2DArray[2][J].lineWidth;
        Series_Line3HeightValues[J] := Form_UI.draw2DArray[2][J].lineHeight;
        Series_Line4WidthValues[J] := Form_UI.draw2DArray[3][J].lineWidth;
        Series_Line4HeightValues[J] := Form_UI.draw2DArray[3][J].lineHeight;
        Series_LineDistance2Values[J] := Form_UI.data2DArray[4][J].lineWidthValue;
        if Series_Line2WidthValues[J] <> 0 then
        begin
          Series_LineDistance1Values[J] := Abs(Series_Line2WidthValues[J] - Series_Line1WidthValues[J]);
        end
        else Series_LineDistance1Values[J] := 0;
        if Series_Line4WidthValues[J] <> 0 then
        begin
          Series_LineDistance2Values[J] := Abs(Series_Line4WidthValues[J] - Series_Line3WidthValues[J]);
        end
        else Series_LineDistance2Values[J] := 0;
        ValuesX[J] := Form_UI.drawTimeX[J];
      end;

      //���߻�ͼ
      Form_UI.Series_Line1Width.XValues.Value := ValuesX;
      Form_UI.Series_Line1Width.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line1Width.XValues.Modified := True;

      Form_UI.Series_Line1Height.XValues.Value := ValuesX;
      Form_UI.Series_Line1Height.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line1Height.XValues.Modified := True;

      Form_UI.Series_Line2Width.XValues.Value := ValuesX;
      Form_UI.Series_Line2Width.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line2Width.XValues.Modified := True;

      Form_UI.Series_Line2Height.XValues.Value := ValuesX;
      Form_UI.Series_Line2Height.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line2Height.XValues.Modified := True;

      Form_UI.Series_LineDistance1.XValues.Value := ValuesX;
      Form_UI.Series_LineDistance1.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_LineDistance1.XValues.Modified := True;

      Form_UI.Series_Line3Width.XValues.Value := ValuesX;
      Form_UI.Series_Line3Width.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line3Width.XValues.Modified := True;

      Form_UI.Series_Line3Height.XValues.Value := ValuesX;
      Form_UI.Series_Line3Height.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line3Height.XValues.Modified := True;

      Form_UI.Series_Line4Width.XValues.Value := ValuesX;
      Form_UI.Series_Line4Width.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line4Width.XValues.Modified := True;

      Form_UI.Series_Line4Height.XValues.Value := ValuesX;
      Form_UI.Series_Line4Height.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line4Height.XValues.Modified := True;

      Form_UI.Series_LineDistance2.XValues.Value := ValuesX;
      Form_UI.Series_LineDistance2.XValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_LineDistance2.XValues.Modified := True;

      Form_UI.Series_Line1Width.YValues.Value := Series_Line1WidthValues;
      Form_UI.Series_Line1Width.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line1Width.YValues.Modified := True;

      Form_UI.Series_Line1Height.YValues.Value := Series_Line1HeightValues;
      Form_UI.Series_Line1Height.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line1Height.YValues.Modified := True;

      Form_UI.Series_Line2Width.YValues.Value := Series_Line2WidthValues;
      Form_UI.Series_Line2Width.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line2Width.YValues.Modified := True;

      Form_UI.Series_Line2Height.YValues.Value := Series_Line2HeightValues;
      Form_UI.Series_Line2Height.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line2Height.YValues.Modified := True;

      Form_UI.Series_LineDistance1.YValues.Value := Series_LineDistance1Values;
      Form_UI.Series_LineDistance1.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_LineDistance1.YValues.Modified := True;

      Form_UI.Series_Line3Width.YValues.Value := Series_Line3WidthValues;
      Form_UI.Series_Line3Width.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line3Width.YValues.Modified := True;

      Form_UI.Series_Line3Height.YValues.Value := Series_Line3HeightValues;
      Form_UI.Series_Line3Height.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line3Height.YValues.Modified := True;

      Form_UI.Series_Line4Width.YValues.Value := Series_Line4WidthValues;
      Form_UI.Series_Line4Width.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line4Width.YValues.Modified := True;

      Form_UI.Series_Line4Height.YValues.Value := Series_Line4HeightValues;
      Form_UI.Series_Line4Height.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_Line4Height.YValues.Modified := True;

      Form_UI.Series_LineDistance2.YValues.Value := Series_LineDistance2Values;
      Form_UI.Series_LineDistance2.YValues.Count := length(Form_UI.drawTimeX);
      Form_UI.Series_LineDistance2.YValues.Modified := True;

      Form_UI.Series_Line1Width.Repaint;
      Form_UI.Series_Line1Height.Repaint;
      Form_UI.Series_Line2Width.Repaint;
      Form_UI.Series_Line2Height.Repaint;
      Form_UI.Series_LineDistance1.Repaint;
      Form_UI.Series_Line3Width.Repaint;
      Form_UI.Series_Line3Height.Repaint;
      Form_UI.Series_Line4Width.Repaint;
      Form_UI.Series_Line4Height.Repaint;
      Form_UI.Series_LineDistance2.Repaint;

      Sleep(5);
          
      Form_UI.calCounts := 0;
    end;

    LeaveCriticalSection(Form_UI.CS);
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
begin
  if WaitForSingleObject(m_lock, INFINITE) = WAIT_OBJECT_0 then
  begin
    Form_UI.m_data := tempData;
    for I := 0 to 3 do
    begin
      Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth := Form_UI.m_data.jcx[i].pntLinePos.x;
      Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight := Form_UI.m_data.jcx[i].pntLinePos.y;
      Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue := Form_UI.m_data.jcxComp[i].pntLinePos.x;
      Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue := Form_UI.m_data.jcxComp[i].pntLinePos.y;

      if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth <> 65536 then Form_UI.TempX[i] := Form_UI.m_data.jcx[i].pntLinePos.x;
      if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight <> 65536 then Form_UI.TempY[i] := Form_UI.m_data.jcx[i].pntLinePos.y;

      //��Ч������Ϊ0
      if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineWidth := Form_UI.TempX[i];
      if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineHeight := Form_UI.TempY[i];
      if Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineWidthValue := 0;
      if Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue = 65536 then Form_UI.data2DArray[i][Form_UI.calCounts].lineHeightValue := 0;

//      //����������ʵ��
//      if Form_UI.data2DArray[0][Form_UI.calCounts].lineWidth > 60 then
//      begin
//        Sleep(5);
//      end;
    end;

    Inc(Form_UI.calCounts);
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

procedure TForm_UI.Action_StartCollectExecute(Sender: TObject);
begin
  case Init2DIP of
    0:
    begin
      case Open2D of
        0:
        begin
          dxRibbonStatusBar.Panels[3].Text := '2D��������������ʼ������';

          if not IsRun then
          begin
            ResumeThread(Form_UI.PCollectThread);
            ResumeThread(Form_UI.PProcessThread);
            ResumeThread(Form_UI.PDrawThread);
            IsRun := True;
            dxRibbonStatusBar.Panels[0].Text := '���ڲɼ���';
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

procedure TForm_UI.Action_StopCollectExecute(Sender: TObject);
var
  I: Byte;
  J: Word;
begin
  if IsRun then
  begin
    SuspendThread(Form_UI.PCollectThread);
    SuspendThread(Form_UI.PProcessThread);
    SuspendThread(Form_UI.PDrawThread);
    IsRun := False;
    dxRibbonStatusBar.Panels[0].Text := '��ֹͣ�ɼ���';
  end;

  //Ϊ�´ο�ʼ��׼��
  calCounts:= 0;
  drawCounts:= 0;
  for I := 0 to 4 do
  begin
    for J := 0 to 199 do
    begin
      data2DArray[I][J].lineHeight := 0;
      data2DArray[I][J].lineWidth := 0;
      data2DArray[I][J].lineHeightValue := 0;
      data2DArray[I][J].lineWidthValue := 0;
    end;
  end;
  for I := 0 to 4 do
  begin
    for J := 0 to 999 do
    begin
      draw2DArray[I][J].lineHeight := 0;
      draw2DArray[I][J].lineWidth := 0;
      draw2DArray[I][J].lineHeightValue := 0;
      draw2DArray[I][J].lineWidthValue := 0;
    end;
  end;
  for J := 0 to 999 do drawTimeX[J] := (J + 1) * 0.005;

  Close2D;
  dxRibbonStatusBar.Panels[3].Text := '2D��������ֹͣ������';
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
  FCollectThreadID, FProcessThreadID, FDrawThreadID: DWORD;   //�����߳�ID,THandle����
  I: Byte;
  J: Word;
begin
  RzPageControl.ActivePage := TabSheet_Conductor;

  //������Ӧ��ַ
  ErrorLogPath := ExtractFilePath(Application.ExeName)  + Ansistring('ErrorLog\ErrorLog.txt');
  ConfigurationFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\ConfigurationFile.txt');
  BackupFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\���ñ���\ConfigurationFile.txt');
  SavedOriginalDataPath := ExtractFilePath(Application.ExeName) + AnsiString('SavedData\');
  SavedResultDataPath := ExtractFilePath(Application.ExeName) + AnsiString('DATA\');

  //2D��ʼ������������ֵ��
  Set8087CW(DWord($133f));   //���δ�����
  m_lock := CreateMutex(nil, False, nil);
  m_hjcw := Jcw_InitInstance();
  m_iDevid := JMID_GEO_DEV0;
  Jcw_SetResultCallBack(m_hjcw, self, @fnResultCallback);

  //2D��ʼ�����������ݣ�
  m_mutex := CreateMutex(nil, False, nil);
  m_hYEG := YEG_CreateInstance;
  YEG_SetScanPointCallBack(m_hYEG, @OnPointCould, Self);

  InitFolder;
  InitConfigurationFile;

  FGlobalpara.DataSelfDelete(SavedOriginalDataPath, 20.0);    //������ɾ�������·���ǲ����ڵ�·���ǲ�������
  FGlobalpara.DataSelfDelete(SavedResultDataPath, 20.0);    //������ɾ��

  InitializeCriticalSection(CS);

  //�����߳�
  PCollectThread := CreateThread(nil, 0, @CollectThread, nil, 4, FCollectThreadID);
  PProcessThread := CreateThread(nil, 0, @ProcessThread, nil, 4, FProcessThreadID);
  PDrawThread := CreateThread(nil, 0, @DrawThread, nil, 4, FDrawThreadID);

  Timer_InitSubGroup.Enabled := True;

  //�������ͳ�ʼ��
  IsRun := False;
  IsSave := False;
  IsPlayback := False;

  //�����ͼ�����ʼ��
  for I := 0 to 4 do
  begin
    for J := 0 to 199 do
    begin
      data2DArray[I][J].lineHeight := 0;
      data2DArray[I][J].lineWidth := 0;
      data2DArray[I][J].lineHeightValue := 0;
      data2DArray[I][J].lineWidthValue := 0;
    end;
  end;
  for I := 0 to 4 do
  begin
    for J := 0 to 999 do
    begin
      draw2DArray[I][J].lineHeight := 0;
      draw2DArray[I][J].lineWidth := 0;
      draw2DArray[I][J].lineHeightValue := 0;
      draw2DArray[I][J].lineWidthValue := 0;
    end;
  end;
  for J := 0 to 999 do drawTimeX[J] := (J + 1) * 0.005;

  //�����ͼ�������ʼ��
  calCounts:= 0;
  drawCounts:= 0;
end;

procedure TForm_UI.FormDestroy(Sender: TObject);
begin
  //�߳�����
  TerminateThread(PCollectThread, 0);
  TerminateThread(PProcessThread, 0);
  TerminateThread(PDrawThread, 0);

  //2D����
  CloseHandle(m_mutex);
  CloseHandle(m_lock);

  DeleteCriticalSection(CS);
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
      Writeln(ConfigurationTextFile, 'UDPIP = 10.10.10.11');
      Writeln(ConfigurationTextFile, 'UDPPort = 1025');
      Writeln(ConfigurationTextFile, '');

      Writeln(ConfigurationTextFile, '[����]');
      Writeln(ConfigurationTextFile, '���� = 0');
      Writeln(ConfigurationTextFile, '');

      CloseFile(ConfigurationTextFile);
    End;

    IniFile := TIniFile.Create(ConfigurationFilePath);

    LineName := IniFile.ReadString('��������', '��·����', '');

    TCPIP := IniFile.ReadString('����������', '2DIP', '');
    UDPIP := IniFile.ReadString('����������', 'UDPIP', '');
    UDPPort := IniFile.ReadString('����������', 'UDPPort', '');

    IsDebug := IniFile.ReadInteger('����', '����', 0);

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

  division := UDPIP.Split(['.']);
  for i := 0 to 3 do
  begin
    case i of
      0: Form_Sensor.Edit_UDPIP1.Text := division[i];
      1: Form_Sensor.Edit_UDPIP2.Text := division[i];
      2: Form_Sensor.Edit_UDPIP3.Text := division[i];
      3: Form_Sensor.Edit_UDPIP4.Text := division[i];
    end;
  end;

  Form_Sensor.Edit_UDPPort.Text := UDPPort;
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

end.
