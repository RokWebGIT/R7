unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Net.HttpClient,
  System.Net.URLClient, System.JSON, REST.Json, System.Generics.Collections,
  System.Classes, System.Variants, FMX.Objects, REST.Json.Types,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Unit2,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Appearances, Unit3,
  FireDAC.Stan.Intf, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text,
  FMX.ListView.DynamicAppearance, FMX.ListView.Types, System.ImageList,
  FMX.ImgList, FMX.MultiResBitmap, FMX.Edit, FMX.TextLayout, FMX.ListView, Unit5,
  R7, System.DateUtils;

type

  TForm1 = class(TForm)
    AuthFrame1: TAuthFrame;
    SelfUserFrame1: TSelfUserFrame;
    TaskFrame1: TTaskFrame;
    procedure AuthFrame1AuthButtonClick(Sender: TObject);
    procedure SelfUserFrame1ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SelfUserFrame1ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure TaskFrame1Button2Click(Sender: TObject);
    procedure TaskFrame1Button1Click(Sender: TObject);
    procedure TaskFrame1Button4Click(Sender: TObject);
    procedure TaskFrame1Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TaskFrame1Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  R7: TR7;

implementation

{$R *.fmx}

procedure TForm1.AuthFrame1AuthButtonClick(Sender: TObject);
var
  task: tr7task;
  lvitem: TListViewItem;
begin
  freeandnil(R7);

  R7 := TR7.Create('hidden');

  If R7.auth(AuthFrame1.LoginEdit.Text, AuthFrame1.PasswordEdit.Text) then
  begin
    R7.gettaskcategories;
    R7.getusers;
    R7.getcontacts;
    R7.getselfuser;
    R7.gettasks;
    SelfUserFrame1.ListView1.Items.Clear;
    for task in r7.tasks do
    begin
      LVItem := SelfUserFrame1.ListView1.Items.Add;
      LVItem.TagObject := task;
      LVItem.Tag := 0;
    end;
    LVItem := SelfUserFrame1.ListView1.Items.Add;
    LVItem.TagObject := nil;
    LVItem.Tag := 2;

    SelfUserFrame1.Visible := true;
    SelfUserFrame1.Text1.Text := R7.getselfuser.DisplayName;
    SelfUserFrame1.Text2.Text := R7.getselfuser.Email;
    SelfUserFrame1.Image1.Bitmap := R7.DownloadImage(R7.selfuser.Avatar);
  end
  else
  begin
    showmessage('Авторизация не удачна');
    FreeAndNil(R7);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TaskFrame1.DateEdit1.Date := Now;
  TaskFrame1.TimeEdit1.Time := Now;
end;

procedure TForm1.SelfUserFrame1ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
  var
  Value: string;
  contact: TR7Contact;
begin
  if (not Assigned(AItem.TagObject)) or (AItem.TagObject.ClassType<>TR7Task) then
  begin
    freeandnil(AItem.TagObject);
    AItem.TagObject := TR7Task.Create;
    TR7Task(AItem.TagObject).CreateBy.AvatarSmall := R7.selfuser.AvatarSmall;
    TR7Task(AItem.TagObject).CreateBy.DisplayName := R7.selfuser.DisplayName;
    TR7Task(AItem.TagObject).CreateBy.Id := R7.selfuser.Id;
    TR7Task(AItem.TagObject).CreateBy.ProfileUrl := R7.selfuser.ProfileUrl;
    TR7Task(AItem.TagObject).Category.Id := 1;
    TR7Task(AItem.TagObject).DeadLine := Now;
    TR7Task(AItem.TagObject).Responsible.Id := R7.selfuser.Id;
    TR7Task(AItem.TagObject).Id := -1;
    TaskFrame1.ComboBox1.Clear;
    for Value in r7.taskcategories.Values do
      TaskFrame1.ComboBox1.Items.Add(Value);
    if TaskFrame1.ComboBox1.Items.IndexOf(TR7Task(AItem.TagObject).Category.Title)=-1 then
      TaskFrame1.ComboBox1.ItemIndex := 1
    else
      TaskFrame1.ComboBox1.ItemIndex := TaskFrame1.ComboBox1.Items.IndexOf(TR7Task(AItem.TagObject).Category.Title);
    TaskFrame1.ComboBox4.Clear;
    for Value in r7.users.Values do
      TaskFrame1.ComboBox4.Items.Add(Value);
    if TaskFrame1.ComboBox4.Items.IndexOf(TR7Task(AItem.TagObject).Responsible.DisplayName)=-1 then
      TaskFrame1.ComboBox4.ItemIndex := 1
    else
      TaskFrame1.ComboBox4.ItemIndex := TaskFrame1.ComboBox4.Items.IndexOf(TR7Task(AItem.TagObject).Responsible.DisplayName);

      TaskFrame1.ComboBox2.Clear;
      TaskFrame1.ComboBox2.Items.Add('');
      for contact in r7.contacts do
        TaskFrame1.ComboBox2.Items.Add(contact.DisplayName);
      if TaskFrame1.ComboBox2.Items.IndexOf(TR7Task(AItem.TagObject).Contact.DisplayName)=-1 then
        TaskFrame1.ComboBox2.ItemIndex := 0
      else
        TaskFrame1.ComboBox2.ItemIndex := TaskFrame1.ComboBox2.Items.IndexOf(TR7Task(AItem.TagObject).Contact.DisplayName);
  end;
    if (TR7Task(AItem.TagObject).CreateBy.ID = R7.selfuser.ID) or
       (TR7Task(AItem.TagObject).Responsible.Id = R7.selfuser.ID) then
    begin
      TaskFrame1.VertScrollBox1.ViewportPosition := TPointF.Create(0,0);
      TaskFrame1.Visible := true;
      if TR7Task(AItem.TagObject).Id>-1 then
      TaskFrame1.TagObject := R7.gettask(TR7Task(AItem.TagObject).Id) else TaskFrame1.TagObject := TR7Task(AItem.TagObject);
      TaskFrame1.Edit1.Text := TR7Task(TaskFrame1.TagObject).Title;
      TaskFrame1.DateEdit1.DateTime := TR7Task(TaskFrame1.TagObject).DeadLine;
      TaskFrame1.TimeEdit1.DateTime := TR7Task(TaskFrame1.TagObject).DeadLine;
      TaskFrame1.Memo1.Text := TR7Task(TaskFrame1.TagObject).Description;
      TaskFrame1.ComboBox1.Clear;
      for Value in r7.taskcategories.Values do
        TaskFrame1.ComboBox1.Items.Add(Value);
      if TaskFrame1.ComboBox1.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Category.Title)=-1 then
        TaskFrame1.ComboBox1.ItemIndex := 0
      else
        TaskFrame1.ComboBox1.ItemIndex := TaskFrame1.ComboBox1.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Category.Title);
      TaskFrame1.ComboBox4.Clear;
      for Value in r7.users.Values do
        TaskFrame1.ComboBox4.Items.Add(Value);
      if TaskFrame1.ComboBox4.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Responsible.DisplayName)=-1 then
        TaskFrame1.ComboBox4.ItemIndex := 0
      else
        TaskFrame1.ComboBox4.ItemIndex := TaskFrame1.ComboBox4.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Responsible.DisplayName);

      TaskFrame1.ComboBox2.Clear;
      TaskFrame1.ComboBox2.Items.Add('');
      for contact in r7.contacts do
        TaskFrame1.ComboBox2.Items.Add(contact.DisplayName);
      if TaskFrame1.ComboBox2.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Contact.DisplayName)=-1 then
        TaskFrame1.ComboBox2.ItemIndex := 0
      else
        TaskFrame1.ComboBox2.ItemIndex := TaskFrame1.ComboBox2.Items.IndexOf(TR7Task(TaskFrame1.TagObject).Contact.DisplayName);
      TaskFrame1.CheckBox1.isChecked := TR7Task(TaskFrame1.TagObject).IsNotify;

    case TR7Task(TaskFrame1.TagObject).AlertValue of
    0: TaskFrame1.ComboBox3.ItemIndex := 0;
    5: TaskFrame1.ComboBox3.ItemIndex := 1;
    15: TaskFrame1.ComboBox3.ItemIndex := 2;
    30: TaskFrame1.ComboBox3.ItemIndex := 3;
    60: TaskFrame1.ComboBox3.ItemIndex := 4;
    120: TaskFrame1.ComboBox3.ItemIndex := 5;
    1440: TaskFrame1.ComboBox3.ItemIndex := 6;
    end;

    end else SelfUserFrame1.ListView1.Selected := nil
end;

function GetTextHeight(const D: TListItemText; const Width: single; const
Text: string): Integer;
var
  Layout: TTextLayout;
begin
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width,
                      TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    Result := Round(Layout.Height);
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

procedure TForm1.SelfUserFrame1ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
  var
  Drawable: TListItemText;
  Text: String;
  AvailableWidth: Single;
  TextHeight: integer;
begin
  if AItem.Tag=0 then
  begin
    AItem.BeginUpdate;
      AItem.Objects.FindObjectT<TListItemText>('Text1').Text := Tr7Task(AItem.TagObject).Title;
      AItem.Objects.FindObjectT<TListItemText>('Text2').Text := Tr7Task(AItem.TagObject).CreateBy.DisplayName+' / '+DateTimeToStr(Tr7Task(AItem.TagObject).Created);
      AItem.Objects.FindObjectT<TListItemText>('Text3').Text := Tr7Task(AItem.TagObject).Description;
      AItem.Objects.FindObjectT<TListItemImage>('Image1').OwnsBitmap := False;
      AItem.Objects.FindObjectT<TListItemImage>('Image1').Bitmap := R7.DownloadImage(Tr7Task(AItem.TagObject).CreateBy.AvatarSmall);
    AItem.EndUpdate;

    AItem.Tag := 1;
  end;

  AvailableWidth := TListView(Sender).Width - TListView(Sender).ItemSpaces.Left - TListView(Sender).ItemSpaces.Right - AItem.Objects.FindObjectT<TListItemImage>('Image1').Width;

  Drawable := AItem.Objects.FindObjectT<TListItemText>('Text3');
  Text := Trim(Drawable.Text);

  if AItem.Tag = 2 then
  begin
      Drawable.Text := '+';
      Drawable.TextAlign := TTextAlign.Center;
      Drawable.Font.Style := [TFontStyle.fsBold];
      Drawable.Font.Size := 32;
      Drawable.TextVertAlign := TTextAlign.Leading;
      Drawable.PlaceOffset.X := 0;
      Drawable.PlaceOffset.Y := 0;
      Drawable.Size := TPointF.Create(TListView(Sender).Width, AItem.Height);
  exit;
  end;

  TextHeight := GetTextHeight(Drawable, AvailableWidth, Text);
  AItem.Height := TextHeight + Round(Drawable.PlaceOffset.Y);
  Drawable.Height := AItem.Height;
  Drawable.Width := AvailableWidth;
end;

procedure TForm1.TaskFrame1Button1Click(Sender: TObject);
begin
  TaskFrame1.Button1Click(Sender);
  AuthFrame1.AuthButton.OnClick(Self);
end;

procedure TForm1.TaskFrame1Button2Click(Sender: TObject);
var
  res: boolean;
  task: TPair<int64, string>;
  user: TPair<string, string>;
  dt: String;
begin
  TR7Task(TaskFrame1.TagObject).Title := TaskFrame1.Edit1.Text;
  TR7Task(TaskFrame1.TagObject).Description := TaskFrame1.Memo1.Text;

  for task in r7.taskcategories do
    if task.Value = taskframe1.ComboBox1.Selected.text then
      TR7Task(TaskFrame1.TagObject).Category.ID := task.Key;

  for user in r7.users do
    if user.Value = taskframe1.ComboBox4.Selected.text then
      TR7Task(TaskFrame1.TagObject).Responsible.ID := user.Key;

  TR7Task(TaskFrame1.TagObject).Contact.Id := 0;
  for var contact in R7.contacts do
    if contact.DisplayName = taskframe1.ComboBox2.Selected.text then
      TR7Task(TaskFrame1.TagObject).Contact.Id := Contact.ID;

  TR7Task(TaskFrame1.TagObject).DeadLine := TaskFrame1.DateEdit1.Date + TaskFrame1.TimeEdit1.Time;
  TR7Task(TaskFrame1.TagObject).DeadLine := RecodeSecond(TR7Task(TaskFrame1.TagObject).DeadLine,0);
  TR7Task(TaskFrame1.TagObject).IsNotify := TaskFrame1.CheckBox1.isChecked;

  case TaskFrame1.ComboBox3.ItemIndex  of
  0: TR7Task(TaskFrame1.TagObject).AlertValue := 0;
  1: TR7Task(TaskFrame1.TagObject).AlertValue := 5;
  2: TR7Task(TaskFrame1.TagObject).AlertValue := 15;
  3: TR7Task(TaskFrame1.TagObject).AlertValue := 30;
  4: TR7Task(TaskFrame1.TagObject).AlertValue := 60;
  5: TR7Task(TaskFrame1.TagObject).AlertValue := 120;
  6: TR7Task(TaskFrame1.TagObject).AlertValue := 1440;
  end;

  if TR7Task(TaskFrame1.TagObject).Id=-1 then
    res := R7.createtask(TR7Task(TaskFrame1.TagObject))
  else
    res := R7.savetask(TR7Task(TaskFrame1.TagObject));
  if not res then
  begin
    ShowMessage('Не удалось сохранить задачу');
    exit;
  end;
  //FreeAndNil(TaskFrame1.TagObject);
  AuthFrame1.AuthButton.OnClick(Self);
  TaskFrame1.Visible := false;
end;

procedure TForm1.TaskFrame1Button3Click(Sender: TObject);
begin
  if (TR7Task(TaskFrame1.TagObject).Id>-1) and (R7.closetask(TR7Task(TaskFrame1.TagObject).Id)=true) then
  begin
    AuthFrame1.AuthButton.OnClick(Self);
    TaskFrame1.Visible := false;
  end else ShowMessage('Не удалось закрыть задачу');;
end;

procedure TForm1.TaskFrame1Button4Click(Sender: TObject);
begin
  if (TR7Task(TaskFrame1.TagObject).Id>-1) and (R7.reopentask(TR7Task(TaskFrame1.TagObject).Id)=true) then
  begin
    AuthFrame1.AuthButton.OnClick(Self);
    TaskFrame1.Visible := false;
  end else ShowMessage('Не удалось открыть задачу');;
end;

procedure TForm1.TaskFrame1Button5Click(Sender: TObject);
begin
  if (TR7Task(TaskFrame1.TagObject).Id>-1) and (R7.deletetask(TR7Task(TaskFrame1.TagObject).Id)=true) then
  begin
    AuthFrame1.AuthButton.OnClick(Self);
    TaskFrame1.Visible := false;
  end else ShowMessage('Не удалось удалить задачу');;
end;

end.
