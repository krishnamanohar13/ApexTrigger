trigger AccountOpporunityAmountHandler on Opportunity (before update,after update,before insert) {
    if(Trigger.isBefore && Trigger.isUpdate){
        //AccountOpporunityAmount.validateAmount(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //AccountOpporunityAmount.validateAmount(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isInsert){
        //AccountOpporunityAmount.validateAmount(Trigger.new);
    }
}