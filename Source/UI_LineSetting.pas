unit UI_LineSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, UGlobalpara;

type
  TForm_LineSetting = class(TForm)
    Panel_Kilometer: TPanel;
    Panel_KilometerSetting: TPanel;
    Panel_StreamSetting: TPanel;
    Panel_Stream: TPanel;
    Label_Kilometer: TLabel;
    Label_Line: TLabel;
    Edit_Kilometer: TEdit;
    ComboBox_Line: TComboBox;
    RadioButton_Up: TRadioButton;
    RadioButton_Down: TRadioButton;
    Panel_DirectionSetting: TPanel;
    RadioButton_Front: TRadioButton;
    RadioButton_Back: TRadioButton;
    Panel_Dirction: TPanel;
    Panel_AddAndSubStractSetting: TPanel;
    RadioButton_Add: TRadioButton;
    RadioButton_Substract: TRadioButton;
    Panel_AddAndSubStract: TPanel;
    Panel_Setting: TPanel;
    Panel_SettingSet: TPanel;
    Button_Set: TButton;
    Button_Start: TButton;
    Label_Pole: TLabel;
    Edit_Pole: TEdit;
    Panel_JiaAndJjian: TPanel;
    RadioButton_Jia: TRadioButton;
    RadioButton_Jian: TRadioButton;
    Panel_Ganjiajian: TPanel;
    procedure Button_StartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button_SetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGlobalpara: TGlobalpara;
  public
    { Public declarations }
    kilometer: Double;
    line_name, shangxiaxing, direction: string;
    plus_minus, Pole_Zengjian: Byte;
    Pole_InitNumber: Integer;       //��ʼ�����˺�
    record_gh: Integer;   //��ͼ�˺ż����ж�
  end;

var
  Form_LineSetting: TForm_LineSetting;

implementation

uses
  UI;

{$R *.dfm}

procedure TForm_LineSetting.Button_SetClick(Sender: TObject);
begin
  if (not (FGlobalpara.IsNumberType(Edit_Kilometer.Text) <> 0)) or (not (FGlobalpara.IsNumberType(Edit_Pole.Text) = 1) or ((StrToInt(Edit_Pole.Text) < 0))) then MessageBox(Handle, '�������ʼ�˺������ֵ�������⣬���顣', '��·����', MB_OK)
  else
  begin
    if Length(ComboBox_Line.Text) = 0 then MessageBox(Handle, 'δѡ����·���ƣ����顣', '��·����', MB_OK)
    else
    begin
      if not (RadioButton_Up.Checked or RadioButton_Down.Checked) then MessageBox(Handle, 'δѡ�������У����顣', '��·����', MB_OK)
      else
      begin
        if not (RadioButton_Front.Checked or RadioButton_Back.Checked) then MessageBox(Handle, 'δѡ�����������顣', '��·����', MB_OK)
        else
        begin
          if not (RadioButton_Add.Checked or RadioButton_Substract.Checked) then MessageBox(Handle, 'δѡ������ݼ������顣', '��·����', MB_OK)
          else
          begin
            if MessageBox(Handle, '��ȷ��Ҫ������', '��·����', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
            begin
              kilometer := StrToFloat(Edit_Kilometer.Text);
              Pole_InitNumber := StrToInt(Edit_Pole.Text);
              record_gh := Pole_InitNumber;
              line_name := ComboBox_Line.Text;
              if RadioButton_Up.Checked then shangxiaxing := '����'
              else shangxiaxing := '����';
              if RadioButton_Front.Checked then direction := '����'
              else direction := '����';
              if RadioButton_Add.Checked then plus_minus := 1
              else plus_minus := 0;
              if RadioButton_Jia.Checked then Pole_Zengjian := 1
              else Pole_Zengjian := 0;
              Form_UI.dxRibbonStatusBar.Panels[4].Text := '��·״����' + shangxiaxing + direction + '��';
              Form_UI.dxRibbonStatusBar.Panels[5].Text := '����꣺' + FloatToStr(kilometer) + 'km';
              MessageBox(handle, '���óɹ���', '��Ϣ��ʾ', MB_OK);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm_LineSetting.Button_StartClick(Sender: TObject);
begin
  if MessageBox(Handle, '��ȷ��Ҫ��ʼ��', '��·����', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
  begin
    case Form_UI.Init2DIP of
      0:
      begin
        case Form_UI.Open2D of
          0:
          begin
            Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������������ʼ������';

            if not Form_UI.IsRun then
            begin
              Form_UI.Counts_Package := 0;
              Form_UI.Counts_Save := 0;
              Form_UI.Counts_Number := 0;
              Form_UI.StartMs := GetTickCount;
              Form_UI.startTime := FormatDateTime('yymmddhhnnss', Now);
              Form_UI.Data2DCache.clear;
              Form_UI.HvUDPCache.clear;
              Form_UI.LvUDPCache.clear;
              Form_UI.AcyingCache.clear;
              Form_UI.DrawCache.clear;
              Form_UI.OriginalCache.clear;
              ResumeThread(Form_UI.PSaveThread);
              ResumeThread(Form_UI.PProcessThread);
              Form_UI.FDrawThread.Resume;
              if not Form_UI.IsSave then Form_UI.TempOrignalDataPath := Form_UI.SavedOriginalDataPath + FormatDateTime('yyyymmddhhnnss', Now) + '.dat';
              Form_UI.Action_StartSaveExecute(Sender);
              Form_UI.IsRun := True;
              Form_UI.Counts_Package := 0;
              Form_UI.Counts_Save := 0;
              Form_UI.UDPStartCollect;
              Form_UI.IdUDPServer_Acying.Active := True;
              Form_UI.dxRibbonStatusBar.Panels[0].Text := '���ڲɼ���';
              Form_UI.dxRibbonStatusBar.Panels[1].Text := '���ڴ洢���ݡ�';
              Form_UI.dxRibbonStatusBar.Panels[4].Text := '��·״����' + shangxiaxing + direction + '��';
              Form_UI.dxRibbonStatusBar.Panels[5].Text := '����꣺' + FloatToStr(Form_LineSetting.kilometer) + 'km   �ٶȣ�0km/h';
            end;
          end;
          -1: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D����������δ֪����';
          -2: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч��ʵ�������';
          -3: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч�豸ID��';
          -4: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D�����������������ܸ������á�';
          -5: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D������δ���������ܸ������á�';
          -6: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч����ֵ������������Ч��Χ�����߲��������Ч��';
          -404: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D������δʵ�֡�';
        end;
      end;
      -1: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D����������δ֪����';
      -2: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч��ʵ�������';
      -3: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч�豸ID��';
      -4: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D�����������������ܸ������á�';
      -5: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D������δ���������ܸ������á�';
      -6: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D��������Ч����ֵ������������Ч��Χ�����߲��������Ч��';
      -404: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D������δʵ�֡�';
    end;
  end;
end;

procedure TForm_LineSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Form_UI.Enabled := True;
end;

procedure TForm_LineSetting.FormCreate(Sender: TObject);
begin
  kilometer := 0;
  line_name := 'δ֪��·';
  shangxiaxing := '����';
  direction := '����';
  plus_minus := 1;
  Pole_Zengjian := 1;
  Pole_InitNumber := 0;
  record_gh := 0;
end;

procedure TForm_LineSetting.FormShow(Sender: TObject);
begin
  Form_UI.Enabled := False;
end;
end.
