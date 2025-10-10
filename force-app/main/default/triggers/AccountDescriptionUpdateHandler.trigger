trigger AccountDescriptionUpdateHandler on Account (before insert,before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        AccountDescriptionUpdate.updateDescription(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
       AccountDescriptionUpdate.updateDescription(Trigger.new);
    }
}