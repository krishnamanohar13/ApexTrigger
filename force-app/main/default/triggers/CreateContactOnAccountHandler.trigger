trigger CreateContactOnAccountHandler on Account (after insert){
    if(Trigger.isAfter && Trigger.isInsert){
        CreateContactOnAccount.createContacts(Trigger.new);
    }
}