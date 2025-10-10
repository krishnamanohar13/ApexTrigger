trigger OpporunityStageUpdateHandlerTrigger on Opportunity (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
       // OpporunityStageUpdateHandler.updateStage(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
      //  OpporunityStageUpdateHandler.updateStage(Trigger.new);
    }
}