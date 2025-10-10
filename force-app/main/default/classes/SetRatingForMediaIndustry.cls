public with sharing class SetRatingForMediaIndustry {
    public static void updateRating(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.Industry == 'Media' && acc.Industry!=null){
                System.debug('Incoming');
                acc.Rating = 'Hot';
            }
        }
    }
}