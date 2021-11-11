pageextension 50101 "GeneralLedgerEntries.DSA" extends "General Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {

            field("Chinese voucher No."; Rec."Chinese voucher No.")
            {

                ApplicationArea = Basic, Suite;
                Editable = true;
                ToolTip = 'Specifies the value of the Chinese voucher No. field.';
            }


        }
    }
}
