trigger TaskHandlerTrigger on Task (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        TaskHandler.preventDeletions(Trigger.old);
    }
}