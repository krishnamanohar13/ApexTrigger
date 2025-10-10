public with sharing class OpporunityAmountAggreagate {
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
}