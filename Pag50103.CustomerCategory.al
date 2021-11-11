page 50103 CustomerCategory
{

    APIGroup = 'APIGrp';
    APIPublisher = 'DSA';
    APIVersion = 'v1.0';
    Caption = 'Customer Category';
    DelayedInsert = true;
    EntityName = 'EntityCustomerCategory';
    EntitySetName = 'EntityCustomerCategorySet';
    PageType = API;
    SourceTable = "Customer Category";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(default; Rec.Default)
                {
                    Caption = 'Default';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(enableNewsletter; Rec.EnableNewsletter)
                {
                    Caption = 'Enable Newsletter';
                }
                field(freeGiftsAvailable; Rec.FreeGiftsAvailable)
                {
                    Caption = 'Free Gifts Available';
                }
                field(no; Rec.No)
                {
                    Caption = 'No';
                }
               

                field(totalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    Caption = 'TotalCustomersForCategory';
                }
            }
        }
    }

}
