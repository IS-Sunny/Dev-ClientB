codeunit 50101 "Test"
{
    TableNo = "Gen. Journal Batch";
    trigger OnRun()
    begin
        GeneralBatch.Copy(Rec);
        MyProcedure();
    end;

    var
        GeneralBatch: Record "Gen. Journal Batch";
        TempPurchLineLocal: Record "Purchase Line";

        custReport: Report "Customer - List";
        custCategory: Record "Customer Category";


    local procedure createData()
    begin
        custCategory.Init();
        custCategory.No := 'C0001';
        custCategory.Description := 'Desc1';

    end;

    local procedure MyProcedure()
    begin
        GeneralBatch.SetRange("Journal Template Name");
        GeneralBatch.SetRange("Name");
        GeneralBatch.TestField("Description");
    end;










}
