trigger CreateOpportunitiesForAccountTrigger on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        CreateOpportunitiesForAccount.createOpporunity(Trigger.new);
    }
}