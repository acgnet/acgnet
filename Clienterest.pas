unit Clientrest;

interface
uses
  REST.Client, REST.Types, System.SysUtils;

function MetodoPost(ABaseUrl, AResource, AToken, AJson: string): string;

implementation

function MetodoPost(ABaseUrl, AResource, AToken, AJson: string): string;
var
  LClient  : TRestClient;
  LRequest : TRESTRequest;
  LResponse: TRESTResponse;
begin
  LClient   := TRESTClient.Create(ABaseUrl);
  LRequest  := TRESTRequest.Create(nil);
  LResponse := TRESTResponse.Create(nil);

  try
    LRequest.Method   := rmPOST;
    LRequest.Resource := AResource;
    LRequest.Client   := LClient;
    LRequest.Response := LResponse;

    LRequest.Params.AddHeader('Authorization', Format('Bearer %s',[AToken]));
    LRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];

    LRequest.Params.AddHeader('Content-Type', 'application/json');
    LRequest.Params.AddBody(AJson, ctAPPLICATION_JSON);

    LRequest.Execute;

    result := LResponse.Content;

  finally
    FreeAndNil(LClient);
    FreeAndNil(LRequest);
    FreeAndNil(LResponse);
  end;
end;
