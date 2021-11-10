page 50102 DocumentAttachmentPageList
{

    ApplicationArea = All;
    Caption = 'DocumentAttachmentPageList';
    PageType = List;
    SourceTable = "Document Attachment";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field';
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field("Attached Date"; Rec."Attached Date")
                {
                    ToolTip = 'Specifies the value of the Attached Date field';
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ToolTip = 'Specifies the value of the Attachment field';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        FileName: Text;
                        fileStream: OutStream;
                    begin
                        rec."Document Reference ID".ExportStream(fileStream);

                        if rec."Document Reference ID".HasValue then
                            Export_DSA(true)
                        else begin
                            ImportWithFilter(TempBlob, FileName);
                            // if FileName <> '' then
                            //   SaveAttachment_DSA(xRec, FileName, TempBlob);
                            CurrPage.Update(false);
                        end;
                    end;

                }
                field("File Type"; Rec."File Type")
                {
                    ToolTip = 'Specifies the value of the File Type field';
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ToolTip = 'Specifies the value of the File Extension field';
                    ApplicationArea = All;
                }
                field("Attachment Size"; rec."Attachment Size")
                {
                    ApplicationArea = All;
                }
                field("Attached By"; Rec."Attached By")
                {
                    ToolTip = 'Specifies the value of the Attached By field';
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field';
                    ApplicationArea = All;
                }
                field("Document Reference ID"; Rec."Document Reference ID")
                {
                    ToolTip = 'Specifies the value of the Document Reference ID field';
                    ApplicationArea = All;
                }

                field(User; Rec.User)
                {
                    ToolTip = 'Specifies the value of the User field';
                    ApplicationArea = All;
                }
                field(CompanyName; rec.CompanyName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        NoDocumentAttachedErr: Label 'Please attach a document first.';
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        FileManagement: Codeunit "File Management";
        IncomingFileName: Text;
        DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';

    local procedure ImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        IsHandled: Boolean;
        ImportTxt: Label 'Attach a document.';
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;


    begin
        IsHandled := false;
        // OnBeforeImportWithFilter(TempBlob, FileName, IsHandled);
        if IsHandled then
            exit;

        FileName := FileManagement.BLOBImportWithFilter(
            TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
    end;

    procedure Export_DSA(ShowFileDialog: Boolean): Text
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
    begin
        if rec.ID = 0 then
            exit;
        // Ensure document has value in DB
        if not rec."Document Reference ID".HasValue then
            exit;

        //  OnBeforeExportAttachment(Rec);
        FullFileName := rec."File Name" + '.' + rec."File Extension";
        TempBlob.CreateOutStream(DocumentStream);
        rec."Document Reference ID".ExportStream(DocumentStream);
        exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
    end;

    procedure SaveAttachment_DSA(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob")
    var
        DocStream: InStream;
    begin
        // OnBeforeSaveAttachment(Rec, RecRef, FileName, TempBlob);

        if FileName = '' then
            Error(EmptyFileNameErr);
        // Validate file/media is not empty
        if not TempBlob.HasValue then
            Error(NoContentErr);

        TempBlob.CreateInStream(DocStream);
        InsertAttachment_DSA(DocStream, RecRef, FileName);
    end;

    local procedure InsertAttachment_DSA(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    begin
        IncomingFileName := FileName;

        rec.Validate(rec."File Extension", FileManagement.GetExtension(IncomingFileName));
        rec.Validate(rec."File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen(rec."File Name")));

        // IMPORTSTREAM(stream,description, mime-type,filename)
        // description and mime-type are set empty and will be automatically set by platform code from the stream
        rec."Document Reference ID".ImportStream(DocStream, '');
        if not rec."Document Reference ID".HasValue then
            Error(NoDocumentAttachedErr);

        rec.InitFieldsFromRecRef(RecRef);

        //OnBeforeInsertAttachment(Rec, RecRef);
        rec.Insert(true);
    end;

}
