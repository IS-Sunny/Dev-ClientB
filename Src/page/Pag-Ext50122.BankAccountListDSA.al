pageextension 50122 "BankAccountList.DSA" extends "Bank Account List"
{
    layout
    {
        addlast(Control1)
        {
            field(LocalName; rec.LocalName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Local name';
            }
        }
    }
}
