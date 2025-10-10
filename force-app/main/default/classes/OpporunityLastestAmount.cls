public with sharing class OpporunityLastestAmount {
    public static void updateAmount(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
        if ((newList == null || newList.isEmpty()) && (oldMap == null || oldMap.isEmpty())) {
            return;
        }

        Set<Id> accIds = new Set<Id>();
        if(newList != null) {
            for (Opportunity opp : newList) {
                if (opp.AccountId != null) {
                    accIds.add(opp.AccountId);
                }
            }
        }
        System.debug('List of Account Ids new --->'+ accIds);

        if(oldMap != null) {
            for (Opportunity oldOpp : oldMap.values()) {
                if (oldOpp.AccountId != null) {
                    accIds.add(oldOpp.AccountId);
                }
            }
        }
        System.debug('List of Account Ids old --->'+ accIds);
        if (accIds.isEmpty()) {
            return;
        }

        Map<Id,Opportunity> accMap = new Map<Id,Opportunity>();
        List<Opportunity> oppoLister = [SELECT Id, Name,AccountId, Amount FROM Opportunity WHERE AccountId IN :accIds ORDER BY CreatedDate DESC LIMIT 1];
        for (Opportunity opp : oppoLister) {
            accMap.put(opp.AccountId, opp);
        }
        
        System.debug('Latest Amount --->'+ accMap.values());
        if(!accMap.isEmpty()){
            List<Account> accList = [Select Id,Lastest_Opporunity_Name__c,Lastest_Opporunity_Amount__c FROM Account where Id IN:accMap.keySet()];
            for(Account acc : accList){
                if(accMap.containsKey(acc.Id)){
                    acc.Lastest_Opporunity_Name__c = accMap.get(acc.Id).Name;
                    acc.Lastest_Opporunity_Amount__c = accMap.get(acc.Id).Amount;
                }
            }
            if(!accList.isEmpty()){
                update accList;
            }
        }
    }
}