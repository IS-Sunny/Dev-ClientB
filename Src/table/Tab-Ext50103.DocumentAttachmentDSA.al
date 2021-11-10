tableextension 50109 DocumentAttachmentDSA extends "Document Attachment"
{
    fields
    {
        field(50100; "Attachment Size"; Integer)
        {
            Caption = 'Size (KB)';
            DataClassification = ToBeClassified;
        }
        field(50101; CompanyName; Text[100])
        {
            Caption = 'Company name';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()
    var

        fileGuid: Guid;
        TeantMedia: Record "Tenant Media";
        fileObj: File;
        //FileInfo : DotNet FileInfo;
        fileSize: Integer;
        FileManagement: Codeunit "File Management";
    begin
        fileGuid := "Document Reference ID".MediaId();
        //TeantMedia.SetRange(ID, fileGuid);
        //TeantMedia.FindFirst();
        TeantMedia.Get(fileGuid);

        fileSize := TeantMedia.Content.Length();
        // fileSize := TeantMedia."Content".Length() * 1.315;
        fileSize := System.Round(fileSize / 1024) div 1;
        "Attachment Size" := fileSize;

        //FileManagement.GetClientFileProperties()

        "CompanyName" := TeantMedia."Company Name";
        //  FileManagement.get

    end;

}
