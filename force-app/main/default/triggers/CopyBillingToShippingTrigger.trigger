trigger CopyBillingToShippingTrigger on Account (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        //CopyBillingToShipping.updateDescription(Trigger.new);
    }
}