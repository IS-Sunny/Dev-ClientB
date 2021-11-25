page 50103 CustomerCategoryEntity
{

    APIGroup = 'APIGrp';
    APIPublisher = 'DSA';
    APIVersion = 'v1.0';
    Caption = 'Customer Category';
    ODataKeyFields = SystemId;
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
                field(CustomerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(SystemId; Rec.SystemId)
                {

                }
                field(ID; Rec.RecordId)
                {

                }
                field(totalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    Caption = 'TotalCustomersForCategory';
                }
            }
        }
    }

}
