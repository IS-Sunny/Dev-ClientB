codeunit 50104 "Gen. Jnl.-Post Line.DSA"
{
    TableNo = "Gen. Journal Line";


    trigger OnRun()
    begin

    end;

    var
        voucher_CN: Text[10];
        NoSeriesMgt: codeunit NoSeriesManagement;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnAfterConfirmPostJournalBatch', '', false, false)]
    local procedure OnAfterConfirmPostJournalBatch(var GenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        LedgerSetup: Record "General Ledger Setup";
        newNo: Code[20];
        newSeries: Code[20];
    begin
        GenJournalLine.SetFilter("Chinese voucher No.", '=%1', '');
        LedgerSetup.Get();
        NoSeriesMgt.InitSeries(LedgerSetup.ChineseVoucherNos, '', 0D, newNo, newSeries);
        while GenJournalLine.FindFirst() do begin
            GenJournalLine."Chinese voucher No." := newNo;
            GenJournalLine.Modify();
            GenJournalLine.SetFilter("Document No.", '>%1', GenJournalLine."Document No.");
        end;
        exit;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeProcessLines', '', false, false)]
    local procedure OnBeforeProcessLines(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean; CommitIsSuppressed: Boolean)
    var
        GenJnlLine: Record "Gen. Journal Line";
        LedgerSetup: Record "General Ledger Setup";
        newNo: Code[20];
        newSeries: Code[20];
    begin
        GenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJnlLine.SetFilter("Chinese voucher No.", '=%1', '');
        LedgerSetup.Get();
        NoSeriesMgt.InitSeries(LedgerSetup.ChineseVoucherNos, '', 0D, newNo, newSeries);
        while GenJnlLine.FindFirst() do begin
            GenJnlLine."Chinese voucher No." := newNo;
            GenJnlLine.Modify();
            GenJnlLine.SetFilter("Document No.", '>%1', GenJnlLine."Document No.");
        end;

    end;
    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-B.Post+Print", 'OnBeforePostJournalBatch', '', false, false)]
        local procedure OnBeforePostJournalBatch(var GenJournalBatch: Record "Gen. Journal Batch"; var HideDialog: Boolean)
        var
            GenJnlLine: Record "Gen. Journal Line";
            LedgerSetup: Record "General Ledger Setup";
            newNo: Code[20];
            newSeries: Code[20];
        begin

            GenJnlLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
            GenJnlLine.SetFilter("Chinese voucher No.", '=%1', '');
            LedgerSetup.Get();
            NoSeriesMgt.InitSeries(LedgerSetup.ChineseVoucherNos, '', 0D, newNo, newSeries);
            while GenJnlLine.FindFirst() do begin
                GenJnlLine."Chinese voucher No." := newNo;
                GenJnlLine.Modify();
                GenJnlLine.SetFilter("Document No.", '>%1', GenJnlLine."Document No.");
            end;

        end;
        

    // [IntegrationEvent(true, false)]
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"MyPublishers", 'OnAddressLineChanged', '', true, true)]
    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', true, false)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    var
        LedgerSetup: Record "General Ledger Setup";
        newNo: Code[20];
        newSeries: Code[20];
    begin
        LedgerSetup.Get();
        NoSeriesMgt.InitSeries(LedgerSetup.ChineseVoucherNos, '', 0D, newNo, newSeries);
        //voucher_CN := newNo;
        GLEntry."Chinese voucher No." := newNo;//'记0001';
    end
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        LedgerSetup: Record "General Ledger Setup";
        GLEntryFind: Record "G/L Entry";
        newNo: Code[20];
        newSeries: Code[20];
    begin
        // GLEntryFind.get
        LedgerSetup.Get();
        if LedgerSetup.ChineseVoucher_CN then begin
            GLEntry."Chinese voucher No." := GenJournalLine."Chinese voucher No.";//'记0001';
        end;


    end;
    //local procedure OnBeforePostGLAcc(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    // begin
    // end;
    /*
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGLAcc', '', false, false)]
    local procedure OnBeforePostGLAcc(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
        LedgerSetup: Record "General Ledger Setup";
        newNo: Code[20];
        newSeries: Code[20];
    begin
        LedgerSetup.Get();
        NoSeriesMgt.InitSeries(LedgerSetup.ChineseVoucherNos, '', 0D, newNo, newSeries);
        voucher_CN := newNo;
        //GLEntry."Chinese voucher No." := newNo;
        GenJournalLine."Chinese voucher No." := newNo;
        GenJournalLine.UpdateAccountID();
    end;
    */


}
