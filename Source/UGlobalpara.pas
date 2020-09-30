unit UGlobalpara;

interface

Uses
  System.SysUtils, Vcl.Dialogs, winapi.Windows, System.Classes, System.StrUtils, JCWDataDef, YEGinc;

type
  data2D = record
    lineHeight, lineWidth, lineHeightValue, lineWidthValue: Single;
  end;

  TGlobalpara = class
    private
      Function GetResidualDiskSize(TempSaveDataPath : String) : Int64;
      Function IsResidualDiskSizeEnough(TempSaveDataPath : String; TempCompareDataSize : Single) : Boolean;
      Function FindFileList(TempPath, FileExt : String) : TStringList;
      Function GetFileCreateTime(FilePathName : String; TimeFlag : Byte) : TDateTime;
      Function PathToTime(TempTStringList : TStringList) : TStringList;
      Function FileTimeSort(TempTimeTStringList, TempFileTStringList : TStringList) : TStringList;
      Function DeleteRedundantFile(TempSaveDataPath : String; TempCompareDataSize : Single; TempTStringList : TStringList) : TStringList;
    public
      procedure ShowAndSaveErrorLog(txtPath, errorProcedure, errorResult: String; testFlag: Boolean);
      Procedure DataSelfDelete(TempSaveDataPath : String; TempCompareDataSize : Single);
      function IsNumberType(inputString : string) : Byte;   //返回值：0——字符串，1——整数，2——小数
  end;

  Const
    FILE_CREATE_TIME = 0;   //创建时间
    FILE_MODIFY_TIME = 1;   //修改时间
    FILE_ACCESS_TIME = 3;   //访问时间

    MinResidualDiskSize = 10.0;   //最小磁盘容量

  Var
    //2D数据变量（导高拉出值）
    m_data: JCWJH;
    m_lock: THandle;

    //2D数据变量（点云数据）
    m_vecPot : array of YEGtagPOINTF;
    m_dTimeStampLast: Single;
    m_uiFrameNo, m_uiFrameRecvCount, m_uiPotNum: Cardinal;
    m_mutex: THandle;

    data2DArray: array[0..3] of array[0..199] of data2D;
    draw2DArray: array[0..4] of array[0..999] of data2D;
    calCounts, drawCount: Word;

implementation

procedure TGlobalpara.ShowAndSaveErrorLog(txtPath: string; errorProcedure: string; errorResult: string; testFlag: Boolean);
var
  errorInformation: String;
  errorFile: TextFile;
begin
  errorInformation := FormatDateTime('yyyy年mm月dd日 hh时nn分ss秒', now()) + ':错误信息为' + errorResult + ',错误地点位于' + errorProcedure;
  AssignFile(errorFile, txtPath);
  if FileExists(txtPath) then Append(errorFile)
  else
  begin
    ForceDirectories(ExtractFilePath(txtPath));
    Rewrite(errorFile);
  end;
  Writeln(errorFile, errorInformation);
  CloseFile(errorFile);
  if testFlag then ShowMessage(errorResult);
end;

Function TGlobalpara.GetResidualDiskSize(TempSaveDataPath: string) : Int64;
Var
  UnKnowDiskSize, TotalDiskSize, ResidualDiskSize : TLargeInteger;
begin
  TempSaveDataPath := ExtractFileDrive(TempSaveDataPath);
  GetDiskFreeSpaceEx(PChar(TempSaveDataPath), UnKnowDiskSize, TotalDiskSize, @ResidualDiskSize);
  Result := ResidualDiskSize;
end;

Function TGlobalpara.IsResidualDiskSizeEnough(TempSaveDataPath: string; TempCompareDataSize: Single) : Boolean;
begin
  if TempCompareDataSize > MinResidualDiskSize then
  Begin
    if GetResidualDiskSize(TempSaveDataPath) > TempCompareDataSize * 1024 * 1024 * 1024 then
    Begin
      Result := True;
    End
    else
    Begin
      Result := False;
    End;
  End
  else
  Begin
    TempCompareDataSize := MinResidualDiskSize;
    if GetResidualDiskSize(TempSaveDataPath) > TempCompareDataSize * 1024 * 1024 * 1024 then
    Begin
      Result := True;
    End
    else
    Begin
      Result := False;
    End;
  End;
end;

Function TGlobalpara.FindFileList(TempPath: string; FileExt: string) : TStringList;
Var
  Searchrec : TSearchrec;
begin
  Result := TStringList.Create;
  if RightStr(Trim(TempPath), 1) <> '\' then
  Begin
    TempPath := Trim(TempPath) + '\';
  End
  else
  Begin
    TempPath := Trim(TempPath);
  End;
  if not DirectoryExists(TempPath) then
  Begin
    Result.Clear;
    Exit;
  End;
  if FindFirst(TempPath + '*', FaAnyfile, Searchrec) = 0 then
  Begin
    Repeat
      if (Searchrec.Name = '.') Or (Searchrec.Name = '..') then
      Begin
        Continue;
      End;
      if DirectoryExists(TempPath + Searchrec.Name) then
      Begin
        Result.AddStrings(FindFileList(TempPath + Searchrec.Name, FileExt));
      End
      else
      Begin
        if (UpperCase(ExtractFileExt(TempPath + Searchrec.Name)) = UpperCase(FileExt)) or (FileExt = '.*') then
        Begin
          Result.Add(TempPath + Searchrec.Name);
        End;
      End;
    Until FindNext(Searchrec) <> 0;
    System.SysUtils.FindClose(Searchrec);
  End;
end;

Function TGlobalpara.GetFileCreateTime(FilePathName: string; TimeFlag: Byte) : TDateTime;
Var
  Handle : Thandle;
  Win32FindData : TWin32FindData;
  FileTime : TFileTime;
  dwDateTime : DWord;
begin
  Handle := FindFirstFile(PChar(FilePathName), Win32FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  Begin
    case TimeFlag of
      FILE_CREATE_TIME : FileTimeToLocalFileTime(Win32FindData.ftCreationTime, FileTime);
      FILE_MODIFY_TIME : FileTimeToLocalFileTime(Win32FindData.ftLastWriteTime, FileTime);
      FILE_ACCESS_TIME : FileTimeToLocalFileTime(Win32FindData.ftLastAccessTime, FileTime);
    else
      FileTimeToLocalFileTime(Win32FindData.ftCreationTime, FileTime);
    end;
    FileTimeToDosDateTime(FileTime, LongRec(dwDateTime).Hi, LongRec(dwDateTime).Lo);
    Result := FileDateToDateTime(dwDateTime);
    Winapi.Windows.FindClose(Handle);
  End
  else
  Begin
    Result := 0;
    Exit;
  End;
end;

Function TGlobalpara.PathToTime(TempTStringList: TStringList) : TStringList;
Var
  I : LongWord;
begin
  Result := TStringList.Create;
  TempTStringList.Capacity := TempTStringList.Count;
  Result.Capacity := TempTStringList.Count;
  if TempTStringList.Count > 0 then
  Begin
    for I := 0 to TempTStringList.Count - 1 do
    Begin
      Result.Add(DateTimeToStr(GetFileCreateTime(TempTStringList[I], FILE_CREATE_TIME)));
    End;
  End;
end;

Function TGlobalpara.FileTimeSort(TempTimeTStringList: TStringList; TempFileTStringList: TStringList) : TStringList;
var
  I, J : LongWord;
  TimeTempString, FileTempString : String;
begin
//  Result := TStringList.Create;
  if TempTimeTStringList.Count > 0 then
  begin
    TempFileTStringList.Capacity := TempFileTStringList.Count;
    for I := 1 to TempTimeTStringList.Count - 1 do
    Begin
      for J := 0 to TempTimeTStringList.Count - 1 - I do
      Begin
        if StrToDateTime(TempTimeTStringList[J]) < StrToDateTime(TempTimeTStringList[J + 1]) then
        Begin
          TimeTempString := TempTimeTStringList[J];
          TempTimeTStringList[J] := TempTimeTStringList[J + 1];
          TempTimeTStringList[J + 1] := TimeTempString;
          FileTempString := TempFileTStringList[J];
          TempFileTStringList[J] := TempFileTStringList[J + 1];
          TempFileTSTringList[J + 1] := FileTempString;
        End;
      End;
    End;
    for I := TempTimeTStringList.Count - 1 DownTo 0 do
    Begin
      if Now - StrToDateTime(TempTimeTStringList[I]) > 366 then   //185是六个月的天数
      Begin
        DeleteFile(PWideChar(WideString(TempFileTStringList[I])));
        TempTimeTStringList.Delete(I);
        TempFileTStringList.Delete(I);
      End;
    End;
  end;
  TempFileTStringList.Capacity := TempFileTStringList.Count;
  Result := TempFileTStringList;
end;

Function TGlobalpara.DeleteRedundantFile(TempSaveDataPath: String; TempCompareDataSize : Single; TempTStringList: TStringList) : TStringList;
var
  I : LongWord;
begin
//  Result := TStringList.Create;
  if TempTStringList.Capacity > 0 then
  begin
    for I := TempTStringList.Capacity - 1 DownTo 0 do
    Begin
      if Not(IsResidualDiskSizeEnough(TempSaveDataPath, TempCompareDataSize)) then
      Begin
        DeleteFile(PWideChar(WideString(TempTStringList[I])));
        TempTStringList.Delete(I);
      End
      else Break;
    End;
  end;
  Result := TempTStringList;
  Result.Capacity := Result.Count;
end;

Procedure TGlobalpara.DataSelfDelete(TempSaveDataPath: string; TempCompareDataSize: Single);
begin
  if Not(IsResidualDiskSizeEnough(TempSaveDataPath, TempCompareDataSize)) then
  DeleteRedundantFile(TempSaveDataPath, TempCompareDataSize, FileTimeSort(PathToTime(FindFileList(TempSaveDataPath, '.*')), FindFileList(TempSaveDataPath, '.*')));
end;

function TGlobalpara.IsNumberType(inputString: string) : Byte;   //返回值：0——字符串，1——整数，2——小数
var
  i : Word;
begin
  Result := 0;
  if Length(inputString) > 0 then
  Begin
    for i := 1 to Length(inputString) do
    Begin
      if (inputString[i] < '0') or (inputString[i] > '9') then
      Begin
        if (inputString[i] = '.') And (i <> 1) And (i <> Length(inputString)) then
        Begin
          if Result = 2 then
          Begin
            Result := 0;
            Exit;
          End;
          Result := 2;
          Continue;
        End;
        if (i = 1) And (inputString[i] = '-') And (Length(inputString) > 1) then Result := 1
        else
        Begin
          Result := 0;
          Exit;
        End;
      End;
    End;
    if Result <> 2 then Result := 1;
  End;
end;

end.
