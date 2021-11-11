pageextension 50104 "CustomerCard.DSA" extends "Customer Card"
{
    layout
    {
        addafter("Name")
        {

            field(CustomerCategory; Rec.CustomerCategory)
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Customer Category';
            }
        }
    }

}


