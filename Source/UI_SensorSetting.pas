unit UI_SensorSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Sensor: TForm_Sensor;

implementation

uses
  UI;

{$R *.dfm}

procedure TForm_Sensor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_UI.Enabled := True;
end;

procedure TForm_Sensor.FormShow(Sender: TObject);
begin
  Form_UI.Enabled := False;
end;

end.
