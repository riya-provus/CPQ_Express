public class QuoteOpportunityHandler {

    public static void updateOpportunity(List<Quote> newQuotes, Map<Id, Quote> oldMap){
        Set<Id> oppIds = new Set<Id>();
        for(Quote q : newQuotes){
            Quote oldQ = oldMap.get(q.Id);

            if(q.Status == 'Approved' && oldQ.Status != 'Approved'){
                oppIds.add(q.OpportunityId);
            }
        }
        if(oppIds.isEmpty()){
            return;
        }

        List<Quote> allQuotes = [
            SELECT Id, Status, OpportunityId
            FROM Quote
            WHERE OpportunityId IN :oppIds
        ];

        Map<Id, Boolean> allApprovedMap = new Map<Id, Boolean>();
        for(Id oppId : oppIds){
            allApprovedMap.put(oppId, true);
        }

        for(Quote q : allQuotes){
            if(q.Status != 'Approved'){
                allApprovedMap.put(q.OpportunityId, false);
            }
        }
        
        List<Opportunity> oppToUpdate = new List<Opportunity>();

        for(Id oppId : allApprovedMap.keySet()){
            if(allApprovedMap.get(oppId)){
                oppToUpdate.add(new Opportunity(
                    Id = oppId,
                    StageName = 'Closed Won'
                ));
            }
        }
        if(!oppToUpdate.isEmpty()){
            update oppToUpdate;
        }
    }
}