object Form_UI: TForm_UI
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = #24339#32593#26816#27979#36719#20214
  ClientHeight = 709
  ClientWidth = 1350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu_UI
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon: TdxRibbon
    Left = 0
    Top = 0
    Width = 1350
    Height = 136
    BarManager = dxBarManager
    ColorSchemeName = 'Blue'
    Contexts = <>
    TabOrder = 0
    TabStop = False
    OnMinimizedChanged = dxRibbonMinimizedChanged
    object dxRibbonTab_System: TdxRibbonTab
      Active = True
      Caption = #31995#32479#25511#21046#21488
      Groups = <
        item
          ToolbarName = 'ManagerBar_Setting'
        end
        item
          ToolbarName = 'ManagerBar_Display'
        end
        item
          ToolbarName = 'ManagerBar_Simulation'
        end
        item
          ToolbarName = 'ManagerBar_System'
        end>
      Index = 0
    end
    object dxRibbonTab_Debug: TdxRibbonTab
      Caption = #35843#35797#25511#21046#21488
      Groups = <
        item
          ToolbarName = 'ManagerBar_Collect'
        end
        item
          ToolbarName = 'ManagerBar_Save'
        end
        item
          ToolbarName = 'ManagerBar_Server'
        end
        item
          ToolbarName = 'ManagerBar_LineAndSensor'
        end
        item
          ToolbarName = 'ManagerBar_Playback'
        end>
      Index = 1
    end
  end
  object dxRibbonStatusBar: TdxRibbonStatusBar
    Left = 0
    Top = 686
    Width = 1350
    Height = 23
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 195
      end>
    Ribbon = dxRibbon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object RzPageControl: TRzPageControl
    Left = 0
    Top = 136
    Width = 1350
    Height = 550
    Hint = ''
    ActivePage = TabSheet_Data
    Align = alClient
    TabOrder = 2
    FixedDimension = 19
    object TabSheet_Conductor: TRzTabSheet
      TabVisible = False
      Caption = #23548#39640#25289#20986#20540#30028#38754
      object Chart_Condutor: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 10.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 11.000000000000000000
            EndPosition = 20.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 21.000000000000000000
            EndPosition = 30.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 31.000000000000000000
            EndPosition = 40.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 41.000000000000000000
            EndPosition = 50.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 51.000000000000000000
            EndPosition = 60.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 61.000000000000000000
            EndPosition = 70.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 71.000000000000000000
            EndPosition = 80.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 81.000000000000000000
            EndPosition = 90.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 91.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series_Line1Width: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'1'#25289#20986#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 10708548
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object Series_Line1Height: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'1'#23548#39640#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 3513587
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
        object Series_Line2Width: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'1'#25289#20986#20540#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 1330417
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 2
        end
        object Series_Line2Height: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'1'#23548#39640#20540#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 11048782
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 3
        end
        object Series_LineDistance1: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'1'#27700#24179#36317#31163#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 7028779
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 4
        end
        object Series_Line3Width: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'2'#25289#20986#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 6519581
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 5
        end
        object Series_Line3Height: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'2'#23548#39640#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 919731
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 6
        end
        object Series_Line4Width: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'2'#25289#20986#20540#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 6144242
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 7
        end
        object Series_Line4Height: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'2'#23548#39640#20540#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 10401629
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 8
        end
        object Series_LineDistance2: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#32447'2'#27700#24179#36317#31163#65288#26580#24615#21452#32447#26102#65289
          VertAxis = aCustomVertAxis
          LinePen.Color = 7368816
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 9
        end
      end
    end
    object TabSheet_Parameter: TRzTabSheet
      TabVisible = False
      Caption = #20854#20313#20960#20309#21442#25968#30028#38754
      object Chart_Parameter: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 25.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 26.000000000000000000
            EndPosition = 50.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 51.000000000000000000
            EndPosition = 75.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 76.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PointSeries_Width: TPointSeries
          Marks.Callout.Length = 8
          Title = #25509#35302#23548#32447#38388#27700#24179#36317#31163
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object PointSeries_Height: TPointSeries
          Marks.Callout.Length = 8
          Title = #25509#35302#23548#32447#38388#22402#30452#36317#31163
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
        object PointSeries_Changerate: TPointSeries
          Marks.Callout.Length = 8
          Title = #23548#39640#21464#21270#29575
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 2
        end
        object PointSeries_Elevation: TPointSeries
          Marks.Callout.Length = 8
          Title = #23450#20301#28857#39640#24046
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 3
        end
      end
    end
    object TabSheet_Contactforce: TRzTabSheet
      TabVisible = False
      Caption = #25509#35302#21147#30028#38754
      object Chart_Contactforce: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 20.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 21.000000000000000000
            EndPosition = 40.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 41.000000000000000000
            EndPosition = 60.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 61.000000000000000000
            EndPosition = 80.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 81.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series_Force: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147
          VertAxis = aCustomVertAxis
          LinePen.Color = 10708548
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object Series_ForceAve: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147#22343#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 3513587
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
        object Series_ForceMax: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147#26368#22823#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 1330417
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 2
        end
        object Series_ForceMin: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147#26368#23567#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 11048782
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 3
        end
        object Series_ForceVariance: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147#26631#20934#26041#24046
          VertAxis = aCustomVertAxis
          LinePen.Color = 7028779
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 4
        end
      end
    end
    object TabSheet_Hardspot: TRzTabSheet
      TabVisible = False
      Caption = #30828#28857#30028#38754
      object Chart_Hardspot: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 50.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 51.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series_Vacc1: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30828#28857'1'#22402#21152
          VertAxis = aCustomVertAxis
          LinePen.Color = 10708548
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object Series_Vacc2: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30828#28857'2'#22402#21152
          VertAxis = aCustomVertAxis
          LinePen.Color = 3513587
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
      end
    end
    object TabSheet_Electric: TRzTabSheet
      TabVisible = False
      Caption = #30005#27969#30028#38754
      object Chart_Electric: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 50.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 51.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series_ElectricValue: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30005#27969#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 10708548
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object PointSeries_ElectricTime: TPointSeries
          Marks.Callout.Length = 8
          Title = #30005#27969#26102#38388
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
      end
    end
    object TabSheet_Acying: TRzTabSheet
      TabVisible = False
      Caption = #29123#24359#30028#38754
      object Chart_Acying: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 50.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 51.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PointSeries_AcyingTime: TPointSeries
          Marks.Callout.Length = 8
          Title = #29123#24359#25345#32493#26102#38388
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object PointSeries_AcyingCount: TPointSeries
          Marks.Callout.Length = 8
          Title = #29123#24359#27425#25968
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
      end
    end
    object TabSheet_Data: TRzTabSheet
      TabVisible = False
      Caption = #24339#32593#27979#35797#25968#25454#30028#38754
      object Chart_Data: TChart
        Left = 0
        Top = 0
        Width = 1346
        Height = 546
        BackWall.Brush.Gradient.Direction = gdBottomTop
        BackWall.Brush.Gradient.EndColor = clWhite
        BackWall.Brush.Gradient.StartColor = 15395562
        BackWall.Brush.Gradient.Visible = True
        BackWall.Transparent = False
        Foot.Font.Color = clBlue
        Foot.Font.Name = 'Verdana'
        Gradient.Direction = gdBottomTop
        Gradient.EndColor = clWhite
        Gradient.MidColor = 15395562
        Gradient.StartColor = 15395562
        Gradient.Visible = True
        LeftWall.Color = 14745599
        Legend.Font.Name = 'Verdana'
        Legend.Shadow.Transparency = 0
        MarginLeft = 5
        RightWall.Color = 14745599
        Title.Font.Name = 'Verdana'
        Title.Text.Strings = (
          'TChart')
        BottomAxis.Axis.Color = 4210752
        BottomAxis.Grid.Color = 11119017
        BottomAxis.LabelsFormat.Font.Name = 'Verdana'
        BottomAxis.TicksInner.Color = 11119017
        BottomAxis.Title.Font.Name = 'Verdana'
        DepthAxis.Axis.Color = 4210752
        DepthAxis.Grid.Color = 11119017
        DepthAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthAxis.TicksInner.Color = 11119017
        DepthAxis.Title.Font.Name = 'Verdana'
        DepthTopAxis.Axis.Color = 4210752
        DepthTopAxis.Grid.Color = 11119017
        DepthTopAxis.LabelsFormat.Font.Name = 'Verdana'
        DepthTopAxis.TicksInner.Color = 11119017
        DepthTopAxis.Title.Font.Name = 'Verdana'
        CustomAxes = <
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            EndPosition = 9.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 10.000000000000000000
            EndPosition = 19.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 20.000000000000000000
            EndPosition = 29.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 30.000000000000000000
            EndPosition = 39.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 40.000000000000000000
            EndPosition = 49.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 50.000000000000000000
            EndPosition = 59.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 60.000000000000000000
            EndPosition = 69.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 70.000000000000000000
            EndPosition = 79.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Axis.Color = 4210752
            Grid.Color = 11119017
            Horizontal = False
            OtherSide = False
            LabelsFormat.Font.Name = 'Verdana'
            StartPosition = 80.000000000000000000
            EndPosition = 89.000000000000000000
            TicksInner.Color = 11119017
            Title.Font.Name = 'Verdana'
          end
          item
            Horizontal = False
            OtherSide = False
            StartPosition = 90.000000000000000000
          end>
        LeftAxis.Axis.Color = 4210752
        LeftAxis.Grid.Color = 11119017
        LeftAxis.LabelsFormat.Font.Name = 'Verdana'
        LeftAxis.TicksInner.Color = 11119017
        LeftAxis.Title.Font.Name = 'Verdana'
        RightAxis.Axis.Color = 4210752
        RightAxis.Grid.Color = 11119017
        RightAxis.LabelsFormat.Font.Name = 'Verdana'
        RightAxis.TicksInner.Color = 11119017
        RightAxis.Title.Font.Name = 'Verdana'
        TopAxis.Axis.Color = 4210752
        TopAxis.Grid.Color = 11119017
        TopAxis.LabelsFormat.Font.Name = 'Verdana'
        TopAxis.TicksInner.Color = 11119017
        TopAxis.Title.Font.Name = 'Verdana'
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          30
          15
          30)
        ColorPaletteIndex = 13
        object FastLineSeries_Line1Height: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #23548#39640
          VertAxis = aCustomVertAxis
          LinePen.Color = 10708548
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 0
        end
        object FastLineSeries_Line1Width: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25289#20986#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 3513587
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 1
        end
        object FastLineSeries_Vacc1: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30828#28857'1'
          VertAxis = aCustomVertAxis
          LinePen.Color = 1330417
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 2
        end
        object FastLineSeries_Vacc2: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30828#28857'2'
          VertAxis = aCustomVertAxis
          LinePen.Color = 11048782
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 3
        end
        object FastLineSeries_Force: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #25509#35302#21147
          VertAxis = aCustomVertAxis
          LinePen.Color = 7028779
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 4
        end
        object PointSeries_AcyingCountData: TPointSeries
          Title = #29123#24359#27425#25968
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loAscending
          CustomVertAxis = 5
        end
        object PointSeries_AcyingTimeData: TPointSeries
          Title = #29123#24359#26102#38388
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 6
        end
        object FastLineSeries_ElectricValue: TFastLineSeries
          Selected.Hover.Visible = True
          Title = #30005#27969#20540
          VertAxis = aCustomVertAxis
          LinePen.Color = 6144242
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 7
        end
        object PointSeries_ElectricTimeData: TPointSeries
          Title = #30005#27969#26102#38388
          VertAxis = aCustomVertAxis
          ClickableLine = False
          Pointer.HorizSize = 1
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.VertSize = 1
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 8
        end
        object FastLineSeries_Pole: TFastLineSeries
          Title = #26438
          VertAxis = aCustomVertAxis
          LinePen.Color = 7368816
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          CustomVertAxis = 9
        end
      end
    end
  end
  object MainMenu_UI: TMainMenu
    BiDiMode = bdLeftToRight
    OwnerDraw = True
    ParentBiDiMode = False
    Left = 688
    object MenuItem_Setting: TMenuItem
      Caption = #35774#32622
      object MenuItem_Init: TMenuItem
        Action = Action_OpenLineUI
        Caption = #21021#22987#35774#32622
      end
      object MenuItem_Pause: TMenuItem
        Action = Action_StopCollect
      end
      object MenuItem_Calibration: TMenuItem
        Action = Action_StartCalibrate
      end
      object MenuItem_StopCalibrate: TMenuItem
        Action = Action_StopCalibrate
      end
    end
    object MenuItem_Display: TMenuItem
      Caption = #30028#38754#26174#31034
      object MenuItem_Data: TMenuItem
        Action = Action_DataDisplay
      end
      object MenuItem_Conductor: TMenuItem
        Action = Action_ConductorDisplay
      end
      object MenuItem_Parameter: TMenuItem
        Action = Action_ParameterDisplay
      end
      object MenuItem_Contactforce: TMenuItem
        Action = Action_ForceDisplay
      end
      object MenuItem_Hardspot: TMenuItem
        Action = Action_HardspotDisplay
      end
      object MenuItem_Electric: TMenuItem
        Action = Action_ElectricDisplay
      end
      object MenuItem_Arcing: TMenuItem
        Action = Action_AcyingDisplay
      end
    end
    object MenuItem_Simulation: TMenuItem
      Caption = #20223#30495#35774#32622
      object MenuItem_StartSimulate: TMenuItem
        Action = Action_StartSimulate
      end
      object MenuItem_StopSimulate: TMenuItem
        Action = Action_StopSimulate
      end
    end
    object MenuItem_Help: TMenuItem
      Caption = #24110#21161
      object MenuItem_Close: TMenuItem
        Action = Action_Close
      end
      object MenuItem_Restore: TMenuItem
        Action = Action_Restore
      end
      object MenuItem_Version: TMenuItem
        Action = Action_Version
      end
    end
    object MenuItem_Collect: TMenuItem
      Caption = #37319#38598#35774#32622
      object MenuItem_StartCollect: TMenuItem
        Action = Action_StartCollect
      end
      object MenuItem_StopCollect: TMenuItem
        Action = Action_StopCollect
      end
    end
    object MenuItem_Save: TMenuItem
      Caption = #23384#20648#35774#32622
      object MenuItem_StartSave: TMenuItem
        Action = Action_StartSave
      end
      object MenuItem_StopSave: TMenuItem
        Action = Action_StopSave
      end
    end
    object MenuItem_Server: TMenuItem
      Caption = #26381#21153#22120#35774#32622
      object MenuItem_Connect: TMenuItem
        Caption = #36830#25509#26381#21153#22120
      end
      object MenuItem_DisConnect: TMenuItem
        Caption = #26029#24320#26381#21153#22120
      end
    end
    object MenuItem_LineAndSensor: TMenuItem
      Caption = #32447#36335#19982#20256#24863#22120#35774#32622
      object MenuItem_InitLine: TMenuItem
        Action = Action_OpenLineUI
        Caption = #32447#36335#35774#32622
      end
      object MenuItem_Sensor: TMenuItem
        Action = Action_OpenSensorUI
      end
    end
    object MenuItem_Playback: TMenuItem
      Caption = #25968#25454#22238#25918
      object MenuItem_SelectData: TMenuItem
        Action = Action_OpenFile
      end
      object MenuItem_StartPlayback: TMenuItem
        Action = Action_StartPlayback
      end
      object MenuItem_Pauseplayback: TMenuItem
        Action = Action_StopPlayback
      end
    end
  end
  object ActionList: TActionList
    Left = 744
    object Action_OpenLineUI: TAction
      Caption = #25171#24320#32447#36335#35774#32622#30028#38754
      OnExecute = Action_OpenLineUIExecute
    end
    object Action_CloseLineUI: TAction
      Caption = #20851#38381#32447#36335#35774#32622#30028#38754
      OnExecute = Action_CloseLineUIExecute
    end
    object Action_Version: TAction
      Caption = #36719#20214#29256#26412
      OnExecute = Action_VersionExecute
    end
    object Action_Close: TAction
      Caption = #36864#20986#36719#20214
      OnExecute = Action_CloseExecute
    end
    object Action_ConductorDisplay: TAction
      Caption = #23548#39640#25289#20986#20540
      OnExecute = Action_ConductorDisplayExecute
    end
    object Action_ParameterDisplay: TAction
      Caption = #20854#20313#20960#20309#21442#25968
      OnExecute = Action_ParameterDisplayExecute
    end
    object Action_ForceDisplay: TAction
      Caption = #25509#35302#21147
      OnExecute = Action_ForceDisplayExecute
    end
    object Action_HardspotDisplay: TAction
      Caption = #30828#28857
      OnExecute = Action_HardspotDisplayExecute
    end
    object Action_ElectricDisplay: TAction
      Caption = #30005#27969
      OnExecute = Action_ElectricDisplayExecute
    end
    object Action_AcyingDisplay: TAction
      Caption = #29123#24359
      OnExecute = Action_AcyingDisplayExecute
    end
    object Action_Restore: TAction
      Caption = #24674#22797#35774#32622
      OnExecute = Action_RestoreExecute
    end
    object Action_StopCollect: TAction
      Caption = #20572#27490#37319#38598
      OnExecute = Action_StopCollectExecute
    end
    object Action_StartCollect: TAction
      Caption = #24320#22987#37319#38598
      OnExecute = Action_StartCollectExecute
    end
    object Action_OpenSensorUI: TAction
      Caption = #20256#24863#22120#35774#32622
      OnExecute = Action_OpenSensorUIExecute
    end
    object Action_StartCalibrate: TAction
      Caption = #24320#22987#26631#23450
      OnExecute = Action_StartCalibrateExecute
    end
    object Action_StopCalibrate: TAction
      Caption = #20572#27490#26631#23450
      OnExecute = Action_StopCalibrateExecute
    end
    object Action_StartSave: TAction
      Caption = #24320#22987#23384#20648
      OnExecute = Action_StartSaveExecute
    end
    object Action_StopSave: TAction
      Caption = #20572#27490#23384#20648
      OnExecute = Action_StopSaveExecute
    end
    object Action_OpenFile: TAction
      Caption = #36873#25321#25968#25454
      OnExecute = Action_OpenFileExecute
    end
    object Action_StartPlayback: TAction
      Caption = #24320#22987#22238#25918
      OnExecute = Action_StartPlaybackExecute
    end
    object Action_StopPlayback: TAction
      Caption = #26242#20572#22238#25918
      OnExecute = Action_StopPlaybackExecute
    end
    object Action_StartSimulate: TAction
      Caption = #24320#22987#20223#30495
      OnExecute = Action_StartSimulateExecute
    end
    object Action_StopSimulate: TAction
      Caption = #20572#27490#20223#30495
      OnExecute = Action_StopSimulateExecute
    end
    object Action_DataDisplay: TAction
      Caption = #24339#32593#27979#35797#25968#25454
      OnExecute = Action_DataDisplayExecute
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Microsoft YaHei UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 800
    PixelsPerInch = 96
    object ManagerBar_Setting: TdxBar
      Caption = #36305#36710#35774#32622
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_InitSetting'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Pause'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StartCalibrate'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StopCalibrate'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_System: TdxBar
      Caption = #31995#32479#25805#20316
      CaptionButtons = <>
      DockedLeft = 841
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_Recovery'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Info'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Close'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Collect: TdxBar
      Caption = #37319#38598#35774#32622
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_StartCollect'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StopCollect'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Save: TdxBar
      Caption = #23384#20648#35774#32622
      CaptionButtons = <>
      DockedLeft = 137
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_StartSave'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StopSave'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Server: TdxBar
      Caption = #26381#21153#22120#35774#32622
      CaptionButtons = <>
      DockedLeft = 274
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_Connect'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Disconnect'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_LineAndSensor: TdxBar
      Caption = #32447#36335#19982#20256#24863#22120#35774#32622
      CaptionButtons = <>
      DockedLeft = 435
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_Line'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Sensor'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Playback: TdxBar
      Caption = #25968#25454#22238#25918
      CaptionButtons = <>
      DockedLeft = 584
      DockedTop = 0
      FloatLeft = 1298
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_SelectData'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StartPlayback'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StopPlayback'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Display: TdxBar
      Caption = #30028#38754#26174#31034
      CaptionButtons = <>
      DockedLeft = 265
      DockedTop = 0
      FloatLeft = 1384
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_Data'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Conductor'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Parameter'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Contactforce'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Hardspot'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Electric'
        end
        item
          Visible = True
          ItemName = 'LargeButton_Arcing'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ManagerBar_Simulation: TdxBar
      Caption = #20223#30495#35774#32622
      CaptionButtons = <>
      DockedLeft = 704
      DockedTop = 0
      FloatLeft = 1384
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'LargeButton_StartSimulate'
        end
        item
          Visible = True
          ItemName = 'LargeButton_StopSimulate'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object LargeButton_InitSetting: TdxBarLargeButton
      Action = Action_OpenLineUI
      Caption = #36305#36710#35774#32622
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000021744558745469746C650043686172744F7074696F6E73
        3B436861727453657474696E67733BA6408EEF0000078149444154785EC5577B
        70545719FFDDBB7793DD4D08A453AB1695E20CA94C9D49694B934A08213C0401
        EB908E436C515A1529E35054A2510B8438A55AE8E0442456CB40A1E151482821
        0D90F04C48792621A5ED3480755AA3947493DDCD669FF79E73BCE7CC39B9EE40
        1AF9CB0367CEEB3BE7FB7DBFEF71371A630CFFCF66F041B31B00D99D26D723B7
        91E528EFEC36D61A4AD10B9B9B8F6B9A5EC4A10829E620A060D0A40EC6E7F29C
        6972E47272ADC90D2EA51EB12CABA5E2677367F0E9B000EC5654FE6C319CC66E
        9D8DE02D36CCE6FA2DC70B01E8C3B82095C2702409081A9873A441AC995C6B72
        3624C11C761483EA6E86D700181DD64D0A950846A14273E4388DE51555128CA3
        9C49850E40066677A42887BCC7E5311200252B47AA6E3075A6666A4CE1F816A5
        F22D254A2582CF7401934A5598FD72F51FC118A75477B0330C13176A480D5665
        820C7EEDB30080A62415C34B95CF892B65CF6F729438AFA8E8973E5729A13932
        4E16381E1C39066E358F112A251C97380C2B9729588E1B1D1000A37444061C98
        725859BE41E5A7B450D9A4129EA504A1729712644C137B945270F7AAB7868F01
        193C8AC24DBF2F13163FF7AB0D6A5378D8314FCC7B28A5272C62B50782A18C31
        595931B7DBFDA8ADA89431B23B96485C0806A33ECB3223CA83BF58BB85095D32
        EB9C2C901B10DB4A40131600A9E511F2014269EBBBDDD7FF55B3EF48E91B074F
        ACDB5D77B4249E889DB1019D8EC6A26D7BEB9A4AB6EF6DAA3013374B972C5FFD
        2007F0F2BAE5DAC68A67B171DD725042FF9B81D4B2FED355EB25AD1A860C678A
        6EBE41F9B9D671B9BB20FF9189F90FE7E6A0B1F97C41C3D13337A7173C547BB2
        F5D2F4FBBEF28582F9B31E437B57775E4D6DD35200170110650B21C461803226
        94281636BFFC1BD119A3B729B694CFC4030CD44A262D589461EEAC3CCE5849F5
        B6035584B29205B3A7C0A240349600319351002E00BA4BD735974BD7F8FDD418
        70D2CB09264AB9F90AA49F12DAA6822B168B5ED2C166064361C14E389CC033DF
        9B07C3ED02210CD17802BAA621381046D24C52006E4931E5BD7A631919024069
        6AB2FE64C53A270BE41EA1F4D4F5EB1F5D39D771A5C0E7F104E2F144515F60A0
        F8F16F15C2B4083F4760202A5894FF0580A9790FE2CA7BD7967D7FD99A984B77
        7D1E9A464341FFE6BA9AAAAE9434744800FE52B556405DBAA282AF452A99C9E4
        B9D6F39D0B267D3D675A5F2084D1593E2C5A3813999919188CC439805406A5C3
        292158F67489D174F27CD997EFBD479C6C7BFD4D9DDB795B17A8AF1F340D9430
        F5ADB7291E4CF3FB0379DF98FC005C8621E4620913A17014943A19C4A7EAB984
        7D9E489A300CCD8E91293C8039011CF413F985F3CB150061A1F8A70934F8E1F2
        357CE5140F06783CE956A6CF77B9E9D485FC19D31E45301C139AA80C6B7F5F00
        7BF7D4E39F3D373076EC17B1B0640EBC1999E2AE69327C1CEB477676269A9A5A
        D1E7EFDF76AEA52138548AA50132FF8157B75462EB96DF39C000A47BBCB98B4A
        66EDFAE0EA3F1A5FDBD500AF270D1625A076278462FFFE46DC9F331E15AB5720
        67C23834361C17CA2D4260518A31A37D786DC701341E6E5EB36FC786DF02B052
        0B919A3B3F0F4119553E859D3A4FFA7CBE39C505934E74BD77D572EB10D16E12
        0ACB22080643C8CF9B64CB19C89B9C0B7F6000A333BD201605B5BBDBE542F7B5
        0F71685FF556F9F38C3A59E0543FA8B85700962CFDB5ACEB64A7998CB7676767
        CF9F5A30D9D0ED072D4205088061C284AFA2B3EB7D4CCA9D88CB573EC0FD13C6
        C3708994040345783086AFD90C7DF3F11FFDF8E8C157AB00984300409DE865CE
        3715DB5F79916F89BCF7FBFDDD5B77D63DF5D8E4DC47E6DA45E6D37E9EDF1620
        04809933A7E0EDB39DA879E330C68FFB12BE3DBF18B17842B88043E8B5E5973C
        B510F7DC9D5DE172B9EF7BFB54DD4AC38941A11E3E8F01394D490A0E8031A207
        4391070A0B1E823D0ADA350698161375802FA617E5233B2B4330190846D01B08
        8BF4D475C0E74D434F6F3FA64DCBC3C9960BDFBDEBEE7B9F5700AC643CDA5ABE
        FEE05420F537B7F3ED61882706CD482479F1AD23670A03A1B0D8CB7B3817467A
        BA4847C6A828BB3D37FBE5559121D0750DA669E148CB5964656522DD960F0603
        073EBCDA195600E2D57F583C47964A1DB76F02515EE182E6FD03BD4F98896418
        1AEE7AF7FDABCB163FB93043D30D989448B0A99530118B63CF9EFAC4C71FFDFD
        6F7680A6E92E6354A0EFC66600C9FFF54F33550F74F9413164F7CE98F78355B3
        67179715154D419F4D7966A6076EC38578DC44381A4586C783E3C74EA3F5746B
        55EBB1DD2F0188C90C48023075DC41FB4EE9CFA9BC9CE0ACF1AE69BA3E266B14
        D2D3DCF07ADCA8DDD780CACA4D78F34023BCEE34244C93D32E0891CA23BC4B00
        F48E00104A101A8CAA924565A9F7BA0C1762F138DADA2EA2B3A3BDFA70ED9F73
        3ADA2FFDF59DAE77904C24B91B3883E91CBCECF4137F8816CF7B86DD11004A88
        A8F9FDA188026105FA7A77BC5E53BBFD8517FF3478ACF9C4A196A65D9500FCAD
        CDBBD7D6D71F39F44AF5B6C8C1FAC61D81BE4F764AABD9BF3F0DF2AC136F1977
        0480522C5AB24AA48502D071F6AD2E002BC78E9BB8361E0DC7010C002000E217
        DB0E3D3D7ACCE746DDE8B916E26B693D2B5DBC52E517FE037AC4820F20CE0A64
        0000000049454E44AE426082}
    end
    object LargeButton_Recovery: TdxBarLargeButton
      Action = Action_Restore
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F400000011744558745469746C650052657365743B556E646F3B138116FF0000
        012349444154785EEDD53D2F045114C7E1339188A030211291E8140AFB49D0A9
        A8B650282844E225B13241A1A554ECC7D0A844A35388448846140A4A26597BFC
        4A39C924CEB5734731C553FF7FC57D1155ADD4FF0AA803EA80F9ECBCC81C3EA1
        3FB4204E41018BC8CDF83E2446C0323A663C83C40858C197193F80C4085843D7
        8C1F4162046C411D72BCE1111738C10206430232688FBC630F439E8063688FDD
        62CA73060E4B88B8C180E710B6A0C60EA4403F52CCA0892BA8B1E1BD86DB8E08
        2B41DB04DCF90280CD3F444CC2BE23A3BE00601DDDC088171330EB0F00560323
        9E4D40C31F106E02F61F198F1590E0CC8C3F40CA08E8438A3134D0C425D4D82D
        23407FE91EC355053C611A123BE003A71881941D90E315D7686309A9E33BAE4E
        1D50077C03DA5FBD090AF74E5B0000000049454E44AE426082}
    end
    object LargeButton_Info: TdxBarLargeButton
      Action = Action_Version
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000000B744558745469746C6500496E666F3B6D122D860000095A49444154
        785E8D57099054D5153DBFFFEF6598A56D068671209A1AF60282444712A91040
        8510B114E3460205551ADC529AAA98CA6E0C89C1AD44DC02C68891455064D351
        56D9B771020C8C023D382BC3D033CCF4F436DDFDB7977BDFEF6EBB942ABD5D77
        DEEFD7EFDD73EEB9F7BDEE518410C8374551F02DED720B05BEC1BE86C713AB36
        D7C1CE451410D9675B646614CCBF63829203FE660272FCCF7B9F0A08198F0728
        190202CEC42FEF9D080D64966D63FEEC09974FD39144FA2BFFDD3DCEED2998ED
        525D372942F1D147E3854200B67D9200929665EC4AC4229B1E7FF096930C71DF
        5D557626EBAF29B36CCDE19C2478F3BD5A39E63B5916587D6DD5813B5F5F5773
        76ED8775E2D3BA36D11E8A8AAE9E38E1DAECF2B9FD62441C3DD12A566F392EFE
        B5FA60F0C53776CD01E0E6FD59A5F3FD95B70F20C7EB8D75359703773DFDCA96
        CA65AB0F1FD9B2F373718140B3C6A0A6650BC3B4846E5834B2DBC2A239325A1B
        119BB69F122FADD877F4F7FF58311C904ABBF23196AED89B2FC791AF82ABCF2F
        DB7A13C9D473EA4C47065488B46E8AE0F9A8F8F85887587BA04D3CBB3928166F
        3A2BDEDED322361C3E2FEABEE811D1B82E74DD94244F7C7E41BCFCD6DE9E279F
        5F3F83D5C827F1C2BF7783CD450E5A9C5F6FD7B3AF7D34F58A40A0FAD669A303
        63479683B2457D4B2F96EF6A41F5C96E04BB7474F609F80ABCF0F9BC08C56C9C
        BD98C4C6DA4E2CFDB0014783DD48F419183DAC0CB74FFF5E60E0C0F22D7F5ABC
        E6464E8C201853C6CC11304D2BD76C4F3CB776686151C9DA5953477B2A06F991
        4C9B78F7E0796CADEF865035B83D1A54CD0545552038166D73A9E49AF399A5A8
        F88088BCB9B30991781AA58142DC3E639CA77FE9A0D50FFDE6C51119128A6599
        60D31C36564E7ABF7FE05B3FAAAA2C1D34B01889A48115BB5BD167016EAF0641
        60A610B00D8131837D183BA418056E15A75AA3D81F8CC8E30A22A5D15C5BB78E
        97B79CC343B754C25FE2C3B41B46F4EFEB4BBE018095B0FFF0C80C9640E49F69
        75D192CD777FF7AA2B57CFBBA30AD45C58B5B7051D24AF873273690A20006A38
        DC34EA0A8CB9CA0F0101D5E582B00516BD7B061E9F07B669C3A284D2BA8D74DA
        40855FC303338751A934ACD9F0294E9F6D58F0C2A2056B01184CC4954FC0ED2E
        7872F2C4A1A0FE416D430F9ABA528022400D2E0951C3231E4B6270C007855E6E
        02F75239CEB6F4C8529904CEB5350C010821EBDB184A627F7D08C9948129370C
        474181FF2FD98604EB953D72BF5DB472CA80D2C2E1570FEE8F042DDE7A3C2425
        E7EA18060536050C4902D851DB26CB1624E077B69FC1D24D9F93120A4C83C059
        019B4721CBC5F6714D0711B030A07F31CA07950CBDFFB125533304A06515A01B
        6EC6C8CA32997D437B04B1B4455DAE12A02D55502C0560C955176A5B12D8F1D2
        411829132E52A1BCAC5866CF2F613301019B085A9673E4E204FEBF864B98386A
        20460D2D47B0A1E566003BC9CD8C029C807AFD90F22B40679D1687E5468B33D2
        2D99B96E9ACE486ED1F3F5C34AF1EB3BC760D9E393F1CC7DD7224A1D6F5AA6EC
        11D390E5E091C9C858F58DBD44C84669690991D6AA32C92B390528F351A58122
        797EDB3AFB4809B09CF288C1C95EF66C2291C483D32B5139C49FBDCBE1D65CD0
        5344809B309BBD1C8504153670AE3D069DE68BFA7921A08CF85A0F58A65552D8
        CF8314B10E3687395B793FE83A3795C9F56515A4AC0DE77B613B7D061B8E599C
        B1CC9E9CFBC0C834A4740BA14B09D83221175F7CC5F904D894CC5D40A026D249
        03A10B51E8DCD92C3D8373601940C53A3A9EDCD53633106063B01CB8E1907148
        E916FAA269284248550C9ECFDD3B4096006F88C61369297D51818654529724FA
        E2BAA300BBEED45475A9E88DA50038F565B372C0B4865CAA97D29188A6E45C71
        A126CB93200C8A178363820908763DAD07439722F27C0F28A15AB27404782914
        45B82B8114656C184E46A66D31B0ACADEDB481933113A491954B5053C6892465
        CB92A3ACC42BC987C33118E9F4390076BE02762A95A86D6CEE82A62AB8665880
        9B8737CA5B2E49ACBB4371F474C510EB4D22D5A7D33AD589209C5ABB84402C9E
        42B43785442405830833494E84498CBEDA2FE37584C24826E3C75834729123D0
        1BEEDC557BA2115EAF1B632B03F06880CD5939D9F266626E201EED43912A10F0
        FB3873E9B1A481AB4ABD4852C65C2A5B48F2CE0920F7B85D9830B25496E0B3D3
        6DE8ED09EDC9272098C0C6558BF634367534863AC3F0D28669DF77BE866D7626
        41CE010CC3C0AFEE1D9F0117505C0A7C1E154F2CFC81BC1D85DC23D7F25E59AE
        6913AE94315BDB3AD1DC7AA179FBE6173F016032B6C67F326C8C70B8E3E90D1F
        D6BC3EF7EE1F63CA84721C0F5E4247771AB0150904D85004504FF395E525183C
        A8186CCD1722A8DEDF243BDD161C4A6112926045A90F93291637F79EFD75085F
        6A7F0E408A31BFFA0B97C914CD59B864FBFC7B6FBC6E60597F44E23A96ACFB0C
        B13EBE7215F04B28CEE562990E00C8155581EAD29C4BCB999225282ED0F0D83D
        63E12FF2E054FD17F8E8E343751B56FD713A8008B99EFB3AFEF9032F61CDF247
        B91CDE1F4E9D77CDC83113ABEF9F3723E02DF0211C4BE3ADEA06B47725E15214
        87AA1C72FC9D1E91C8F28D7C3F64403FCCFBE930048ABDB878B107EBD6EFEE3D
        5DBFFFB6134737720326C9ED5C1372AD32A5300EEF5E59DFD2747AE18A353B8D
        CEAE30FC851E3C3C7B34A6579543D3387B6E4C9B9D9FA5DBD2851C3515B8B9AA
        020FDC318A3397755FBF71AFD1DC74EA61023F0920CD90B7FD62B1C8FF4DC8AC
        B3BD90DA5DFDEA8E863327E6AE7C67572478AE4D4A3BF5DA0AFC6EEE78DC3AE9
        3B185E518432BF97C09D735F16F061C4E022FE8CD7C8B51A95ACEE542365BE2B
        7A2E787CC1E14F566C03D0476E0A369BA19CBACB2CF2CCE485FBB62DDF3AEEBA
        593392C9C4F21143AF1E3FF1FAD1282F2FC50DE3CAA44BBAD9EF2864DFB009B4
        B77761FFC13A3435B59D6C0C1E7AE874DD8ED30012E4061C93A72467B3E73E73
        B97F48985C2179D9949F3CF2C8AD739E6ABDFFD1D7C4E2A59BC59A8D47C5FBD5
        C7C4BE9A46E9EBE979F58623E29F4B3689050FBF2C66DDFDB7D649372E7C14C0
        95E4C5E4EE6CDC2CCECCBB9ECC29204B903541A69065CB416EEED9FAEA4A00EF
        5F37694E557353C54C8FAF6812009FA67946B01486A9370022994EC60F85BBDB
        B61D3FB2BE8655CCEEE758D9D8391CC6CCEA36EB9EA7A028025FB50FD6FE39AB
        AB2B43D69DE76AFE55CE2019303D23B59571CCFCD95F1D60CE5EC98C02D8B6F1
        EF50F0ED4CC91B5D7963BE31092147C784F46FB0FF0362546FFDF639EEA90000
        000049454E44AE426082}
    end
    object LargeButton_Close: TdxBarLargeButton
      Action = Action_Close
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B093C7374796C6520747970653D22746578742F637373223E2E52
        65647B66696C6C3A234431314331433B7D3C2F7374796C653E0D0A093C706174
        6820636C6173733D225265642220643D224D32302C342E3776342E3463322E34
        2C312E342C342C342C342C362E3963302C342E342D332E362C382D382C38732D
        382D332E362D382D3863302D332C312E362D352E352C342D362E3956342E3743
        372E332C362E332C342C31302E382C342C313620202623393B63302C362E362C
        352E342C31322C31322C313263362E362C302C31322D352E342C31322D313243
        32382C31302E382C32342E372C362E332C32302C342E377A222F3E0D0A093C70
        61746820636C6173733D225265642220643D224D31372C3134682D32632D302E
        362C302D312D302E342D312D31563363302D302E362C302E342D312C312D3168
        3263302E362C302C312C302E342C312C317631304331382C31332E362C31372E
        362C31342C31372C31347A222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_StartCollect: TdxBarLargeButton
      Action = Action_StartCollect
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B093C7374796C6520747970653D22746578742F637373223E2E477265656E
        7B66696C6C3A233033394332333B7D3C2F7374796C653E0D0A093C7061746820
        636C6173733D22477265656E2220643D224D31362C3243382E332C322C322C38
        2E332C322C313673362E332C31342C31342C31347331342D362E332C31342D31
        345332332E372C322C31362C327A204D31322C32325631306C31302C364C3132
        2C32327A222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_StopCollect: TdxBarLargeButton
      Action = Action_StopCollect
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000B744558745469746C650053746F703BBA6D204F000001
        9449444154785EED963D4EE44010855F7B3C1EEF0C22580948B806E966408044
        46C00DE0289C000E40468644C08FC81129270089804D4033F6D8EEAE2AAA2548
        61DAED15AC9827BDF0933EBBAA5B9D8A08BE32A9F67B09CC058C31F8571191FF
        6F0473017374BE7D620CB600E4084B2582B3BDCDD31D00D2562061E6AD8DB5FD
        7C215B8631C98CCBC698344FF9C5EDA117F710B51620927C98FEC6FDF3354418
        B3C48BAE2EFE816763050C39068340EC3073E48D515663A296D0390671036642
        483CE3599F480182A50A248C9078C6B3F1029651347FE1C8062DA1329E8D17B0
        9651D917BC4C1F30CC969026838F85B946A9C2A36C45D98E46D0B8A9B6D23EA0
        DFFBA55DD0E6488CC705CC0E966B589A68A7D078A6BB1134AE783F05201EA3B2
        637C1665BA1A01A1762528F01428A36C474B58FBAF611728A04C573BA0022DFE
        40D1D10E386E3B826E2E22725C97F564D0EF0D101265E0D95801A92BBABAB97C
        5C0790212C8DB37C05406204F8F8E06E17C048DB4358485B68394A405B6A2BAD
        415844CBB102A225DF9FF32614919FF52A9E0BBC02BD9D14ED749B485E000000
        0049454E44AE426082}
    end
    object LargeButton_StartSave: TdxBarLargeButton
      Action = Action_StartSave
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D22D0
        A1D0BBD0BED0B95F312220786D6C6E733D22687474703A2F2F7777772E77332E
        6F72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A
        2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230707822
        20793D22307078222076696577426F783D223020302033322033322220737479
        6C653D22656E61626C652D6261636B67726F756E643A6E657720302030203332
        2033323B2220786D6C3A73706163653D227072657365727665223E262331333B
        262331303B2623393B2623393B2623393B2623393B2623393B2623393B262339
        3B2623393B2623393B2623393B2623393B2623393B2623393B2623393B262339
        3B2623393B093C7374796C6520747970653D22746578742F6373732220786D6C
        3A73706163653D227072657365727665223E2E57686974657B66696C6C3A2346
        46464646463B7D262331333B262331303B2623393B2E426C61636B7B66696C6C
        3A233732373237323B7D262331333B262331303B2623393B2E426C75657B6669
        6C6C3A233131373744373B7D262331333B262331303B2623393B2E7374307B6F
        7061636974793A302E353B7D3C2F7374796C653E0D0A093C672069643D22D0A1
        D0BBD0BED0B95F32223E0D0A09093C672069643D2253617665223E0D0A090909
        3C706F6C79676F6E20636C6173733D22426C75652220706F696E74733D223330
        2C3220322C3220322C333020322C333020362C333020362C32302032362C3230
        2032362C33302033302C3330202623393B2623393B222F3E0D0A0909093C7265
        637420783D22362220793D22322220636C6173733D2257686974652220776964
        74683D22323022206865696768743D223134222F3E0D0A0909093C7061746820
        636C6173733D22426C61636B2220643D224D362C323076313068323056323048
        367A204D32342C3238682D34762D3668345632387A222F3E0D0A0909093C6720
        636C6173733D22737430223E0D0A090909093C7265637420783D22382220793D
        22342220636C6173733D22426C61636B222077696474683D2231362220686569
        6768743D2232222F3E0D0A090909093C7265637420783D22382220793D223822
        20636C6173733D22426C61636B222077696474683D2231322220686569676874
        3D2232222F3E0D0A0909093C2F673E0D0A09093C2F673E0D0A093C2F673E0D0A
        3C2F7376673E0D0A}
    end
    object LargeButton_StopSave: TdxBarLargeButton
      Action = Action_StopSave
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B093C7374796C6520747970653D22746578742F6373732220786D6C3A7370
        6163653D227072657365727665223E2E57686974657B66696C6C3A2346464646
        46463B7D262331333B262331303B2623393B2E426C61636B7B66696C6C3A2337
        32373237323B7D262331333B262331303B2623393B2E426C75657B66696C6C3A
        233131373744373B7D262331333B262331303B2623393B2E5265647B66696C6C
        3A234431314331433B7D262331333B262331303B2623393B2E7374307B6F7061
        636974793A302E353B7D3C2F7374796C653E0D0A093C672069643D224C617965
        725F32223E0D0A09093C672069643D22536176655F616E645F636C6F7365223E
        0D0A0909093C706F6C79676F6E20636C6173733D22426C75652220706F696E74
        733D2233302C3220322C3220322C333020322C333020362C333020362C323020
        32362C32302032362C33302033302C3330202623393B2623393B222F3E0D0A09
        09093C7265637420783D22362220793D22322220636C6173733D225768697465
        222077696474683D22323022206865696768743D223134222F3E0D0A0909093C
        7061746820636C6173733D22426C61636B2220643D224D362C32307631306832
        3056323048367A204D32342C3238682D34762D3668345632387A222F3E0D0A09
        09093C6720636C6173733D22737430223E0D0A090909093C7265637420783D22
        382220793D22342220636C6173733D22426C61636B222077696474683D223822
        206865696768743D2232222F3E0D0A090909093C7265637420783D2238222079
        3D22382220636C6173733D22426C61636B222077696474683D22382220686569
        6768743D2232222F3E0D0A0909093C2F673E0D0A0909093C7061746820636C61
        73733D225265642220643D224D32352C3063332E392C302C372C332E312C372C
        37732D332E312C372D372C37732D372D332E312D372D375332312E312C302C32
        352C307A222F3E0D0A0909093C7061746820636C6173733D2257686974652220
        643D224D32382E382C392E336C2D312E342C312E344C32352C382E346C2D322E
        332C322E336C2D312E342D312E344C32332E362C376C2D322E332D322E336C31
        2E342D312E344C32352C352E366C322E332D322E336C312E342C312E344C3236
        2E342C3720202623393B2623393B2623393B4C32382E382C392E337A222F3E0D
        0A09093C2F673E0D0A093C2F673E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_Connect: TdxBarLargeButton
      Caption = #24320#21551#26381#21153#22120
      Category = 0
      Hint = #24320#21551#26381#21153#22120
      Visible = ivAlways
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000024744558745469746C65005365727665724D6F64653B53
        65727665723B50433B436F6D70757465723B72D8E067000003F849444154785E
        AD974F685C6514C57FF7CD24D3E8C6852E44255A44502462FD432DA2B813FF84
        68C5BA73955D372E256941CDC2952222820AA57B69D354ACAE6AC09560AB4275
        23522C5D2822629BCE4CE6BD7BACBDBCB90C43C8BC9033F3E6FBF8E0E39C7BBE
        EFDCC7B42501606600AC9DFD95F967EE3502453C0018CDA0787040C7577FD2EB
        0B73000467A0CD286A72035A9F7F7DE1C8F474E7083BC41F7FFEBDB278E8F177
        8032C81181AD05D4E41F1F5F3F7AFBAD372FDF337B1BDDCD6ABC3C310E7271A6
        D3E6C22FD5F2CAFB6BB6FCC6FCDB4099CE6C2DC080E27FF2B907676F90F7827C
        421801D1ED973C70FF9D004BD745705DC45B4039890345E7A699E503FB66D90D
        DCF1E47DFC7EF99F256005A82671C04C46B757DEA84224D0B8E1663151AC20C5
        9A88F53D9D16EE9EF64C72071C3135D5022BC084D74C12860DC9F018856105C8
        A9650CF9A65A8694C54D24402E24E1C089D3E74186108951A2B400643147F0F2
        0B0F835AB8AB8903195E10EDA9362F3D3B37E2804392E288023321A5B493677E
        AC4D4AF1130A08CF14962251BA4002ABAB16A3C53BF59E1AF29AD8A181030698
        BB2038918424302119463D66C5920D37FB702DE672E16AE4406C1241EE88535F
        859DE4EDAE91B7DE0991D9844304865C0D5320111F470E079F7B08004F726431
        8F61BC439EF8E27C106B270E48B80C54E012FD4A9884B08C5F118A7C8B662CA5
        1B929AC530143B951C099090839B28821FDC410598238879CA416494A58631C4
        85105858B8FAE50F599E65A9E94976C10444781C779198D4810A54815C1C7C71
        1F12C880CAA120E020C8040C136F9C3CFD3D728117480D63585BE712C2E90D4A
        00E469800F632120867449B117A850F34EE812C497A8A226ACD7464E3AE7D99C
        904204126A980293D7E717624E9D3997F10392D0C082D860944864136EFC32AA
        4B74F1DAC26360B5D5E3D0D86FBE9CAE6C0CF0EC03D6B00F388EB87A6D80C81B
        1FBFE9B5F2328E40E4FBA4E911E4BB80E09182D051089131D32968B70ACACAE9
        F61CE4C842944562620FEC2405E00817E04A8303CCEC6971EED2477C77F1131E
        B96B9147EF3ECCD5AE30F23E500999D281510E6D73041E1B5D43BBA530DF0D0A
        33BEFDF918FD0397F8E6EC67ECDF7B381CF04CA61086A1E69D301C10E0C13D6C
        BF46882ABD62EF2DAFB0F6E9873CBFFF108352A08C70B01995147BC5240252A1
        5C54AEA84A5021189E2B74BB250B4FBCC9AB4F2DD1DB74FEDDE8530DBDB78C25
        80A7B8496388D0586371A05EA8107F5DE9673264313A60024F02B540F2462990
        247A7D67A35701158916EE80550431DB62DA8BAC0BB49D000706BF5DBCBCFEEE
        7BAB4FB34B180C7AEBC0E67602140FBD631F2CCE03D3408B5118CDE1401FE801
        BEDD3F230125700DE802C6EEC0937C14FF010E59F456E5CE5714000000004945
        4E44AE426082}
    end
    object LargeButton_Disconnect: TdxBarLargeButton
      Caption = #20851#38381#26381#21153#22120
      Category = 0
      Hint = #20851#38381#26381#21153#22120
      Visible = ivAlways
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B093C7374796C6520747970653D22746578742F637373223E2E5265647B66
        696C6C3A234431314331433B7D3C2F7374796C653E0D0A093C7061746820636C
        6173733D225265642220643D224D32392C32483343322E352C322C322C322E35
        2C322C3376323663302C302E352C302E352C312C312C3168323663302E352C30
        2C312D302E352C312D3156334333302C322E352C32392E352C322C32392C327A
        204D32342C32326C2D322C326C2D362D366C2D362C3620202623393B6C2D322D
        326C362D366C2D362D366C322D326C362C366C362D366C322C326C2D362C364C
        32342C32327A222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_Line: TdxBarLargeButton
      Action = Action_OpenLineUI
      Caption = #32447#36335#35774#32622
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B093C7374796C6520747970653D22746578742F6373732220786D
        6C3A73706163653D227072657365727665223E2E426C75657B66696C6C3A2331
        31373744373B7D262331333B262331303B2623393B2E426C61636B7B66696C6C
        3A233732373237323B7D3C2F7374796C653E0D0A093C706F6C79676F6E20636C
        6173733D22426C61636B2220706F696E74733D2231372E322C31322031392E32
        2C313020322C313020322C32342031302C32342031302C323220342C32322034
        2C313220222F3E0D0A093C7061746820636C6173733D22426C75652220643D22
        4D32372C31334C31372C32336C2D342D344C32332C394C32372C31337A204D32
        382C31326C312E372D312E3763302E342D302E342C302E342D312C302D312E33
        4C32372C362E33632D302E342D302E342D312D302E342D312E332C304C32342C
        384C32382C31327A20202623393B204D31322C3230763468344C31322C32307A
        222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_SelectData: TdxBarLargeButton
      Action = Action_OpenFile
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
        526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000054249444154
        785EE597DF8B5D5715C73FFBCC9D4CDBA4650C6DD334516223452CD81A8B208A
        587D50109F2A2DD42789885450FF8116F441F4455A141F2CEA836FFAD23C444B
        25A4A5A57D504A29D8265183CEA493CCDCCECCFD79EEB9E7ECB5BE827B73CEE5
        1221948A0F5DB0D86B9F75EFFE7ED777AD7DE0F424F1FFB41EF03E2710420008
        DC9889F7C824B50A04A0C8BE6CA103C6B3EBBD6E41F1C2539FFBC2FAA1D51F15
        213C48362D0593B279EC33DF7DF1F780BDFECB2FE6B49002A0657D902020A42E
        7DEA3BE7AF4F60FDE0EA6F4F7EE97B470EDE797211BA8DE36CC485677FF2F453
        8F7FFCC5EFFFE28D9D07BE75CEDF8DEAEDBA4C40AE23878EDE07CD859457565C
        295EEDF5B8FBD4E7EFF8D4F0CC4F81D3C08D10084BE096DDF3BE9B0139204F8E
        72BCB8361C3E71827B1F7AF8D13FFF8C47176B51A7F9624BBA3A80687A6D6BAF
        7AE2911FFFE51CD02C13409E81644BC0DE7A50CDE10F1EE5F0E91F4071DBF55A
        F55F9F8DB72E9FE2773FFF0DF061202EB72078F4F4DC6D1918DC01CF246BA887
        600E18F294975BFEADA5D81773915B6EBE0BCCEF5CBC69218405029E41F341CB
        04945794C0526CC80C3CAF6A5A022D293324C3572AEA2A02AC6412CA9E099812
        B8C7EB82A2AE223C1D8A3528CE515323ABD37F2D91F14C4216913B856E66BC3F
        03B80970A0C9ABF500DC048AC82264095106CA7B99779567F0663AE2ED7F6C32
        D89D800B1072474A2BAE14EB22A8E4CCE3F75C13C2C534463DFBC833FFFC463B
        0356576836451EA1AB2AED2D1172F3F4CC1A46FD5D76B66B8E7DFA313E72F2C1
        4E55D18D3FDEC692B7FBE9DEB583CFFFF09B9F058ADC0227CE4A6C5AA27AC6B8
        BFC53B57AE32AF1AC8D54810DC900B97583FF1093EFAF0D759E941F3F69FD07C
        84A4A45248D57B3B478667F5280EB0F9E6DFA86A3F07A8552056639AD110ABA6
        6C5DDAE0635F7B92B55B6F2799B2D3DE1297A3D916CDD53720D6480958AEC539
        CAE4AD1BD05E60E7D26546657CAE2360A29E8CA98623A6BB3BACDE7637070EDE
        4A73E58F283659DADC53940E0270C7597C7F2801C9F16E9612E16880F0067636
        AE5567FF3A3E0F780F08D618F3F188D960C8E05A9F3B1EF8249AF5F17909A8AB
        4A8900EA6E89502296C01270CEE111CFABDC2114F4AF5CA52A9B97CEBE359A66
        05C01A518D87947B23C67B53EE3D7E029B6CA6EA9501255C960E4648DE0207AC
        AD58128A31C96FD65E6179030A6CFF7D834965CF03DEBD071AA31A0E18EFED53
        AC1EE0964337515D7E19B9137A6B84A28703215F31296670476E2813C30C57EE
        B5722ED678AC913514BD35B63776B9D49F3F07583B03B13166C301A3FE8023F7
        DD8F953BD8640F2124501021AC127A0740052A8A549D2717069600DD1A880D8A
        CD7F62E59B2002E3FD8AF1B0BAF8F4ABBBFF02D4295047CAFD01E5A4E4F0F163
        34C34D2CD6597A4086790972DCE97A1C423B071E230143DEB62CB90B700281FE
        C68849A5F3E4EA7FFDD5634981BA71CAC1008FF081BBD669FA17F07ADE1D2243
        2690B787E36DDC8228934142D9C96D0B2B05BBDB13F6CAF80AE080E4A2071475
        658CDFD965FDE8ED508F68867D641170DC32901C39045956458B37A1DD07D1CA
        EE0894DC63417FBB9A9FB9347E212B807B6A81628C54E309F7DCFF219AC1165E
        579D94D9C995AA93372B026028D584210A0997C84962E30C76E78C67F6EAEBDB
        D504D0335F3E2A941468E635AFADAE71EACD972FF2D64B179080E0B8070200BE
        F09A6F030864F901D42903D0C6C25D5473DB7F656BF62450035EAC14E421A4FC
        F61F361F02D68062F91B6179FF2E72CA92CF8119D0FCEA2BC71DD41288400954
        DCB8056EDC58FEAE387DF60A5247C05B96FF7B134BD6CB4CF4BEFD38FD379B7D
        158A0D532ADA0000000049454E44AE426082}
    end
    object LargeButton_StartPlayback: TdxBarLargeButton
      Action = Action_StartPlayback
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000017744558745469746C65004D656469613B506C61793B53
        746172743B51505E670000088149444154785E95577B6C14C719FFCDEE9EEFCE
        E7E79D0DC6718C1B631E0EA40830C44948484209347F84B491A22A695AAA8456
        6962DA4851A9A2246D1201529B288D504B6595A6E5119EE59100E5656879181C
        0CF6193018F33AC0C42F6CDF9D7D77BB3B33BD9B9D5D9D11A074E4F1CCECDE7C
        BFDFF7FBBEF9E68E7CB2E32CFE9FF6D6B39504F768497B1C776A1C0091A37CF0
        EB672BA101C02BB32BEE095AE076D9A024BDDF0E21097239E73D0983E32EEDF3
        DD6D62D4BE25B00280FCEE9F071FCACCCA9D4F34F56902E225843C04105093B6
        80F098A127EAA2FDB7B62E5D3837088025F7B3BB11618C8110020D9CDF0B3CD5
        D58FD61D7BDEE3CDFC282BD35DF19DA26C1417F890A129F0677BC486DE707CB2
        6132DCE819ACBE7C33E79D655B9A2E0C85C3BFFFE0278F6F024053449224D8ED
        0484028C73DC4EA1D002577EB36267997FC47D6B8A02BE1953C616A230DF8B18
        E5A21BE008C574C1D1EDD1A082605CAE0793C716A0BB2F56D178BE6BF587EB1B
        1785CE9D7AA5F6FD572F2549980078B754833A04281722D82C467805B8FAEEE7
        079FCCCAF5AF9F31A128BFBC340FFDBA8950D400705B32118EA1940D02442D3E
        F07A5C78BA6A34DA43B7AA8EAAE4E8AF3EDBF2F2A735CFEF0760249D4357CCE0
        295C4120C584316B51949921C07F5BBBEFA9BCFCC0974F4EBD3FC39DE54E02EB
        0290100E8104380C380808912B0E318F508E88AE63C4A85CCCF3B9F3773790AD
        359FFC6BFE676FFD4090609C73933A0A30989CA3C4E716B2D77CBC614C8E3FB0
        36056EBA3484870CDBD17460A902010803E7CE72D867BB2943A6C7853933CA5C
        5FE9E6AA97172F9FB57AD91BE7938E9AEFAE6A6082402241C1986352F51795AD
        9C36AE2890505444E2A6A336B1BD4D5B71A4A921DF3933A9966198F0B9543C3C
        B1D81F8B7DB716C06C00ECC31F4FE782F3E2BF1FC3B2050F0BF0B757EC7DF1FE
        9251ABABA795A12BAAA727A725332758B27433CA4AF3316F6E15FC816CDB6547
        05DC85F0C82C0D078F5EC285B60B3FFBEBE217BE00A003601AA5D4F13E2333EB
        FD896346E0665887C9B86349348140C472666509D6ADD98FF2F1A5786CE64468
        9A06C06640D21830677FC700C3E40945E8E8EC7B07C06600A650C0067F75C9C6
        D9151515BBA64E2943CF902100790A501AB3255FFEE976FCEDBDE7D0DB1FC59E
        FA36D4076FE091272661DC84525B25270988C3DB6211C874A13EB9A7F9D4A9E7
        367FFCF3DD000CBB122A49F79FC9CDF120D41B83AA2952599E9E58565C091789
        35EA819108E4FB3063D2686CD97F1A271BDBF0D4F7AA901FC8493FA5C30211EA
        19425E9E0FEECCBC3900F60330354954218A6BBACBE3469F38CC40A65783A62A
        69D273CB3BE11587CBA561F4883CF8B3BD282EC8C1A9B60E6CDE7E18852545A8
        AA7E102E8FCB39BABAC1313864080D73BD1E40754F03A0A6DF058AC9300EAA0A
        AA535117FA0D064D25C8C85093A32A6B80E50DE3001373C0E7CD4079891F7939
        5E8C292DC48186766C5EBB1793A68E4359C568240C0AC3A410B1260A90B40728
        159200B11520CC60393A57605253CA2798273B15315415058A2A45655C9014A1
        95B9EA4F12F079DDC8F1B931754209761E6AC557C14B7862DEA34E0E73C240B9
        0B94F16C1BD7568098940930C6ACB8CB7FB0775346C14DB14D284099A50608B7
        01C405555EEC47B6CF83FAB337919750843DA771206E5250D339794E08523285
        63BA1E6020E08C0060CE19041F6E84312E08284E9A2B70A996CD5DC72F6243DD
        79949617A37A6629C243E6B05A124B18294723904D1E60703D116F8B0FE9D5AA
        C703C6EDC2C260177AE6D43D22DE8BEAA930688A2A92B5F56A0F6AB737817BBC
        A87A74228C541E450D0B55826820880FC6A0C7872E4A0FB9AD004BC46227A2FD
        D1EADC916E3059842C21B87DCB384230E9BD4BD330108DE31FBB5A70E6FA00C6
        579621C3EB4658A7C2BC0C8EFD07AE120CF447118F464E02A0C30844FA3AF775
        7614BC993B32006A65B8342245605CCAC891E152A1AA04DB0E9DC797F5979272
        DF87C955E33118A788263BC7F0900170F6DEBCD68D687FE7019B80530901F8E6
        2E5A73F2C169950F78B37D605CF24FAFEA9CE3F0AE2358BCE0716C3C700E1939
        39185D3E0A0913D04D26019D922CA682BC04188C44D17C3878E560ED82190006
        00E8CADC9A755CC6C388F4742C0BB585C42626321FE08C818B397748AD3ED08E
        D2CA7214978D42244E1137684A2141908910014CAC99358A234B70E9EC550C74
        5DFE2380B8BC0B202F2341D238B2E6ED8DB316AE5C9817EA9E16282E10C0DCA9
        E7563CBEFFC3593029C5608282264C476206FB44120CD78E4381828EABDFA0BB
        A3ABF9D4B60F360248384968528EAD2DDD7CFEA4420A20D1D9FEF59B4471EDF4
        64B9F353A1E07602C9BAD01B4EC0399DF29F04B2216597440847241CC1F9E0C5
        FECEB64335008684F7B229D4A4E2EADDD8DC25C2D05AF797D3BDD75A5F6B6968
        35FA7AC210074248CAAC0A28EB803CAA626DCF394F7B2EE7FDDD61048FB6183D
        579A5EBF7C7C4DD0F6BEEAA55A2EEF0066818825840AC11D4BF6765D0CBE74E6
        F8E9816F429D160060918188B304611254BE93CF29E782F4CDAB9D683E1A0C77
        B637FEB4ADEE4FBB6DEFD79DECE4F6B762855161C42600294FECEC9E3FFCFB7A
        CB9E39E74E9C696AA96FC1406FC422C204135B19B9975BC46422866F45D07424
        88D68660B023B8635EFB7F96EF04100560004E2D9121A0B67C408A593A89D089
        F5671AD7FD72CEF5D6A6379AFEDB183A51D788CBE7AEA0AF6700D1BEA8237B74
        6010FD5D03B8DC7A050DFB4EA0B1EEEB6B37CE36D6346F5AF44C47705B0B8041
        1BFC8B24069704ECAFE54ED6DA1FF8D194910400B58FCBB93D4B5701D854F6C8
        6BD3FB3A4AE76A9EACC7C0150FD1DC6385EFA6DE06B0B8118B1C19EABBB23B74
        6C65038098BD5FDAC2DAC64E0E2754B2B04D7E71059C263399706B6CDEF08BF4
        DF862A0097DDE55AB11595DD48EB54764C7AE1CF1C77682D9B5E07C1B76B246D
        54EEF00B99A7752647F9FCDEED7F0358EFC93A24EC5E0000000049454E44AE42
        6082}
    end
    object LargeButton_StopPlayback: TdxBarLargeButton
      Action = Action_StopPlayback
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222076696577426F783D2230203020333220333222207374796C653D
        22656E61626C652D6261636B67726F756E643A6E657720302030203332203332
        3B2220786D6C3A73706163653D227072657365727665223E262331333B262331
        303B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B2623393B2623393B2623393B2623393B2623393B2623393B2623393B2623
        393B093C7374796C6520747970653D22746578742F637373223E2E426C75657B
        66696C6C3A233131373744373B7D3C2F7374796C653E0D0A093C706174682063
        6C6173733D22426C75652220643D224D32372C34483543342E352C342C342C34
        2E352C342C3576323263302C302E352C302E352C312C312C3168323263302E35
        2C302C312D302E352C312D3156354332382C342E352C32372E352C342C32372C
        347A222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_Pause: TdxBarLargeButton
      Action = Action_StopCollect
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000011744558745469746C650050617573653B53746F703B3B
        8A7A3C0000017349444154785EED97B14A03411086679358D8DAE4850441B0B4
        B4158BA0B63E848D951622D818B01404B1F615F4092C44B44B727BB7F38FBB91
        010B77D3CC62081EFCC5775FF33373DCDD0E4484FEF21AC42C6701E79C590111
        59F6092CCE7F0177FEB073E69CDB8D308C791391DB83ADBBC3240B4EAC0AF444
        68B4B779A13CBC7EDC1F45384E50706C56001062F2F4F23A9E8BC4E97E829CB3
        2CE098418C8644301789D3FD0425675580C042811A824079A1332D10C2F70400
        28979C7D016650901941A05C74F6050228201560E592ABB382301FB32817DC4A
        4E80411D37C48072C1555BC18C26ED3BADF5D613FFEADA30A9B70286A789FF50
        2EB85A13E0EC7B405DE587903D315839EFAABD88D81384950BAEDA0A3A624079
        A133FF18315A0258B9E42AAD2074D43193F72E71C9991790661A2EC7574FDBBD
        BEDB00CB67E870AFBF5C3967590037A7CF47114E62FA311C338D419239675A20
        A689697F0868819C335D410CA764BCBAD53917E8796EF54F465FD5BBF840931F
        16EA0000000049454E44AE426082}
    end
    object LargeButton_Conductor: TdxBarLargeButton
      Action = Action_ConductorDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F400000026744558745469746C650053656C6563744C6162656C73416E645661
        6C7565735069766F745461626C653B343F32DC000001B949444154785EC597B1
        4A3B4110C6779253115F406B052D2C05C17456BE808D0F206A25A945416C05C1
        42843482A8A00F606369A1585A2868AD8D367FFE4908971967CECBC23A8483E3
        E66E609AAFD8DF77DFCCC22D1091ABB2407AFFE8760D0036B91BD64022BAE73E
        D9DD5EB920AE480CB0B0D55C5F5E02006719084062A071787A072C5C722706EA
        00B504FEBF133B328E7B623C72C2132E378A811A12C99727F083EB6705D8599D
        577A9E927384233CE18AF63B02C400383337E5016F2F1F819EA3D439290FBC0B
        C4126F42C8ABDE40940844C3E2527A1185F4D70062B028AABC5E5402181A20EF
        C8FE16785E6820044ECF4E7AE1FDF553E939CA9F13F27402A9431F91D20BA8EC
        0408BDA0F4224A27E04A4EC06526D0F782D22D12F08ABE264A2FC841C6122A90
        D26D97107DD45AB75FC2EC11D82FA1FD08F412967A0BF41272973B0297318240
        00A5E72B1836029DC1D7B7872ABD98229D0000B7F1FF0048834E80B01F3F20E2
        22FF329BBF0B98E398F728DC8101ECB4FFB59A7B57F568646CC119571CF79E7A
        DD764BB80303FDB3E38D73166EB847D3070318B04958DC3DEEAE70FD08444C85
        4E00B73181298B44A8FC755C7315D70F9B75319098366F9D0000000049454E44
        AE426082}
    end
    object LargeButton_Parameter: TdxBarLargeButton
      Action = Action_ParameterDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001D744558745469746C650053656C65637456616C7565735069766F74
        5461626C653B95FAA9A5000001A849444154785EC597B14AF450108567B2F1FF
        115FC0DEC2C67241703B2B5FC0C60758D442646B51105B41B410651B4154D007
        B0B1B450B6B4B1B0B7D146DC2C219971266E0297100949EEDE2187C014F90E67
        E6C20D3233B82C54ED1FDDAF21E286A8631BC8CC8FA2D3DDED952B96F2D580BC
        377BDDE52544049B812026063A87670F288D6B5162A085E825F0EF2002B61CF7
        CCB40FCA53AE88D48047CC204F023FB87DC901765617D27E2DE97794A33CE58A
        E077044406F0B8DBCE005BE703A35FADCCEF8C7998B920629858993CF706FCA4
        C15C1857BE5FBF94671A203216A560811A4C804C039C39B27F0A329E69004A9D
        82B9F9D9CAF0B7D7F7B4A1BC7C02658A99A0669549A0585CF3B4142700134E00
        2A27105B49403BA58F4F430E2A2E21395E42A2D8ED1212395F4272BB844CB1A5
        25144D7604506D04F5AEF0F8C708A0DC7DE0E313A199E27C028822CBF7015461
        3E01A6387A22A245B9325BFF2F100E08EF59B9A9010A865FFDDEDE4DCB9FFADF
        06CB1545E1201C0DFBCA4D0DC41727EB97F2BE13FD13B5446881CDCA1285A291
        72B3116873DC080CB81D13A4AC7404CEFF8E3D705C3FD76D0C37DDD6B75D0000
        000049454E44AE426082}
    end
    object LargeButton_Contactforce: TdxBarLargeButton
      Action = Action_ForceDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001B744558745469746C6500466F72636520546573743B546573743B43
        6865636B643340A40000064049444154785E95960F8C55D511C67F73EF7BBB08
        762BD5AD35554B4951B4FC915AB0C0E276B5B86A4DEAD29054B43652846E495B
        2C0902555124A8A888566849DAA20612140B8410A3526902D89A5621444C9B2A
        41C46D6A6B8DC495DDB7EFDEF9DAEEDE937BF382CBEBBC9CDC9393C9CC37E7FB
        66CE3349981999D986675F7BC9226B432003130840C23084106080100894F922
        0170FC78F7BD0B6F6D5B0E38A0351B5E167204DC367B1AC12451223703CCCCDA
        BED731817AACAF2FA19A3A4935A5524DE8E949F8E0780F277AAB77DEB7F6795B
        32FFEAE540BAE096A9BC7DEC033DF3DC416AAD547360CA36692A30025430900C
        42E58067CE324318A9C4CBFB8F32FFA6C99CE8A9DEB1ECE19D76CFC2EB9603C9
        88F33EC38AC776E9940050F051C85DF80A0208208A2340288E48A3817DA5AF0A
        C0E44B4790BAFF6CF1CAAD76FFD219FD20EEF8F1740744C1A25A009E6514866B
        60215006C21102E4E02ECC22CC0C22431895DE2A00711CD13271242D93462FBD
        6DD9E6654039CB678351000140F8660B0FCACBC93240593233432E7A2B7D0094
        22C388689D720189FB92CAE2A75877FFCDCB816A10E7492908BCE6D9850C42BA
        FCB8E82622330CA352A96206A5D88822238E457BEB683C4D97F4557FCDAF1EFE
        FEDD804E06C08A00A4220650E05F02949D01CA68C02837C6349DDEC882BB7F8B
        2B6F511057B65CC845178F5A02AC00D24FEE02F7BCAEC2AD5B3833F151F787AC
        7DF647F4A4479831651563467D8DB8649C36A481591D97D17DA2B75F8C692292
        D4A92629B1C1E1773E048807D5402DF712B884490878FFF8DFF9F996397CFDF2
        F339E70BE359F77827AB7FF267E252030DA588A64F3572FAB0069254A4D584C4
        4592A444067EE01880658B4135E002C9D977702BAF1CDACED82FB633EABCAFB0
        F1C545745C7F1195A16FF2D0A3079831E921886240FD9C37C6255CA241903444
        B88BA4EA9462703C0060500A04C8C51F0EEDE0F57737D1DAFA6576EF798ACDBB
        56307F6E3BDD8D87D8F9CC9B8CFFDC6CAE98D24184A1E218C106841845A426C0
        28C786270C062088D003150C2D9FC95B87BB98367D3837DC7809F824DEE9FE13
        7FDC7B94BEAE89DCB26011A5B88403EB9FDC874BE080092FF4EFBC9BA7F58371
        AFE306DC01819931E64B9399D97B1F6B1F9DCFACCE7311BD74757DC42BCFC53C
        B2F8411A1A87605104123FF86E0BA0628BE2722CCB17C586EAA5803060A2884B
        464FA55259CD86FF82F8F69CE16CFBCD7BCCED58C759C3CFEEE75CEE6142124C
        858D19481045119E2A17E12947B1C081B85462E2D836BE336D0D8FDCDEC598CF
        CFE4B24BAFA0DC5046CA6219D920CA839A406101205C2A526027D34086524861
        0E18A57299A95FBD8AA7C7FCA59FF321434E0BEE38800C910F0CE5332B8B6348
        D4A781E21C40A27BFFABBCBFE9099ADAA673C637BF05C0BFB76DE1F8EF77D33C
        7B2EC3C64F0044A82D945C7C35C33775823108056968431CE85AFF0B2E987313
        F6DE51FEB96533FFD8F824D1BFDEE5E25B6FE0D8636BF2841EAA252C5C22FCC2
        6D9C7210A5A9724204C9D8091C7CF001C65DDDCA1B07F62187F3C78DE0B50756
        A129D764C133E7E23B62422E6451E6233CAD878214C8D02318D5F9435E5FDDC3
        FE6DBB18DFDE825CBCBAFD0592A9D7316E5E27CAF85FFDCBDF0120AF7D31C5C2
        CEE92070A98E41E42988C24B064D4386D178D6D954DEFA1BA4E28C33CFA12F2E
        23088EFC74DE37102A5E04EE1A685581A85384C536147064ED7A1A8EBEC1B923
        9B797EE76E90B8EADA56DEFEEB7E0EAF5BCFC8CE7908CBD1926F158A50D655E2
        13E780E5935008827438BAE9699A9B22B66F7D81CA951D74B75CC3F66D2FD2FC
        E988234F6C445916E5978128260DF1ECFFBD01431217DE73277BEEBA9778E68D
        B42F5808123B4A65F6EE788971AB56162ACEFB1D84177420CB3AA21E0DA42EA4
        10C2F86C5B2BCD7B5B918C810E11D72E5A0AFF5B822475C040803912C5598CCC
        40200977EAD04050B1830C2C321018102834041842584860F9330C81EFA820CA
        FA1E23E40E28E7B128AAA2C46BFE2D4BCA63CB9005DF40A908C50D36883C88B0
        6968391756482F2B0029C6CF814A022B8A3117242E8014D0C9003850EDAD9CD8
        73FBCA1D975BB1FA9010D5DC46916E152620E4C722586FEFC7FB800AE0B50094
        1DF63CBE62D6F5402310D7F66CB0DAB33A7C9455DE0B7C5CBC85528D531F9064
        4EF524AEDFF222BD48C17F005864E2B434A8A0190000000049454E44AE426082}
    end
    object LargeButton_Hardspot: TdxBarLargeButton
      Action = Action_HardspotDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001C744558745469746C65004170706F696E746D656E743B5363686564
        756C65723B42A8C3A70000061D49444154785EA5976B8C5D5515C77FFBDC338F
        CEBB2DBD53CBB4D399692D8E3129A04481164885D804E22331885F8C4AA83101
        C40F7EA1CC58048D0FD01A2941690D269A484423A204FB4C1A8C406A05A6B5D3
        9976E8B494967678A569E7DE7BD65A9EECEC64E7DEB9331F98FFC9CED9F7CCDA
        EBBFDE3BE3CC8CF9E0D4EF6E01C000CC08EA300C2C7C0B027D77EE71C79FBCC9
        53064152E60955C33F51297DDFDCE3C69EB87178F5A67D0F1EFBF54D0AC6C05D
        FB92D16DEB87FAEFDCBB65ECF1F5168C2275CE311FE41E6116BCC541D8603A7C
        F857EBDDC05D7BB7008CFC72DD306643C00F445442C448C329FCFB4320F7883A
        28A82897ADFDC2D0C147B2048CE295B76D3E7FF0AF00ACFEDA6F38B2FD1B9841
        0A2471057C38835C5C2492298B3E7E03A5774F6EC6A52C1C5CC7D9579E01682C
        B47FAC42A81077FF4FFE72736B5BE7F696D6B6E5A160666066A11AF193D1D3DD
        C1C0F4F3344FFE190C2C3C57DCF100567E1FD7B8082B4DF1BFA7B756156B39D3
        87DDC38FED3EF395DBD676F75EBE90D9F0EFFF9EE2D36B7B980DCEC18937DF25
        3BB09DA47C92DE0D77000EBD788AECBDA3B86050DADE876BBA8C633BFFC891DD
        3B7FF4C5A74E0DA5E03C7959042C1411E1EDE11031726BC105CFCD936244BC7F
        A1CC151BBFC3B1671F6164C7F718F8CC27481A5B700DCD98826517C9D3C1917D
        AF30317AF6C7B7FFFEF41020A9A8426CE4481FDF58783CB181391724897D6FE6
        D782AE569A8ADD8050991AF7DF9C85F366B42D6EA7EB23970C4E3B00B765EB4E
        DB70DD1A447596FC03811C177F4701E8EC68A6A3B5910B077E4BA7BC46F7EA55
        79E88F2317DE86D0A2C10092E64ECE9DBEC0F191633FFCDCA347BFEF867FF182
        3D70F7CD942A02441247C44B790D5CB3F67298C5C042E2187DEEE75CFCCF5371
        28610C7EAA07D0903663E4A537318B9E5C2AEB43A989C50CD4A42298819AD592
        5625CACC68BDEAEBACDE780F00954A85571FFA24AE6521AFEF3A48A99471E5F5
        3D6499F0D947C797021F000248AA6A91DEEB332C28770685D4D1DFD34543A1C0
        5C489224974DA9644A9ABF3311C65E1E235DF3555260FCD09FD04C09C4E517EE
        EE13532355535E3C3049261ABC7340CC5BFFF2456C7DF6D658F50631A73122AA
        CA77BFF40FC64F4CB162591B920953EDB7B0F2864D00BCF1DC2592734F138064
        8A99E12370EDD5BD4C97B3EA103B3C9AD2022ACAA6DBBF1C73147B20E4141EFF
        C333F42CEB62C992761A12C872E2FEBC2D7109002BBFF520BB9F30E0A70A38C9
        04F006684D4BC5F4466B0D4338F3C16B44C42814DB06BD4C0062B072E37DBE5D
        55C3B5DB9072A2EBD66000DE290811402339549187A212540533C5AAAC333087
        22B98C82857410F459F53C199B98226CF9FC8ED3F814982AFB5F9EF0356075BC
        5BD5BB98524950CB10AB1D5A0E504433CA65C9C7F13B1C3D7E2EEA89770B69E2
        50D319975CAA06EBAEE9E3529803B504CD8D05B24C294B0955AD6ABD20E5FF26
        22ACC8477A7149476873C3E1B020DFDC90F0FC9E43D4C2D740303688038EF8DB
        CC1357B212D3E51249C191B804FFDDCC7B5FC9A691CCA2ED1A8CACC9A9AACD8C
        80A9C5794F8002F1B241C410AD90E50BAD4A121888961151B058C9519BE1CC2B
        C3EAA7C0D8FBAF712AA23167C40B664DFF1234F379462D908410872DA2E2BD7B
        E3E41487C7CFE2EA4CD6B4E0A34680AB8AC08DD7AEE262298BAD10C558D09022
        AADE7B110147551494608018BDCB17532C7650AF9B1734A6FC7DD7EBF522E03D
        9F494E6C23152346C0853B3946299332A2561DF8B022EA53A4AAF1800B7D6DF1
        0B60A87A2F59D8DA1335A16808875A86A906D240E40C07D15066A9013363D7FE
        5132091E18A8451306078AA828DBB6BD5833A3A2B1CE6F8D8913E73974F44CB5
        5C1068F035509B602C3553365CBF86E94A460062E1320A77C1CFEEDBCFCA3CBF
        736162F23C2B7A16512C76D61DE72D4D790DECAC530356933B80C4B93086A022
        C2E1B1332C5DEA15D7F10E00EF79777757381BF823152EEEADB608DFCB0F770D
        7E742906717A4571D224A1B9A11034D5AA89A3B6A5A9509F05383CFA16967301
        0291209D7A7BF2DB8FEDD8FBA473AE8539F0B77FBECADC20B4597DA8CAF977CE
        4DDE0B940085E84F0BD008A4809BC77F46739D3120034A610960393CE934509E
        937CFE308018FE88FF03BFA0F41A6BCBF9E30000000049454E44AE426082}
    end
    object LargeButton_Electric: TdxBarLargeButton
      Action = Action_ElectricDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001C744558745469746C6500436861727453656C656374446174613B43
        686172743B79A25B4E0000053749444154785EB5575D889645147E66BF6F5524
        2DF31721D79F6A5734A336B31F75A512EFDC8B12C2B0242FC408BA313208BA2C
        E842280A2FEB424233A3ABA090DACDD62E8C52DBD4CD4CADB05D773F0DB7FDFB
        66CE939E9977DEBFC556A881C3CC9CF9E03CE739CF99773E033FD2F9FF1BCCCE
        A4DF5635A8B70A80869B04616E22B800706126C2A886B9D2BD7FC717958A6923
        23486F997D38CB1D67B339826D200843A3330C6060F45CC4766E7F66F57A002C
        02D0EC0DD8B678CD9379B2E28618B8701E33173445AFC4331FA476EE1C36AF68
        2DA61D29DAFBC9D1B5219E55470140039D0329B097BB41E3E31A4330E01DE8E9
        C6F469577D6648CE93EC0D2E9DFE1153963E570CACEBC98D1508884CB9512C81
        112700454180596A350AC4395044B7087E21759B9C87254C04919A08113486F1
        018803E90071496A21B65611CE3AC0830B2C783F53008195B23A092AD8CC2803
        A075E8EBE9C1C02F270006A233D910C4E9AE1F6E28CE4F3F3F86F144B0E88E59
        804CA00473962CC28CDB87A12230049866D0D37502CD8FDC9338629A0C653875
        F838DA37DCAB67347900931A1B70E2E41F1962CA22848803A4AE1A308CDD16C5
        2812348058A19421124E1C08940082DE1C9903608C2930601D44041001B35266
        085017506CA0DC801108752D750B0ACB2548003A9788D004631E808AC8676912
        E2192AD1782B6636AF4365560B8465911910735B97A0DA20280E054841EBF2F9
        003019C068E666A40920A675ED6EAFCD5CB80CFDBF7647EE0DBD76E6DDBF115D
        7F2E44FFF05490210F090C988048425245F6C0E4F77138E73A5ED9D1B61E808D
        DF82AEA92F61FB8635985DCF67212268AC1097F67D8F17B63C98AD4C59F0C535
        73FE78F6EE0747DAC2B7C7152E229406030809EBD1311722C4A90C24997593F7
        4FCADF8A68880098A18FF9CF9D843A32FACB3A38F0F559ECFEF8B8DA81CEB330
        A1C02C82022056E29D9003C04059444DC48558C21423330D70ECE77E3CD17697
        DA97477FBBC1B79A10A6C7B1044E8843874FE162DF5F69F440FF8A9639F9AB34
        5966EE2BA1E06CDF08FAAE8E409C27F9A38E33B8D03BA84C34CDBE059BD6DDA9
        7E47C901306A423CBEBA0575AF8548A1F6AF8CA1F3686F8E7B66D6A0A7D5CA75
        43D2F3F8EE642F36B5DFA7EB3DEF7F1301D0CA381A10899C9A24405A0245CD70
        CEB2EA6085A83B07EBC4032074DDD33788AE333558AB3EEF274B1A508ACB3D96
        A158A4A0CFDC46835EF9DBA236380A6B05F0ECE9DA3AC2799F0ED2953420422A
        E5D50693036109506965F47D78A807E77BFDE3A469EE746C7EEC6E0D60297002
        9F2DA0D7F795218BCB43637A9EB0672D730004C0D8C0407FE7EB6F1D5C4B9A5C
        6D290E6B1F5A0C7112FD478EFD8EA79F5AE92F953D1D0A20C95484708A1ABAAF
        8B40AECF5652B6444A0086DF7B636B3B8029002A8566ABBE0D4CDDF5E667DD61
        AF017EBA3888DAD55188739E6EEB942547812DFA8410972981A41AA806B2EBE1
        C93C546ADFF0AD708CAF410D707968F45ACDEBB16BACF35D20C248B773A2D93A
        4AEC0CF54BBE04CC98437928409148A106D0EE846890A4DE5608A10748E3B5E0
        C40BDCD65DD4903003806449D3854703834A754502CD4D33F0D5C16F4110AD4B
        E729C296A6DB70E8401720C403CBE66B7ACD0BAEF9F61D0641AC5C3E3FCD34AB
        8109FEF331CE4944B873CB2AEC7C76556C51638097B73EAC963ED5805DCF3F8A
        57AF59FA78892D97A9EFC40613A61AAB0D98E820399E332901270A4000D46BB5
        818E175FDBDF968154BAB488BC8B1498C888BE4A9489FAD84847103EFF0D0083
        8DEC7D67DB460093429B1ADCF488D8243CCB4600C8441820001B5A74F83FFA0B
        2FC1F80F3A60C142BF5AE3F00000000049454E44AE426082}
    end
    object LargeButton_Arcing: TdxBarLargeButton
      Action = Action_AcyingDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000013744558745469746C65005461626C653B466F726D6174
        3BEEACCAE30000055C49444154785EC5975B6C54551486BF3D733A504A5B2E4D
        AF289482B160A1186B34818297A84151D078A9269A20C19868343E184DA00541
        499A4822311A6F2412318A412D314605A1064DAC256D80524A5B0A28502E12B5
        C865A6E7EC65DB9DB337D349139010FE764FD73E6B67AD7FF5FFCF391925225C
        4D785C060EAFBB0B000110219C45101073CDE4A078D156D5F5E16D665E731011
        B93C025A0B82E08A42F1D35B55C77B736A263F53FFDAFEF76FD320942CAE8FEC
        7BA7B27AE2A26DCB3BDEAD342705434029C5FF45DF44889869416103D135AD6F
        57AA92C5DB9603B4AC9955834835B022087460080848B204CAFEBD48F44D442A
        88EA4093533EBFBAF94D3F0242EE8C794BFE6CAE0350939FFA80B68F1622E224
        50661131CB10B84432117075025F3366EA6CE27FFDB104E5317ACA2C8E376E04
        8845334B15A001D9597BB30E9B7B0FADDCBA5945A2B3B9444CBD369BD9DE0FE4
        767F6574353F5C5FB51449FC838A8D41E2A7D8BBE1AD24B3267CFDFA2D4B9A96
        7A21EBFEE6CF55950FEDF8A33D1415643118A3867B64C62673E8EB738CCFFA93
        F17754010A7DF6307ECF4114071084D2475E400DCB61FFE6CF69FB71F3AA051F
        1F5E06E025E92ED07AEC0CA980F6BD27E851111073549458958AB263A44D5FC8
        D9039FD0B2F6654A6E2D23121B814A1B8E6810FF6CBF1CB4D537D2D576ACF6B1
        4FBBAB81A0EEC9427104426144408112851042CC2D276E6F7EDDEDA8B5263D3B
        0372F38080DE539D88084A8C248830726C26A30BCF69E8560063C78DC2121011
        440BE6AC32130A165A34F60676A0303B8DC20C8FD34DEB89A6EF256FDA34FCBF
        BB103F11EA6D091494E4E1A567BCF2DD4B5ADFB3BA7DD9CC375A7D054481E10F
        AEA8FFF7DE99E369DA77120BDB5061CAB8BD18364CCACFA4EC741D19EDEB11C4
        929C52310ED0F621D5D2700411530B11CE25F4CAB96B3A6B3CD74BB8A6681467
        BC188880324D190815ADBB7EA7B4EC9A646E4061568C9159CF727C5215B74FCB
        A7B7B797965515A811A3D9BDA59978DC67C6CC71F87EC09DAB3B0B801EC00702
        C079604047C14E861650D809B426E9596F9270E4EFF8C0DAB3B39BCAA985789E
        871F0474FCD641F4BA2A460874EED988F67568B3C4F7CF17FBA24D15474084FE
        8536C54501DAB85D0968AD4DDEC2C5624C6AAF057E40227F1E658FBE02C0EECF
        409F5C0780C96B33A8084E026DA6D4E25C8E0BD181E0FA277B03145A1BBDA3D1
        28F9B31633E1EE171122A0A0FCF157D97EFE3C50AB438260EA390944D3D17992
        DD7DCBD5B79298499A0E2691B21041507CF96D13F9B959907D1F871A3AE93ED1
        03C0F4D2228EE5CEB70474A03104947B17680DC51373D023D371CD31EC4C736E
        B8718223E73882825D3B0EB0606E854B82F5492C16E19B2D2DF6E2036B8FDAC1
        228410A3B16810B33501C69C41202098BC80202667E5339A0AB86789D9200326
        D6A92FB71413EAB080B8B3A24C01D16824C58396CA85CD81E44F45A04D343401
        6B4241D9C28E08E184E2865018EDC19077B20C42CA7FC0BA37F92EF8B5A18BE3
        A7CED8E1060FDCDC974F31883BC686BA464BDA761028C8CB360453B939139667
        C659FA4439F184B6FC2C55055F6CDAC1C3F7DF942A811210D8B0A9B12F5FE194
        135766589AE2971D9DA4022238099C696C773705615E9275161323E21A639B87
        EA2974602550A90430DA0B20AEAB2B0E685C77D71C0B67C2B096846C6CFDA14D
        08225A03422C4D0191643B09E4E66491168D849752E4CC1DDB9F3749543884B2
        94C53E6291C10434D01B4FC4EBAB6BEBE6882BEFFC6628B2BDA17DB001DC2184
        9F1B3BDCDE991551E0C7CFFF0424061308C7F58061400C88920CC5D0505C1C34
        1007CE03BD4611B112887D3F9B038A2B036D1632D4048A2B0FB18198F0AA7F3B
        8E7095F11F31E5524635A15C3F0000000049454E44AE426082}
    end
    object LargeButton_Sensor: TdxBarLargeButton
      Action = Action_OpenSensorUI
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D22D0
        A1D0BBD0BED0B95F312220786D6C6E733D22687474703A2F2F7777772E77332E
        6F72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A
        2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230707822
        20793D22307078222076696577426F783D223020302033322033322220737479
        6C653D22656E61626C652D6261636B67726F756E643A6E657720302030203332
        2033323B2220786D6C3A73706163653D227072657365727665223E262331333B
        262331303B2623393B093C7374796C6520747970653D22746578742F63737322
        3E2E426C61636B7B66696C6C3A233732373237323B7D3C2F7374796C653E0D0A
        093C7061746820636C6173733D22426C61636B2220643D224D33322C3856366C
        2D322E352D302E324332392E342C352E332C32392E332C352C32392C342E366C
        312E352D312E354C32392C312E354C32372E332C33632D302E342D302E322D30
        2E382D302E332D312E322D302E354C32362C30682D326C2D302E322C322E3520
        202623393B4332332E332C322E362C32332C322E372C32322E362C336C2D312E
        352D312E354C31392E352C334C32312C342E37632D302E322C302E342D302E33
        2C302E382D302E352C312E324C31382C3676326C322E352C302E324332302E36
        2C382E372C32302E372C392C32312C392E346C2D312E352C312E356C312E362C
        312E3620202623393B6C312E362D312E3563302E342C302E322C302E382C302E
        342C312E322C302E354C32342C313468326C302E322D322E3463302E352D302E
        312C302E382D302E322C312E322D302E356C312E352C312E356C312E362D312E
        364C32392C392E3363302E322D302E332C302E332D302E382C302E352D312E32
        4C33322C387A20202623393B204D32352C392E33632D312E332C302D322E332D
        312E312D322E332D322E3373312E312D322E332C322E332D322E3373322E332C
        312E312C322E332C322E335332362E332C392E332C32352C392E337A222F3E0D
        0A093C7061746820636C6173733D22426C61636B2220643D224D32302C323476
        2D34682D342E33632D302E312D302E322D302E322D302E342D302E322D302E36
        4C31382C31366C2D322D326C2D332E342C322E36632D302E322D302E312D302E
        342D302E322D302E362D302E32563132483876342E3320202623393B632D302E
        322C302E312D302E342C302E322D302E362C302E324C342C31346C2D322C326C
        322E362C332E34632D302E312C302E322D302E322C302E342D302E322C302E36
        4830763468342E3363302E312C302E322C302E312C302E342C302E322C302E36
        4C322C32386C322C326C332E342D322E3620202623393B63302E322C302E312C
        302E342C302E322C302E362C302E325633326834762D342E3363302E322D302E
        312C302E342D302E322C302E362D302E324C31362C33306C322D326C2D322E36
        2D332E3463302E312D302E322C302E322D302E342C302E322D302E364832307A
        204D31302C323520202623393B632D312E372C302D332D312E332D332D337331
        2E332D332C332D3373332C312E332C332C335331312E372C32352C31302C3235
        7A222F3E0D0A3C2F7376673E0D0A}
    end
    object LargeButton_StartCalibrate: TdxBarLargeButton
      Action = Action_StartCalibrate
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000011744558745469746C6500506C61793B53746172743B5D
        61407A0000033749444154785EED976B4C936714C70708132246F701AFDF345E
        1287A0CBA8B88143528116A9A19B3A0C0A2A83C5BB84459449A814CB2C0222D6
        AA9442413BE805A40349AC73502E8582D5459009D6E2050D112F215996E07F67
        A43105D9A7DE62E29BFC3E3C39E7C9F93DE7E4499EF713002E65CA8003BF0F53
        E0A3809BE8DA46E599ABAC79AE12F0103544837871B68EB58BBD6DA9BBB3053C
        CFFEC646CB800CE2DF77A348C3D616D4442D72A680D799AB5178FEC68887231D
        A8D21F03AD470BD491A9FBF841D39C2290AF8EC4D06B038C4F2EA17F58838E87
        0A88B5C938AD8AECCCBDC20C70B88050B1014F5EB5A3D35C38CEDDA14A98475A
        A1EEE48162FF9CAA669E387A2E64BAC304727F6562F06533F4E68209F43CAB86
        F1711DCE5FFF110239B3975F111EE210819CCA700C0C37A2DD74FA3DBA06C5E8
        7DA644AD4100CA1BCB96AD2FCE1087CEB4ABC089F230DC7A24856E40809607C2
        29A1388DA61E25DABDE0958599B3A4DFB0EC2690295907BDA90835B713D1D49F
        035D7FEE94B43EC883F1511934DD42FCA2DC8CE325A195E9A2AFFD6C16C8B810
        42054E416EF80E8AEE7868EF1D47D37DC1FFD26E2A46CF53158AEB13417B9F93
        80BB4D0247445FE1461F0F959DB116B850DFFE01DABE2CDCFC2BE71D7FDC3F49
        57F43C8D4306E9CD03A07D63A985C11212F0B04920AD28188D3DE990E93913A8
        D06F4255573CEAEEEC278193309825D018F9D4FE2D3898C7F8939BB29C4DFB67
        D82C70289F41450E42DA163D1992E0D25876427D2B05997226150E7A9D7034E0
        671F5F4F3F92F726A6116E3609EC177E09557732242D5113B8DCB115CAAE2408
        6AD9A09CB74959AB546B22167E6E39B5A7F5EC6D12D823F80272C30E5CD44580
        A09373C6D7A21BB1482B0D454AF6AA3ECEEE255CCA9D457C6A69B99BDDAE610A
        7F3564ED9B71A179034A5B6250D6C6457AF93A2467AF1EFDFEF00AFE6773BCE7
        529ECFE476DB4D20891708898E43C480A7588F3D850C6C4FF7AF67442C08A4B8
        EFE476DB5D60676600F21BC37140BC163B8EAD34B11216C751603631DDBADD0E
        1348C8F0A7C2FE7F7FBB77599EDF429F05D6ED76CA8B28EEA7150D4111F319B4
        98497811EE4E7D1312DED6ED76FAABD87262B78F3F268E127025AE17F817914D
        393A88580AA50000000049454E44AE426082}
    end
    object LargeButton_StopCalibrate: TdxBarLargeButton
      Action = Action_StopCalibrate
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000B744558745469746C650053746F703BBA6D204F000001
        9449444154785EED963D4EE44010855F7B3C1EEF0C22580948B806E966408044
        46C00DE0289C000E40468644C08FC81129270089804D4033F6D8EEAE2AAA2548
        61DAED15AC9827BDF0933EBBAA5B9D8A08BE32A9F67B09CC058C31F8571191FF
        6F0473017374BE7D620CB600E4084B2582B3BDCDD31D00D2562061E6AD8DB5FD
        7C215B8631C98CCBC698344FF9C5EDA117F710B51620927C98FEC6FDF3354418
        B3C48BAE2EFE816763050C39068340EC3073E48D515663A296D0390671036642
        483CE3599F480182A50A248C9078C6B3F1029651347FE1C8062DA1329E8D17B0
        9651D917BC4C1F30CC969026838F85B946A9C2A36C45D98E46D0B8A9B6D23EA0
        DFFBA55DD0E6488CC705CC0E966B589A68A7D078A6BB1134AE783F05201EA3B2
        637C1665BA1A01A1762528F01428A36C474B58FBAF611728A04C573BA0022DFE
        40D1D10E386E3B826E2E22725C97F564D0EF0D101265E0D95801A92BBABAB97C
        5C0790212C8DB37C05406204F8F8E06E17C048DB4358485B68394A405B6A2BAD
        415844CBB102A225DF9FF32614919FF52A9E0BBC02BD9D14ED749B485E000000
        0049454E44AE426082}
    end
    object LargeButton_StartSimulate: TdxBarLargeButton
      Action = Action_StartSimulate
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F400000016744558745469746C650046696C7465723B417267756D656E743B17
        84C1610000078249444154785EE5556B8C5647197ECE65D91BCB750B5E1629D2
        D272ED5A20A95C96A8D8D46831A61A43225563D428057BD1904AFD518A1A8B50
        A09252A8290DADA0052B9484B402BA5B5B2ECB1DCB82202C0BCBB737BEFB77CE
        9CB93A3339275DDBB07CFFFCE1244F66CECC64DEE77DDE67E638F8EFE6247D0C
        D7F61F5D53F158C590B6EF3F9F0C94C240CD4F02F683F7D48AD51F6F68183BDF
        F3FDD9AEE34C530A9E729C0628D44B29FB84109D4A41704E4F87243C78E5D285
        7D2FACFF750A00B764124265B4FE997ACF6FDCF6D59A9AC1CBEA86D64E1F593F
        1CA3478DC0E0C1B5F6ACBABAC1F07D0F9C73E4F34598C40A8512AE5FEF412AD5
        8B4C267B3C97CBAE5AB1FC91DD009886D090032A9048FCC4B267466DDAF2973F
        DE35F18E3FDDFFC0ECE973E6CEC0A8D1F5B8DAD587BF36B7625FCB51AC79613B
        D66F7A1D5BB6ED45EB890BE8E8EC85500E264F9E80050B3E8F871E7AE0DEC6C6
        A9DB563EFBD2F6850FFFE89300BC38B95B96C0BB63C2A417A7DD73D783953555
        D8BCF54DE47205F89E0B2E39189736F3C135B5A8D0BDEF79C8158B904AA2580A
        41488451F5433064482D9AE6CDC4B061431EA49C99E05F8F5550B722E02AA5BE
        307EFC18FCF8B167505155A50FAB83549E0DAEA43140EC2BA5E0380E3C0DDFD5
        3D1C5455F97A4E824421A24860D2A4F1D8B367FF17E3B369390AB88C73379B2B
        E1D1C5DFC2C6975EC3E54BDDA8A9AA848207CFAF40A51E1B35A0183867902202
        E31A8CA0BA1620CCD7FBAB3162F8489CFAE7250821ACBFCA2D0138E3A9B6F357
        C6CD9C31011B9E7B1AD73A53B8D4DE8173E7FFADC75DE04CE0DCC536D4D454DB
        40B7DF3E06631B3EA1BF8762485D1D6EAB1F0913F3EDFDC770F0D069547B229B
        042F87808A284D854138AE902FE95A0FC2A7C68CC698868F61CE6767820B0546
        39AAAB2BADFCC6D53DBD1950CAD0DB97C1FB673B50082EA0A72B837CB1043812
        94D2F6E45D288B40502AFD2D93CECDCAE6029D4D1D2A2A4C5D1528A35A810CD2
        374AC8974204A500C520B0D7AEE3DA750821515F3F0CF523B4024A817301708E
        889023D6806534574366D27DCD7D7D7D48678A2895A8CD520A930947A1484018
        03D3E042D872302EED2DF07C57C3B735A79C834A0EC5234DB87B6F7203CA22B0
        61EDD3078B85C2899EEEB496358F524011461C4140350868446D00A661A4A782
        43C181EBFA18A44DCAA500631C2C0C20053FF5E69F5F7EAF6C02F12676A3AF77
        755BDB39B477F4225F0841428A4C264018462011B5DF11E1208C83460C52724D
        C0B14428E3882282A8904726DDB31640A421CB36A186D8BC61E5AEC58FFFF28D
        33A7DBBEE63AC050FDB0302610680221B100214C7F870835A05C4DC005A51168
        C491EDED81E464F7AE1D9B7701E0C97FC518B7FF0FEB2604EC223DF2DEFEC766
        DEF7B9C9126AC2C4BBEF84E739286A6797C2C84A1F528A5231000D23EB11CE98
        F64C805C3A0DC5828BC78EFCFD090044433DBAAE71BFEBA3090A905235AF5D7A
        6A7E4CEC2304A033971BD62CE7AD870E742BE0CBF7DC3B6B676F57CFB4899327
        C6462C815063446EB3E7228264121402057D435C8833A74FBCFB8D7FB51DBF0E
        80DACC5DD5F4B345EB61DA6F5E59320F807B330F5867275E387AE8C0B5BDBB5F
        BBFF464F6ACDD1C347A20BE7CF2322D4980B2408ADAE159E89C040833C8DC2FC
        DA7D7BB77FE9EC99C357FBD75E2A85AEFC091CBEBCC9DEAA011FA6EFFCE0E7F8
        F6F70D9E4C480DD2183AB571F667BEFBC3E5ED2B56BFAAF6B69C5427DBDAD51F
        76BDA31E5FB6523DFCBD65ED774F9A3113C0708DCA0FFDFD2A97AE9BA25A3B56
        A99D2717AA256BA72800D586BB593388C78E2DC1964DBF42BF26E35A85674EBE
        DB31B5F1BE564AA3B1AE3513ECE323A542488263E7CE1E6D37FBE2A015FDFCE4
        9A3D5C469052260AF8DA176F79BE3B1750E05CBEB3EE27A7E6FB371145C5F798
        51423A35E02404A480E00C8CD2545C6F471FFCB6EB3B73ED3AB7077F45490921
        29A412868425E07A98FBD345CFC1B4675F596AF67B3E066E9244512A22D10704
        B800E71C84849D3151D7713177F13797DBF5E7B7AD30447CE30126987D31CD38
        5125953F8EF61B47210CA9A40403A820C3A0D049C2008EEB984C2E0641694FA1
        50BCDAD7DD792096DB9352E0F28D7F201F7643081BCC318185A09092DB2B6BE7
        A4B4A484E0892A8E3B4070DB170BB9EB24B42530596F6D2FAE5E70DBF4E6D573
        16F59D78E4B753DE32044C368C5370134C0380ABA4B2D755580F483B67CAC725
        81501CB25C05BABBAE76368C9D0053014DA4C491FDF49285BFB0CBEBB6AE9805
        C037C664D2101010FDB335265442235645487041203ED807170337D57EE9FD34
        E73C97CDE4A07B1BE0624F0B8E5FD9610E8A6BCB4145082158525BD79480C71E
        50F19C554AD0B80462C01224101A2493EE7DF2F71B5FBEBA6AD5EF1CFBEB1511
        9846922D379971FD6DEB2DEC9C52CAA862A54E1430849920A654E5974083B4EC
        7FFD55003B349C714D77AE623C00152C51C006658299831305EC5B2112052C01
        D831E351FFAB091FB76E5C23887F3283B2D9B065C7CE9626138786A2194094CB
        46CDBBDF689DA700B050B698B9740F69D9BEADA5C9C4A644D9B95447A9E5C5CD
        BB9A0C39C6EC3EE6A0BC96EC4B9EE984383788BF2BE23936C05CC587E688ADD5
        FFB2B91AFFDF04FE0379781A0C49593EF70000000049454E44AE426082}
      SyncImageIndex = False
      ImageIndex = -1
    end
    object LargeButton_StopSimulate: TdxBarLargeButton
      Action = Action_StopSimulate
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
        F40000001A744558745469746C650049676E6F72652046696C7465723B46696C
        746572B3EC78CB0000093649444154785E9D947B7054E519C69FB36793BD6737
        61B3096123C44034444003192D5E50C156C63256EB4CA7338ED5B6FA8738B4D8
        19D0D2918B58ADAD48A9A8152C8250DA516B11348C035A3B9500922097981002
        C690DB269BBDEFB97EE7FBFACE999D49EC8C65DB77E637E73BDFEEE479DEF77D
        B24E21042449C2A492269E368E4977939FA2701605F8A433263D411AF8A6724E
        169E84FCAB0D2F4C8D46A72F919DCE1B1D92345708C84292A2100873CEE39665
        0DD29DC598715AD5D4B6AF2E9E3FF4CA966787013082DB4C98B88C81894EE53F
        BCBAF76EAFD7BF3A10F4CD9F122E4755A4027EBFCF6E2810F0C3E994C1180B67
        32B9B01040369B6F1E1A1A7D305219C1CC977677A4D3A9DF6E58F3D87B004CC2
        22F87F35205101907EB1FAE9C8558D735E9E5137ED7B8D8DF5A0CE319E48E3D2
        F0280606BF8024015FF68FC0ED2A85D7E3466D4D3522952194057C686A6A404B
        CB1CE4724A734747E7DE8DCF6FDFDF79B67DC5DE5DAF0CA2B096CB4D409ED930
        FB8F73E75DB5CCE57563DB9BFB914E67E1941D609CC164DCEEDCEFF5A1849E4E
        59463A9703171CB9BC0A4DD3110997A1ACCC875B16B520142A5B66305306701F
        615DCE803D7E21C4E2FAFA5A3CBAF26994B8DDF4C7022420DBE2820BC8A290AB
        426865C2E9A02724B8DD4EBAE3D07415BA6E61F6EC7A1C3870F88E4283463119
        70988C3952E93C7EBEFC7EBCBA7D0FBEBC1883D7ED0249D33A4AE0A233E30C10
        261833C12D9DCC11A6068F0FD04C277DDF838AF2293875F62228A413C12EC200
        98C986BBCE7D55D7B2A0015B5F5C4F7B1FC6C5BE7E749FBB40E71130D342776F
        17BC5E8F2D3463462DA6476BE83D483908A0323C8544810F0FB7A3EDE8697864
        2B35217E790342378C615551EBB2993CEDBA1457D456A1365A8D9BBED5026609
        980683C7E3B2C72F84C0E858128661622C9E44E717FDC82AE7313A9244269707
        244E9F197D13012CC28092CF7F9C4CA417A6D20A751340498993C4040CD3A009
        249118CF23438153F20A728A82E1E131F40F0C51D71CE17008E10A9A801060CC
        021883AE69C70158C54C40103C99887FE2F6FAD6249239E4F3E50806653B7C86
        C190CD69D04C1326C12CCB5E0785135C70CA878370DA3B3748D8E00C82E96438
        D60AC02A76027CEBE6F56D4FACFDFDC9D158E2BAB1CA209C25B23D6E4531080D
        866ED8022641A38761911024381C4E9452481927532683A92AE0163BB5FF6F3B
        8E14654050919000608EC7C75EE8EAEADE1D28F3C3E777C3456B482615A8AA0E
        4D37A1A906748D41232183DE396764A0D43662D09DAE6BD0B31964D3639B01E8
        042F3A8484B56DEBC67DCB1F7FE6DD33A7BBEE714840B0CC475D5950C880AAD9
        40D34C7A57A112100E32E08061E8695D338E276223E798966DDBF7F6B67D0018
        2181A042FBBAF5820A829930294B74C2C217377DCD00278CE3470EAF6CB9E1B6
        260ED1D078F52CC8B2841C253BAFEAF6E855C3403EA7C0A0776E71CB34F40F8C
        8C7EBC59E49AA3D58EDB8272F9BDABD7AEDB43620316E7DDBA69B61EE9ED7D63
        FEBAB5A9F8FEBF72700BC6781CBD1DE7BF360150E77CEBA635ECB3A31FC50470
        D7BCE685EF8C8D8CCE6D6C6A2C04310F8D0CD09EEDEE99A5E5986E6D9BE7522B
        5ADCF2AA604528E02DF7A3D4EB41A9CF0523A746F59C12CD27B24B1661D6EAFD
        8FAD58195EF683B700B0C1D73609CEACFFFC21B22F04619E38FAD1C0D0C097DF
        BEE5B6BB579DC865977BBC3E57684A045C58D01415126039606DBFABCCBCFA9A
        907B69B87E1A85B6045A2683547C1CDC34E0F25086023E5446C3F0857C11E9E2
        D09ED6471F9BBDF4E597D64F7BE47176E8A78F88C906EC00FDE8E15F0A40583B
        B73D2BC840F22F6F6EDE30E7DA1B772FB8FED6773DD1DAE92D2DD7606A650867
        BAFA5A954F3EA86C0ABA974E6D9A012D9985AA1AF05FD9888A5933E18E4C8311
        8F411FEC87D9730A340F441BA6C1EAEC5BB3F7FE07CEFF70F7AE3D16A5F66B06
        DE78EDD798549C60847AE6F34FFBE75C7BC36714B4E90EFB5750A4F5C4F8D17A
        A6AD8ACCAC87323A0E11A840F5ED4BE0AEAA0104EC2AA5B3D173063C9D860007
        2415E1EA2032F1C4733F695ED0FA9D5D3BC6C4CE3F0927BEB9046111A6A16983
        0428CDE0DC6AF39F3FBDA0CC5F5A66E5B3D085849A454BE08AD4400800848040
        EE9356A89D27ED8BF47816A19A085C3C039F5BAEBEB126FAE0EB1D273601604E
        5CBEB8A6EBC3BAA6DB064CD3EC75274697FA674C41666000A1858BE1AEB6C50B
        EA40E6E303D03A3B0041E2F12C2237DD0C47792552EFFD197EB7048FE4580660
        4B310604C155253BA8A90A24876D60DCA12855AED208F2C35978EAEA61814312
        126CF143FBA09E6D0784DD392237DF0CEFADDF85111B043774944282C4F9D500
        6402975B8144885C363DA4A9F60AC04CA672C3F0489609C118DCD119105C8093
        60A6F56D68673B408574228DC8C245F02DBE1B1C80A3B20A9C31DB2837591074
        45A0A809C4462E0D46A73780F4097875CB524D55F7973825684397E08AD621F5
        EE4E281D6D0017482672984AA1F4DFF97DF0422F2C36641B364D0EC334332854
        3119107D173B13F3E62F4AA792E96038E40F2B1CA3F94CDE5FEA00B4DE6E28C7
        FE01B5FD883D896492C417DF81E03DF743D0CA04247B1D5ACF17B6819C6242D5
        B45E00BC580316A12513634FBEFEEA8E2721E1AAEB32CAC99A51F9CA2B225E28
        FFFA1056266D8BA45279FBDF3178EF03E0920C89EE04C14687A07E7E0CDCB210
        4F6A882BCAFB0058D12B20B47F1E7E6B3780B709E778A4DA3B93CFBDB5325032
        C5A52A76E7A9B44263BF03A1FB1E02A515029CC4618F3EFBE1DF69029D48660C
        8CC4B3E30707FB771567600246288446388E8E8EA4EF9C5ABBB6B4477A69765D
        10B2E028AFAA84B3AA06066542AE9E06363200FD5C2734EA5CBFD005D3B07061
        2883BE6C66C3A7F158EC7F5981283C790110D2BA539FED7C66DE827A5DD356D6
        55FB51CE4CA4DEA1C60A6387E004ECF3785627F11C06F2CA96DFF49CDD0140DF
        32BB59140CD85F42B1465E5B70136E5F3A5FCCDAB8455973EAC453AB1AAEB990
        CBA91BABCABDA170A01401B78C1227609816B20A432CA5219654535F69F9A736
        F7F5EC0490EFFED98FC5C183ED983481E26126032C8E9E2796F386E7B6E69FEF
        39FBFAF5A1F0FB4BF2550FFB9DF212B724CF7400154C888466B1DE8C691E3E94
        18DDDE9E4D0E03D0BA573C2420042CC6FF3F039C311CDCD70601812D8DD78915
        5D27F563A9F825622380E7099970108260845180FFEECA267160FF3188498BFD
        37F99759150253FACD0000000049454E44AE426082}
    end
    object LargeButton_Data: TdxBarLargeButton
      Action = Action_DataDisplay
      Category = 0
      HotGlyph.SourceDPI = 96
      HotGlyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D22D0
        A1D0BBD0BED0B95F312220786D6C6E733D22687474703A2F2F7777772E77332E
        6F72672F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A
        2F2F7777772E77332E6F72672F313939392F786C696E6B2220783D2230707822
        20793D22307078222076696577426F783D223020302033322033322220737479
        6C653D22656E61626C652D6261636B67726F756E643A6E657720302030203332
        2033323B2220786D6C3A73706163653D227072657365727665223E262331333B
        262331303B2623393B093C7374796C6520747970653D22746578742F63737322
        20786D6C3A73706163653D227072657365727665223E2E57686974657B66696C
        6C3A234646464646463B7D262331333B262331303B2623393B2E426C61636B7B
        66696C6C3A233732373237323B7D262331333B262331303B2623393B2E426C75
        657B66696C6C3A233131373744373B7D3C2F7374796C653E0D0A093C72656374
        20793D22322220636C6173733D22426C61636B222077696474683D2233322220
        6865696768743D223238222F3E0D0A093C673E0D0A09093C7265637420783D22
        322220793D22362220636C6173733D225768697465222077696474683D223130
        22206865696768743D223232222F3E0D0A09093C7265637420783D2231342220
        793D22362220636C6173733D225768697465222077696474683D223136222068
        65696768743D223232222F3E0D0A093C2F673E0D0A093C673E0D0A09093C7265
        637420783D2231362220793D2231302220636C6173733D22426C756522207769
        6474683D22313222206865696768743D2232222F3E0D0A09093C726563742078
        3D2231362220793D2231342220636C6173733D22426C7565222077696474683D
        22313222206865696768743D2232222F3E0D0A09093C7265637420783D223136
        2220793D2231382220636C6173733D22426C7565222077696474683D22313222
        206865696768743D2232222F3E0D0A09093C7265637420783D2231362220793D
        2232322220636C6173733D22426C7565222077696474683D2231322220686569
        6768743D2232222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
    end
  end
  object OpenDialog: TOpenDialog
    Left = 864
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 904
  end
  object Timer_InitSubGroup: TTimer
    Enabled = False
    OnTimer = Timer_InitSubGroupTimer
    Left = 968
  end
  object IdUDPServer_Hv: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer_HvUDPRead
    Left = 1064
  end
  object IdUDPServer_Lv: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer_LvUDPRead
    Left = 1064
    Top = 48
  end
  object IdUDPServer_Acying: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer_AcyingUDPRead
    Left = 1064
    Top = 96
  end
end
