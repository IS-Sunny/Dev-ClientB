table 50121 TestTable_VC
{
    Caption = 'TestTable_VC';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[20])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    
}
