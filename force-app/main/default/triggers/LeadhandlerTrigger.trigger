trigger LeadhandlerTrigger on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert|| Trigger.isUpdate)){
        //Leadhandler.updateValue(Trigger.new);
    }
}