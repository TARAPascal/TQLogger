program console_logger;

{$mode objfpc}{$H+}

uses
  Classes,
  SysUtils,
  CustApp,
  tlogger;

type
  TMyLogger = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  end;

  procedure TMyLogger.DoRun;
  var
    l: TQLogger;

  begin
    l := TQLogger.Create('x.log');
    sleep(100);
    l.PToAppend := 'message 1';
    l.PToAppend := 'message 2';
    l.PToAppend := 'message 3';
    writeln(l.PCurrentLogFile);

    sleep(300);

    {
      repeat
        sleep(10);
      until l.PCanAppend;  }

    try
      l.PToAppend := 'message 4';
    except
      on E: Exception do
      begin
        writeln('exception TMyLogger.DoRun: ' + E.Message);
      end;
    end;

    {stop logger}
    l.Terminate;
    l.WaitFor;
    l.Destroy();

    Terminate;
  end;

  constructor TMyLogger.Create(TheOwner: TComponent);
  begin
    inherited Create(TheOwner);
    StopOnException := True;
  end;

  destructor TMyLogger.Destroy;
  begin
    inherited Destroy;
  end;

var
  Application: TMyLogger;
begin
  Application := TMyLogger.Create(nil);
  Application.Title := 'Logger';
  Application.Run;
  Application.Free;
end.
