public with sharing class AccountOwnerSyncService {
    public static void updateOwner(List<Account> accList){
        Map<Id,Id> accMap = new Map<Id,Id>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.OwnerId !=null || acc.Id!=null){
                accMap.put(acc.Id,acc.OwnerId);
            }
        }
        System.debug('Map of owners changes --->'+ accMap);
        List<Contact> conList = [Select Id,LastName,OwnerId,AccountId FROM Contact WHERE Id IN:accMap.keySet()];
        for(Contact con : conList){
            if(accMap.containsKey(con.AccountId)){
                con.OwnerId = accMap.get(con.AccountId);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
}