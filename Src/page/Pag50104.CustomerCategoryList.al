page 50104 CustomerCategoryList
{

    ApplicationArea = All;
    Caption = 'CustomerCategoryList';
    PageType = List;
    SourceTable = "Customer Category";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(EnableNewsletter; Rec.EnableNewsletter)
                {
                    ToolTip = 'Specifies the value of the Enable Newsletter field.';
                    ApplicationArea = All;
                }
                field(FreeGiftsAvailable; Rec.FreeGiftsAvailable)
                {
                    ToolTip = 'Specifies the value of the Free Gifts Available field.';
                    ApplicationArea = All;
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(ID; Rec.RecordId)
                {

                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
                field(TotalCustomersForCategory; Rec.TotalCustomersForCategory)
                {
                    ToolTip = 'Specifies the value of the TotalCustomersForCategory field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
