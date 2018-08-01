unit GTINTests;

interface

uses
  TestFramework,
  GTIN;

type
  TGTINTests = class(TTestCase)
  private
    FGTIN: TGTIN;
    procedure AssertValid;
    procedure CheckIfGTINIsValid(const aGTIN: array of string);
  published
    procedure TestGTINIsValid;
    procedure TestGTINAssertValid;
    procedure TestGTIN8IsValid;
    procedure TestGTIN12IsValid;
    procedure TestGTIN13IsValid;
    procedure TestGTIN14IsValid;
    procedure TestInvalidCheckDigit;
    procedure TestInvalidDataStructure;
  end;

implementation

const
  VALID_GTIN: array[1..20] of string = ('20013776', '20012984', '20007331', '48297943', '80496373',
    '789822986142', '789300005969', '789300768727', '789300488953', '789300030206',
    '7897158700011', '7898951405073', '7892970020019', '7898386722677', '7899638306768',
    '47891164132185', '47891164132772', '87891164132534', '47891164133038', '47891164133267');

{ TGTINTests }

procedure TGTINTests.AssertValid;
begin
  GTINAssertValid(FGTIN);
end;

procedure TGTINTests.CheckIfGTINIsValid(const aGTIN: array of string);
var
  GTIN: string;
begin
  for GTIN in aGTIN do
  begin
    FGTIN := GTIN;
    CheckTrue(FGTIN.IsValid, GTIN + ' should be a valid GTIN');
  end;
end;

procedure TGTINTests.TestGTIN12IsValid;
const
  VALID_GTIN: array[1..10] of string = (
    '700083132369', '700083132239', '742832426107', '789733701292', '789300768307',
    '751320009548', '789300081581', '341224116000', '789300005945', '761318111894');
begin
  CheckIfGTINIsValid(VALID_GTIN);
end;

procedure TGTINTests.TestGTIN13IsValid;
const
  VALID_GTIN: array[1..10] of string = (
    '7898387630018', '7898419081504', '7890000182249','7898302290877', '7898494840027',
    '7891515852108', '7891515898106', '7892970020118', '7898929528865', '9788524304460');
begin
  CheckIfGTINIsValid(VALID_GTIN);
end;

procedure TGTINTests.TestGTIN14IsValid;
const
  VALID_GTIN: array[1..10] of string = (
    '78972929000182', '47891164020406', '17894904996473', '17894904996480', '27893000516834',
    '78915158781507', '47891164132284', '47891164132352', '47891164132673', '47891164132383');
begin
  CheckIfGTINIsValid(VALID_GTIN);
end;

procedure TGTINTests.TestGTIN8IsValid;
const
  VALID_GTIN: array[1..10] of string = ('20006693', '78911017', '45584411' , '20001773',
    '20010379', '20006532', '20006143', '20005658', '20005818', '10011812');
begin
  CheckIfGTINIsValid(VALID_GTIN);
end;

procedure TGTINTests.TestGTINAssertValid;
var
  GTIN: string;
begin
  for GTIN in VALID_GTIN do
  begin
    FGTIN := GTIN;
    AssertValid;
  end;
end;

procedure TGTINTests.TestGTINIsValid;
var
  GTIN: string;
begin
  for GTIN in VALID_GTIN do
    CheckTrue(GTINIsValid(GTIN), GTIN + ' should be a valid GTIN');
end;

procedure TGTINTests.TestInvalidCheckDigit;
const
  INVALID_GTIN: array[1..20] of string = ('20013771', '20012982', '20007333', '48297944', '80496375',
    '789822986146', '789300005967', '789300768728', '789300488959', '789300030200',
    '7897158700012', '7898951405074', '7892970020015', '7898386722676', '7899638306767',
    '47891164132188', '47891164132779', '87891164132530', '47891164133031', '47891164133262');
var
  GTIN: string;
begin
  for GTIN in INVALID_GTIN do
  begin
    FGTIN := GTIN;
    CheckException(FGTIN.AssertValid, GTINException, 'Check digit of GTIN ' + GTIN + ' should be invalid');
    CheckException(AssertValid, GTINException, 'GTINAssertValid should throw exception for Check digit invalid of GTIN ' + GTIN);
  end;
end;

procedure TGTINTests.TestInvalidDataStructure;
const
  INVALID_GTIN: array[1..5] of string = ('1234567', '123456789', '1234567890', '12345678901', '123456789012345');
var
  GTIN: string;
begin
  for GTIN in INVALID_GTIN do
  begin
    FGTIN := GTIN;
    CheckException(FGTIN.AssertValid, GTINException, 'GTIN ' + GTIN + ' should throw exception for data structure');
    CheckException(AssertValid, GTINException, 'GTINAssertValid of GTIN ' + GTIN + ' should throw exception for data structure');
  end;
end;

initialization
  RegisterTest(TGTINTests.Suite);

end.