public class QuoteLineItemHandler {
    public static void getApproval(List<QuoteLineItem> qliList){
        Set<Id> productIds = new Set<Id>();
        Set<Id> quoteIds = new Set<Id>();

        for(QuoteLineItem qli : qliList){
            if(qli.Product2Id != null){
                productIds.add(qli.Product2Id);
            }
            if(qli.QuoteId != null){
                quoteIds.add(qli.QuoteId);
            }
        }
        Map<Id, Product2> productMap = new Map<Id, Product2>(
            [SELECT Id, Product_Category__r.Max_Discount__c
             FROM Product2
             WHERE Id IN :productIds]
        );

        Set<Id> quotesToSubmit = new Set<Id>();

        for(QuoteLineItem qli : qliList){

            Product2 prod = productMap.get(qli.Product2Id);

            if(prod != null && prod.Product_Category__r != null){

                Decimal maxDiscount = prod.Product_Category__r.Max_Discount__c;

                if(qli.Discount != null && maxDiscount != null){

                    if(qli.Discount > maxDiscount){
                        quotesToSubmit.add(qli.QuoteId);
                    }
                }
            }
        }
        List<Quote> quotesToUpdate = [
            SELECT Id, Status
            FROM Quote
            WHERE Id IN :quotesToSubmit
        ];
        for(Quote q : quotesToUpdate){
            q.Status = 'Submitted';
        }
        update quotesToUpdate;
    }
}