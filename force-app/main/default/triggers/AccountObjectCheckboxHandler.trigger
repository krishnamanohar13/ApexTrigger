trigger AccountObjectCheckboxHandler on Account (after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
       // AccountObjectCheckboxHandler.objectCheckbox(Trigger.new);
    }

}