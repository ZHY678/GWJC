unit UDrawThread;

interface

uses
  System.Classes, VCLTee.TeEngine, Winapi.Windows, Vcl.Forms;

type
  TDrawThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure DrawLine;
    procedure Execute; override;
  end;

implementation

uses
  UI;

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure UDrawThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ UDrawThread }

procedure TDrawThread.DrawLine;
var
  TempResultData: ^sDataFrame;
  TempRData: sDataFrame;
  I: Word;
  tmp0ChartValues, tmp1ChartValues, tmp2ChartValues, tmp3ChartValues, tmp4ChartValues, tmp5ChartValues, tmp6ChartValues, tmp7ChartValues, tmp8ChartValues, tmp9ChartValues, tmp10ChartValues: TChartValues;
begin
  if Form_UI.DrawCache.count > Form_UI.drawThreshold then
  begin
    if Form_UI.paintCounts + Form_UI.drawThreshold < Number_Draw + 1 then
    begin
      for I := 0 to Form_UI.drawThreshold - 1 do
      begin
        TempResultData := Form_UI.DrawCache.Pop;
        CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
        Dispose(TempResultData);

        Form_UI.DrawData[0][I + Form_UI.paintCounts] := TempRData.LCZ11_value;
        Form_UI.DrawData[1][I + Form_UI.paintCounts] := TempRData.LCZ12_value;
        Form_UI.DrawData[2][I + Form_UI.paintCounts] := TempRData.LCZSP1_value;
        Form_UI.DrawData[3][I + Form_UI.paintCounts] := TempRData.LCZ21_value;
        Form_UI.DrawData[4][I + Form_UI.paintCounts] := TempRData.LCZ22_value;
        Form_UI.DrawData[5][I + Form_UI.paintCounts] := TempRData.LCZSP2_value;
        Form_UI.DrawData[6][I + Form_UI.paintCounts] := TempRData.DGZ11_value;
        Form_UI.DrawData[7][I + Form_UI.paintCounts] := TempRData.DGZ12_value;
        Form_UI.DrawData[8][I + Form_UI.paintCounts] := TempRData.DGZ21_value;
        Form_UI.DrawData[9][I + Form_UI.paintCounts] := TempRData.DGZ22_value;
        Form_UI.DrawData[10][I + Form_UI.paintCounts] := TempRData.SPJL_value;
        Form_UI.DrawData[11][I + Form_UI.paintCounts] := TempRData.SPGC_value;
        Form_UI.DrawData[12][I + Form_UI.paintCounts] := TempRData.DGBHL_value;
        Form_UI.DrawData[13][I + Form_UI.paintCounts] := TempRData.DWDGC_value;
        Form_UI.DrawData[14][I + Form_UI.paintCounts] := TempRData.JCL_value;
        Form_UI.DrawData[15][I + Form_UI.paintCounts] := TempRData.JCL_mean;
        Form_UI.DrawData[16][I + Form_UI.paintCounts] := TempRData.JCL_max;
        Form_UI.DrawData[17][I + Form_UI.paintCounts] := TempRData.JCL_min;
        Form_UI.DrawData[18][I + Form_UI.paintCounts] := TempRData.JCL_std;
        Form_UI.DrawData[19][I + Form_UI.paintCounts] := TempRData.YD1_value;
        Form_UI.DrawData[20][I + Form_UI.paintCounts] := TempRData.YD2_value;
        Form_UI.DrawData[21][I + Form_UI.paintCounts] := TempRData.DL_value;
        Form_UI.DrawData[22][I + Form_UI.paintCounts] := TempRData.RH_value;
        Form_UI.DrawData[23][I + Form_UI.paintCounts] := TempRData.RH_time;
        Form_UI.DrawData[24][I + Form_UI.paintCounts] := TempRData.RH_numb;
        Form_UI.DrawData[25][I + Form_UI.paintCounts] := TempRData.mykilo;
        Form_UI.DrawData[26][I + Form_UI.paintCounts] := TempRData.mark;
      end;
      Form_UI.paintCounts := Form_UI.paintCounts + Form_UI.drawThreshold;
    end
    else
    begin
      for I := 0 to 9999 - Form_UI.paintCounts - Form_UI.drawThreshold do
      begin
        Form_UI.DrawData[0][I] := Form_UI.DrawData[0][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[1][I] := Form_UI.DrawData[1][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[2][I] := Form_UI.DrawData[2][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[3][I] := Form_UI.DrawData[3][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[4][I] := Form_UI.DrawData[4][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[5][I] := Form_UI.DrawData[5][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[6][I] := Form_UI.DrawData[6][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[7][I] := Form_UI.DrawData[7][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[8][I] := Form_UI.DrawData[8][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[9][I] := Form_UI.DrawData[9][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[10][I] := Form_UI.DrawData[10][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[11][I] := Form_UI.DrawData[11][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[12][I] := Form_UI.DrawData[12][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[13][I] := Form_UI.DrawData[13][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[14][I] := Form_UI.DrawData[14][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[15][I] := Form_UI.DrawData[15][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[16][I] := Form_UI.DrawData[16][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[17][I] := Form_UI.DrawData[17][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[18][I] := Form_UI.DrawData[18][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[19][I] := Form_UI.DrawData[19][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[20][I] := Form_UI.DrawData[20][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[21][I] := Form_UI.DrawData[21][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[22][I] := Form_UI.DrawData[22][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[23][I] := Form_UI.DrawData[23][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[24][I] := Form_UI.DrawData[24][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[25][I] := Form_UI.DrawData[25][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
        Form_UI.DrawData[26][I] := Form_UI.DrawData[26][I + Form_UI.paintCounts + Form_UI.drawThreshold - Number_Draw];
      end;

      for I := Number_Draw - 1 - Form_UI.drawThreshold to Number_Draw - 1 do
      begin
        TempResultData := Form_UI.DrawCache.Pop;
        CopyMemory(@TempRData, TempResultData, SizeOf(sDataFrame));
        Dispose(TempResultData);

        Form_UI.DrawData[0][I] := TempRData.LCZ11_value;
        Form_UI.DrawData[1][I] := TempRData.LCZ12_value;
        Form_UI.DrawData[2][I] := TempRData.LCZSP1_value;
        Form_UI.DrawData[3][I] := TempRData.LCZ21_value;
        Form_UI.DrawData[4][I] := TempRData.LCZ22_value;
        Form_UI.DrawData[5][I] := TempRData.LCZSP2_value;
        Form_UI.DrawData[6][I] := TempRData.DGZ11_value;
        Form_UI.DrawData[7][I] := TempRData.DGZ12_value;
        Form_UI.DrawData[8][I] := TempRData.DGZ21_value;
        Form_UI.DrawData[9][I] := TempRData.DGZ22_value;
        Form_UI.DrawData[10][I] := TempRData.SPJL_value;
        Form_UI.DrawData[11][I] := TempRData.SPGC_value;
        Form_UI.DrawData[12][I] := TempRData.DGBHL_value;
        Form_UI.DrawData[13][I] := TempRData.DWDGC_value;
        Form_UI.DrawData[14][I] := TempRData.JCL_value;
        Form_UI.DrawData[15][I] := TempRData.JCL_mean;
        Form_UI.DrawData[16][I] := TempRData.JCL_max;
        Form_UI.DrawData[17][I] := TempRData.JCL_min;
        Form_UI.DrawData[18][I] := TempRData.JCL_std;
        Form_UI.DrawData[19][I] := TempRData.YD1_value;
        Form_UI.DrawData[20][I] := TempRData.YD2_value;
        Form_UI.DrawData[21][I] := TempRData.DL_value;
        Form_UI.DrawData[22][I] := TempRData.RH_value;
        Form_UI.DrawData[23][I] := TempRData.RH_time;
        Form_UI.DrawData[24][I] := TempRData.RH_numb;
        Form_UI.DrawData[25][I] := TempRData.mykilo;
        Form_UI.DrawData[26][I] := TempRData.mark;
      end;
    end;

    if Form_UI.paintCounts > Number_Draw then Form_UI.paintCounts := Number_Draw;

    SetLength(tmp0ChartValues, Form_UI.paintCounts);
    for I := 0 to Form_UI.paintCounts - 1 do
    begin
      tmp0ChartValues[I] := Form_UI.DrawData[25][I];
    end;

    if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Conductor then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);
      SetLength(tmp5ChartValues, Form_UI.paintCounts);
      SetLength(tmp6ChartValues, Form_UI.paintCounts);
      SetLength(tmp7ChartValues, Form_UI.paintCounts);
      SetLength(tmp8ChartValues, Form_UI.paintCounts);
      SetLength(tmp9ChartValues, Form_UI.paintCounts);
      SetLength(tmp10ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[0][I];
        tmp2ChartValues[I] := Form_UI.DrawData[1][I];
        tmp3ChartValues[I] := Form_UI.DrawData[2][I];
        tmp4ChartValues[I] := Form_UI.DrawData[3][I];
        tmp5ChartValues[I] := Form_UI.DrawData[4][I];
        tmp6ChartValues[I] := Form_UI.DrawData[5][I];
        tmp7ChartValues[I] := Form_UI.DrawData[6][I];
        tmp8ChartValues[I] := Form_UI.DrawData[7][I];
        tmp9ChartValues[I] := Form_UI.DrawData[8][I];
        tmp10ChartValues[I] := Form_UI.DrawData[9][I];
      end;

      Form_UI.Series_Line1Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line1Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Width.XValues.Modified := True;
      Form_UI.Series_Line1Width.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Line1Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Width.YValues.Modified := True;

      Form_UI.Series_Line2Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line2Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Width.XValues.Modified := True;
      Form_UI.Series_Line2Width.YValues.Value := tmp2ChartValues;
      Form_UI.Series_Line2Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Width.YValues.Modified := True;

      Form_UI.Series_LineDistance1.XValues.Value := tmp0ChartValues;
      Form_UI.Series_LineDistance1.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance1.XValues.Modified := True;
      Form_UI.Series_LineDistance1.YValues.Value := tmp3ChartValues;
      Form_UI.Series_LineDistance1.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance1.YValues.Modified := True;

      Form_UI.Series_Line3Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line3Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Width.XValues.Modified := True;
      Form_UI.Series_Line3Width.YValues.Value := tmp4ChartValues;
      Form_UI.Series_Line3Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Width.YValues.Modified := True;

      Form_UI.Series_Line4Width.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line4Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Width.XValues.Modified := True;
      Form_UI.Series_Line4Width.YValues.Value := tmp5ChartValues;
      Form_UI.Series_Line4Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Width.YValues.Modified := True;

      Form_UI.Series_LineDistance2.XValues.Value := tmp0ChartValues;
      Form_UI.Series_LineDistance2.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance2.XValues.Modified := True;
      Form_UI.Series_LineDistance2.YValues.Value := tmp6ChartValues;
      Form_UI.Series_LineDistance2.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_LineDistance2.YValues.Modified := True;

      Form_UI.Series_Line1Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line1Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Height.XValues.Modified := True;
      Form_UI.Series_Line1Height.YValues.Value := tmp7ChartValues;
      Form_UI.Series_Line1Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line1Height.YValues.Modified := True;

      Form_UI.Series_Line2Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line2Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Height.XValues.Modified := True;
      Form_UI.Series_Line2Height.YValues.Value := tmp8ChartValues;
      Form_UI.Series_Line2Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line2Height.YValues.Modified := True;

      Form_UI.Series_Line3Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line3Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Height.XValues.Modified := True;
      Form_UI.Series_Line3Height.YValues.Value := tmp9ChartValues;
      Form_UI.Series_Line3Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line3Height.YValues.Modified := True;

      Form_UI.Series_Line4Height.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Line4Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Height.XValues.Modified := True;
      Form_UI.Series_Line4Height.YValues.Value := tmp10ChartValues;
      Form_UI.Series_Line4Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Line4Height.YValues.Modified := True;

      Form_UI.Series_Line1Width.Repaint;
//        Form_UI.Series_Line2Width.Repaint;
//        Form_UI.Series_LineDistance1.Repaint;
//        Form_UI.Series_Line3Width.Repaint;
//        Form_UI.Series_Line4Width.Repaint;
//        Form_UI.Series_LineDistance2.Repaint;
//        Form_UI.Series_Line1Height.Repaint;
//        Form_UI.Series_Line2Height.Repaint;
//        Form_UI.Series_Line3Height.Repaint;
//        Form_UI.Series_Line4Height.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Parameter then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[10][I];
        tmp2ChartValues[I] := Form_UI.DrawData[11][I];
        tmp3ChartValues[I] := Form_UI.DrawData[12][I];
        tmp4ChartValues[I] := Form_UI.DrawData[13][I];
      end;

      Form_UI.PointSeries_Width.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Width.XValues.Modified := True;
      Form_UI.PointSeries_Width.YValues.Value := tmp1ChartValues;
      Form_UI.PointSeries_Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Width.YValues.Modified := True;

      Form_UI.PointSeries_Height.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Height.XValues.Modified := True;
      Form_UI.PointSeries_Height.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Height.YValues.Modified := True;

      Form_UI.PointSeries_Changerate.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Changerate.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Changerate.XValues.Modified := True;
      Form_UI.PointSeries_Changerate.YValues.Value := tmp3ChartValues;
      Form_UI.PointSeries_Changerate.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Changerate.YValues.Modified := True;

      Form_UI.PointSeries_Elevation.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_Elevation.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Elevation.XValues.Modified := True;
      Form_UI.PointSeries_Elevation.YValues.Value := tmp4ChartValues;
      Form_UI.PointSeries_Elevation.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_Elevation.YValues.Modified := True;

      Form_UI.PointSeries_Width.Repaint;
//        Form_UI.PointSeries_Height.Repaint;
//        Form_UI.PointSeries_Changerate.Repaint;
//        Form_UI.PointSeries_Elevation.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_ContactForce then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);
      SetLength(tmp5ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[14][I];
        tmp2ChartValues[I] := Form_UI.DrawData[15][I];
        tmp3ChartValues[I] := Form_UI.DrawData[16][I];
        tmp4ChartValues[I] := Form_UI.DrawData[17][I];
        tmp5ChartValues[I] := Form_UI.DrawData[18][I];
      end;

      Form_UI.Series_Force.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Force.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Force.XValues.Modified := True;
      Form_UI.Series_Force.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Force.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Force.YValues.Modified := True;

      Form_UI.Series_ForceAve.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceAve.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceAve.XValues.Modified := True;
      Form_UI.Series_ForceAve.YValues.Value := tmp2ChartValues;
      Form_UI.Series_ForceAve.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceAve.YValues.Modified := True;

      Form_UI.Series_ForceMax.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceMax.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMax.XValues.Modified := True;
      Form_UI.Series_ForceMax.YValues.Value := tmp3ChartValues;
      Form_UI.Series_ForceMax.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMax.YValues.Modified := True;

      Form_UI.Series_ForceMin.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceMin.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMin.XValues.Modified := True;
      Form_UI.Series_ForceMin.YValues.Value := tmp4ChartValues;
      Form_UI.Series_ForceMin.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceMin.YValues.Modified := True;

      Form_UI.Series_ForceVariance.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ForceVariance.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceVariance.XValues.Modified := True;
      Form_UI.Series_ForceVariance.YValues.Value := tmp5ChartValues;
      Form_UI.Series_ForceVariance.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ForceVariance.YValues.Modified := True;

      Form_UI.Series_Force.Repaint;
//        Form_UI.Series_ForceAve.Repaint;
//        Form_UI.Series_ForceMax.Repaint;
//        Form_UI.Series_ForceMin.Repaint;
//        Form_UI.Series_ForceVariance.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Hardspot then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[19][I];
        tmp2ChartValues[I] := Form_UI.DrawData[20][I];
      end;

      Form_UI.Series_Vacc1.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Vacc1.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc1.XValues.Modified := True;
      Form_UI.Series_Vacc1.YValues.Value := tmp1ChartValues;
      Form_UI.Series_Vacc1.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc1.YValues.Modified := True;

      Form_UI.Series_Vacc2.XValues.Value := tmp0ChartValues;
      Form_UI.Series_Vacc2.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc2.XValues.Modified := True;
      Form_UI.Series_Vacc2.YValues.Value := tmp2ChartValues;
      Form_UI.Series_Vacc2.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_Vacc2.YValues.Modified := True;

      Form_UI.Series_Vacc1.Repaint;
//        Form_UI.Series_Vacc2.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Electric then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[21][I];
        tmp2ChartValues[I] := Form_UI.DrawData[22][I];
      end;

      Form_UI.Series_ElectricValue.XValues.Value := tmp0ChartValues;
      Form_UI.Series_ElectricValue.XValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ElectricValue.XValues.Modified := True;
      Form_UI.Series_ElectricValue.YValues.Value := tmp1ChartValues;
      Form_UI.Series_ElectricValue.YValues.Count := Form_UI.paintCounts;
      Form_UI.Series_ElectricValue.YValues.Modified := True;

      Form_UI.PointSeries_ElectricTime.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_ElectricTime.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTime.XValues.Modified := True;
      Form_UI.PointSeries_ElectricTime.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_ElectricTime.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTime.YValues.Modified := True;

      Form_UI.Series_ElectricValue.Repaint;
//        Form_UI.PointSeries_ElectricTime.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Acying then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[23][I];
        tmp2ChartValues[I] := Form_UI.DrawData[24][I];
      end;

      Form_UI.PointSeries_AcyingTime.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingTime.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTime.XValues.Modified := True;
      Form_UI.PointSeries_AcyingTime.YValues.Value := tmp1ChartValues;
      Form_UI.PointSeries_AcyingTime.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTime.YValues.Modified := True;

      Form_UI.PointSeries_AcyingCount.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingCount.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCount.XValues.Modified := True;
      Form_UI.PointSeries_AcyingCount.YValues.Value := tmp2ChartValues;
      Form_UI.PointSeries_AcyingCount.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCount.YValues.Modified := True;

      Form_UI.PointSeries_AcyingTime.Repaint;
//        Form_UI.PointSeries_AcyingCount.Repaint;
    end
    else if Form_UI.RzPageControl.ActivePage = Form_UI.TabSheet_Data then
    begin
      SetLength(tmp1ChartValues, Form_UI.paintCounts);
      SetLength(tmp2ChartValues, Form_UI.paintCounts);
      SetLength(tmp3ChartValues, Form_UI.paintCounts);
      SetLength(tmp4ChartValues, Form_UI.paintCounts);
      SetLength(tmp5ChartValues, Form_UI.paintCounts);
      SetLength(tmp6ChartValues, Form_UI.paintCounts);
      SetLength(tmp7ChartValues, Form_UI.paintCounts);
      SetLength(tmp8ChartValues, Form_UI.paintCounts);
      SetLength(tmp9ChartValues, Form_UI.paintCounts);
      SetLength(tmp10ChartValues, Form_UI.paintCounts);

      for I := 0 to Form_UI.paintCounts - 1 do
      begin
        tmp1ChartValues[I] := Form_UI.DrawData[6][I];
        tmp2ChartValues[I] := Form_UI.DrawData[0][I];
        tmp3ChartValues[I] := Form_UI.DrawData[19][I];
        tmp4ChartValues[I] := Form_UI.DrawData[20][I];
        tmp5ChartValues[I] := Form_UI.DrawData[14][I];
        tmp6ChartValues[I] := Form_UI.DrawData[24][I];
        tmp7ChartValues[I] := Form_UI.DrawData[23][I];
        tmp8ChartValues[I] := Form_UI.DrawData[21][I];
        tmp9ChartValues[I] := Form_UI.DrawData[22][I];
        if Form_UI.DrawData[26][I] = 4 then tmp10ChartValues[I] := 1
        else tmp10ChartValues[I] := 0;
      end;

      Form_UI.FastLineSeries_Line1Height.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Line1Height.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Line1Height.XValues.Modified := True;
      Form_UI.FastLineSeries_Line1Height.YValues.Value := tmp1ChartValues;
      Form_UI.FastLineSeries_Line1Height.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Line1Height.YValues.Modified := True;

      Form_UI.FastLineSeries_Line1Width.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Line1Width.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Line1Width.XValues.Modified := True;
      Form_UI.FastLineSeries_Line1Width.YValues.Value := tmp2ChartValues;
      Form_UI.FastLineSeries_Line1Width.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Line1Width.YValues.Modified := True;

      Form_UI.FastLineSeries_Vacc1.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Vacc1.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Vacc1.XValues.Modified := True;
      Form_UI.FastLineSeries_Vacc1.YValues.Value := tmp3ChartValues;
      Form_UI.FastLineSeries_Vacc1.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Vacc1.YValues.Modified := True;

      Form_UI.FastLineSeries_Vacc2.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Vacc2.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Vacc2.XValues.Modified := True;
      Form_UI.FastLineSeries_Vacc2.YValues.Value := tmp4ChartValues;
      Form_UI.FastLineSeries_Vacc2.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Vacc2.YValues.Modified := True;

      Form_UI.FastLineSeries_Force.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Force.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Force.XValues.Modified := True;
      Form_UI.FastLineSeries_Force.YValues.Value := tmp5ChartValues;
      Form_UI.FastLineSeries_Force.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Force.YValues.Modified := True;

      Form_UI.PointSeries_AcyingCountData.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingCountData.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCountData.XValues.Modified := True;
      Form_UI.PointSeries_AcyingCountData.YValues.Value := tmp6ChartValues;
      Form_UI.PointSeries_AcyingCountData.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingCountData.YValues.Modified := True;

      Form_UI.PointSeries_AcyingTimeData.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_AcyingTimeData.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTimeData.XValues.Modified := True;
      Form_UI.PointSeries_AcyingTimeData.YValues.Value := tmp7ChartValues;
      Form_UI.PointSeries_AcyingTimeData.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_AcyingTimeData.YValues.Modified := True;

      Form_UI.FastLineSeries_ElectricValue.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_ElectricValue.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_ElectricValue.XValues.Modified := True;
      Form_UI.FastLineSeries_ElectricValue.YValues.Value := tmp8ChartValues;
      Form_UI.FastLineSeries_ElectricValue.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_ElectricValue.YValues.Modified := True;

      Form_UI.PointSeries_ElectricTimeData.XValues.Value := tmp0ChartValues;
      Form_UI.PointSeries_ElectricTimeData.XValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTimeData.XValues.Modified := True;
      Form_UI.PointSeries_ElectricTimeData.YValues.Value := tmp9ChartValues;
      Form_UI.PointSeries_ElectricTimeData.YValues.Count := Form_UI.paintCounts;
      Form_UI.PointSeries_ElectricTimeData.YValues.Modified := True;

      Form_UI.FastLineSeries_Pole.XValues.Value := tmp0ChartValues;
      Form_UI.FastLineSeries_Pole.XValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Pole.XValues.Modified := True;
      Form_UI.FastLineSeries_Pole.YValues.Value := tmp10ChartValues;
      Form_UI.FastLineSeries_Pole.YValues.Count := Form_UI.paintCounts;
      Form_UI.FastLineSeries_Pole.YValues.Modified := True;

      Form_UI.FastLineSeries_Line1Height.Repaint;
    end;
  end;
end;

procedure TDrawThread.Execute;
begin
  { Place thread code here }
  while not Terminated do
  begin
    Synchronize(DrawLine);
    Application.ProcessMessages;
    Sleep(50);
  end;
end;
end.
