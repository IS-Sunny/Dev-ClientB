
pagecustomization CustomizationList customizes "Customer List"
{
    actions
    {
        moveafter(Orders; "Blanket Orders")

        modify(NewSalesBlanketOrder)
        {
            Visible = false;
        }

    }
}
//pagecustomization MyCustomization customizes "Customer List"