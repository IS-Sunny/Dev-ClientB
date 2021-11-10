pageextension 50121 "GeneralLedgerSetupPage.DSA" extends "General Ledger Setup"
{
    layout
    {
        //addfirst()
        addlast(General)
        {

            field(ChineseVoucher_CN; rec.ChineseVoucher_CN)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chinese Voucher';
            }
            field(ChineseVoucherNos; rec.ChineseVoucherNos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chinese voucher Nos.';
            }



        }
    }
}
