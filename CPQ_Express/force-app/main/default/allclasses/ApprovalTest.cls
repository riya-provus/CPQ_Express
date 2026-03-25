@isTest
public class ApprovalTest {

    @isTest
    static void OnlyManagerApproval(){
        Profile managerProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        Profile salesProfile = [SELECT Id FROM Profile WHERE Name = 'Custom Sales Rep' LIMIT 1];

        User managerUser = new User(
            Alias = 'mgr',
            Email = 'mgr@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Manager',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', 
            ProfileId = managerProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'mgr' + System.currentTimeMillis() + '@test.com'
        );
        insert managerUser;

        User salesUser = new User(
           	Alias = 'sales',
            Email = 'sales@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Sales',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = salesProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'sales' + System.currentTimeMillis() + '@test.com'
        );
        insert salesUser;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );
        insert opp;

      
        Quote qt = new Quote(
            Name = 'Test Quote',
            OpportunityId = opp.Id,
            Status = 'Submitted'
        );
        insert qt;

        System.runAs(managerUser){
            qt.Status = 'Approved';
            update qt;
        }

        System.runAs(salesUser){
            qt.Status = 'Approved';
            try{
                update qt;
                System.assert(false);
            }catch(Exception e){
                System.assert(true);
            }
        }
    }
}