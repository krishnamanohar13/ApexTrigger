trigger AccountDuplicateValidatorTrigger on Account (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
      AccountDuplicateValidator.duplicateNames(Trigger.new);
    }
}