@isTest
public class QuoteOpportunityHandlerTest {
    @isTest
    static void testOpportunityClosedWonWhenAllQuotesApproved(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = acc.Id
        );
        insert opp;
        Quote q1 = new Quote(
            Name = 'Quote 1',
            OpportunityId = opp.Id,
            Status = 'Draft'
        );
        Quote q2 = new Quote(
            Name = 'Quote 2',
            OpportunityId = opp.Id,
            Status = 'Draft'
        );
        insert new List<Quote>{q1, q2};
        Test.startTest();
        q1.Status = 'Approved';
        update q1;
        q2.Status = 'Approved';
        update q2;
        Test.stopTest();
        Opportunity updatedOpp = [
            SELECT StageName FROM Opportunity WHERE Id = :opp.Id
        ];
        System.assertEquals('Closed Won', updatedOpp.StageName);
    }
     @isTest
    static void testOpportunityNotChangedIfQuoteNotApproved(){
        Account acc = new Account(Name = 'Test Account 2');
        insert acc;
        
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity 2',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = acc.Id
        );
        insert opp;
        
        Quote q1 = new Quote(Name = 'Quote 1', OpportunityId = opp.Id, Status = 'Draft');
        insert q1;
        
        Test.startTest();
        q1.Status = 'Rejected';
        update q1; 
        Test.stopTest();
        
        Opportunity updatedOpp = [SELECT StageName FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Prospecting', updatedOpp.StageName);
    }
}