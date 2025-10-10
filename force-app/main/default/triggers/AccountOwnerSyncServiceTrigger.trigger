trigger AccountOwnerSyncServiceTrigger on Account (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
      //  AccountOwnerSyncService.updateOwner(Trigger.new);
    }
}