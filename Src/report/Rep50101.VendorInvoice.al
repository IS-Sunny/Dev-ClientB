report 50101 VendorInvoice
{
    ApplicationArea = All;
    Caption = 'VendorInvoice';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(VendorInvoiceDisc; "Vendor Invoice Disc.")
        {
            column(Code; "Code")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Discount; "Discount %")
            {
            }
            column(MinimumAmount; "Minimum Amount")
            {
            }
            column(ServiceCharge; "Service Charge")
            {
            }

            column(SystemId; SystemId)
            {
            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
