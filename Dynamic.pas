unit Dynamic;

interface

uses
  Variants;

type
  TDynamic = class
  public
    function Sum(a, b: Variant): Variant;
  end;

implementation

function TDynamic.Sum(a, b: Variant): Variant;
begin
  Result := a + b;
end;

end.



{ input }

Edit1.Text := '1';
Edit2.Text := '2';
Edit3.Text := '';

// string

var
  v1, v2: Variant;
begin
  v1 := Edit1.Text;
  v2 := Edit2.Text;
  Edit3.Text := Dynamic.Sum(v1, v2);
end;

{output}

Edit1.Text := '1';
Edit2.Text := '2';
Edit3.Text := '12';

// Integer

var
  v1, v2: Variant;
begin
  v1 := StrToInt(Edit1.Text);
  v2 := StrToInt(Edit2.Text);
  Edit3.Text := Dynamic.Sum(v1, v2);
end;

{output}

Edit1.Text := '1';
Edit2.Text := '2';
Edit3.Text := '3';
