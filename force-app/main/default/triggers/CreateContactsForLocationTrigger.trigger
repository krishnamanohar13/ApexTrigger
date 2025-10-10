trigger CreateContactsForLocationTrigger on Account (after insert,after update,after delete,after undelete) {
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert )){
        //CreateContactsForLocation.numberofConatcts(Trigger.new);
    }
}