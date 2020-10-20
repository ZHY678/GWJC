unit UFirFilter;

interface

Uses
  MtxVec, MtxVecEdit, MtxExpr, MtxBaseComp, SignalUtils, OptimalFir, SysUtils, Math387, Polynoms;

  type
    {
    �� �ܣ�FIR�˲�����
    ˵ ����
    }
    TUserFilterType =
    (
      UserLowPass,   //��ͨ
      UserHighPass,  //��ͨ
      UserBandPass,  //��ͨ
      UserSavGolay,  //5������
      UserAverage  //��ֵ
    );

    {
    �� �ܣ�����FIR�˲�������
    ˵ ����
    }
    TFirFilter = class
      private
        H, yy:     Vector;
        State:     TFirState;  //�˲��м����������
        ValidFlag: Boolean;    //�˲����������Ч��ʶ

      public
        constructor create(FilterType: TUserFilterType;  const W: array of Double; out order: Integer; rw: Double = 0.01; fs: Double = 1);
        function    filter(input: Vector; out output: Vector): Boolean;
        procedure   clear;
        destructor  Destroy; override;
    end;


implementation

//**********************************TFirFilter**********************************
{
������  ��filter
��    �ܣ��������������������ķ�ʽFIR�˲�
���������input-��������
����ֵ  ���˲����(True/False)
���ù�ϵ��
��    �����������ݻᱻ����
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
������  ��clear
��    �ܣ����FIR�˲�
���������
����ֵ  ��
���ù�ϵ��
��    ����
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
������  ��create
��    �ܣ�����FIR�˲�����
���������FilterType-�˲�����
          W-��������
          order-����
          rw-�Ʋ���С
          fs-����Ƶ��
����ֵ  ����
���ù�ϵ��
��    ����
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
������  ��Destroy
��    �ܣ�����FIR�˲�����
�����������
����ֵ  ����
���ù�ϵ��
��    ����
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
