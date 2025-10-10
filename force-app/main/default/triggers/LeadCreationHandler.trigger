trigger LeadCreationHandler on Lead (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
       //LeadCreation.createLead(Trigger.new);
    }
}
