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
    plus_minus: Byte;
  end;

var
  Form_LineSetting: TForm_LineSetting;

implementation

uses
  UI;

{$R *.dfm}

procedure TForm_LineSetting.Button_SetClick(Sender: TObject);
begin
  if not (FGlobalpara.IsNumberType(Edit_Kilometer.Text) <> 0) then MessageBox(Handle, '公里标输入的值存在问题，请检查。', '线路设置', MB_OK)
  else
  begin
    if Length(ComboBox_Line.Text) = 0 then MessageBox(Handle, '未选择线路名称，请检查。', '线路设置', MB_OK)
    else
    begin
      if not (RadioButton_Up.Checked or RadioButton_Down.Checked) then MessageBox(Handle, '未选择上下行，请检查。', '线路设置', MB_OK)
      else
      begin
        if not (RadioButton_Front.Checked or RadioButton_Back.Checked) then MessageBox(Handle, '未选择正反向，请检查。', '线路设置', MB_OK)
        else
        begin
          if not (RadioButton_Add.Checked or RadioButton_Substract.Checked) then MessageBox(Handle, '未选择递增递减，请检查。', '线路设置', MB_OK)
          else
          begin
            kilometer := StrToFloat(Edit_Kilometer.Text);
            line_name := ComboBox_Line.Text;
            if RadioButton_Up.Checked then shangxiaxing := '上行'
            else shangxiaxing := '下行';
            if RadioButton_Front.Checked then direction := '正向'
            else direction := '反向';
            if RadioButton_Add.Checked then plus_minus := 1
            else plus_minus := 0;
            Form_UI.dxRibbonStatusBar.Panels[4].Text := '线路状况：' + shangxiaxing + direction + '。';
            Form_UI.dxRibbonStatusBar.Panels[5].Text := '公里标：' + FloatToStr(kilometer) + 'km';
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm_LineSetting.Button_StartClick(Sender: TObject);
begin
  if plus_minus <> 2 then
  begin
    case Form_UI.Init2DIP of
      0:
      begin
        case Form_UI.Open2D of
          0:
          begin
            Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器已正常开始工作。';

            if not Form_UI.IsRun then
            begin
              Form_UI.StartMs := GetTickCount;
              Form_UI.startTime := FormatDateTime('yymmddhhnnss', Now);
              ResumeThread(Form_UI.PSaveThread);
              ResumeThread(Form_UI.PProcessThread);
              ResumeThread(Form_UI.PDrawThread);
              Form_UI.IdUDPServer_Hv.Active := True;
              Form_UI.IdUDPServer_Lv.Active := True;
              Form_UI.IdUDPServer_Acying.Active := True;
              if not Form_UI.IsSave then Form_UI.TempOrignalDataPath := Form_UI.SavedOriginalDataPath + FormatDateTime('yyyymmddhhnnss', Now) + '.dat';
              Form_UI.Action_StartSaveExecute(Sender);
              Form_UI.IsRun := True;
              Form_UI.UDPStartCollect;
              Form_UI.dxRibbonStatusBar.Panels[0].Text := '正在采集。';
              Form_UI.dxRibbonStatusBar.Panels[1].Text := '正在存储数据。';
              Form_UI.dxRibbonStatusBar.Panels[4].Text := '线路状况：' + shangxiaxing + direction + '。';
              Form_UI.dxRibbonStatusBar.Panels[5].Text := '公里标：' + FloatToStr(kilometer) + 'km';
            end;
          end;
          -1: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
          -2: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
          -3: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
          -4: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
          -5: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
          -6: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
          -404: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
        end;
      end;
      -1: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器发生未知错误。';
      -2: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效的实例句柄。';
      -3: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效设备ID。';
      -4: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器已启动，不能更改设置。';
      -5: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器未启动，不能更改设置。';
      -6: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器无效参数值，参数超出有效范围，或者参数组合无效。';
      -404: Form_UI.dxRibbonStatusBar.Panels[3].Text := '2D传感器未实现。';
    end;
  end
  else MessageBox(handle, '未进行相应的线路设置，请检查。', '线路设置', MB_OK);
end;

procedure TForm_LineSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Form_UI.Enabled := True;
end;

procedure TForm_LineSetting.FormCreate(Sender: TObject);
begin
  kilometer := 0;
  line_name := '未知线路';
  shangxiaxing := '上行';
  direction := '正向';
  plus_minus := 1;
end;

procedure TForm_LineSetting.FormShow(Sender: TObject);
begin
  Form_UI.Enabled := False;
end;

end.
