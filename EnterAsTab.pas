{
  In the Main Form of application
}

procedure TMainUI.DoEnterAsTab(var Msg: TMsg; var Handled: Boolean);
begin
  if Msg.Message = WM_KEYDOWN then
  begin
    if (not (Screen.ActiveControl is TCustomMemo)) and (not (Screen.ActiveControl is TButtonControl)) then
    begin
      if Msg.wParam = VK_RETURN then
        Screen.ActiveForm.Perform(WM_NextDlgCtl, 0, 0);
    end;
  end;
end;

procedure TMainUI.FormCreate(Sender: TObject);
begin
  // At the end of the method, add:
  Application.OnMessage := DoEnterAsTab;
end;
