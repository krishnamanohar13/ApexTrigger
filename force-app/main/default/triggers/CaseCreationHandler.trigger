trigger CaseCreationHandler on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        //CaseCreation.createCase(Trigger.new);
    }
}