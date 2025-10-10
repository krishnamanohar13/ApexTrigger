trigger LastestCaseHandlerTrigger on Case (after insert,after update,after delete) {
    if(Trigger.isAfter && Trigger.isInsert){
       // LastestCaseHandler.latestCase(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //LastestCaseHandler.latestCase(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isDelete){
        //LastestCaseHandler.latestCase(Trigger.old);
    }
}