trigger AccounthandlerTrigger on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Accounthandler.createContact(Trigger.new);
    }
}
