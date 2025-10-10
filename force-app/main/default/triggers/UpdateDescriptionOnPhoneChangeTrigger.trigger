trigger UpdateDescriptionOnPhoneChangeTrigger on Account (before update) {
    if(Trigger.isBefore && Trigger.isUpdate ){
        UpdateDescriptionOnPhoneChange.updateDescription(Trigger.new,Trigger.oldMap);
    }
}