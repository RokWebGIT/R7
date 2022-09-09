unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.Objects;

type
  TAuthFrame = class(TFrame)
    GridPanelLayout1: TGridPanelLayout;
    Text1: TText;
    LoginEdit: TEdit;
    Text2: TText;
    PasswordEdit: TEdit;
    AuthButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
