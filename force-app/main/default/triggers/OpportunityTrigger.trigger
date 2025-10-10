trigger OpportunityTrigger on Opportunity (before insert,before update,after insert,after update,after delete,after undelete) {
    // if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    //     //OpporunityHandler.updateAmount(Trigger.new, Trigger.oldMap);
    //     //OpporunityHandler.updateStage(Trigger.new);
    // }
    if(Trigger.isAfter && Trigger.isInsert){
        //OpporunityHandler.updateAmount(Trigger.new,null);
        OpporunityHandler.updateAmountAggregate(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate) {
       // OpporunityHandler.updateAmount(Trigger.new,Trigger.oldMap);
        OpporunityHandler.updateAmountAggregate(Trigger.new,Trigger.oldMap);
    }

    if(Trigger.isAfter && Trigger.isDelete) {
       // OpporunityHandler.updateAmount(Trigger.old, Trigger.oldMap);
        OpporunityHandler.updateAmountAggregate(Trigger.old,Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete) {
       // OpporunityHandler.updateAmount(Trigger.new,null);
        OpporunityHandler.updateAmountAggregate(Trigger.new,null);
    }
}