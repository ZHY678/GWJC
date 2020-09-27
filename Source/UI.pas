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
  UI_SensorSetting;

type
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
  private
    { Private declarations }
    errorLogPath, configurationFilePath, backupFilePath, savedOriginalDataPath, savedResultDataPath: String;   //�����ļ�·��

    m_hjcw: Pointer;
    m_iDevid: JMDEVID;

    m_hYEG: Pointer;   //ָ���Cardinal������

    FGlobalpara: TGlobalpara;

    procedure InitFolder;
    procedure InitConfigurationFile;
    procedure InitSubGroup;
  public
    { Public declarations }
    PCollectThread, PProcessThread, PDrawThread: DWORD;   //�����߳�
  end;

var
  Form_UI: TForm_UI;

implementation

{$R *.dfm}

function CollectThread(p: Pointer): Integer; stdcall;
begin
  ;
end;

function ProcessThread(p: Pointer): Integer; stdcall;
begin
  ;
end;


function DrawThread(p: Pointer): Integer; stdcall;
begin
  ;
end;

procedure OnPointCould(pTag: Pointer; dtimestamp: Double; uiframeNo: Int64; potArray: PPOINTF; uiPotNum: Cardinal); cdecl;
var
  i : cardinal;
begin
  if WaitForSingleObject(m_mutex, INFINITE) = WAIT_OBJECT_0 then
  begin
    if uiPotNum > 5 then
    begin
      Setlength(m_vecPot, uiPotNum);
      for i := 0 to uiPotNum - 1 do
      begin
        m_vecPot[i] := potArray[i];
      end;
    end;
    m_dTimeStampLast := dtimestamp;
    m_uiFrameNo := uiframeNo;
    m_uiFrameRecvCount := m_uiFrameRecvCount + 1;
    m_uiPotNum := uiPotNum;
  end;
  ReleaseMutex(m_mutex);
end;

procedure fnResultCallback(const pTag: Pointer; const tempData: JCWJH); cdecl;
begin
  if WaitForSingleObject(m_lock, INFINITE) = WAIT_OBJECT_0 then
  begin
    m_data := tempData;
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
  ResumeThread(Form_UI.PCollectThread);
  ResumeThread(Form_UI.PProcessThread);
  ResumeThread(Form_UI.PDrawThread);
end;

procedure TForm_UI.Action_StopCollectExecute(Sender: TObject);
begin
  SuspendThread(Form_UI.PCollectThread);
  SuspendThread(Form_UI.PProcessThread);
  SuspendThread(Form_UI.PDrawThread);
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
begin
  RzPageControl.ActivePage := TabSheet_Conductor;

  //������Ӧ��ַ
  ErrorLogPath := ExtractFilePath(Application.ExeName)  + Ansistring('ErrorLog\ErrorLog.txt');
  ConfigurationFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\ConfigurationFile.txt');
  BackupFilePath := ExtractFilePath(Application.ExeName) + AnsiString('ConfigurationFile\���ñ���\ConfigurationFile.txt');
  SavedOriginalDataPath := ExtractFilePath(Application.ExeName) + AnsiString('SavedData\');
  SavedResultDataPath := ExtractFilePath(Application.ExeName) + AnsiString('DATA\');

  InitFolder;
  InitConfigurationFile;
  InitSubGroup;

  FGlobalpara.DataSelfDelete(SavedOriginalDataPath, 20.0);    //������ɾ�������·���ǲ����ڵ�·���ǲ�������
  FGlobalpara.DataSelfDelete(SavedResultDataPath, 20.0);    //������ɾ��

  //�����߳�
  PCollectThread := CreateThread(nil, 0, @CollectThread, nil, 4, FCollectThreadID);
  PProcessThread := CreateThread(nil, 0, @ProcessThread, nil, 4, FProcessThreadID);
  PDrawThread := CreateThread(nil, 0, @DrawThread, nil, 4, FDrawThreadID);

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
end;

procedure TForm_UI.TimerTimer(Sender: TObject);
begin
  dxRibbonStatusBar.Panels[6].Text := FormatDateTime('yyyy��mm��dd�� hh:nn:ss', Now);
end;

procedure TForm_UI.InitFolder;
begin
  if not DirectoryExists(ExtractFilePath(ErrorLogPath)) then ForceDirectories(ExtractFilePath(ErrorLogPath));
  if not DirectoryExists(ExtractFilePath(BackupFilePath)) then ForceDirectories(ExtractFilePath(BackupFilePath));
  if not DirectoryExists(ExtractFilePath(SavedOriginalDataPath)) then ForceDirectories(ExtractFilePath(SavedOriginalDataPath));
  if not DirectoryExists(ExtractFilePath(SavedResultDataPath)) then ForceDirectories(ExtractFilePath(SavedResultDataPath));
end;

procedure TForm_UI.InitConfigurationFile;
//var
//  ConfigurationTextFile : TextFile;
//  IniFile : TIniFile;
begin
//  try
//    AssignFile(ConfigurationTextFile, ConfigurationFilePath);
//    if not FileExists(ConfigurationFilePath) then
//    Begin
//      Rewrite(ConfigurationTextFile);
//      Writeln(ConfigurationTextFile, '[SenSorSetting]');
//      Writeln(ConfigurationTextFile, '');
//
//      Writeln(ConfigurationTextFile, '[ParameticCorrection]');
//      Writeln(ConfigurationTextFile, 'IsThermalCompensation = 0');
//      Writeln(ConfigurationTextFile, 'UpperSensorAngle = 0');
//      Writeln(ConfigurationTextFile, 'LowerSensorAngle = 0');
//      Writeln(ConfigurationTextFile, 'SensorsDistance = 0');
//      Writeln(ConfigurationTextFile, '');
//
//      Writeln(ConfigurationTextFile, '[CalibrationParameter]');
//      Writeln(ConfigurationTextFile, 'UpperLineMeanValue = 0');
//      Writeln(ConfigurationTextFile, 'LowerLineMeanValue = 0');
//      Writeln(ConfigurationTextFile, 'UpperSensorTemperature = 0');
//      Writeln(ConfigurationTextFile, 'LowerSensorTemperature = 0');
//      Writeln(ConfigurationTextFile, '');
//
//      Writeln(ConfigurationTextFile, '[Debug]');
//      Writeln(ConfigurationTextFile, 'IsDebug = 0');
//      Writeln(ConfigurationTextFile, 'IsShow3D = 0');
//
//      CloseFile(ConfigurationTextFile);
//    End;
//
//    IniFile := TIniFile.Create(ConfigurationFilePath);
//
//    GConfigParameter.IsThermalCompensation := IniFile.ReadInteger('ParameticCorrection', 'IsThermalCompensation', 0);
//    GConfigParameter.UpperSensorAngle := IniFile.ReadFloat('ParameticCorrection', 'UpperSensorAngle', 0);
//    GConfigParameter.LowerSensorAngle := IniFile.ReadFloat('ParameticCorrection', 'LowerSensorAngle', 0);
//    GConfigParameter.SensorsDistance := IniFile.ReadFloat('ParameticCorrection', 'SensorsDistance', 0);
//
//    GConfigParameter.UpperLineMeanValue := IniFile.ReadFloat('CalibrationParameter', 'UpperLineMeanValue', 0);
//    GConfigParameter.LowerLineMeanValue := IniFile.ReadFloat('CalibrationParameter', 'LowerLineMeanValue', 0);
//    GConfigParameter.UpperSensorTemperature := IniFile.ReadFloat('CalibrationParameter', 'UpperSensorTemperature', 0);
//    GConfigParameter.LowerSensorTemperature := IniFile.ReadFloat('CalibrationParameter', 'LowerSensorTemperature', 0);
//
//    GConfigParameter.IsDebug := IniFile.ReadInteger('Debug', 'IsDebug', 0);
//    GConfigParameter.IsShow3D := IniFile.ReadInteger('Debug', 'IsShow3D', 0);
//
//    IniFile.Free;
//
//    GConfigParameter.StandardThickness := StrToFloat(StandardEdit.Text);
//    GConfigParameter.CenterPoint := StrToFloat(CenterPointEdit.Text);
//
//    if (GConfigParameter.IsThermalCompensation > 1) Or (GConfigParameter.IsDebug > 1) then
//    begin
//      RibbonStatusBar.Panels[2].Text := '�����ʼ��ʧ�ܣ����������ļ���';
//      OpenSensorLargeButton.Enabled := False;
//      CloseSensorLargeButton.Enabled := False;
//    end;
//
//    if GConfigParameter.IsDebug > 0 then DebugTab.Visible := True
//    else DebugTab.Visible := False;
//
//    InitCalibPara;
//
//  except
//    On E : Exception Do
//    begin
//      FGlobalpara.ShowAndSaveErrorLog(ErrorLogPath, 'InitConfigurationFile', E.Message, False);
//      RibbonStatusBar.Panels[2].Text := '�����ʼ��ʧ�ܣ����������ļ���';
//      OpenSensorLargeButton.Enabled := False;
//      CloseSensorLargeButton.Enabled := False;
//    end;
//  end;
end;

procedure TForm_UI.InitSubGroup;
begin
//  StartMeasureLargeButton.Enabled := False;
//  StopMeasureLargeButton.Enabled := False;
//  dxBarLargeButton_Show3D.Enabled := False;
//  dxBarLargeButton_Hide3D.Enabled := False;
//  RzPageControl.ActivePage := DetectionTabSheet;
//
//  OUpperAngleEdit.Text := FloatToStr(GConfigParameter.UpperSensorAngle);
//  OLowerAngleEdit.Text := FloatToStr(GConfigParameter.LowerSensorAngle);
//  OUpperValueEdit.Text := FloatToStr(GConfigParameter.UpperLineMeanValue);
//  OLowerValueEdit.Text := FloatToStr(GConfigParameter.LowerLineMeanValue);
//  OSensorDistanceEdit.Text := FloatToStr(GConfigParameter.SensorsDistance);
//  OUpperTempEdit.Text := FloatToStr(GConfigParameter.UpperSensorTemperature);
//  OLowerTempEdit.Text := FloatToStr(GConfigParameter.LowerSensorTemperature);
end;

end.
