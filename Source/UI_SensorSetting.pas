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
    Label_1: TLabel;
    Label_11: TLabel;
    Label_12: TLabel;
    Label_13: TLabel;
    Edit_1: TEdit;
    Edit_11: TEdit;
    Edit_12: TEdit;
    Edit_13: TEdit;
    GroupBox_11: TGroupBox;
    Label_14: TLabel;
    Label_15: TLabel;
    Label_16: TLabel;
    Label_17: TLabel;
    Edit_14: TEdit;
    Edit_15: TEdit;
    Edit_16: TEdit;
    Edit_17: TEdit;
    Edit_18: TEdit;
    Label_18: TLabel;
    Button_Comfirm: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Sensor: TForm_Sensor;

implementation

{$R *.dfm}

end.
