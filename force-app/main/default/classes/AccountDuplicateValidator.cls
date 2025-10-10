public class AccountDuplicateValidator {
    public static String errorMessage = 'Duplicates Names are not Allowed';
    public static void duplicateNames(List<Account> accList){
        Map<String,Account> accMap = new Map<String,Account>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            List<Account> accNames = [Select Id,Name FROM Account ];
            for(Account acc: accNames){
                accMap.put(acc.Name,acc);
            }
            for(Account accl : accList){
                if(accMap.containsKey(accl.Name)){
                    accl.Name.addError(errorMessage);
                }
            }
        }
    }
}