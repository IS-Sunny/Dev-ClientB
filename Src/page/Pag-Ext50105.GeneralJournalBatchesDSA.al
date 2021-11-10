pageextension 50135 "GeneralJournalBatches.DSA" extends "General Journal Batches"
{
    actions
    {
        addafter("Post and &Print")
        {
            action(Test)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test posting';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Codeunit "Test";
                // ShortCutKey = 'Shift+F9';
                // ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
            }

        }
    }

}
