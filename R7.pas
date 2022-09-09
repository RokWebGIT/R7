unit R7;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.UITypes, System.Net.HttpClient,
  System.Net.URLClient, System.JSON, Rest.Json, System.Generics.Collections, FMX.Graphics;

type

  {TR7AccessList = class
  private
    FAvatarSmall: string;
    FDisplayName: string;
    FId: string;
    FProfileUrl: string;
  published
    property AvatarSmall: string read FAvatarSmall write FAvatarSmall;
    property DisplayName: string read FDisplayName write FDisplayName;
    property Id: string read FId write FId;
    property ProfileUrl: string read FProfileUrl write FProfileUrl;
  end;}

  {TR7CustomFields = class
  end;}

  {TR7CommonData = class
  end; }

  TR7CreateBy = class
  private
    FAvatarSmall: string;
    FDisplayName: string;
    FId: string;
    FProfileUrl: string;
  published
    property AvatarSmall: string read FAvatarSmall write FAvatarSmall;
    property DisplayName: string read FDisplayName write FDisplayName;
    property Id: string read FId write FId;
    property ProfileUrl: string read FProfileUrl write FProfileUrl;
  end;

  TR7Contact = class
  private
    FAbout: string;
    //FAccessList: TObjectList<TR7AccessList>;
    FCanDelete: Boolean;
    FCanEdit: Boolean;
    //FCommonData: TObjectList<TR7CommonData>;
    FCompanyName: string;
    FCreateBy: TR7CreateBy;
    [SuppressZero]
    FCreated: TDateTime;
    //FCustomFields: TObjectList<TR7CustomFields>;
    FDisplayName: string;
    FFirstName: string;
    FHaveLateTasks: Boolean;
    FId: Integer;
    FIndustry: string;
    FIsCompany: Boolean;
    FIsPrivate: Boolean;
    FIsShared: Boolean;
    FLastName: string;
    FMediumFotoUrl: string;
    FShareType: Integer;
    FSmallFotoUrl: string;
    FTitle: string;
  protected
  published
    property About: string read FAbout write FAbout;
    //property AccessList: TObjectList<TR7AccessList> read FAccessList;
    property CanDelete: Boolean read FCanDelete write FCanDelete;
    property CanEdit: Boolean read FCanEdit write FCanEdit;
    //property CommonData: TObjectList<TR7CommonData> read FCommonData write FCommonData;
    property CompanyName: string read FCompanyName write FCompanyName;
    property CreateBy: TR7CreateBy read FCreateBy;
    property Created: TDateTime read FCreated write FCreated;
   // property CustomFields: TObjectList<TR7CustomFields> read FCustomFields;
    property DisplayName: string read FDisplayName write FDisplayName;
    property FirstName: string read FFirstName write FFirstName;
    property HaveLateTasks: Boolean read FHaveLateTasks write FHaveLateTasks;
    property Id: Integer read FId write FId;
    property Industry: string read FIndustry write FIndustry;
    property IsCompany: Boolean read FIsCompany write FIsCompany;
    property IsPrivate: Boolean read FIsPrivate write FIsPrivate;
    property IsShared: Boolean read FIsShared write FIsShared;
    property LastName: string read FLastName write FLastName;
    property MediumFotoUrl: string read FMediumFotoUrl write FMediumFotoUrl;
    property ShareType: Integer read FShareType write FShareType;
    property SmallFotoUrl: string read FSmallFotoUrl write FSmallFotoUrl;
    property Title: string read FTitle write FTitle;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TR7Contacts = TObjectList<TR7Contact>;

  TR7Category = class
  private
    FColor: string;
    FDescription: string;
    FId: Integer;
    FImagePath: string;
    FSortOrder: Integer;
    FTitle: string;
  published
    property Color: string read FColor write FColor;
    property Description: string read FDescription write FDescription;
    property Id: Integer read FId write FId;
    property ImagePath: string read FImagePath write FImagePath;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Title: string read FTitle write FTitle;
  end;

  TR7Responsible = class
  private
    FAvatarSmall: string;
    FDisplayName: string;
    FId: string;
    FProfileUrl: string;
  published
    property AvatarSmall: string read FAvatarSmall write FAvatarSmall;
    property DisplayName: string read FDisplayName write FDisplayName;
    property Id: string read FId write FId;
    property ProfileUrl: string read FProfileUrl write FProfileUrl;
  end;

  TR7SaveTask = class
  private
    FAlertValue: Integer;
    FCategoryID: Integer;
    [SuppressZero]
    FCreated: TDateTime;
    [SuppressZero]
    FDeadLine: TDateTime;
    FDescription: string;
    FIsClosed: Boolean;
    FResponsibleID: String;
    FTitle: string;
    FContactID: int64;
    FIsNotify: boolean;
  published
    property AlertValue: Integer read FAlertValue write FAlertValue;
    property CategoryID: Integer read FCategoryID write FCategoryID;
    property Created: TDateTime read FCreated write FCreated;
    property DeadLine: TDateTime read FDeadLine write FDeadLine;
    property Description: string read FDescription write FDescription;
    property IsClosed: Boolean read FIsClosed write FIsClosed;
    property ResponsibleID: String read FResponsibleID write FResponsibleID;
    property Title: string read FTitle write FTitle;
    property ContactID: int64 read FContactID write FContactID;
    property IsNotify: boolean read FIsNotify write FIsNotify;
  public
  end;

  TR7Task = class
  private
    FAlertValue: Integer;
    FCategory: TR7Category;
    FCreateBy: TR7CreateBy;
    FContact: TR7Contact;
    [SuppressZero]
    FCreated: TDateTime;
    [SuppressZero]
    FDeadLine: TDateTime;
    FDescription: string;
    FId: Integer;
    FIsClosed: Boolean;
    FIsNotify: Boolean;
    FResponsible: TR7Responsible;
    FTitle: string;
  published
    property AlertValue: Integer read FAlertValue write FAlertValue;
    property Category: TR7Category read FCategory;
    property CreateBy: TR7CreateBy read FCreateBy;
    property Contact: TR7Contact read FContact;
    property Created: TDateTime read FCreated write FCreated;
    property DeadLine: TDateTime read FDeadLine write FDeadLine;
    property Description: string read FDescription write FDescription;
    property Id: Integer read FId write FId;
    property IsClosed: Boolean read FIsClosed write FIsClosed;
    property IsNotify: Boolean read FIsNotify write FIsNotify;
    property Responsible: TR7Responsible read FResponsible;
    property Title: string read FTitle write FTitle;
  public
    constructor Create;
    destructor Destroy; override;
    function ToSaveTask: TR7SaveTask;
  end;

  TR7Tasks = TObjectList<TR7Task>;

  TR7SelfUser = class
  private
    FActivationStatus: Integer;
    FAvatar: string;
    FAvatarMedium: string;
    FAvatarSmall: string;
    FDepartment: string;
    FDisplayName: string;
    FEmail: string;
    FFirstName: string;
    FId: string;
    FIsAdmin: Boolean;
    FIsLDAP: Boolean;
    FIsOwner: Boolean;
    FIsSSO: Boolean;
    FIsVisitor: Boolean;
    FLastName: string;
    FProfileUrl: string;
    FSex: string;
    FStatus: Integer;
    FUserName: string;
    [SuppressZero]
    FWorkFrom: TDateTime;
  published
    property ActivationStatus: Integer read FActivationStatus write FActivationStatus;
    property Avatar: string read FAvatar write FAvatar;
    property AvatarMedium: string read FAvatarMedium write FAvatarMedium;
    property AvatarSmall: string read FAvatarSmall write FAvatarSmall;
    property Department: string read FDepartment write FDepartment;
    property DisplayName: string read FDisplayName write FDisplayName;
    property Email: string read FEmail write FEmail;
    property FirstName: string read FFirstName write FFirstName;
    property Id: string read FId write FId;
    property IsAdmin: Boolean read FIsAdmin write FIsAdmin;
    property IsLDAP: Boolean read FIsLDAP write FIsLDAP;
    property IsOwner: Boolean read FIsOwner write FIsOwner;
    property IsSSO: Boolean read FIsSSO write FIsSSO;
    property IsVisitor: Boolean read FIsVisitor write FIsVisitor;
    property LastName: string read FLastName write FLastName;
    property ProfileUrl: string read FProfileUrl write FProfileUrl;
    property Sex: string read FSex write FSex;
    property Status: Integer read FStatus write FStatus;
    property UserName: string read FUserName write FUserName;
    property WorkFrom: TDateTime read FWorkFrom write FWorkFrom;
  end;

  TR7 = class
    host: string;
    token: string;
    selfuser: TR7SelfUser;
    tasks: TR7Tasks;
    contacts: TR7Contacts;
    taskcategories: TDictionary<Int64, String>;
    users: TDictionary<String, String>;
  private
    http: THTTPClient;
  public
    function auth(login, password: string): boolean;
    function getselfuser: TR7SelfUser;
    function gettasks: TR7Tasks;
    function gettask(id: int64): TR7Task;
    function createtask(ftask: TR7Task): boolean;
    function savetask(ftask: TR7Task): boolean;
    function closetask(id: int64): boolean;
    function reopentask(id: int64): boolean;
    function deletetask(id: int64): boolean;
    function DownloadImage(url: string): TBitmap;
    function gettaskcategories: TDictionary<int64, string>;
    function getusers: TDictionary<string, string>;
    function getcontacts: TR7Contacts;
    constructor Create(url: string);
    destructor Destroy; override;
  end;

implementation

constructor TR7Contact.Create;
begin
  inherited;
  FCreateBy := TR7CreateBy.Create;
  //FCommonData := TObjectList<TR7CommonData>.Create;
  //FCustomFields := TObjectList<TR7CustomFields>.Create;
  //FAccessList := TObjectList<TR7AccessList>.Create;
end;

destructor TR7Contact.Destroy;
begin
  FreeAndNil(FCreateBy);
  //FreeAndNil(FCommonData);
  //FreeAndNil(FCustomFields);
  //FreeAndNil(FAccessList);
  inherited;
end;

function TR7Task.ToSaveTask: TR7SaveTask;
begin
  Result := TR7SaveTask.Create;
  Result.AlertValue := Self.AlertValue;
  Result.CategoryID := Self.Category.Id;
  Result.Created := Self.Created;
  Result.DeadLine := Self.DeadLine;
  Result.Description := Self.Description;
  Result.IsClosed := Self.IsClosed;
  Result.ResponsibleID := Self.Responsible.Id;
  Result.ContactID := Self.Contact.Id;
  Result.IsNotify := Self.IsNotify;
  Result.Title := Self.Title;
end;

function TR7.SaveTask(ftask: TR7Task): boolean;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
  Value: TJsonValue;
  task: TR7Task;
  data: TBytesStream;
begin
  result := false;
  method := '/api/2.0/crm/task/'+ftask.Id.ToString;
  try
    data := TBytesStream.Create(TEncoding.UTF8.GetBytes(TJson.ObjectToJsonObject(ftask.ToSaveTask, [joDateFormatISO8601]).ToString));
    response := http.Put(host + method, data);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      result := true else;
  finally
    freeandnil(data);
    freeandnil(jsonvalue);
  end;
end;

function TR7.CloseTask(id: int64): boolean;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
begin
  result := false;
  method := '/api/2.0/crm/task/'+id.ToString+'/close';
  try
    response := http.Put(host + method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      result := true else;
  finally
    freeandnil(jsonvalue);
  end;
end;

function TR7.ReopenTask(id: int64): boolean;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
begin
  result := false;
  method := '/api/2.0/crm/task/'+id.ToString+'/reopen';
  try
    response := http.Put(host + method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      result := true else;
  finally
    freeandnil(jsonvalue);
  end;
end;

function TR7.DeleteTask(id: int64): boolean;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
begin
  result := false;
  method := '/api/2.0/crm/task/'+id.ToString;
  try
    response := http.delete(host + method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      result := true else;
  finally
    freeandnil(jsonvalue);
  end;
end;

function TR7.CreateTask(ftask: TR7Task): boolean;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
  Value: TJsonValue;
  task: TR7Task;
  data: TBytesStream;
begin
  result := false;
  method := '/api/2.0/crm/task';
  try
    data := TBytesStream.Create(TEncoding.UTF8.GetBytes(TJson.ObjectToJsonObject(ftask.ToSaveTask, [joDateFormatISO8601]).ToString));
    response := http.Post(host + method, data);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      result := true else;
  finally
    freeandnil(data);
    freeandnil(jsonvalue);
  end;
end;

function TR7.gettasks: TR7Tasks;
  var
  method: string;
  response: IHTTPResponse;
  jsonarray: TJsonArray;
  jsonvalue: TJsonValue;
  Value: TJsonValue;
begin
  FreeAndNil(Tasks);
  Tasks := TR7Tasks.Create;
  method := '/api/2.0/crm/task/filter';
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      jsonarray := jsonvalue.GetValue<TJsonArray>('response');
      for Value in jsonarray do
        Tasks.Add(TJson.JsonToObject<TR7Task>(value as TJsonObject, [joDateFormatISO8601]));
    end;
  finally
    freeandnil(jsonvalue);
    result := tasks;
  end;
end;

function TR7.gettask(id: int64): TR7Task;
  var
  method: string;
  response: IHTTPResponse;
  jsonarray: TJsonArray;
  jsonvalue: TJsonValue;
  Value: TJsonValue;
  task: TR7Task;
begin
  task := nil;
  method := '/api/2.0/crm/task/'+id.ToString;
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      task := TR7Task.Create;
      task := TJson.JsonToObject<TR7Task>(jsonvalue.GetValue<TJsonObject>('response'), [joDateFormatISO8601]);
    end;
  finally
    freeandnil(jsonvalue);
    result := task;
  end;
end;

function TR7.getcontacts: TR7Contacts;
  var
  method: string;
  response: IHTTPResponse;
  jsonarray: TJsonArray;
  jsonvalue: TJsonValue;
  Value: TJsonValue;
begin
  FreeAndNil(Contacts);
  Contacts := TR7Contacts.Create;
  method := '/api/2.0/crm/contact/filter';
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      jsonarray := jsonvalue.GetValue<TJsonArray>('response');
      for Value in jsonarray do
        Contacts.Add(TJson.JsonToObject<TR7Contact>(value as TJsonObject));
    end;
  finally
    freeandnil(jsonvalue);
    result := Contacts;
  end;
end;

constructor TR7Task.Create;
begin
  inherited;
  FCreateBy := TR7CreateBy.Create;
  FResponsible := TR7Responsible.Create;
  FCategory := TR7Category.Create;
  FContact := TR7Contact.Create;
  FisNotify := true;
end;

destructor TR7Task.Destroy;
begin
  FreeAndNil(FCreateBy);
  FreeAndNil(FResponsible);
  FreeAndNil(FCategory);
  FreeAndNil(FContact);
  inherited;
end;

constructor TR7.Create(url: string);
begin
  http := THTTPClient.Create;
  http.ContentType := 'application/json';
  host := url;
  token := '';
  taskcategories := TDictionary<Int64, String>.Create;
  users := TDictionary<String, String>.Create;
end;

destructor TR7.Destroy;
begin
inherited;
  FreeAndNil(contacts);
  FreeAndNil(users);
  FreeAndNil(taskcategories);
  freeandnil(tasks);
  freeandnil(selfuser);
  FreeAndNil(http);
end;

function TR7.auth(login, password: string): boolean;
  var
  method: string;
  params: tstringlist;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
begin
  result := false;
  http.CustomHeaders['Authorization'] := '';
  method := '/api/2.0/authentication';
  params := TStringList.Create;
  params.Values['userName'] := login;
  params.Values['password'] := password;
  try
    response := http.Post(host+method,params);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      token := jsonvalue.GetValue<string>('response.token');
      http.CustomHeaders['Authorization'] := 'Bearer '+token;
      result := true;
    end;
    freeandnil(jsonvalue);
  finally
    freeandnil(params);
  end;
end;

function TR7.getselfuser: TR7SelfUser;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
begin
  selfuser := nil;
  method := '/api/2.0/people/@self';
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
      selfuser := TJson.JsonToObject<TR7SelfUser>(jsonvalue.GetValue<TJsonObject>('response'));
  finally
    freeandnil(jsonvalue);
    result := selfuser;
  end;
end;

function TR7.gettaskcategories: TDictionary<int64, string>;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
  jsonarray: TJsonArray;
  value: TJsonValue;
begin
  taskcategories.Clear;
  method := '/api/2.0/crm/task/category';
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      jsonarray := jsonvalue.GetValue<TJsonArray>('response');
      for value in jsonarray do
        taskcategories.Add(Value.GetValue<Int64>('id'), Value.GetValue<String>('title'));
    end;
  finally
    freeandnil(jsonvalue);
    result := taskcategories;
  end;
end;

function TR7.getusers: TDictionary<string, string>;
  var
  method: string;
  response: IHTTPResponse;
  jsonvalue: TJsonValue;
  jsonarray: TJsonArray;
  value: TJsonValue;
begin
  users.Clear;
  method := '/api/2.0/people';
  try
    response := http.Get(host+method);
    jsonvalue := TJsonObject.ParseJSONValue(Response.ContentAsString);
    if jsonvalue.GetValue<integer>('statusCode') in [200,201] then
    begin
      jsonarray := jsonvalue.GetValue<TJsonArray>('response');
      for value in jsonarray do
        users.Add(Value.GetValue<String>('id'), Value.GetValue<String>('displayName'));
    end;
  finally
    freeandnil(jsonvalue);
    result := users;
  end;
end;

function TR7.DownloadImage(url: string): TBitmap;
  var
  response: IHTTPResponse;
begin
  result := nil;
  if (url.IsEmpty)  then exit;
    response := http.get(host + url);
    if (response.StatusCode=200) then
      Result := TBitmap.CreateFromStream(response.ContentStream);
end;

begin

end.