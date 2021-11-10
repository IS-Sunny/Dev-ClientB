tableextension 50103 CustomerTableExtensions extends Customer
{
    fields
    {
        field(50100; CustomerCategory; Code[20])
        {
            Caption = 'Customer Category';
            //TableRelation = "Customer Category";
            DataClassification = CustomerContent;
        }
    }
}
