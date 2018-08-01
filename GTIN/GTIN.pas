unit GTIN;

interface

uses
  SysUtils;

type
  {
  Global Trade Item Number (GTIN) is an identifier for trade items, developed by GS1

  The family of data structures (not symbologies) comprising GTIN include:
   * GTIN-12 (UPC-A): this is a 12-digit number used primarily in North America
   * GTIN-8 (EAN/UCC-8): this is an 8-digit number used predominately outside of North America
   * GTIN-13 (EAN/UCC-13): this is a 13-digit number used predominately outside of North America
   * GTIN-14 (EAN/UCC-14 or ITF-14): this is a 14-digit number used to identify trade items at various packaging levels
  }
  TGTIN = record
  private
    FValue: string;
    function CalculateCheckDigit: string;
  public
    class operator Implicit(const GTIN: string): TGTIN;
    class operator Implicit(const GTIN: TGTIN): string;
    function IsValid: Boolean; overload;
    procedure AssertValid;
    property Value: string read FValue write FValue;
  end;

  GTINException = class(Exception);

function GTINIsValid(const GTIN: string): Boolean;
procedure GTINAssertValid(const GTIN: string);

implementation

uses
  Math;

procedure GTINAssertValid(const GTIN: string);
var
  G: TGTIN;
begin
  G := GTIN;
  G.AssertValid;
end;

function GTINIsValid(const GTIN: string): Boolean;
var
  G: TGTIN;
begin
  G := GTIN;
  Result := G.IsValid;
end;

{ TGTIN }

class operator TGTIN.Implicit(const GTIN: string): TGTIN;
begin
  Result.Value := GTIN;
end;

procedure TGTIN.AssertValid;
var
  GTINLength: Integer;
begin
  GTINLength := Length(FValue);
  if not (GTINLength in [8, 12, 13, 14]) then
    raise GTINException.Create('The GTIN ' + FValue + ' have a invalid Data Structure');

  if FValue[GTINLength] <> CalculateCheckDigit then
    raise GTINException.Create('Check digit is invalid');
end;

function TGTIN.CalculateCheckDigit: string;
var
  I: Integer;
  Sum, CheckDigit: Integer;
  Number: string;

  function Multiplier: Integer;
  begin
    Result := IfThen(Odd(I), 3, 1);
  end;

begin
  for I := Length(FValue)-1 downto 1 do
    Number := Number + FValue[I];

  Sum := 0;
  for I := 1 to Length(Number) do
    Sum := Sum + (StrToIntDef(Number[I], 0) * Multiplier);

  CheckDigit := (Ceil(Sum/10)*10) - Sum;
  Result := IntToStr(CheckDigit);
end;

class operator TGTIN.Implicit(const GTIN: TGTIN): string;
begin
  Result := GTIN.Value;
end;

function TGTIN.IsValid: Boolean;
begin
  try
    AssertValid;
    Result := True;
  except
    Result := False;
  end;
end;

end.