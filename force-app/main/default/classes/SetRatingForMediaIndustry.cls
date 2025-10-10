public with sharing class SetRatingForMediaIndustry {
    public static  String industry = 'Media';
    public static String rating = 'Hot';
    public static void updateRating(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        if(!accList.isEmpty()){
            for(Account acc : accList){
                if(acc.Industry == 'industry' && acc.Industry!=null){
                    acc.Rating = 'rating';
                }
            }
        }
    }
}