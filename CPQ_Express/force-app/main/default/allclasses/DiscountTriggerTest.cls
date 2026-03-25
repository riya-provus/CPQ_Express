@isTest
public class DiscountTriggerTest {

    @isTest
    static void testDiscountApproval() {

        Id standardPricebookId = Test.getStandardPricebookId();

        Category__c category = new Category__c(
            Name = 'Electronics',
            Max_Discount__c = 10
        );
        insert category;

        Product2 prod = new Product2(
            Name = 'Laptop',
            Product_Category__c = category.Id,
            IsActive = true
        );
        insert prod;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebookId,
            Product2Id = prod.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert pbe;

        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = acc.Id
        );
        insert opp;
        Quote q = new Quote(
            Name = 'Test Quote',
            OpportunityId = opp.Id,
            Status = 'Draft',
            Pricebook2Id = standardPricebookId
        );
        insert q;
        QuoteLineItem qli = new QuoteLineItem(
            QuoteId = q.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 100,
            Discount = 20
        );

        Test.startTest();
        insert qli;
        Test.stopTest();
        Quote updatedQuote = [SELECT Status FROM Quote WHERE Id = :q.Id];

        System.assertEquals('Submitted', updatedQuote.Status);
    }
}