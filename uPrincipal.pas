unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses Horse, Horse.Jhonson, System.Json;
begin


  THorse.Use(Jhonson);


  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

    THorse.Post('/OnCarHandled',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LBody: TJSONObject;
      license: string;
      channel : string;
      foto : string;
    begin


      // Req.Body gives access to the content of the request in string format.
      // Using jhonson middleware, we can get the content of the request in JSON format.

      LBody := Req.Body<TJSONObject>;
      channel:=LBody.GetValue<string>('AlarmInfoPlate.channel');
      license:=LBody.GetValue<string>('AlarmInfoPlate.result.PlateResult.license');
      foto:=LBody.GetValue<string>('AlarmInfoPlate.result.PlateResult.license');
      ShowMessage('Canal '+channel+' enviou placa '+license);
      Res.Send<TJSONObject>(LBody);

    end);

  THorse.Listen(9001);







end.
