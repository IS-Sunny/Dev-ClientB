table 50101 FreeGifts
{
    Caption = 'FreeGifts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; CustomerCategoryCode; Code[20])
        {
            Caption = 'CustomerCategoryCode';
            DataClassification = CustomerContent;
            TableRelation = "Customer Category";
        }
        field(2; ItemNo; Code[20])
        {
            Caption = 'ItemNo';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(3; MinimumOrderQuantity; Decimal)
        {
            Caption = 'MinimumOrderQuantity';
            DataClassification = CustomerContent;
        }
        field(4; GiftQuantity; Decimal)
        {
            Caption = 'GiftQuantity';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; CustomerCategoryCode, ItemNo)
        {
            Clustered = true;
        }
    }

}
