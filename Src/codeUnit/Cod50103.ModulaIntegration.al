codeunit 50103 ModulaIntegration
{
    TableNo = "Inventory Profile";

    trigger OnRun()
    var
        requestUri: Text;
    begin
        // requestUri := 'http://10.0.10.17:3001/api/jobs/CFG-IMP-ART-BASE';
        // requestUri := 'http://10.0.10.17:3001/api/jobs/CFG-IMP-ARTICOLI';
        requestUri := 'http://10.0.10.17:3001/api/jobs/CFG-IMP-ORDINI';
        GetRequest(requestUri);
    end;

    /*
    <IMP_ARTICOLI>
<ART_OPERAZIONE>I</ART_OPERAZIONE>
<ART_ARTICOLO>WEB_ITEM_001</ART_ARTICOLO>
<ART_DES>Item description</ART_DES>
<ART_UMI>PZ</ART_UMI>
<ART_TIPOGESTART>V</ART_TIPOGESTART>
<ART_NOTE />
</IMP_ARTICOLI>
    */
    procedure linesData(): Text
    var
        jsonObj: JsonObject;
        jsonAll: JsonObject;
        jsonArray: JsonArray;
        data: Text;
        salesLine: Record "Sales Line";
        salesTable: Record "Sales Header";
    begin
        salesLine.SetFilter("No.", '>%1', '');
        salesLine.SetFilter("Document No.", '>%1', '');
        //salesLine.SetRange("No.", '00000', '99999');
        salesLine.FindFirst();
        //while salesLine.FindFirst() do begin
        jsonObj.Add('RIG_ORDINE', salesLine."Document No.");
        jsonObj.Add('RIG_ARTICOLO', salesLine."No.");
        jsonObj.Add('RIG_QTAR', salesLine."Quantity (Base)");

        jsonArray.Add(jsonObj);

        Clear(jsonObj);
        salesLine.SetFilter("Document No.", '>%1', salesLine."Document No.");
        //end;
        jsonAll.Add('IMP_ORDINI_RIGHE', jsonArray);

        jsonAll.WriteTo(data);

        exit(data);

    end;

    procedure OrderData(): Text
    var
        jsonObj: JsonObject;
        jsonObjLines: JsonObject;
        jsonOrderLine: JsonObject;
        jsonAll: JsonObject;
        jsonArrayOrder: JsonArray;
        jsonArrayLine: JsonArray;
        data: Text;
        salesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";

    begin
        salesHeader.SetFilter("No.", '>%1', '');
        salesHeader.SetFilter("Bill-to Address", '>%1', '');
        salesHeader.SetFilter("Bill-to Customer No.", '>%1', '');
        while salesHeader.FindFirst() do begin
            jsonObj.Add('ORD_OPERAZIONE', 'I');
            jsonObj.Add('ORD_ORDINE', salesHeader."No.");
            jsonObj.Add('ORD_DES', salesHeader."Bill-to Address");
            jsonObj.Add('ORD_CLIENTE', salesHeader."Bill-to Customer No.");

            jsonArrayOrder.Add(jsonObj);

            //jsonOrderLine.Add('IMP_ORDINI', jsonObj);

            //jsonOrderLine.Add('IMP_ORDINI_RIGHE', jsonArray);
            Clear(jsonObj);

            salesHeader.SetFilter("No.", '>%1', salesHeader."No.");


        end;
        jsonAll.Add('IMP_ORDINI', jsonArrayOrder);
        salesLine.SetFilter("Document No.", '>%1', '');
        salesLine.SetFilter("No.", '>%1', '');
        while salesLine.FindFirst() do begin
            jsonObjLines.Add('RIG_ORDINE', salesLine."Document No.");
            jsonObjLines.Add('RIG_ARTICOLO', salesLine."No.");
            jsonObjLines.Add('RIG_QTAR', salesLine."Quantity (Base)");

            jsonArrayLine.Add(jsonObjLines);

            Clear(jsonObjLines);
            salesLine.SetFilter("No.", '>%1', salesLine."No.");

        end;
        jsonAll.Add('IMP_ORDINI_RIGHE', jsonArrayLine);

        jsonAll.WriteTo(data);

        exit(data);



    end;

    procedure inventoryData(): Text
    var
        jsonObj: JsonObject;
        jsonAll: JsonObject;
        jsonArray: JsonArray;
        itemTable: Record "Item";
        data: Text;
    begin
        itemTable.SetFilter("Description", '>%1', '');
        itemTable.SetFilter("No.", '>%1', '');
        while itemTable.FindFirst() do begin
            jsonObj.Add('ART_OPERAZIONE', 'I');
            jsonObj.Add('ART_ARTICOLO', itemTable."No.");
            jsonObj.Add('ART_DES', itemTable.Description);
            jsonObj.Add('ART_CREA_UMI', itemTable."Base Unit of Measure");
            jsonObj.Add('ART_UMI', itemTable."Base Unit of Measure");
            jsonObj.Add('ART_ATTR1', itemTable."Net Weight");
            jsonObj.Add('ART_ATTR2', itemTable."Gross Weight");
            jsonObj.Add('ART_ATTR3', itemTable."Unit Volume");
            jsonArray.Add(jsonObj);
            Clear(jsonObj);
            itemTable.SetFilter("No.", '>%1', itemTable."No.");
        end;
        jsonAll.Add('IMP_ARTICOLI', jsonArray);
        jsonAll.WriteTo(data);
        exit(data);

    end;

    procedure buildData(): Text
    var
        jsonObj1: JsonObject;
        jsonObj2: JsonObject;
        jsonObj3: JsonObject;
        jsonObj4: JsonObject;
        JsonPart: JsonObject;
        jsonArrayA: JsonArray;
        jsonArrayB: JsonArray;
        jsonToken: JsonToken;
        data: Text;
    begin
        jsonObj1.Add('ART_ARTICOLO', 'Item0001');
        jsonObj1.Add('ART_DES', 'item0001 description');
        jsonObj1.Add('ART_ERRORE', 'testing');
        JsonArrayA.Add(jsonObj1);

        jsonObj2.Add('ART_ARTICOLO', 'Item0002');
        jsonObj2.Add('ART_DES', 'item0002 description');
        jsonObj2.Add('ART_ERRORE', 'testing2');
        JsonArrayA.Add(jsonObj2);

        JsonPart.Add('IMP_ARTICOLI', JsonArrayA);

        // "ORD_ORDINE": "WEB001001",  "ORD_DES": "Order description",  "ORD_TIPOOP": "P",  }, 
        /*
         jsonObj1.Add('ORD_ORDINE', 'WEB001021');
         jsonObj1.Add('ORD_DES', 'Order description');
         jsonObj1.Add('ORD_TIPOOP', 'P');
         JsonArrayA.Add(jsonObj1);

         jsonObj2.Add('ORD_ORDINE', 'WEB001022');
         jsonObj2.Add('ORD_DES', 'Order description');
         jsonObj2.Add('ORD_TIPOOP', 'P');
         JsonArrayA.Add(jsonObj2);

         JsonPart.Add('IMP_ORDINI', JsonArrayA);

         jsonObj3.Add('RIG_ORDINE', 'WEB001001');
         jsonObj3.Add('RIG_ARTICOLO', 'ITEM1001');
         jsonObj3.Add('RIG_QTAR', '1000');

         jsonArrayB.Add(jsonObj3);
         jsonObj4.Add('RIG_ORDINE', 'WEB001001');
         jsonObj4.Add('RIG_ARTICOLO', 'ITEM1002');
         jsonObj4.Add('RIG_QTAR', '2000');
         jsonArrayB.Add(jsonObj4);

         JsonPart.Add('IMP_ORDINI_RIGHE', jsonArrayB);
         */

        JsonPart.WriteTo(data);

        exit(data);

    end;

    procedure GetRequest(var requestUri: Text): Boolean
    var
        // NYAPISetup: Record "NYT API Setup";
        httpClient: HttpClient;
        httpHeader: HttpHeaders;
        httpContent: HttpContent;
        AuthString: Text;
        httpRequestMge: HttpRequestMessage;
        Data: Text;
        httpStatusCode: Integer;
        httpResponseMessage: HttpResponseMessage;
        userName: Text;
        Password: Text;
        respData: Text;
    begin
        userName := 'ADVANCED';
        Password := 'SYSTEM08';
        AddHttpBasicAuthHeader(userName, Password, httpClient);
        data := inventoryData();
        httpContent.WriteFrom(data);
        httpContent.GetHeaders(httpHeader);
        httpHeader.Clear();
        httpHeader.Add('Content-Type', 'application/json');
        httpClient.Post(requestUri, httpContent, httpResponseMessage);
        httpResponseMessage.Content().ReadAs(respData);
        httpStatusCode := httpResponseMessage.HttpStatusCode();
        if not httpResponseMessage.IsSuccessStatusCode() then
            Error('', httpStatusCode, Data);
        exit(true);
    end;

    procedure AddHttpBasicAuthHeader(UserName: Text[50]; Password: Text[50]; var HttpClient: HttpClient);
    var
        AuthString: Text;
        TypeHelper: Codeunit "Type Helper";
        Base64Convert: Codeunit "Base64 Convert";
    begin
        AuthString := STRSUBSTNO('%1:%2', UserName, Password);
        AuthString := Base64Convert.ToBase64(AuthString);
        //AuthString := TypeHelper.ConvertValueToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;

}
