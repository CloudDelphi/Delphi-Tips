procedure Clear;
var
  t: TRttiType;
  prop: TRttiProperty;
begin
  t := TRttiContext.Create.GetType(Self.ClassType);
  for prop in t.GetProperties do
  begin
    if not prop.IsWritable then Continue;
    case prop.PropertyType.TypeKind of
      tkInteger, tkInt64, tkFloat: prop.SetValue(Self, 0);
      tkString, tkUString, tkWString: prop.SetValue(Self, '');
    end;
  end;
end;