function RemoveNumbers(const aString: string): string;
var
  C: Char;
begin
  Result := '';
  for C in aString do
  begin
    if not CharInSet(C, ['0'..'9']) then
      Result := Result + C;
  end;
end;