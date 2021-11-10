tableextension 50101 "GeneralLedgerSetup.DSA" extends "General Ledger Setup"
{
    fields
    {
        field(50100; ChineseVoucher_CN; Boolean)
        {
            Caption = 'ChineseVoucher_CN';
            DataClassification = ToBeClassified;
        }
        field(50101; ChineseVoucherNos; text[10])
        {
            Caption = 'Chinese voucher Nos.';
            TableRelation = "No. Series";
        }
    }
}
