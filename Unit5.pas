unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Memo.Types, FMX.ListBox, FMX.Edit,
  FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls;

type
  TTaskFrame = class(TFrame)
    Button1: TButton;
    VertScrollBox1: TVertScrollBox;
    GridPanelLayout1: TGridPanelLayout;
    Memo1: TMemo;
    Button2: TButton;
    Text1: TText;
    Edit1: TEdit;
    Text2: TText;
    ComboBox1: TComboBox;
    Text3: TText;
    ComboBox2: TComboBox;
    Text4: TText;
    Text5: TText;
    ComboBox3: TComboBox;
    Text6: TText;
    Panel1: TPanel;
    GridPanelLayout2: TGridPanelLayout;
    DateEdit1: TDateEdit;
    GridPanelLayout3: TGridPanelLayout;
    ComboBox4: TComboBox;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    TimeEdit1: TTimeEdit;
    procedure DateEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TTaskFrame.Button1Click(Sender: TObject);
begin
  Self.Visible := false;
end;

procedure TTaskFrame.DateEdit1Change(Sender: TObject);
begin
  with Sender as TDateEdit do
  begin
    if Date < Now then
      Date := Now;
    end;
end;

end.
