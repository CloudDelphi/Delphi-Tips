// uses RegularExpressions;

function ValidatePhone(const PhoneNumber: string): Boolean;
var
  RegEx: TRegEx;
begin
  RegEx := TRegex.Create('^(?:(?:\+|00)?(\d)?)?([0-9]{10,12})$');
  Result := RegEx.Match(PhoneNumber).Success;
end;