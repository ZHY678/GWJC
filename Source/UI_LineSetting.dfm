object Form_LineSetting: TForm_LineSetting
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32447#36335#35774#32622
  ClientHeight = 675
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Panel_Kilometer: TPanel
    Left = 0
    Top = 0
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #20844#37324#26631
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Panel_KilometerSetting: TPanel
    Left = 0
    Top = 32
    Width = 393
    Height = 153
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 1
    object Label_Kilometer: TLabel
      Left = 64
      Top = 24
      Width = 96
      Height = 19
      Caption = #21021#22987#20844#37324#26631#65306
    end
    object Label_Line: TLabel
      Left = 80
      Top = 65
      Width = 80
      Height = 19
      Caption = #32447#36335#21517#31216#65306
    end
    object Label_Pole: TLabel
      Left = 80
      Top = 104
      Width = 80
      Height = 19
      Caption = #21021#22987#26438#21495#65306
    end
    object Edit_Kilometer: TEdit
      Left = 200
      Top = 21
      Width = 145
      Height = 27
      Alignment = taCenter
      TabOrder = 0
      Text = '0'
    end
    object ComboBox_Line: TComboBox
      Left = 200
      Top = 60
      Width = 145
      Height = 27
      TabOrder = 1
    end
    object Edit_Pole: TEdit
      Left = 200
      Top = 101
      Width = 145
      Height = 27
      Alignment = taCenter
      TabOrder = 2
      Text = '0'
    end
  end
  object Panel_StreamSetting: TPanel
    Left = 0
    Top = 216
    Width = 393
    Height = 65
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 2
    object RadioButton_Up: TRadioButton
      Left = 96
      Top = 24
      Width = 113
      Height = 17
      Caption = #19978#34892
      TabOrder = 0
    end
    object RadioButton_Down: TRadioButton
      Left = 232
      Top = 24
      Width = 113
      Height = 17
      Caption = #19979#34892
      TabOrder = 1
    end
  end
  object Panel_Stream: TPanel
    Left = 0
    Top = 184
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #19978#19979#34892
    TabOrder = 3
  end
  object Panel_DirectionSetting: TPanel
    Left = 0
    Top = 312
    Width = 393
    Height = 65
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 4
    object RadioButton_Front: TRadioButton
      Left = 96
      Top = 24
      Width = 113
      Height = 17
      Caption = #27491#21521
      TabOrder = 0
    end
    object RadioButton_Back: TRadioButton
      Left = 232
      Top = 24
      Width = 113
      Height = 17
      Caption = #21453#21521
      TabOrder = 1
    end
  end
  object Panel_Dirction: TPanel
    Left = 0
    Top = 280
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #27491#21453#21521
    TabOrder = 5
  end
  object Panel_AddAndSubStractSetting: TPanel
    Left = 0
    Top = 408
    Width = 393
    Height = 65
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 6
    object RadioButton_Add: TRadioButton
      Left = 96
      Top = 24
      Width = 113
      Height = 17
      Caption = #36882#22686
      TabOrder = 0
    end
    object RadioButton_Substract: TRadioButton
      Left = 232
      Top = 24
      Width = 113
      Height = 17
      Caption = #36882#20943
      TabOrder = 1
    end
  end
  object Panel_AddAndSubStract: TPanel
    Left = 0
    Top = 376
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #37324#31243#36882#22686#36882#20943
    TabOrder = 7
  end
  object Panel_Setting: TPanel
    Left = 0
    Top = 568
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #35774#32622#38754#26495
    TabOrder = 8
  end
  object Panel_SettingSet: TPanel
    Left = 0
    Top = 599
    Width = 393
    Height = 76
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 9
    object Button_Set: TButton
      Left = 71
      Top = 24
      Width = 89
      Height = 25
      Caption = #35774#32622
      TabOrder = 0
      OnClick = Button_SetClick
    end
    object Button_Start: TButton
      Left = 232
      Top = 24
      Width = 89
      Height = 25
      Caption = #24320#22987
      TabOrder = 1
      OnClick = Button_StartClick
    end
  end
  object Panel_JiaAndJjian: TPanel
    Left = 0
    Top = 504
    Width = 393
    Height = 65
    Color = clHighlightText
    ParentBackground = False
    TabOrder = 10
    object RadioButton_Jia: TRadioButton
      Left = 96
      Top = 24
      Width = 113
      Height = 17
      Caption = #36882#22686
      TabOrder = 0
    end
    object RadioButton_Jian: TRadioButton
      Left = 232
      Top = 24
      Width = 113
      Height = 17
      Caption = #36882#20943
      TabOrder = 1
    end
  end
  object Panel_Ganjiajian: TPanel
    Left = 0
    Top = 472
    Width = 393
    Height = 33
    BevelKind = bkTile
    Caption = #26438#21495#36882#22686#36882#20943
    TabOrder = 11
  end
end
