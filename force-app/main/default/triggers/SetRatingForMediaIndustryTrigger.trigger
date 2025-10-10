trigger SetRatingForMediaIndustryTrigger on Account (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isBefore || Trigger.isUpdate)){
        SetRatingForMediaIndustry.updateRating(Trigger.new);
    }
}