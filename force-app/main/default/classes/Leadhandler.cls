public with sharing class Leadhandler {
    public static void updateValue(List<Lead> leadList){
        if(!leadList.isEmpty() && leadList!=null){
            for(Lead ld : leadList){
                if(ld.LeadSource == 'Web'){
                    ld.Rating = 'Cold';}
                else {
                    ld.Rating = 'Hot';
                }
            }
        }
    }
}