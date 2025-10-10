public with sharing class AccountDeletionGuard {
    public static void preventDeletions(List<Account> accList){
        System.debug('Triggerold --->'+ accList);
        if(accList ==null  && accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.PreventDeletion__c == true){
                acc.addError('Please dont delete this records');
            }
        }
    }
}