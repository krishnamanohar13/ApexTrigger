public with sharing class OpporunityHandler {
    public static void latestAmount(List<Opportunity> newList, Map<Id, Opportunity> oldMap) {
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

    //update total Amount of all the opportunities related to the account
    public static void updateAmountAggregate(List<Opportunity> newList,Map<Id,Opportunity> oldList){
        Set<Id> accIds = new Set<Id>();
        if(newList == null || newList.isEmpty()){
            return ;
        }
        if(newList!=null){
            for(Opportunity oppo : newList){
                if(oppo.AccountId!=null){
                    accIds.add(oppo.AccountId);
                }
            }
        }

        if(oldList!=null){
            for(Opportunity oldOppo : oldList.values()){
                if(oldOppo.AccountId!=null){
                    accIds.add(oldOppo.AccountId);
                }
            }
        }

        System.debug('List of Account Ids --->'+ accIds);
        if(accIds.isEmpty()){
            return ;
        }
        Map<Id,Decimal> accMap = new Map<Id,Decimal>();
        List<AggregateResult> results = [Select SUM(Amount) totalAmount,AccountId FROM Opportunity WHERE AccountId IN:accIds GROUP BY AccountId];
        if(results.isEmpty()){
            return ;
        }
        for(AggregateResult ar : results){
            Id accountIds = (Id)ar.get ('AccountId');
            Decimal totalAmount = (Decimal)ar.get('totalAmount');
            accMap.put(accountIds,totalAmount);
        }
        System.debug('List of Amount per Account --->'+ accMap);
        List<Account> accLister = [Select Id,LastestAmount__c FROM Account WHERE Id IN:accMap.keySet()];
        for(Account acc : accLister){
            if(accMap.containsKey(acc.Id)){
                acc.LastestAmount__c = accMap.get(acc.Id);
            }
        }
        if(!accLister.isEmpty()){
            update accLister;
        }
    }
    //  If opportunity Stage is updated upon its creation or update then update description as either 'Opp is Closed Lost' or 'Opp is Closed Won' or 'Opp IS Open
    public static void updateStage(List<Opportunity> newList){
        if(newList == null || newList.isEmpty()){
            return ;
        }
        Map<String, String> stageDescMap = new Map<String, String>{'Closed Lost' => 'Closed Lost','Closed Won' => 'Closed Won','Open' => 'Opp is Open','Qualification' => 'Qualification','Needs Analysis' => 'Needs Analysis',
        'Value Proposition' => 'Value Proposition','Identify Decision Makers' => 'Identify Decision Makers','Perception Analysis' => 'Perception Analysis','Proposal/Price Quote' => 'Proposal/Price Quote','Negotiation/Review' => 'Negotiation/Review'};
        for(Opportunity oppo : newList){
            if(oppo.StageName != null && stageDescMap.containsKey(oppo.StageName)){
                oppo.Description = stageDescMap.get(oppo.StageName);
            }
        }
    }
}



