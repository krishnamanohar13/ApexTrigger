public with sharing class UpdateDescriptionOnPhoneChange {
    public static void updateDescription(List<Account> accList,Map<Id,Account> oldMap){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            for(Account acc : accList){
                Account oldAcc = oldMap.get(acc.Id);
                if(acc.Phone != oldAcc.Phone){
                    acc.Description = 'Phone number has been updated with '+ acc.Phone + 'with ' + oldAcc.Phone;
                }
            }
        }
    }
}