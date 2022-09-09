unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.ListBox, FMX.TextLayout,
  r7;

type
  TSelfUserFrame = class(TFrame)
    ListView1: TListView;
    Text1: TText;
    Text2: TText;
    Image1: TImage;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TSelfUserFrame.Button1Click(Sender: TObject);
begin
  Self.Visible := false;
end;

end.
