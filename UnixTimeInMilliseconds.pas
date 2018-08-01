function UNIXTimeInMilliseconds: Int64;
var
  ST: SystemTime;
  DT: TDateTime;
begin
  Windows.GetSystemTime(ST);
  DT := SysUtils.EncodeDate(ST.wYear, ST.wMonth, ST.wDay) +
        SysUtils.EncodeTime(ST.wHour, ST.wMinute, ST.wSecond, ST.wMilliseconds);
  Result := DateUtils.MilliSecondsBetween(DT, UnixDateDelta);
end;