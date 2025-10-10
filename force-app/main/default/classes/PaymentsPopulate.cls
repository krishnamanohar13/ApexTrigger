public with sharing class PaymentsPopulate {
    public static void populatePayments(List<Position__c> posiList){
        if(posiList == null || posiList.isEmpty()){
            return;
        }

        for(Position__c pos : posiList){
            if(pos.Open_Date__c == null && pos.Min_Pay__c == null && pos.Max_Pay__c == null){
                System.debug('Incoming');
                pos.Open_Date__c = Date.today();
                pos.Min_Pay__c =  1000;
                pos.Max_Pay__c = 15000;
            }
        }
    }
}
//Example -- 9