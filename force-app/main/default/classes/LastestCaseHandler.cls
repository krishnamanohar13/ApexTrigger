public with sharing class LastestCaseHandler {
    public static void latestCase(List<Case> caseList){
        Map<Id,String> caseMap = new Map<Id,String>();
        if(caseList == null || caseList.isEmpty()){
            return ;
        }
        for(Case cs : caseList){
            if(cs.AccountId!=null && cs.CaseNumber!=null ){
                caseMap.put(cs.AccountId,cs.CaseNumber);
            }
        }
        List<Account> accList = [Select Id,Latest_Case__c FROM Account where Id IN:caseMap.keySet()];
        for(Account acc : accList){
            if(caseMap.containsKey(acc.Id)){
                acc.Latest_Case__c = caseMap.get(acc.Id);
            }
            if(!accList.isEmpty()){
                update accList;
            }
        }
    }
}