tableextension 50121 "BankAccount.DSA" extends "Bank Account"
{
    fields
    {
        field(50100; LocalName; Text[100])
        {
            Caption = 'LocalName';
            DataClassification = ToBeClassified;
        }
        field(50101; DefaultAccount; Text[100])
        {
            Caption = 'DefaultAccount';
            DataClassification = ToBeClassified;
        }
    }
}
