public with sharing class LastestCaseHandler {
    public static void latestCase(List<Case> newList,Map<Id,Case> oldMap){
        Map<Id,String> caseMap = new Map<Id,String>();
        if(newList == null || newList.isEmpty() && oldMap == null || oldMap.isEmpty()){
            return ;
        }
        
        if(newList!=null){
            for(Case cl : newList){
                if(cl.AccountId!=null){
                    caseMap.put(cl.AccountId,cl.CaseNumber);
                }
            }
        }
        if(oldMap!=null){
            for(Case oldcl : oldMap.values()){
                if(oldcl.AccountId!=null){
                    caseMap.put(oldcl.AccountId,oldcl.CaseNumber);
                }
            }
        }
        if(!caseMap.isEmpty()){
            List<Account> accList = [Select Id,Latest_Case__c FROM Account where Id IN:caseMap.keySet()];
            for(Account acc : accList){
                if(caseMap.containsKey(acc.Id)){
                    acc.Latest_Case__c = caseMap.get(acc.Id);
                }
            }
            try {
                if(!accList.isEmpty()){
                    update accList;
                } 
            }
            catch(Exception e){
                System.debug('Error --->'+ e.getMessage());
            }
        }
    }
}