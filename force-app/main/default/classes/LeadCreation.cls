public with sharing class LeadCreation {
    public static void createLead(List<Lead> leadList){
        if(!leadList.isEmpty() && leadList!=null){
            for(Lead ld : leadList){
                if(ld.LeadSource == 'Web'){
                    ld.Rating = 'Cold';
                }else {
                    ld.Rating = 'Hot';
                }
            }
        }
    }
}
//Example -- 2
