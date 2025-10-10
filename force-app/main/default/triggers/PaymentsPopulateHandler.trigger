trigger PaymentsPopulateHandler on Position__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        //PaymentsPopulate.populatePayments(Trigger.new);
    }
}