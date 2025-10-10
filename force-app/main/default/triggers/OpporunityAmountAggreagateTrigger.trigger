trigger OpporunityAmountAggreagateTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
           OpporunityAmountAggreagate.updateAmountAggregate(Trigger.new, Trigger.oldMap);
        }
        else if(Trigger.isDelete) {
           OpporunityAmountAggreagate.updateAmountAggregate(null, Trigger.oldMap);
        }
    }
}