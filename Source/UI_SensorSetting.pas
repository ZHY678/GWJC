unit UI_SensorSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles, UGlobalpara;

type
  TForm_Sensor = class(TForm)
    Label_IP1: TLabel;
    Edit_IP1: TEdit;
    Label_IP2: TLabel;
    Edit_IP2: TEdit;
    Label_IP3: TLabel;
    Edit_IP3: TEdit;
    Label_IP4: TLabel;
    Edit_IP4: TEdit;
    GroupBox_2D: TGroupBox;
    GroupBox_HvDataCollecter: TGroupBox;
    Label_UDPHvIP1: TLabel;
    Label_UDPHvIP2: TLabel;
    Label_UDPHvIP3: TLabel;
    Label_UDPHvIP4: TLabel;
    Edit_UDPHvIP1: TEdit;
    Edit_UDPHvIP2: TEdit;
    Edit_UDPHvIP3: TEdit;
    Edit_UDPHvIP4: TEdit;
    GroupBox_Acying: TGroupBox;
    Edit_UDPHvPort: TEdit;
    Label_UDPHvPort: TLabel;
    Button_Comfirm: TButton;
    GroupBox_LvDataCollecter: TGroupBox;
    Label_UDPLvIP1: TLabel;
    Label_UDPLvIP2: TLabel;
    Label_UDPLvIP3: TLabel;
    Label_UDPLvIP4: TLabel;
    Label_UDPLvPort: TLabel;
    Edit_UDPLvIP1: TEdit;
    Edit_UDPLvIP2: TEdit;
    Edit_UDPLvIP3: TEdit;
    Edit_UDPLvIP4: TEdit;
    Edit_UDPLvPort: TEdit;
    Label_UDPAcyingIP1: TLabel;
    Label_UDPAcyingPort: TLabel;
    Edit_UDPAcyingIP1: TEdit;
    Label_UDPAcyingIP2: TLabel;
    Edit_UDPAcyingIP2: TEdit;
    Label_UDPAcyingIP3: TLabel;
    Edit_UDPAcyingIP3: TEdit;
    Label_UDPAcyingIP4: TLabel;
    Edit_UDPAcyingIP4: TEdit;
    Edit_UDPAcyingPort: TEdit;
    GroupBox_CalCount: TGroupBox;
    Label_CalCounts: TLabel;
    Edit_CalCounts: TEdit;
    GroupBox_Calibration: TGroupBox;
    Label_Force: TLabel;
    Edit_Force: TEdit;
    Label_Electricity: TLabel;
    Edit_Electricity: TEdit;
    Label_Power2: TLabel;
    Edit_Power2: TEdit;
    Label_Power1: TLabel;
    Edit_Power1: TEdit;
    Edit_ACC1: TEdit;
    Label_ACC2: TLabel;
    Label_ACC1: TLabel;
    Edit_ACC2: TEdit;
    Label_Power4: TLabel;
    Edit_Power4: TEdit;
    Edit_Power3: TEdit;
    Label_Power3: TLabel;
    Edit_ACC5: TEdit;
    Label_ACC6: TLabel;
    Label_ACC5: TLabel;
    Edit_ACC6: TEdit;
    Label_ACC4: TLabel;
    Edit_ACC4: TEdit;
    Edit_ACC3: TEdit;
    Label_ACC3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button_ComfirmClick(Sender: TObject);
  private
    { Private declarations }
    FGlobalpara: TGlobalpara;
  public
    { Public declarations }
  end;

var
  Form_Sensor: TForm_Sensor;

implementation

uses
  UI;

{$R *.dfm}

procedure TForm_Sensor.Button_ComfirmClick(Sender: TObject);
var
  IniFile : TIniFile;
begin
  if (FGlobalpara.IsNumberType(Edit_IP1.Text) = 1) and (FGlobalpara.IsNumberType(Edit_IP2.Text) = 1) and (FGlobalpara.IsNumberType(Edit_IP3.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_IP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPHvIP1.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPHvIP2.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPHvIP3.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPHvIP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPHvPort.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPLvIP1.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPLvIP2.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPLvIP3.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPLvIP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPLvPort.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPAcyingIP1.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPAcyingIP2.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPAcyingIP3.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPAcyingIP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPAcyingPort.Text) = 1) then
  begin
    if (StrToInt(Edit_IP1.Text) <= 255) and (StrToInt(Edit_IP2.Text) <= 255) and (StrToInt(Edit_IP3.Text) <= 255) and
    (StrToInt(Edit_IP4.Text) <= 255) and (StrToInt(Edit_UDPHvIP1.Text) <= 255) and (StrToInt(Edit_UDPHvIP2.Text) <= 255) and
    (StrToInt(Edit_UDPHvIP3.Text) <= 255) and (StrToInt(Edit_UDPHvIP4.Text) <= 255) and (StrToInt(Edit_UDPHvPort.Text) < 65536) and
    (StrToInt(Edit_IP1.Text) >= 0) and (StrToInt(Edit_IP2.Text) >= 0) and (StrToInt(Edit_IP3.Text) >= 0) and
    (StrToInt(Edit_IP4.Text) >= 0) and (StrToInt(Edit_UDPHvIP1.Text) >= 0) and (StrToInt(Edit_UDPHvIP2.Text) >= 0) and
    (StrToInt(Edit_UDPHvIP3.Text) >= 0) and (StrToInt(Edit_UDPHvIP4.Text) >= 0) and (StrToInt(Edit_UDPHvPort.Text) >= 0) and
    (StrToInt(Edit_UDPLvIP1.Text) <= 255) and (StrToInt(Edit_UDPLvIP2.Text) <= 255) and
    (StrToInt(Edit_UDPLvIP3.Text) <= 255) and (StrToInt(Edit_UDPLvIP4.Text) <= 255) and (StrToInt(Edit_UDPLvPort.Text) < 65536) and
    (StrToInt(Edit_UDPLvIP1.Text) >= 0) and (StrToInt(Edit_UDPLvIP2.Text) >= 0) and
    (StrToInt(Edit_UDPLvIP3.Text) >= 0) and (StrToInt(Edit_UDPLvIP4.Text) >= 0) and (StrToInt(Edit_UDPLvPort.Text) >= 0) and
    (StrToInt(Edit_UDPAcyingIP1.Text) <= 255) and (StrToInt(Edit_UDPAcyingIP2.Text) <= 255) and
    (StrToInt(Edit_UDPAcyingIP3.Text) <= 255) and (StrToInt(Edit_UDPAcyingIP4.Text) <= 255) and (StrToInt(Edit_UDPAcyingPort.Text) < 65536) and
    (StrToInt(Edit_UDPAcyingIP1.Text) >= 0) and (StrToInt(Edit_UDPAcyingIP2.Text) >= 0) and
    (StrToInt(Edit_UDPAcyingIP3.Text) >= 0) and (StrToInt(Edit_UDPAcyingIP4.Text) >= 0) and (StrToInt(Edit_UDPAcyingPort.Text) >= 0) then
    begin
      if FileExists(Form_UI.ConfigurationFilePath) then
      begin
        if MessageBox(Handle, '您确定要修改设置吗？', '传感器设置', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
        begin
          IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
          Inifile.WriteString('传感器设置', '2DIP', Edit_IP1.Text + '.' + Edit_IP2.Text + '.' + Edit_IP3.Text + '.' + Edit_IP4.Text);
          Inifile.WriteString('传感器设置', 'HvUDPIP',  Edit_UDPHvIP1.Text + '.' + Edit_UDPHvIP2.Text + '.' + Edit_UDPHvIP3.Text + '.' + Edit_UDPHvIP4.Text);
          Inifile.WriteString('传感器设置', 'HvUDPPort',  Edit_UDPHvPort.Text);
          Inifile.WriteString('传感器设置', 'LvUDPIP',  Edit_UDPLvIP1.Text + '.' + Edit_UDPLvIP2.Text + '.' + Edit_UDPLvIP3.Text + '.' + Edit_UDPLvIP4.Text);
          Inifile.WriteString('传感器设置', 'LvUDPPort',  Edit_UDPLvPort.Text);
          Inifile.WriteString('传感器设置', 'LvUDPIP',  Edit_UDPAcyingIP1.Text + '.' + Edit_UDPAcyingIP2.Text + '.' + Edit_UDPAcyingIP3.Text + '.' + Edit_UDPAcyingIP4.Text);
          Inifile.WriteString('传感器设置', 'LvUDPPort',  Edit_UDPAcyingPort.Text);
          IniFile.Free;
          MessageBox(Handle, '设置已恢复。', '传感器设置', MB_OK + MB_ICONQUESTION);
          Close;
          Form_UI.InitConfigurationFile;
        end;
      end
      else MessageBox(Handle, '配置文件不存在，请检查。', '传感器设置', MB_OK);
    end
    else MessageBox(Handle, '输入的参数长度不符合要求，请检查。', '传感器设置', MB_OK);
  end
  else MessageBox(Handle, '输入的参数不为整数，请检查。', '传感器设置', MB_OK);
end;

procedure TForm_Sensor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_UI.Enabled := True;
end;

procedure TForm_Sensor.FormShow(Sender: TObject);
begin
  Form_UI.InitSubGroup;
  Form_UI.Enabled := False;
end;

end.
