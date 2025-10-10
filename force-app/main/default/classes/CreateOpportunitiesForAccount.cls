public with sharing class CreateOpportunitiesForAccount {
    public static void createOpporunity(List<Account> accList){
        List<Opportunity> oppoList = new List<Opportunity>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            oppo.StageName = 'Prospecting';
            oppo.CloseDate = Date.today();
            oppo.AccountId = acc.Id;
            oppoList.add(oppo);
        }
        if(!oppoList.isEmpty()){
            insert oppoList;
        }
    }
}