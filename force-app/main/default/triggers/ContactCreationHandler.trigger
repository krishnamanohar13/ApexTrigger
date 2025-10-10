trigger ContactCreationHandler on Account (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isAfter || Trigger.isUpdate)){
       // NumberOfContacts.createContacts(Trigger.new); 
    }
}