public with sharing class AccountCreationIndustry {
    public static void updateRating(List<Account> accList){
    public static String value = 'Hot';
        if(accList == null || accList.isEmpty()){
            return ;
        }

        for(Account acc : accList){
            if(acc.Industry == 'Media' && acc.Industry!=null){
                acc.Rating = value;
            }
        }
    }
}
