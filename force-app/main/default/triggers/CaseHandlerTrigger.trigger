trigger CaseHandlerTrigger on Case (after insert,after update,after delete) {
    if(Trigger.isAfter && Trigger.isInsert){
        CaseHandler.latestCase(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        CaseHandler.latestCase(Trigger.old);
    }
}