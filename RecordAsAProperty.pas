{interface}

type
  TInnerRecord = record
    Value: string;
  end;

  TClassA = class
  public
    InnerRecord: TInnerRecord;
  end;

  TClassB = class
  private
    FInnerRecord: TInnerRecord;
  public
    property InnerRecord: TInnerRecord read FInnerRecord write FInnerRecord;
  end;

  TClassC = class
  public
    procedure DoSomethingA();
    procedure DoSomethingB();
    procedure DoSomethingB_Error();
  end;

{implementation}

procedure TClassC.DoSomethingA();
var
  ClassA: TClassA;
begin
  ClassA := TClassA.Create();
  try
    ClassA.InnerRecord.Value := 'correct implementation';
  finnaly
    ClassA.Free();
  end;
end;

procedure TClassC.DoSomethingB();
var
  ClassB: TClassB;
begin
  ClassB := TClassB.Create();
  try
    with ClassB.InnerRecord do
      Value := 'correct implementation';
  finnaly
    ClassB.Free();
  end;
end;

procedure TClassC.DoSomethingB_Error();
var
  ClassB: TClassB;
begin
  ClassB := TClassB.Create();
  try
    ClassB.InnerRecord.Value := 'incorrect implementation'; // ERROR! "Left Side Cannot Be Assigned To"
  finnaly
    ClassB.Free();
  end;
end;