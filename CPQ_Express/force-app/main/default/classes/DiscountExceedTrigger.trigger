trigger DiscountExceedTrigger on QuoteLineItem (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            QuoteLineItemHandler.getApproval(Trigger.New);
        }
    }
}