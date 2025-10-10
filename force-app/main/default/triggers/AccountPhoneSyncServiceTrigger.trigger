trigger AccountPhoneSyncServiceTrigger on Account (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isAfter || Trigger.isUpdate)){
        AccountPhoneSyncService.updatePhone(Trigger.new);
    }
}