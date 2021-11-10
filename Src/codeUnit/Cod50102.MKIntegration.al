codeunit 50102 MKIntegration
{
    TableNo = Customer;

    trigger OnRun()
    begin
        getToken();
    end;

    procedure testXX(): Text
    var
        result: text;
    begin
        result := '223';
        exit(result);
    end;

    procedure SHA256(var _appCode: Text; var _appSecret: Text; var _timestamp: Text): Text
    var
        CrypMangement: Codeunit "Cryptography Management";
        HashAlgorithmType: Option MD5,SHA1,SHA256,SHA384,SHA581;
        Encoding: TextEncoding;
        valueText: Text;
        result: Text;
    begin
        valueText := _appCode + ':' + _appSecret + ':' + _timestamp;
        //CrypMangement.GenerateHashAsBase64String()
        result := CrypMangement.GenerateHashAsBase64String(valueText, HashAlgorithmType::SHA256);
        result := result.ToLower();
        exit(result);
    end;


    procedure GetLoginJson(): Text
    var
        appCode: Text;
        appSecret: Text;
        jsonObj: JsonObject;
        cDateTime2: DateTime;
        cDateTime1: DateTime;
        DurationText: Text;
        iDuration: BigInteger;
        secret: Text;
        data: Text;

    begin
        appCode := 'UI190719CQB91UOG';
        appSecret := 'BWxcHozmkXszkXYoEOytpibmDWsBClnuQaUBWmCokJAwIebClANFlUtJfhlUjXrP';
        jsonObj.Add('appCode', appCode);

        cDateTime2 := System.CurrentDateTime();
        cDateTime1 := CreateDateTime(19700101D, 000000T);
        iDuration := (cDateTime2 - cDateTime1) / 1;
        DurationText := Format(iDuration);
        secret := SHA256(appCode, appSecret, DurationText);
        jsonObj.add('secret', secret);
        jsonObj.Add('timestamp', DurationText);


        jsonObj.WriteTo(data);
        exit(data);

    end;

    procedure getToken()
    var
        client: HttpClient;
        headers: HttpHeaders;
        content: HttpContent;
        test: HttpRequestMessage;
        httpResponseMessage: HttpResponseMessage;
        webAPIURL: Text;
        Data: Text;
        loginJson: Text;
        contentHeaders: HttpHeaders;
        httpwebRequest: Codeunit "Http Web Request Mgt.";
    begin
        headers := client.DefaultRequestHeaders();
        // headers.Add()
        // headers.Add('content-type', 'application/json');
        webAPIURL := 'https://www.maycur.com/api/openapi/auth/login';
        loginJson := GetLoginJson();
        content.WriteFrom(loginJson);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        // client.Get(webAPIURL, httpResponseMessage);
        client.Post(webAPIURL, content, httpResponseMessage);
        if httpResponseMessage.IsSuccessStatusCode() then begin
            httpResponseMessage.Content().ReadAs(Data);
        end;



    end;

    procedure GetRequest(AdditionalURL: Text; var Data: Text; var httpStatusCode: Integer): Boolean
    var
        // NYAPISetup: Record "NYT API Setup";
        httpClient: HttpClient;
        httpHeader: HttpHeaders;
        AuthString: Text;
        httpResponseMessage: HttpResponseMessage;
        requestUri: Text;
    begin
        // NYAPISetup.get();
        requestUri := '';//NYAPISetup."Base URL" + AdditionalURL + 'api-key=' + NYAPISetup.GetAPIKey();
        httpClient.DefaultRequestHeaders().Add('Authorization', AuthString);

        httpClient.Get(requestUri, httpResponseMessage);
        httpResponseMessage.Content().ReadAs(Data);
        httpStatusCode := httpResponseMessage.HttpStatusCode();
        if not httpResponseMessage.IsSuccessStatusCode() then
            Error('', httpStatusCode, Data);
        exit(true);
    end;

    procedure call()
    var
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        HttpClientReq: HttpClient;
    begin



        /*
            navBinding := navBinding.BasicHttpBinding;  

        // Set security mode to BasicHttpSecurityMode.TransportCredentialOnly  
            navBinding.Security.Mode := 4;   
            address :=   
                'https://localhost:7047/DynamicsNAV70/WS/CRONUS%20International%20Ltd./Page/SalesOrder';  

            // Set client credential type to HttpClientCredentialType.Windows  
            navBinding.Security.Transport.ClientCredentialType := 4;  
            salesOrderService := salesOrderService.SalesOrder_PortClient(navBinding,  
                endpointAddress.EndpointAddress(address);  

            // Set impersonation level to System.Security.Principal.TokenImpersonationLevel.Delegation  
            salesOrderService.ClientCredentials.Windows.AllowedImpersonationLevel := 4;  

            // Include the sales order ID to be read.  
            salesOrder := salesOrderService.Read('10000');
            */
    end;

    procedure AddHttpBasicAuthHeader(UserName: Text[50]; Password: Text[50]; var HttpClient: HttpClient);
    var
        AuthString: Text;
        TempBlob: CodeUnit "Temp Blob";
    begin
        AuthString := STRSUBSTNO('%1:%2', UserName, Password);
        // TempBlob.(AuthString);

        //AuthString := TempBlob.ToBase64String();
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;

    procedure CreateBasicAuthHeader(UserName: Text; Password: Text): Text
    var
        TempBlob: CodeUnit "Temp Blob";
        userPwdStream: OutStream;
    begin
        TempBlob.CreateOutStream(userPwdStream);
        userPwdStream.WriteText(StrSubstNo('%1:%2', UserName, Password));

        //TempBlob.WriteAsText(StrSubstNo('%1:%2', UserName, Password), TextEncoding::UTF8);
        // exit(StrSubstNo('Basic %1', TempBlob.ToBase64String()));
    end;

    procedure CallService(ProjectName: Text; RequestUrl: Text; RequestType: Enum "Http Request Type"; payload: Text; Username: Text; Password: Text): Text
    var
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        contentHeaders: HttpHeaders;
    begin
        RequestHeaders := Client.DefaultRequestHeaders();
        RequestHeaders.Add('Authorization', CreateBasicAuthHeader(Username, Password));

        case RequestType of
            RequestType::Get:
                Client.Get(RequestURL, ResponseMessage);
            RequestType::patch:
                begin
                    RequestContent.WriteFrom(payload);

                    RequestContent.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json-patch+json');

                    RequestMessage.Content := RequestContent;

                    RequestMessage.SetRequestUri(RequestURL);
                    RequestMessage.Method := 'PATCH';

                    client.Send(RequestMessage, ResponseMessage);
                end;
            RequestType::post:
                begin
                    RequestContent.WriteFrom(payload);

                    RequestContent.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json');

                    Client.Post(RequestURL, RequestContent, ResponseMessage);
                end;
            RequestType::delete:
                Client.Delete(RequestURL, ResponseMessage);
        end;
        if ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            exit(ResponseText);
        end;
    end;

    procedure GetIP(): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        J: JsonObject;
        ResponseTxt: Text;
    begin
        if Client.Get('https://api.ipify.org/?format=json', Response) then
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseTxt);
                J.ReadFrom(ResponseTxt);
                exit(GetJsonTextField(J, 'ip'));
            end;
    end;

    procedure GetJsonTextField(o: JsonObject; Member: Text): Text
    var
        Result: JsonToken;
    begin
        if o.Get(Member, Result) then
            exit(Result.AsValue().AsText());
    end;

}
