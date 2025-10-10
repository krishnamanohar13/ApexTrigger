public with sharing class AccountOpporunityAmount {
    public static void validateAmount(List<Opportunity> oppoList){
        Map<Id,Decimal> accMap = new Map<Id,Decimal>();
        if(oppoList == null || oppoList.isEmpty()){
            return;
        }
        for(Opportunity oppo : oppoList){
            if(oppo.Amount != null && oppo.Amount> 100000 && oppo.AccountId!=null){
                accMap.put(oppo.AccountId,oppo.Amount);
            }
        }
        System.debug('List of Amount per Account -->'+ accMap);
        List<Account> accDesc = [Select Id,Name,Description from Account where Id IN:accMap.keySet()];
        System.debug('List of Accounts --->'+ accDesc);
        for(Account acc : accDesc){
            if(accMap.containsKey(acc.Id)){
                System.debug('List -->');
                acc.Description = 'Amount is greater than 1000000 HOT Opporunity';
            }
            else {
                acc.Description = 'Amount is less than 1000000 Cold Opporunity';
            }
        }
        if(!accDesc.isEmpty()){
            update accDesc;
        }
        System.debug('List -->'+ accDesc);
    }
}

//Example - 7

