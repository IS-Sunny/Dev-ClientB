pageextension 50102 "BusinessManagerRoleCenter.DSA" extends "Business Manager Role Center"
{
    actions
    {

        addfirst(Action39)
        {
            /*
            action(ExpensePwerApp)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Expense Pwer app';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "DSA_FPwrAppExpTable";

                ToolTip = 'Post Expense From Power app.';
            }
*/
            action(DocumentAttachmentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Document Attachment List';
                Image = ListPage;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "DocumentAttachmentPageList";
            }

            action(MKIntegration)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Modula Integration';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "ModulaIntegration";
            }

            action(WXIntegration)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'WeChat Integration';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "DSA_CWXApi";
            }
            action(CustomerCategory)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Category';
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "CustomerCategoryList";
            }

        }
        addafter("Sales Taxes Collected")
        {
            action("Customer report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer report';
                Image = Report;
                RunObject = report "CustomerReport";
            }
        }



    }
}
