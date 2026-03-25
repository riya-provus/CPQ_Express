public class OnlyManagerApprovalHandler {
    public static void ApproveStatus(List<Quote>newQuotes ,Map<Id,Quote>oldMap){
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;

        for(Quote q : newQuotes){

            Quote oldQuote = oldMap.get(q.Id);

            if(oldQuote.Status == 'Submitted' && q.Status == 'Approved'){

                if(profileName != 'System Administrator'){
                    q.addError('No other User Except the Manager has authority to approve the Quote');
                }
            }
        }
    }
}