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
    GroupBox_DataCollecter: TGroupBox;
    Label_UDPIP1: TLabel;
    Label_UDPIP2: TLabel;
    Label_UDPIP3: TLabel;
    Label_UDPIP4: TLabel;
    Edit_UDPIP1: TEdit;
    Edit_UDPIP2: TEdit;
    Edit_UDPIP3: TEdit;
    Edit_UDPIP4: TEdit;
    GroupBox_Acying: TGroupBox;
    Edit_UDPPort: TEdit;
    Label_UDPPort: TLabel;
    Button_Comfirm: TButton;
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
  (FGlobalpara.IsNumberType(Edit_IP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPIP1.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPIP2.Text) = 1) and
  (FGlobalpara.IsNumberType(Edit_UDPIP3.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPIP4.Text) = 1) and (FGlobalpara.IsNumberType(Edit_UDPPort.Text) = 1)then
  begin
    if (StrToInt(Edit_IP1.Text) <= 255) and (StrToInt(Edit_IP2.Text) <= 255) and (StrToInt(Edit_IP3.Text) <= 255) and
    (StrToInt(Edit_IP4.Text) <= 255) and (StrToInt(Edit_UDPIP1.Text) <= 255) and (StrToInt(Edit_UDPIP2.Text) <= 255) and
    (StrToInt(Edit_UDPIP3.Text) <= 255) and (StrToInt(Edit_UDPIP4.Text) <= 255) and (StrToInt(Edit_UDPPort.Text) < 65536) and
    (StrToInt(Edit_IP1.Text) >= 0) and (StrToInt(Edit_IP2.Text) >= 0) and (StrToInt(Edit_IP3.Text) >= 0) and
    (StrToInt(Edit_IP4.Text) >= 0) and (StrToInt(Edit_UDPIP1.Text) >= 0) and (StrToInt(Edit_UDPIP2.Text) >= 0) and
    (StrToInt(Edit_UDPIP3.Text) >= 0) and (StrToInt(Edit_UDPIP4.Text) >= 0) and (StrToInt(Edit_UDPPort.Text) >= 0) then
    begin
      if MessageBox(Handle, '您确定要修改设置吗？', '传感器设置', MB_OKCANCEL + MB_ICONQUESTION) = ID_OK then
      begin
        IniFile := TIniFile.Create(Form_UI.ConfigurationFilePath);
        Inifile.WriteString('传感器设置', '2DIP', Edit_IP1.Text + '.' + Edit_IP2.Text + '.' + Edit_IP3.Text + '.' + Edit_IP4.Text);
        Inifile.WriteString('传感器设置', 'UDPIP',  Edit_UDPIP1.Text + '.' + Edit_UDPIP2.Text + '.' + Edit_UDPIP3.Text + '.' + Edit_UDPIP4.Text);
        Inifile.WriteString('传感器设置', 'UDPPort',  Edit_UDPPort.Text);
        IniFile.Free;
        MessageBox(Handle, '设置已恢复。', '传感器设置', MB_OK + MB_ICONQUESTION);
        Close;
      end;
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
  Form_UI.Enabled := False;
end;

end.
