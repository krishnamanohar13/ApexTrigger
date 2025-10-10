public with sharing class AccountPhoneSyncService {
    public static void updatePhone(List<Account> accList){
        Map<Id,String> accMap = new Map<Id,String>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            try {
                for(Account acc : accList){
                    if(acc.Phone !=null){
                        accMap.put(acc.Id,acc.Phone);
                    }
                }
                if(!accMap.isEmpty()){
                    List<Contact> conList = [Select Id,LastName,Phone,AccountId FROM Contact where AccountId IN:accMap.keySet()];
                    for(Contact con : conList){
                        if(accMap.containsKey(con.AccountId)){
                            con.Phone = accMap.get(con.AccountId);
                        }
                    }
                    if(!conList.isEmpty()){
                        update conList;
                    }
                }
            } 
            catch (Exception e) {
                System.debug('Exception --->'+ e.getMessage());
            }
        }
    }
}