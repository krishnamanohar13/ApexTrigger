public class AccountDuplicateValidator {
    public static void duplicateNames(List<Account> accList){
        Map<String,Account> accMap = new Map<String,Account>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        List<Account> accNames = [Select Id,Name FROM Account ];
        for(Account acc: accNames){
            accMap.put(acc.Name,acc);
        }
        System.debug('Map --->'+ accMap);
        for(Account accl : accList){
            if(accMap.containsKey(accl.Name)){
                accl.addError('Duplicate Names are not allowed');
            }
        }
    }
}