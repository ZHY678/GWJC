unit UFirFilter;

interface

Uses
  MtxVec, MtxVecEdit, MtxExpr, MtxBaseComp, SignalUtils, OptimalFir, SysUtils, Math387, Polynoms;

  type
    {
    功 能：FIR滤波类型
    说 明：
    }
    TUserFilterType =
    (
      UserLowPass,   //低通
      UserHighPass,  //高通
      UserBandPass,  //带通
      UserSavGolay,  //5点三次
      UserAverage  //均值
    );

    {
    功 能：数据FIR滤波处理类
    说 明：
    }
    TFirFilter = class
      private
        H, yy:     Vector;
        State:     TFirState;  //滤波中间结果缓存变量
        ValidFlag: Boolean;    //滤波参数设计有效标识

      public
        constructor create(FilterType: TUserFilterType;  const W: array of Double; out order: Integer; rw: Double = 0.01; fs: Double = 1);
        function    filter(input: Vector; out output: Vector): Boolean;
        procedure   clear;
        destructor  Destroy; override;
    end;


implementation

//**********************************TFirFilter**********************************
{
函数名  ：filter
功    能：对输入数据以数据流的方式FIR滤波
输入参数：input-数据向量
返回值  ：滤波结果(True/False)
调用关系：
其    它：输入数据会被覆盖
}
function TFirFilter.filter(input: Vector; out output: Vector): Boolean;
begin
  Result := False;

  if ValidFlag  then
  begin
    output.Size(input);

    try
      FirFilter(input, output, State);
      //output.Copy(yy);

      Result := True;
    except

      Result := False;
    end;
  end;
end;

{
函数名  ：clear
功    能：清空FIR滤波
输入参数：
返回值  ：
调用关系：
其    它：
}
procedure TFirFilter.clear;
begin
  if ValidFlag  then
  begin
    FillChar(State, SizeOf(State), 0);
    FirInit(H, State);
  end;
end;

{
函数名  ：create
功    能：创建FIR滤波对象
输入参数：FilterType-滤波类型
          W-参数数组
          order-阶数
          rw-纹波大小
          fs-采样频率
返回值  ：无
调用关系：
其    它：
}
constructor TFirFilter.create(FilterType: TUserFilterType; const W: array of Double; out order: Integer; rw: Double = 0.01; fs: Double = 1);
var
  Response: Vector;
begin

  ValidFlag := False;

  case FilterType of
     UserLowPass:
       ValidFlag := RemezImpulse(H, W, rw, ftLowpass, 1, fs, true);

     UserHighPass:
       ValidFlag := RemezImpulse(H, W, rw, ftHighPass, 1, fs, true);

     UserBandPass:
       ValidFlag := RemezImpulse(H, W, rw, ftBandPass, 1, fs, true);

     UserSavGolay:
     begin
       SavGolayImpulse(H, 5, 3);
       ValidFlag := True;
     end;

     UserAverage:
     begin
       MovingAverageImpulse(H, Round(W[0]));
       ValidFlag := True;
     end;

  end;

  if ValidFlag  then
  begin
    FillChar(State, SizeOf(State), 0);
    FirInit(H, State);

    order := H.Length;
  end;

  {$IFDEF FILTER_DEBUG}
  FrequencyResponse(H, nil, Response);
  DrawIt(Response);
  {$ENDIF}

end;
{
函数名  ：Destroy
功    能：销毁FIR滤波对象
输入参数：无
返回值  ：无
调用关系：
其    它：
}
destructor TFirFilter.Destroy;
begin
  if ValidFlag  then
  begin
    FirFree(State);
  end;

  //inherited;
end;
end.
