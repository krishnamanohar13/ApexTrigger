public with sharing class SetRatingForMediaIndustry {
    public static void updateRating(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            Map<String,String> metadata = new Map<String,String>();
            List<IndustryRatingMap__mdt> industryRatingMap = [Select Id,Industry__c,Rating__c FROM IndustryRatingMap__mdt];
            for(IndustryRatingMap__mdt ind : industryRatingMap){
                metadata.put(ind.Industry__c,ind.Rating__c);
            }
            for(Account acc : accList){
                if(metadata.containsKey(acc.Industry) && acc.Industry!=null){
                    acc.Rating = metadata.get(acc.Industry);
                }
            }
        }
    }
}