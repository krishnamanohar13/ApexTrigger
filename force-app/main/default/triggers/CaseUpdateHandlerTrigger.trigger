trigger CaseUpdateHandlerTrigger on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
       // CaseUpdateHandler.createCase(Trigger.new);
    }       
}
