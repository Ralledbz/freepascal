unit ToolsUnit;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils, DB, testdecorator;

// Number of "N" test datasets (as opposed to FieldDatasets) that will be created
// The connectors should have these records prepared in their Create*Dataset procedures.
Const MaxDataSet = 35;
  
type

  { TDBConnector }
  TDBConnectorClass = class of TDBConnector;
  TDBConnector = class(TPersistent)
     private
       FChangedDatasets : array[0..MaxDataSet] of boolean;
       FFormatSettings: TFormatSettings;
       FUsedDatasets : TFPList;
       FChangedFieldDataset : boolean;
     protected
       procedure SetTestUniDirectional(const AValue: boolean); virtual;
       function GetTestUniDirectional: boolean; virtual;
       // These methods should be implemented by all descendents
       // They are called each time a test needs a TDataset descendent
       // n: the dataset index to return (also number of records in set)
       // Presupposes that Create*Dataset(s) has been called already.
       Function InternalGetNDataset(n : integer) : TDataset;  virtual; abstract;
       Function InternalGetFieldDataset : TDataSet; virtual; abstract;

       // These methods should be implemented by all descendents
       // They are called e.g. in the constructor. They can be used
       // to create the tables on disk, or on a DB server
       procedure CreateNDatasets; virtual; abstract;
       procedure CreateFieldDataset; virtual; abstract;

       // These methods are called after each test in which a dataset is used
       // by calling GetXXXDataset with Achange=true
       // They should reset all data to their right/initial values.
       procedure ResetNDatasets; virtual;
       procedure ResetFieldDataset; virtual;
       
       // These methods are called e.g. in the destructor.
       // They should clean up all mess, like tables on disk or on a DB server
       procedure DropNDatasets; virtual; abstract;
       procedure DropFieldDataset; virtual; abstract;
     public
       constructor create; virtual;
       destructor destroy; override;

       procedure DataEvent(dataset :TDataset);

       Function GetNDataset(n : integer) : TDataset;  overload;
       Function GetNDataset(AChange : Boolean; n : integer) : TDataset;  overload;
       Function GetFieldDataset : TDataSet; overload;
       Function GetFieldDataset(AChange : Boolean) : TDataSet; overload;

       // Gets a dataset that tracks calculation of calculated fields etc.
       Function GetTraceDataset(AChange : Boolean) : TDataset; virtual;

       procedure StartTest;
       procedure StopTest;
       property TestUniDirectional: boolean read GetTestUniDirectional write SetTestUniDirectional;
       property FormatSettings: TFormatSettings read FFormatSettings;
     end;

  { TDBBasicsTestSetup }

  TDBBasicsTestSetup = class(TTestSetup)
    protected
      procedure OneTimeSetup; override;
      procedure OneTimeTearDown; override;
    end;

{ TTestDataLink }

  TTestDataLink = class(TDataLink)
     protected
       procedure DataSetScrolled(Distance: Integer); override;
       procedure DataSetChanged; override;
{$IFDEF fpc}
       procedure DataEvent(Event: TDataEvent; Info: Ptrint); override;
{$ELSE}
       procedure DataEvent(Event: TDataEvent; Info: longint); override;
{$ENDIF}
     end;

const
  DataEventnames : Array [TDataEvent] of String[21] =
    ('deFieldChange', 'deRecordChange', 'deDataSetChange', 'deDataSetScroll',
     'deLayoutChange', 'deUpdateRecord', 'deUpdateState', 'deCheckBrowseMode',
     'dePropertyChange', 'deFieldListChange', 'deFocusControl' ,'deParentScroll',
     'deConnectChange', 'deReconcileError', 'deDisabledStateChange');


const
  testValuesCount = 25;
  testFloatValues : Array[0..testValuesCount-1] of double = (-maxSmallint-1,-maxSmallint,-256,-255,-128,-127,-1,0,1,127,128,255,256,maxSmallint,maxSmallint+1,0.123456,-0.123456,4.35,12.434E7,9.876e-5,123.45678,2.4,3.2,0.4,23);
  testCurrencyValues : Array[0..testValuesCount-1] of currency = (-100,-65.5,-54.34,-43.34,-2.50,-0.2,45.40,0.3,45.4,127,128,255,256,45,0.3,45.4,127,128,255,256,45,1234.56,43.23,43.43,99.88);
  testFmtBCDValues : Array[0..testValuesCount-1] of string = ('-100','-65.5','-54.3333','-43.3334','-2.5','-0.234567','45.4','0.3','45.414585','127','128','255','256','45','0.3','45.4','127','128','255','256','45','1234.56789','43.23','43.500001','99.88');
  testIntValues : Array[0..testValuesCount-1] of integer = (-maxInt,-maxInt+1,-maxSmallint-1,-maxSmallint,-256,-255,-128,-127,-1,0,1,127,128,255,256,maxSmallint,maxSmallint+1,MaxInt-1,MaxInt,100,130,150,-150,-132,234);
  testSmallIntValues : Array[0..testValuesCount-1] of smallint = (-maxSmallint,-maxSmallint+1,-256,-255,-128,-127,-1,0,1,127,128,255,256,maxSmallint,maxSmallint-1,100,110,120,130,150,-150,-132,234,231,42);
  testLargeIntValues : Array[0..testValuesCount-1] of LargeInt = ( -$7fffffffffffffff,-$7ffffffffffffffe,-maxInt-1,-maxInt+1,-maxSmallint,-maxSmallint+1,-256,-255,-128,-127,-1,0,1,127,128,255,256,maxSmallint,maxSmallint-1,maxSmallint+1,MaxInt-1,MaxInt,$7fffffffffffffff-1,$7fffffffffffffff,235253244);
  testBooleanValues : Array[0..testValuesCount-1] of boolean = (true,false,false,true,true,false,false,true,false,true,true,true,false,false,false,false,true,true,true,true,false,true,true,false,false);
  testStringValues : Array[0..testValuesCount-1] of string = (
    '',
    'a',
    'ab',
    'abc',
    'abcd',
    'abcde',
    'abcdef',
    'abcdefg',
    'abcdefgh',
    'abcdefghi',
    'abcdefghij',
    'lMnOpQrStU',
    '1234567890',
    '_!@#$%^&*(',
    '_!@#$%^&*(',
    ' ''quotes'' ',
    ')-;:/?.<>',
    '~`|{}- =',    // note that there's no \  (backslash) since some db's uses that as escape-character
    '  WRaP  ',
    'wRaP  ',
    ' wRAP',
    'this',
//    'is',
    'fun',
    'VB7^',
    'vdfbst'
  );

  testDateValues : Array[0..testValuesCount-1] of string = (
    '2000-01-01',
    '1999-12-31',
    '2004-02-29',
    '2004-03-01',
    '1991-02-28',
    '1991-03-01',
    '1997-11-29',
    '2040-10-16',
    '1977-09-29',
    '1977-12-31',
    '1917-12-29',
    '1900-01-01',
    '1899-12-31',
    '1899-12-30',
    '1899-12-29',
    '1800-03-30',
    '1754-06-04',
    '1753-01-01',
    '1650-05-10',
    '0904-04-12',
    '0199-07-09',
    '0079-11-29',
    '0031-11-02',
    '0001-12-31',
    '0001-01-01'
  );

  testTimeValues : Array[0..testValuesCount-1] of string = (
    '10:45:12.000',
    '00:00:00.000',
    '24:00:00.000',
    '33:25:15.000',
    '04:59:16.000',
    '05:45:59.000',
    '16:35:42.000',
    '14:45:52.000',
    '12:45:12.000',
    '18:45:22.000',
    '19:45:12.000',
    '14:45:14.000',
    '16:45:12.000',
    '11:45:12.000',
    '15:35:12.000',
    '16:45:12.010',
    '13:55:12.200',
    '13:46:12.543',
    '15:35:12.000',
    '17:25:12.530',
    '19:45:12.003',
    '10:54:12.999',
    '12:25:12.000',
    '20:15:12.758',
    '12:25:12.000'
  );


var dbtype,
    dbconnectorname,
    dbconnectorparams,
    dbname,
    dbuser,
    dbhostname,
    dbpassword,
    dbQuoteChars   : string;
    DataEvents     : string;
    DBConnector    : TDBConnector;
    testValues     : Array [TFieldType,0..testvaluescount -1] of string;


procedure InitialiseDBConnector;
procedure FreeDBConnector;

function DateTimeToTimeString(d: tdatetime) : string;
function TimeStringToDateTime(d: String): TDateTime;
function StringToByteArray(s: ansistring): Variant;

implementation

uses
  inifiles, FmtBCD, Variants;

var DBConnectorRefCount: integer;

constructor TDBConnector.create;
begin
  FFormatSettings.DecimalSeparator:='.';
  FFormatSettings.ThousandSeparator:=#0;
  FFormatSettings.DateSeparator:='-';
  FFormatSettings.TimeSeparator:=':';
  FFormatSettings.ShortDateFormat:='yyyy/mm/dd';
  FFormatSettings.LongTimeFormat:='hh:nn:ss.zzz';
  FUsedDatasets := TFPList.Create;
  CreateFieldDataset;
  CreateNDatasets;
end;

destructor TDBConnector.destroy;
begin
  if assigned(FUsedDatasets) then FUsedDatasets.Destroy;
  DropNDatasets;
  DropFieldDataset;
end;

function TDBConnector.GetTestUniDirectional: boolean;
begin
  result := false;
end;

procedure TDBConnector.SetTestUniDirectional(const AValue: boolean);
begin
  raise exception.create('Connector does not support tests for unidirectional datasets');
end;

procedure TDBConnector.ResetNDatasets;
begin
  DropNDatasets;
  CreateNDatasets;
end;

procedure TDBConnector.ResetFieldDataset;
begin
  DropFieldDataset;
  CreateFieldDataset;
end;

procedure TDBConnector.DataEvent(dataset : tdataset);

begin
  DataEvents := DataEvents + 'DataEvent' + ';';
end;

function TDBConnector.GetNDataset(n: integer): TDataset;
begin
  Result := GetNDataset(False,n);
end;

procedure ReadIniFile;

var IniFile : TIniFile;

begin
  IniFile := TIniFile.Create(getcurrentdir + PathDelim + 'database.ini');
  dbtype:='';
  if Paramcount>0 then
    dbtype := ParamStr(1);
  if (dbtype='') or not inifile.SectionExists(dbtype) then
    dbtype := IniFile.ReadString('Database','Type','');
  dbconnectorname := IniFile.ReadString(dbtype,'Connector','');
  dbname := IniFile.ReadString(dbtype,'Name','');
  dbuser := IniFile.ReadString(dbtype,'User','');
  dbhostname := IniFile.ReadString(dbtype,'Hostname','');
  dbpassword := IniFile.ReadString(dbtype,'Password','');
  dbconnectorparams := IniFile.ReadString(dbtype,'ConnectorParams','');
  dbquotechars := IniFile.ReadString(dbtype,'QuoteChars','"');

  IniFile.Free;
end;

procedure InitialiseDBConnector;

const B: array[boolean] of char=('0','1');  // should be exported from some main db unit, as SQL true/false?

var DBConnectorClass : TPersistentClass;
    i                : integer;
    FormatSettings   : TFormatSettings;
begin
  if DBConnectorRefCount>0 then exit;
  
  FormatSettings.DecimalSeparator:='.';
  FormatSettings.ThousandSeparator:=#0;
  
  testValues[ftString] := testStringValues;
  testValues[ftFixedChar] := testStringValues;
  testValues[ftTime] := testTimeValues;
  testValues[ftDate] := testDateValues;
  testValues[ftBlob] := testStringValues;
  testValues[ftMemo] := testStringValues;
  testValues[ftWideString] := testStringValues;
  testValues[ftWideMemo] := testStringValues;
  testValues[ftFMTBcd] := testFmtBCDValues;
  for i := 0 to testValuesCount-1 do
    begin
    testValues[ftBoolean,i] := B[testBooleanValues[i]];
    testValues[ftFloat,i] := FloatToStr(testFloatValues[i],FormatSettings);
    testValues[ftSmallint,i] := IntToStr(testSmallIntValues[i]);
    testValues[ftInteger,i] := IntToStr(testIntValues[i]);
    testValues[ftLargeint,i] := IntToStr(testLargeIntValues[i]);
    testValues[ftCurrency,i] := CurrToStr(testCurrencyValues[i],FormatSettings);
    testValues[ftBCD,i] := CurrToStr(testCurrencyValues[i],FormatSettings);
    // For date '0001-01-01' other time-part like '00:00:00' causes "Invalid variant type cast", because of < MinDateTime constant
    if (testDateValues[i]>'0001-01-01') and (testTimeValues[i]>='00:00:01') and (testTimeValues[i]<'24:00:00') then
      testValues[ftDateTime,i] := testDateValues[i] + ' ' + testTimeValues[i]
    else
      testValues[ftDateTime,i] := testDateValues[i];
    end;

  if dbconnectorname = '' then raise Exception.Create('There is no db connector specified');
  DBConnectorClass := GetClass('T'+dbconnectorname+'DBConnector');
  if assigned(DBConnectorClass) then
    DBConnector := TDBConnectorClass(DBConnectorClass).create
  else Raise Exception.Create('Unknown db connector specified: ' + 'T'+dbconnectorname+'DBConnector');
  inc(DBConnectorRefCount);
end;

procedure FreeDBConnector;
begin
  dec(DBConnectorRefCount);
  if DBConnectorRefCount=0 then
    FreeAndNil(DBConnector);
end;

function DateTimeToTimeString(d: tdatetime): string;
var
  millisecond: word;
  second     : word;
  minute     : word;
  hour       : word;
begin
  // Format the datetime in the format hh:nn:ss.zzz, where the hours can be bigger then 23.
  DecodeTime(d,hour,minute,second,millisecond);
  hour := hour + (trunc(d) * 24);
  result := Format('%.2d:%.2d:%.2d.%.3d',[hour,minute,second,millisecond]);
end;

function TimeStringToDateTime(d: String): TDateTime;
var
  millisecond: word;
  second     : word;
  minute     : word;
  hour       : word;
  days       : word;
begin
  // Convert the string in the format hh:nn:ss.zzz to a datetime.
  hour := strtoint(copy(d,1,2));
  minute := strtoint(copy(d,4,2));
  second := strtoint(copy(d,7,2));
  millisecond := strtoint(copy(d,10,3));

  days := hour div 24;
  hour := hour mod 24;

  result := ComposeDateTime(days,EncodeTime(hour,minute,second,millisecond));
end;

function StringToByteArray(s: ansistring): Variant;
var P: Pointer;
    Len: integer;
begin
  Len := Length(s) * SizeOf(AnsiChar);
  Result := VarArrayCreate([0, Len-1], varByte);
  P := VarArrayLock(Result);
  try
    Move(s[1], P^, Len);
  finally
    VarArrayUnlock(Result);
  end;
end;


{ TTestDataLink }

procedure TTestDataLink.DataSetScrolled(Distance: Integer);
begin
  DataEvents := DataEvents + 'DataSetScrolled' + ':' + inttostr(Distance) + ';';
  inherited DataSetScrolled(Distance);
end;

procedure TTestDataLink.DataSetChanged;
begin
  DataEvents := DataEvents + 'DataSetChanged;';
  inherited DataSetChanged;
end;

{$IFDEF FPC}
procedure TTestDataLink.DataEvent(Event: TDataEvent; Info: Ptrint);
{$ELSE}
procedure TTestDataLink.DataEvent(Event: TDataEvent; Info: Longint);
{$ENDIF}
begin
  if Event <> deFieldChange then
    DataEvents := DataEvents + DataEventnames[Event] + ':' + inttostr(info) + ';'
  else
    DataEvents := DataEvents + DataEventnames[Event] + ':' + TField(info).FieldName + ';';
  inherited DataEvent(Event, Info);
end;

{ TDBConnector }

function TDBConnector.GetNDataset(AChange : Boolean; n: integer): TDataset;
begin
  if AChange then FChangedDatasets[n] := True;
  Result := InternalGetNDataset(n);
  FUsedDatasets.Add(Result);
end;

function TDBConnector.GetFieldDataset: TDataSet;
begin
  Result := GetFieldDataset(False);
end;

function TDBConnector.GetFieldDataset(AChange: Boolean): TDataSet;
begin
  if AChange then FChangedFieldDataset := True;
  Result := InternalGetFieldDataset;
  FUsedDatasets.Add(Result);
end;

function TDBConnector.GetTraceDataset(AChange: Boolean): TDataset;
begin
  result := GetNDataset(AChange,15);
end;

procedure TDBConnector.StartTest;
begin
// Do nothing?
end;

procedure TDBConnector.StopTest;
var i : integer;
    ds : TDataset;
begin
  for i := 0 to FUsedDatasets.Count -1 do
    begin
    ds := tdataset(FUsedDatasets[i]);
    if ds.active then ds.Close;
    ds.Free;
    end;
  FUsedDatasets.Clear;
  if FChangedFieldDataset then ResetFieldDataset;
  for i := 0 to MaxDataSet do if FChangedDatasets[i] then
    begin
    ResetNDatasets;
    fillchar(FChangedDatasets,sizeof(FChangedDatasets),ord(False));
    break;
    end;
end;

{ TDBBasicsTestSetup }

procedure TDBBasicsTestSetup.OneTimeSetup;
begin
  InitialiseDBConnector;
end;

procedure TDBBasicsTestSetup.OneTimeTearDown;
begin
  FreeDBConnector;
end;

initialization
  ReadIniFile;
  DBConnectorRefCount:=0;
end.

