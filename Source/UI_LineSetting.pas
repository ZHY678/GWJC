unit UI_LineSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_LineSetting: TForm_LineSetting;

implementation

{$R *.dfm}

end.
