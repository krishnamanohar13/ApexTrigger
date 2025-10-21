trigger AccountDeletionGuardTrigger on Account (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        AccountDeletionGuard.preventDeletions(Trigger.old);
    }
}