trigger OpporunityLastestAmountTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
           // OpporunityLastestAmount.updateAmount(Trigger.new, Trigger.oldMap);
        }
        else if(Trigger.isDelete) {
           // OpporunityLastestAmount.updateAmount(null, Trigger.oldMap);
        }
    }
}
