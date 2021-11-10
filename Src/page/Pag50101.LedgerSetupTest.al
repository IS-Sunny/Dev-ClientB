page 50101 LedgerSetupTest
{

    Caption = 'Importing test....';
    PageType = NavigatePage;
    SourceTable = "General Ledger Setup";
    //SourceTable = "SMTP Mail Setup";

    layout
    {
        area(content)
        {
            group(Control96)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible AND NOT FinalStepVisible;
                Caption = 'Testing Page 1';

            }
            group(Control98)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible AND FinalStepVisible;
                Caption = 'Testing Page 2';

            }
            group("<MediaRepositoryDone>")
            {
                Visible = FirstStepVisible;
                group("Welcome to Email Setup")
                {
                    Caption = 'Welcome to Email Setup';
                    Visible = FirstStepVisible;
                    group(Control18)
                    {
                        InstructionalText = 'To send email messages using actions on documents, such as the Sales Invoice window, you must log on to the relevant email account.';
                        ShowCaption = true;
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Control22)
                    {
                        InstructionalText = 'Choose Next so you can set up email sending from documents.';
                        ShowCaption = false;
                    }
                }
            }
            group(Control2)
            {
                InstructionalText = 'Choose your email provider.';
                ShowCaption = false;
                Visible = ProviderStepVisible;

            }
            group(Control12)
            {
                ShowCaption = false;
                Visible = SettingsStepVisible;
                group(Control27)
                {
                    InstructionalText = 'Enter the SMTP Server Details.';
                    ShowCaption = false;
                    Visible = AdvancedSettingsVisible;


                }
                group(Control26)
                {
                    InstructionalText = 'Enter the credentials for the account, which will be used for sending emails.';
                    ShowCaption = false;
                    Visible = MailSettingsVisible;

                }
            }
            group(Control17)
            {
                ShowCaption = false;
                Visible = FinalStepVisible;
                group(Control23)
                {
                    InstructionalText = 'To verify that the specified email setup works, choose Send Test Email.';
                    ShowCaption = false;
                }
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Control25)
                    {
                        InstructionalText = 'To enable email sending directly from documents, choose Finish.';
                        ShowCaption = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {

            action(ActionBack)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Back';
                Enabled = true;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(true);

                end;
            }
            action(ActionNext)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Next';
                Enabled = true;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin

                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finish';
                Enabled = true;
                InFooterBar = true;
                Image = NextRecord;
                trigger OnAction()
                begin
                    FinishAction;

                end;
            }
        }
    }
    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";

        ClientTypeManagement: Codeunit "Client Type Management";
        Step: Option Start,Provider,Settings,Finish;
        TopBannerVisible: Boolean;
        FirstStepVisible: Boolean;
        ProviderStepVisible: Boolean;
        SettingsStepVisible: Boolean;
        AdvancedSettingsVisible: Boolean;
        MailSettingsVisible: Boolean;
        FinalStepVisible: Boolean;
        EmailProvider: Option "Office 365",Outlook,Gmail,Yahoo,"Other Email Provider";
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        NAVNotSetUpQst: Label 'Email has not been set up.\\Are you sure you want to exit?';
        EmailPasswordMissingErr: Label 'Please enter a valid email address and password.';
        Password: Text[250];
        DummyPasswordTxt: Label '***', Locked = true;

    local procedure EnableControls()
    begin
        ResetControls;

        case Step of
            Step::Start:
                ShowStartStep;
            Step::Provider:
                ShowProviderStep;
            Step::Settings:
                ShowSettingsStep;
            Step::Finish:
                ShowFinishStep;
        end;
    end;

    local procedure StoreSMTPSetup()

    begin

    end;

    local procedure SendTestEmailAction()
    begin
        StoreSMTPSetup;
        //CODEUNIT.Run(CODEUNIT::"SMTP Test Mail");
    end;

    local procedure FinishAction()
    //var
    // AssistedSetup: Codeunit "Assisted Setup";
    begin
        StoreSMTPSetup;
        //AssistedSetup.Complete(PAGE::"Email Setup Wizard");
        CurrPage.Close;
    end;

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls;
    end;

    local procedure ShowStartStep()
    begin
        FirstStepVisible := true;
        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowProviderStep()
    begin
        ProviderStepVisible := true;
    end;

    local procedure ShowSettingsStep()
    begin
        SettingsStepVisible := true;
        AdvancedSettingsVisible := EmailProvider = EmailProvider::"Other Email Provider";
        //  MailSettingsVisible := Authentication = Authentication::Basic;
        // NextActionEnabled := "SMTP Server" <> '';
    end;

    local procedure ShowFinishStep()
    begin
        FinalStepVisible := true;
        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls()
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        FirstStepVisible := false;
        ProviderStepVisible := false;
        SettingsStepVisible := false;
        FinalStepVisible := false;
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(ClientTypeManagement.GetCurrentClientType)) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(ClientTypeManagement.GetCurrentClientType))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue;
    end;

    local procedure GetEmailProvider()
    begin

    end;

}
