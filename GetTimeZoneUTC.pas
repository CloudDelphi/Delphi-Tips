var
  TimeZoneInfo: TTimezoneinformation;
  Minutes: Integer;
  Sign: string;
begin
  if not (GetTimezoneInformation(TimeZoneInfo) in [TIME_ZONE_ID_UNKNOWN, TIME_ZONE_ID_STANDARD, TIME_ZONE_ID_DAYLIGHT]) then
    Result('');
    
  Minutes := (TimeZoneInfo.Bias + TimeZoneInfo.DaylightBias) * -1;
  if Minutes < 0 then
    Sign := '-'
  else
    Sign := '+';

  Result := Sign + FormatDateTime('hh:MM', IncMinute(0, Minutes));
end;