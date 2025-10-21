public with sharing class AccountDeletionGuard {
    public static String errorMessage = 'Account cannot be deleted';
    public static void preventDeletions(List<Account> accList){
        if(accList ==null  && accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            for(Account acc : accList){
                if(acc.PreventDeletion__c == true){
                    acc.Name.addError(errorMessage);
                }
            }
        }
    }
}