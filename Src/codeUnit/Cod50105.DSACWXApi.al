codeunit 50105 DSA_CWXApi
{
    TableNo = Customer;

    trigger OnRun()
    begin
        getToken();
    end;

    procedure getToken()
    var
        webUrl: text;
        corpid: text;
        corpsecret: text;

    begin
        corpid := 'ww6bd96096c19633a8';
        corpsecret := '8T6GiJcjmSzZMEn4IB0zBIaodn9iiArSa6Pus_87lnE';
        webUrl := StrSubstNo('https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%1&corpsecret=%2', corpid, corpsecret);
        callWebApi(webUrl, 'GET', '');

    end;

    procedure callWebApi(_webAPIURL: text; _method: text; _strJsonData: text)
    var
        client: HttpClient;
        headers: HttpHeaders;
        content: HttpContent;
        test: HttpRequestMessage;
        httpResponseMessage: HttpResponseMessage;
        webAPIURL: Text;
        Data: Text;
        loginJson: Text;
        jsonObj: JsonObject;
        contentHeaders: HttpHeaders;
        httpwebRequest: Codeunit "Http Web Request Mgt.";
    begin
        headers := client.DefaultRequestHeaders();
        // headers.Add()
        // headers.Add('content-type', 'application/json');
        //loginJson := GetLoginJson();
        // jsonObj.Add('corpid', 'ww6bd96096c19633a8');
        //jsonObj.Add('corpsecret', '8T6GiJcjmSzZMEn4IB0zBIaodn9iiArSa6Pus_87lnE');
        //jsonObj.WriteTo(_strJsonData);
        content.WriteFrom(_strJsonData);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        case _method of
            'GET':
                client.Get(_webAPIURL, httpResponseMessage);
            'POST':
                client.Post(_webAPIURL, content, httpResponseMessage);

        end;
        if httpResponseMessage.IsSuccessStatusCode() then begin
            httpResponseMessage.Content().ReadAs(Data);
        end;




    end;

}
