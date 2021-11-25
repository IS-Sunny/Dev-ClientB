table 50100 "Customer Category"
{
    Caption = 'Customer Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;

        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Default; Boolean)
        {
            Caption = 'Default';
            DataClassification = CustomerContent;
        }
        field(4; TotalCustomersForCategory; Integer)
        {
            Caption = 'TotalCustomersForCategory';
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = count(Customer where("CustomerCategory" = field(No)));
        }
        field(5; EnableNewsletter; Option)
        {
            Caption = 'Enable Newsletter';
            OptionMembers = " ","Full","Limited";
            OptionCaption = ',Full,Limited';
            DataClassification = CustomerContent;
        }
        field(6; FreeGiftsAvailable; Boolean)
        {
            Caption = 'Free Gifts Available';
            DataClassification = CustomerContent;
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;






}
