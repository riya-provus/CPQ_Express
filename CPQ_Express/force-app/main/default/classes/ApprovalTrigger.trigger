trigger ApprovalTrigger on Quote (before update ,after update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        OnlyManagerApprovalHandler.ApproveStatus(Trigger.New,Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        QuoteOpportunityHandler.updateOpportunity(Trigger.New, Trigger.oldMap);
    }
}